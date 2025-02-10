*** Settings ***

Library    libs/database.py
Library    Browser
Library    JSONLibrary

Resource    env.resource
Resource    pages/SignupPage.resource
Resource    pages/LoginPage.resource
Resource    pages/components/Notice.resource
Resource    pages/components/Alert.resource
Resource    pages/components/Header.resource
Resource    pages/TaskCreatePage.resource
Resource    pages/TasksPage.resource

Resource    services.resource

*** Keywords ***
Start Session
    New Browser    browser=${BROWSER}   headless=false
    New Page    ${BASE_URL}

Short password
    [Arguments]    ${short_pass}

    ${user}    Create Dictionary
    ...            name=Filo
    ...            email=filo@hotmail.com
    ...            password=${short_pass}
    
    Go to signup page
    Submit signup form    ${user}

    Alert should be    Informe uma senha com pelo menos 6 digitos

#Helper
Get fixture
    [Arguments]    ${file_name}    ${scenario}
        
    ${data}    Load Json From File    
    ...    ${EXECDIR}/resources/fixtures/${file_name}.json
    ...    encoding=utf-8

    [Return]    ${data}[${scenario}]