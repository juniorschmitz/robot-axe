*** Settings ***
Library    SeleniumLibrary
Library    AxeLibrary
Library    Collections

*** Variables ***
${HEADLESS_ARGS}    --headless --disable-gpu --no-sandbox --window-size=1920,1080
${URL}              https://app.qulture.rocks/
${RESULTS_FILE}     qulture.json

*** Test Cases ***
Qulture Rocks General Accessibility Test
   Open Browser    ${URL}    chrome    chrome_options=${HEADLESS_ARGS}
   
   # Execute general accessibility tests
   &{results}=    Run Accessibility Tests    ${RESULTS_FILE}
   Log   Violations Count: ${results.violations}
   Capture Page Screenshot

   # Log violation result to log.html
   Log Readable Accessibility Result    violations
   [Teardown]    Close All Browsers
   