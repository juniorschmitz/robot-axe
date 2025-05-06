*** Settings ***
Library    SeleniumLibrary
Library    AxeLibrary

*** Test Cases ***
Qulture Rocks Accessibility Test
   Open Browser    https://app.qulture.rocks/    Chrome
   
   # execute accessibility tests
   &{results}=    Run Accessibility Tests    qulture.json
   Log   Violations Count: ${results.violations}

   # log violation result to log.html
   Log Readable Accessibility Result    violations
   [Teardown]    Close All Browsers