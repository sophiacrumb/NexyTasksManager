*** Settings ***
Documentation    Autotests
Force Tags    seleniumlibrary
Default Tags    example
Resource    resource.robot

*** Variables ***
${LOGIN URL}    http://localhost:3000/tasks
${BROWSER}    googlechrome

*** Test Cases ***

Create new task with existing user/Name less than 250 symbols and Description less than 1000 symbols
    [Documentation]    Открыть браузер и создать новую задачу с имеющимся в системе пользователем, именем < 250 симв., описанием < 1000 симв. Ожидаем успешное создание задачи.
    [Tags]    create task
    [Setup]    Open Browser to check
    Sleep    5 seconds
    Click Link    xpath=//a[contains(.,"Create")]
    ${random_name}    Generate Random String    249    [LETTERS]
    ${random_description}    Generate Random String    999    [LETTERS]
    Input Text    name=task_name    ${random_name}
    Input Text    name=description    ${random_description}
    ${StartDate}    Get Current Date    result_format=%d-%m-%Y
    Input Text    name=start_date    ${StartDate}
    ${EndDate}    Get Current Date    result_format=%d-%m-%Y
    Input Text    name=end_date    ${EndDate}
    Click Element    name=assignee
    Sleep    5 seconds
    Click Element    xpath=//select[@name="assignee"]/option[contains(.,'Chernousova Sophia')]
    Click Element    xpath=//button[contains(.,"Create")]
    Wait Until Page Contains    Task has been created
    Sleep    5 seconds
    [Teardown]    Close Browser


Create new task without Name
    [Documentation]    Открыть браузер и создать новую задачу с имеющимся в системе пользователем, без имени, описанием < 1000 симв. Ожидаем ошибку при создании задачи.
    [Tags]    create task
    [Setup]    Open Browser to check
    Sleep    5 seconds
    Click Link    xpath=//a[contains(.,"Create")]
    ${random_name}    Generate Random String    249    [LETTERS]
    ${random_description}    Generate Random String    999    [LETTERS]
    Input Text    name=description    ${random_description}
    ${StartDate}    Get Current Date    result_format=%d-%m-%Y
    Input Text    name=start_date    ${StartDate}
    ${EndDate}    Get Current Date    result_format=%d-%m-%Y
    Input Text    name=end_date    ${EndDate}
    Click Element    name=assignee
    Click Element    xpath=//select[@name="assignee"]/option[contains(.,"Chernousova Sophia")]
    Click Element    xpath=//button[contains(.,"Create")]
    Alert Should Be Present    Please fill all form data
    Sleep    5 seconds
    [Teardown]    Close Browser
    Log    Couldn't create a task without Name field

Create new task with Name more than 250 symbols
    [Documentation]    Открыть браузер и создать новую задачу с имеющимся в системе пользователем, с именем > 250 симв., описанием < 1000 симв. Ожидаем ошибку при создании задачи.
    [Tags]    create task
    [Setup]    Open Browser to check
    Sleep    5 seconds
    Click Link    xpath=//a[contains(.,"Create")]
    ${random_name}    Generate Random String    251    [LETTERS]
    ${random_description}    Generate Random String    999    [LETTERS]
    Input Text    name=task_name    ${random_name}
    Input Text    name=description    ${random_description}
    ${StartDate}    Get Current Date    result_format=%d-%m-%Y
    Input Text    name=start_date    ${StartDate}
    ${EndDate}    Get Current Date    result_format=%d-%m-%Y
    Input Text    name=end_date    ${EndDate}
    Click Element    name=assignee
    Click Element    xpath=//select[@name="assignee"]/option[contains(.,"Chernousova Sophia")]
    Click Element    xpath=//button[contains(.,"Create")]
    Alert Should Be Present
    Sleep    5 seconds
    [Teardown]    Close Browser
    Log    Task with Name more than 250 symbols was created. IMPOSSSSSIBRE (bug, inconsistency with requirements)


Create new task with Name in quotes
    [Documentation]    Открыть браузер и создать новую задачу с имеющимся в системе пользователем, с именем в кавычках, описанием < 1000 симв. Ожидаем успешное создание задачи.
    [Tags]    create task
    [Setup]    Open Browser to check
    Sleep    5 seconds
    Click Link    xpath=//a[contains(.,"Create")]
    ${random_description}    Generate Random String    999    [LETTERS]
    Input Text    name=task_name   " "
    Input Text    name=description    ${random_description}
    ${StartDate}    Get Current Date    result_format=%d-%m-%Y
    Input Text    name=start_date    ${StartDate}
    ${EndDate}    Get Current Date    result_format=%d-%m-%Y
    Input Text    name=end_date    ${EndDate}
    Click Element    name=assignee
    Click Element    xpath=//select[@name="assignee"]/option[contains(.,"Chernousova Sophia")]
    Click Element    xpath=//button[contains(.,"Create")]
    Wait Until Page Contains    Task has been created
    Sleep    5 seconds
    [Teardown]    Close Browser

*** Keywords ***
Open Browser to check
    Open Browser    ${LOGIN URL}    ${BROWSER}