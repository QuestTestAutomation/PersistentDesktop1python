# coding=UTF-8 

'''

@author: GBorodin
'''
import pyodbc

def get_variables(cnString="DRIVER={SQL Server};SERVER=stage-support-wwwdb2014.prod.quest.corp;DATABASE=Stage_Support;UID=IUSR_Tridion_Support_Solutions;PWD=#Tridion2;",
                  LOCALE='en-US',
                  SITE='DSG'):
    if cnString.startswith('"') and cnString.endswith('"'):
        cnString = cnString[1:-1]
    
    connection = pyodbc.connect(cnString)

    cursor = connection.cursor()
    
    query_old =( "SELECT [Key],[Locale], CASE WHEN [Value] is null THEN '' ELSE [Value] END AS [Value], [Site] FROM [STAGE_Support].[dbo].[SupportI18n] where ([site] = '" + SITE + "') and locale = '" + LOCALE + "'"
             " union " 
             "SELECT [Key],[Locale], CASE WHEN [Value] is null THEN '' ELSE [Value] END AS [Value], [Site] FROM [STAGE_Support].[dbo].[SupportI18n]"
            "where ( [site] ='' and [key] not in (SELECT [Key] FROM [STAGE_Support].[dbo].[SupportI18n] where ( [site] = '" + SITE + "') and locale = '" + LOCALE + "'))  and locale = '" + LOCALE + "'"
             )

    query =("SELECT [Key],[Locale], CASE WHEN [Value] is null THEN '' ELSE [Value] END AS [Value], [Site] "
                "FROM [STAGE_Support].[dbo].[SupportI18n] "
                "where [site] in ('" +SITE + "') and [locale] = '" + LOCALE + "'"
            " union "
            "SELECT [Key],[Locale], CASE WHEN [Value] is null THEN '' ELSE [Value] END AS [Value], [Site] "
                "FROM [STAGE_Support].[dbo].[SupportI18n] "
                "where [site] in ('') and [locale] = '" + LOCALE + "'"
                "and [key] not in ("
                    "SELECT [Key] FROM [STAGE_Support].[dbo].[SupportI18n]"
                    "where [site] in ('" +SITE + "') and [locale] = '" +LOCALE + "') "
            " union "
            " SELECT [Key],[Locale], CASE WHEN [Value] is null THEN '' ELSE [Value] END AS [Value], [Site]"
                " FROM [STAGE_Support].[dbo].[SupportI18n] "
                " where [site] ='" + SITE + "'"
                "and [key] not in ("
                    "SELECT [Key] FROM [STAGE_Support].[dbo].[SupportI18n]"
                    "where [site] in ('" +SITE + "', '') and [locale] = '" +LOCALE + "') "
                "and locale = 'en-us' "
            " union "
            "SELECT [Key],[Locale], CASE WHEN [Value] is null THEN '' ELSE [Value] END AS [Value], [Site]"
                 "FROM [STAGE_Support].[dbo].[SupportI18n]"
                  " where [site] ='' "
                     " and [key] not in ( "
                           " SELECT [Key] FROM [STAGE_Support].[dbo].[SupportI18n] "
                              "  where ([site] in ('" +SITE + "', '') and [locale] = '" +LOCALE + "') or ([site] = '" +SITE +"' and [locale] = 'en-us')  ) "
                            " and locale = 'en-us' "
            )
    #print query

    cursor.execute(query)

    rows = cursor.fetchall()
    
    DBVars = dict()

    for row in rows:
        DBVars.update({row.Key:row.Value.rstrip()})
    
    return DBVars

#print get_variables()

