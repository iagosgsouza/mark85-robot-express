*** Settings ***
Documentation    Cenarios de autenticacao do usuario

Library     Collections
Resource    ../resources/base.resource

Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***

Deve poder logar com um usuario pre-cadastrado

    ${user}    Create Dictionary
    ...        name=Iago Souza
    ...        email=iago.souza@hotmail.com
    ...        password=pwd123
   
    Remove user from database    ${user}[email]
    Insert user from database    ${user}
    
    Submit login form           ${user}
    User should be logged in    ${user}[name]

Nao deve logar com senha invalida

    ${user}    Create Dictionary
    ...        name=Steve Woz
    ...        email=woz@apple.com
    ...        password=123456
   
    Remove user from database    ${user}[email]
    Insert user from database    ${user}
    
    Set To Dictionary    ${user}    password=pwd123

    Submit login form    ${user}
    Notice should be     Ocorreu um erro ao fazer login, verifique suas credenciais.
