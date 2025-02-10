*** Settings ***
Documentation    Cenario de testes do cadastro de usuarios
Library          FakerLibrary
Resource         ../resources/base.resource

Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve poder cadastrar um novo usuario

    ${user}    Create Dictionary
    ...    name=Iago Souza
    ...    email=iago.souza@hotmail.com
    ...    password=pwd123

    Remove user from database    ${user}[email]
    
    Go to signup page
    Submit signup form    ${user}
    Notice should be      Boas vindas ao Mark85, o seu gerenciador de tarefas.

Não deve permitir o cadastro com email duplicado
    [Tags]    dup

    ${user}    Create Dictionary
    ...    name=Leia
    ...    email=leia@hotmail.com
    ...    password=pwd123
    
    Remove user from database    ${user}[email]
    Insert user from database    ${user}
    
    Go to signup page
    Submit signup form    ${user}
    Notice should be      Oops! Já existe uma conta com o e-mail informado.

Campos obrigatorios
    [Tags]    required

    ${user}    Create Dictionary
    ...        name=${EMPTY}
    ...        email=${EMPTY}
    ...        password=${EMPTY}
    
    Go to signup page
    Submit signup form    ${user}

    Alert should be    Informe seu nome completo
    Alert should be    Informe seu e-email
    Alert should be    Informe uma senha com pelo menos 6 digitos

Nao deve cadastrar com senha muito curta
    [Tags]    temp

    @{password_list}    Create List    1    12    123    1234    12345

    FOR    ${password}    IN    @{password_list}
     ${user}    Create Dictionary
    ...    name=Filo
    ...    email=filo@hotmail.com
    ...    password=${password}
    
    Go to signup page
    Submit signup form    ${user}

    Alert should be    Informe uma senha com pelo menos 6 digitos
        
    END

Nao deve cadastrar com email incorreto
    [Tags]    inv_email

    ${user}    Create Dictionary
    ...        name=Raya
    ...        email=raya.com.br
    ...        password=pwd123
   
    Go to signup page
    Submit signup form     ${user}
    Alert should be        Digite um e-mail válido

Nao deve cadastrar com senha de 1 digito
    [Tags]    short_pass
    [Template]
    Short password    1

Nao deve cadastrar com senha de 2 digitos
    [Tags]    short_pass
    [Template]
    Short password    12

Nao deve cadastrar com senha de 3 digitos
    [Tags]    short_pass
    [Template]
    Short password    123

Nao deve cadastrar com senha de 4 digitos
    [Tags]    short_pass
    [Template]
    Short password    1234

Nao deve cadastrar com senha de 5 digitos
    [Tags]    short_pass
    [Template]
    Short password    12345
