*** Settings ***
Library    SeleniumLibrary
Library    AxeLibrary
Library    Collections

*** Variables ***
${HEADLESS_ARGS}    --headless --disable-gpu --no-sandbox --window-size=1920,1080
${URL}              https://app.qulture.rocks/

*** Keywords ***
Log Focused Element Info
    ${tag}=        Execute Javascript    return document.activeElement.tagName || ''
    ${cls}=        Execute Javascript    return document.activeElement.className || ''
    ${id}=         Execute Javascript    return document.activeElement.id || ''
    ${text}=       Execute Javascript    return document.activeElement.textContent || ''
    ${value}=      Execute Javascript    return document.activeElement.value || ''
    Log To Console    Focused Element:\n - Tag: ${tag}\n - ID: ${id}\n - Class: ${cls}\n - Text: ${text}\n - Value: ${value}

Tab Navigation
    Press Keys    None    TAB
    Sleep    2s
    Capture Page Screenshot

*** Test Cases ***
Qulture Rocks Keyboard Navigation Test
    Open Browser    ${URL}    chrome    chrome_options=${HEADLESS_ARGS}
    
    # Accessibility scan
    &{results}=    Run Accessibility Tests    keyboard-test-home.json
    ${violations_count}=    Set Variable    ${results.violations}
    Run Keyword If    ${violations_count} > 0    Log    Found ${violations_count} keyboard navigation issues
    Log Readable Accessibility Result    violations

    # Tab navigation test
    Tab Navigation
    Log To Console    [Step 1] After 1st TAB press:
    Log Focused Element Info

    Repeat Keyword    3    Tab Navigation
    Sleep             1s
    Log To Console    [Step 2] After 4 TAB presses:
    Log Focused Element Info

    # Simulate Enter key press
    Press Keys    None    ENTER
    Sleep         1s
    # Accessibility scan
    &{results}=    Run Accessibility Tests    keyboard-test-forgot-password.json
    ${violations_count}=    Set Variable    ${results.violations}
    Run Keyword If    ${violations_count} > 0    Log    Found ${violations_count} keyboard navigation issues
    Log Readable Accessibility Result    violations
    Capture Page Screenshot
    

    # Simulate Escape key press
    Press Keys    None    ESC
    Sleep         1s

    [Teardown]    Close All Browsers