*** Settings ***
Test Teardown     KB Visibility Teardown
Force Tags        KB_Visibility
Test Template     KB Article Should be Visible
Test Timeout      10 minutes
Resource          ../Resources/Accounts.robot
Resource          ../Resources/Knowledge_Base_KB_Visibility_Resources.robot
Resource          Suite_KB_Visibility_Keywords_Resources.robot

*** Test Cases ***    User                                         KB_Number    Product                               Status        Type        Premium_Sign_In
Internal User [SW3779]
                      [Tags]                                       SNWL
                      ${Internal_User}                             SW3779       SonicWALL SuperMassive 9000 Series    Published     External    Any Value

Internal User [114272]
    [Tags]    internal_account
                      ${Internal_User}                             114272       SharePlex                             Published     External    Not Required

Internal User [104153]
    [Tags]    internal_account
                      ${Internal_User}                             104153       SharePlex                             Published     External    `# Days Required

Internal User [104244]
    [Tags]    internal_account
                      ${Internal_User}                             104244       SharePlex                             Published     External    Always Required

Internal User [92405]
    [Tags]    internal_account
                      ${Internal_User}                             92405        SharePlex                             Published     Internal    Any Value

Internal User [150733]
    [Tags]    internal_account
                      ${Internal_User}                             150733       SharePlex                             Quickshare    External    Not Required

Internal User [183858]
    [Tags]    internal_account
                      ${Internal_User}                             183858       SharePlex                             Quickshare    External    `# Days Required

Internal User [210719]
    [Tags]    internal_account
                      ${Internal_User}                             210719       SharePlex                             Quickshare    External    Always Required

Internal User [95269]
    [Tags]    internal_account
                      ${Internal_User}                             95269        SharePlex                             Quickshare    Internal    Any Value

Internal User [217153]
    [Tags]    internal_account
                      ${Internal_User}                             217153       SharePlex                             Submitted     External    Any Value

Internal User [102243]
    [Tags]    internal_account
                      ${Internal_User}                             102243       SharePlex                             Submitted     Internal    Any Value

Ext User (Ent) [SW3779]
                      [Tags]                                       SNWL
                      ${Ext_User_Ent}                              SW3779       SonicWALL SuperMassive 9000 Series    Published     External    Any Value

Ext User (Ent) [205086]
                      ${Ext_User_Ent}                              205086       Toad for Oracle                       Published     External    Not Required

Ext User (Ent) [105445]
                      ${Ext_User_Ent}                              105445       Toad for Oracle                       Published     External    `# Days Required

Ext User (Ent) [207089]
                      ${Ext_User_Ent}                              207089       Toad for Oracle                       Published     External    Always Required

Ext User (Ent) [122362]
                      ${Ext_User_Ent}                              122362       Toad for Oracle                       Quickshare    External    Not Required

Ext User (Ent) [154054]
                      ${Ext_User_Ent}                              154054       Toad for Oracle                       Quickshare    External    `# Days Required

Ext User (Ent) [207847]
                      ${Ext_User_Ent}                              207847       Toad for Oracle                       Quickshare    External    Always Required

Ext User (Non Ent) [SW3779]
                      [Tags]                                       SNWL
                      ${Ext_User_Non_Ent}                          SW3779       SonicWALL SuperMassive 9000 Series    Published     External    Any Value

Ext User (Non Ent) [121620]
                      ${Ext_User_Non_Ent}                          121620       SQL Navigator for Oracle              Published     External    Not Required

Ext User (Non Ent) [116192]
                      ${Ext_User_Non_Ent}                          116192       SQL Navigator for Oracle              Quickshare    External    Not Required

Ext User (Non Ent) [30062]
                      ${Ext_User_Non_Ent}                          30062        SQL Navigator for Oracle              Quickshare    External    `# Days Required

Ext User (Non Ent) [212525]
                      ${Ext_User_Non_Ent}                          212525       SQL Navigator for Oracle              Quickshare    External    Always Required

SPP [SW3779]          [Tags]                                       SNWL
                      ${SPP}                                       SW3779       SonicWALL SuperMassive 9000 Series    Published     External    Any Value

SPP [114509]          ${SPP}                                       114509       SharePlex                             Published     External    Not Required

SPP [114694]          ${SPP}                                       114694       SharePlex                             Published     External    `# Days Required

SPP [115424]          ${SPP}                                       115424       SharePlex                             Published     External    Always Required

SPP [92600]           ${SPP}                                       92600        SharePlex                             Published     Internal    Any Value

SPP [212212]          ${SPP}                                       212212       SharePlex                             Quickshare    External    Not Required

