*** Variables ***
${dsg_ReleaseNotes_Page_Title_locator}    xpath=//h1[@id="LayoutH1"][text()[contains(.,'${dsg_ReleaseNotes_Page_Title}')]]
${dsg_home_ToolsTitle_rng_locator}    xpath=//div[@id="Tools"]//span[@class="tools-title"][text()[contains(., '${dsg_home_ToolsTitle_rng}')]]
${bookContent_locator}    xpath=//div[@id="bookContent"]
${downloadPdf_links}    xpath=(//div[@class='download-table']//td/a[text()[contains(., 'view pdf')]])
