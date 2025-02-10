*** Settings ***
Documentation    Acoes e elementos do cabecalho do mark85'

Library    Browser
Library    String

*** Keywords ***

User should be logged in
    [Arguments]    ${name}
    #Nesse cenário, importamos a library String, nativa do Robot, para usar o Split String e dividir o nome no meio, sendo possivel pegar o primeiro nome (posicao 0) para identificar se estamos logados
    @{splited_name}    Split String    ${name}
    ${element}         Set Variable    css=header .right small

    # O localizador utilizado aqui foi o css, pois o texto pequeno "Ola, Iago" nao tinha caracteristicas (id, etc), entao localizamos atraves do elemento pai (header) e indicamos que fica a direita e que é um elemento small
    Wait For Elements State    ${element}
    ...    visible    5
    
    Get Text    ${element}    equal    Olá, ${splited_name}[0]

Go to task form
    Click    css=.button-add