SPP [94163]           ${SPP}                                       94163        SharePlex                             Quickshare    External    `# Days Required

SPP [94201]           ${SPP}                                       94201        SharePlex                             Quickshare    External    Always Required

SPP [95510]           ${SPP}                                       95510        SharePlex                             Quickshare    Internal    Any Value

SPP [217272]          ${SPP}                                       217272       SharePlex                             Submitted     External    Any Value

SPP [103956]          ${SPP}                                       103956       SharePlex                             Submitted     Internal    Any Value

Partner w/ DSG Cert to a product [SW3779]
                      [Tags]                                       SNWL
                      ${Partner_w_DSG_Cert_to_a_product}           SW3779       SonicWALL SuperMassive 9000 Series    Published     External    Any Value

Partner w/ DSG Cert to a product [115476]
                      ${Partner_w_DSG_Cert_to_a_product}           115476       SharePlex                             Published     External    Not Required

Partner w/ DSG Cert to a product [104153]
                      ${Partner_w_DSG_Cert_to_a_product}           104153       SharePlex                             Published     External    `# Days Required

Partner w/ DSG Cert to a product [115621]
                      ${Partner_w_DSG_Cert_to_a_product}           115621       SharePlex                             Published     External    Always Required

Partner w/ DSG Cert to a product [102017]
                      ${Partner_w_DSG_Cert_to_a_product}           102017       SQL Navigator for Oracle              Published     Internal    Any Value

Partner w/ DSG Cert to a product [94408]
                      ${Partner_w_DSG_Cert_to_a_product}           94408        SharePlex                             Quickshare    External    Not Required

Partner w/ DSG Cert to a product [94432]
                      ${Partner_w_DSG_Cert_to_a_product}           94432        SharePlex                             Quickshare    External    `# Days Required

Partner w/ DSG Cert to a product [94683]
                      ${Partner_w_DSG_Cert_to_a_product}           94683        SharePlex                             Quickshare    External    Always Required

Partner w/ DSG Cert to a product [210056]
                      ${Partner_w_DSG_Cert_to_a_product}           210056       SQL Navigator for Oracle              Quickshare    Internal    Any Value

Partner w/ DSG Cert to a product [151393]
                      ${Partner_w_DSG_Cert_to_a_product}           151393       SQL Navigator for Oracle              Submitted     External    Any Value

Partner w/ DSG Cert to a product [152017]
                      ${Partner_w_DSG_Cert_to_a_product}           152017       SQL Navigator for Oracle              Submitted     Internal    Any Value

Partner w/ no DSG Cert but entitled [SW3779]
                      [Tags]                                       SNWL
                      ${Partner_w_no_DSG_Cert_but_entitled}        SW3779       SonicWALL SuperMassive 9000 Series    Published     External    Any Value

Partner w/ no DSG Cert but entitled [125645]
                      ${Partner_w_no_DSG_Cert_but_entitled}        125645       Toad for Oracle                       Published     External    Not Required

Partner w/ no DSG Cert but entitled [129135]
                      ${Partner_w_no_DSG_Cert_but_entitled}        129135       Toad for Oracle                       Published     External    `# Days Required

Partner w/ no DSG Cert but entitled [126739]
                      ${Partner_w_no_DSG_Cert_but_entitled}        126739       Toad for Oracle                       Published     External    Always Required

Partner w/ no DSG Cert but entitled [144592]
                      ${Partner_w_no_DSG_Cert_but_entitled}        144592       Toad for Oracle                       Quickshare    External    Not Required

Partner w/ no DSG Cert but entitled [154054]
                      ${Partner_w_no_DSG_Cert_but_entitled}        154054       Toad for Oracle                       Quickshare    External    `# Days Required

Partner w/ no DSG Cert but entitled [145132]
                      ${Partner_w_no_DSG_Cert_but_entitled}        145132       Toad for Oracle                       Quickshare    External    Always Required

Partner w/ no DSG Cert but not entitled [SW3779]
                      [Tags]                                       SNWL
                      ${Partner_w_no_DSG_Cert_but_not_entitled}    SW3779       SonicWALL SuperMassive 9000 Series    Published     External    Any Value

Partner w/ no DSG Cert but not entitled [122136]
                      ${Partner_w_no_DSG_Cert_but_not_entitled}    122136       SQL Navigator for Oracle              Published     External    Not Required

Partner w/ no DSG Cert but not entitled [148479]
                      ${Partner_w_no_DSG_Cert_but_not_entitled}    148479       SQL Navigator for Oracle              Quickshare    External    Not Required

Partner w/ no DSG Cert but not entitled [128669]
                      ${Partner_w_no_DSG_Cert_but_not_entitled}    128669       SQL Navigator for Oracle              Quickshare    External    `# Days Required

Partner w/ no DSG Cert but not entitled [121666]
                      ${Partner_w_no_DSG_Cert_but_not_entitled}    121666       SQL Navigator for Oracle              Quickshare    External    Always Required

Anonymous [SW3779]    [Tags]                                       SNWL
                      Anonymous                                    SW3779       SonicWALL SuperMassive 9000 Series    Published     External    Any Value

Anonymous [115622]    Anonymous                                    115622       SharePlex                             Published     External    Not Required

Anonymous [94766]     Anonymous                                    94766        SharePlex                             Quickshare    External    Not Required

Anonymous [94818]     Anonymous                                    94818        SharePlex                             Quickshare    External    `# Days Required

Anonymous [94898]     Anonymous                                    94898        SharePlex                             Quickshare    External    Always Required
