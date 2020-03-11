*** Settings ***
Test Teardown     KB Visibility Teardown
Force Tags        KB_Visibility
Test Template     KB Article Should Not Be Found
Test Timeout      10 minutes
Resource          ../Resources/Accounts.robot
Resource          ../Resources/Knowledge_Base_KB_Visibility_Resources.robot
Resource          Suite_KB_Visibility_Keywords_Resources.robot

*** Test Cases ***    User                                         KB_Number    Product                     Status        Type        Premium_Sign_In
Ext User (Ent) [208127]
                      ${Ext_User_Ent}                              208127       Toad for Oracle             Published     Internal    Any Value

Ext User (Ent) [208183]
                      ${Ext_User_Ent}                              208183       Toad for Oracle             Quickshare    Internal    Any Value

Ext User (Ent) [147399]
                      ${Ext_User_Ent}                              147399       Toad for Oracle             Submitted     External    Any Value

Ext User (Ent) [145746]
                      ${Ext_User_Ent}                              145746       Toad for Oracle             Submitted     Internal    Any Value

Ext User (Non Ent) [204961]
                      ${Ext_User_Non_Ent}                          204961       SQL Navigator for Oracle    Published     Internal    Any Value

Ext User (Non Ent) [210056]
                      ${Ext_User_Non_Ent}                          210056       SQL Navigator for Oracle    Quickshare    Internal    Any Value

Ext User (Non Ent) [146954]
                      ${Ext_User_Non_Ent}                          146954       SQL Navigator for Oracle    Submitted     External    Any Value

Ext User (Non Ent) [102619]
                      ${Ext_User_Non_Ent}                          102619       SQL Navigator for Oracle    Submitted     Internal    Any Value

Partner w/ no DSG Cert but entitled [123045]
                      ${Partner_w_no_DSG_Cert_but_entitled}        123045       Toad for Oracle             Published     Internal    Any Value

Partner w/ no DSG Cert but entitled [145374]
                      ${Partner_w_no_DSG_Cert_but_entitled}        145374       Toad for Oracle             Quickshare    Internal    Any Value

Partner w/ no DSG Cert but entitled [145393]
                      ${Partner_w_no_DSG_Cert_but_entitled}        145393       Toad for Oracle             Submitted     External    Any Value

Partner w/ no DSG Cert but entitled [145746]
                      ${Partner_w_no_DSG_Cert_but_entitled}        145746       Toad for Oracle             Submitted     Internal    Any Value

Partner w/ no DSG Cert but not entitled [92670]
                      ${Partner_w_no_DSG_Cert_but_not_entitled}    92670        SQL Navigator for Oracle    Published     Internal    Any Value

Partner w/ no DSG Cert but not entitled [140674]
                      ${Partner_w_no_DSG_Cert_but_not_entitled}    140674       SQL Navigator for Oracle    Quickshare    Internal    Any Value

Partner w/ no DSG Cert but not entitled [151393]
                      ${Partner_w_no_DSG_Cert_but_not_entitled}    151393       SQL Navigator for Oracle    Submitted     External    Any Value

Partner w/ no DSG Cert but not entitled [152017]
                      ${Partner_w_no_DSG_Cert_but_not_entitled}    152017       SQL Navigator for Oracle    Submitted     Internal    Any Value

Anonymous [144690]    Anonymous                                    144690       Active Roles                Published     Internal    Any Value

Anonymous [145567]    Anonymous                                    145567       Active Roles                Quickshare    Internal    Any Value

Anonymous [145664]    Anonymous                                    145664       Active Roles                Submitted     External    Any Value

Anonymous [146291]    Anonymous                                    146291       Active Roles                Submitted     Internal    Any Value
