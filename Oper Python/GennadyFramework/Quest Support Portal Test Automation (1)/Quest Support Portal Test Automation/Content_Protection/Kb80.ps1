function GetProductsIDs
{
    param($Connection)

    $Query = "SELECT DISTINCT p.ProductID FROM KBArticleVersions kbv INNER JOIN product p ON p.ProductID = kbv.productId WHERE p.Status = 'Active'"
    
    $prodIDs = Invoke-Sqlcmd -Query $Query -ServerInstance $Connection.ServerInstance -Database $Connection.Database -Username $Connection.User -Password $Connection.Pwd
      
    return $prodIDs
}


function Get20Percent
{

    param($Connection, $ProductID )

    $Query = "SELECT  CEILING(COUNT(1) * 0.80) FROM [dbo].[KBArticles] kb WHERE kbarticleId IN (SELECT kbarticleId FROM KBArticleVersions kbv INNER JOIN product p ON p.ProductID = kbv.productId WHERE p.ProductID = '" +$ProductID +"')AND kb.Status IN ('Published','Archived','QuickShare') AND kb.IsExternal = 'Y'"
    
    $count20 = Invoke-Sqlcmd -Query $Query -ServerInstance $Connection.ServerInstance -Database $Connection.Database -Username $Connection.User -Password $Connection.Pwd

    return $count20[0][0]
}


function GetExpextedProductPremiumDays
{
    param ($Connection, $ProductID, $Count20Percent)

    $Query = "SELECT TOP(1) PremiumDays FROM (
               SELECT TOP($Count20Percent) 
			   DATEDIFF(DAY, GETUTCDATE(), kb.LastUpdatedDate) AS PremiumDays, *
               FROM [dbo].[KBArticles] kb 
               WHERE kbarticleId IN (
                              SELECT kbarticleId FROM KBArticleVersions kbv
                              INNER JOIN product p ON p.ProductID = kbv.productId WHERE p.ProductID = '$ProductID'
                              )
               AND kb.Status IN ('Published','Archived','QuickShare') AND kb.IsExternal = 'Y'
               ORDER BY kb.LastUpdatedDate ASC
               ) AS PremiumDaysTable
        ORDER BY PremiumDays DESC"

     $PremiumDays = Invoke-Sqlcmd -Query $Query -ServerInstance $Connection.ServerInstance -Database $Connection.Database -Username $Connection.User -Password $Connection.Pwd

    if(!$PremiumDays) 
    {
        return 0
    }
    Else
    {
        return $PremiumDays[0][0]
    }

}

function GetActualProductPremiumDays
{
    param ($Connection, $ProductID)

    $Query = "Select PremiumDays from ProductExt where SiebelProductID = '$ProductID'"
    
    $ActualPremiumDays = Invoke-Sqlcmd -Query $Query -ServerInstance $Connection.ServerInstance -Database $Connection.Database -Username $Connection.User -Password $Connection.Pwd

    return $ActualPremiumDays[0][0]
}

function GetBasicProductInfo
{
    param ($Connection, $ProductID)

    $Query = "Select * from Product where ProductID = '$ProductID'" 

    $ProductInfo = Invoke-Sqlcmd -Query $Query -ServerInstance $Connection.ServerInstance -Database $Connection.Database -Username $Connection.User -Password $Connection.Pwd

    return $ProductInfo
}

Push-Location

$c = @{"ServerInstance" = "stage-support-wwwdb2014.prod.quest.corp"; "Database" = "Stage_Support"; "User" = "IUSR_Tridion_Support_Solutions"; "Pwd" = "#Tridion2" } #"source=stage-support-wwwdb2014.prod.quest.corp;initial catalog=Stage_Support;persist security info=True;user id=IUSR_Tridion_Support_Solutions;password=#Tridion2"

$DiffDictionary = @{}


foreach($row in GetProductsIDs($c))
{
 $prid = $row[0]

 
 $p20 = Get20Percent -Connection $c -ProductID $prid

 
 $expPremiumDays = GetExpextedProductPremiumDays -Connection $c -ProductID $prid -Count20Percent $p20

 $actualPremiumDays = GetActualProductPremiumDays -Connection $c -ProductID $prid

 $prodName = (GetBasicProductInfo -Connection $c -ProductID $prid).ProductName
 
 #$prid.ToString() + "::" + $prodName + "::" + $p20.ToString() + "::" + $expPremiumDays.ToString() + "::" + $actualPremiumDays.ToString()

 if(($expPremiumDays -ne $actualPremiumDays) -and ($expPremiumDays -ne 0))
 {
     $DiffDictionary.Add($prid,($prid, $prodName, $expPremiumDays, $actualPremiumDays))
 }
  
}

Pop-Location

if(Test-Path \\spb8456\share\SupportKb80.csv)
{
    Remove-Item \\spb8456\share\SupportKb80.csv
}

foreach($k in $DiffDictionary.Keys)
{
   ''| select-object @{Name="ProductID"; Expression={$DiffDictionary.Item($k)[0]}},@{Name="Product Name"; Expression={$DiffDictionary.Item($k)[1]}},@{Name="Expexted Premium Days"; Expression={$DiffDictionary.Item($k)[2]}},@{Name="Actual Premium Days"; Expression={$DiffDictionary.Item($k)[3]}} | export-csv \\spb8456\share\SupportKb80.csv -notypeinformation -Append -Delimiter ","
}

if($DiffDictionary.Count -ne 0)
{
    return "Differences have been found. See the report"
}
else
{
    return "No differences between Expexcted and Actual Premium Days have been found"
}





