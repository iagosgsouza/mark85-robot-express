*** Settings ***
Documentation    Cenario de cadastro de tarefas

Resource    ../../resources/base.resource

Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve poder cadastrar uma nova tarefa

    ${data}    Get fixture    tasks    create

    Clean user from database     ${data}[user][email]
    Insert user from database    ${data}[user]

    
    Submit login form           ${data}[user]
    User should be logged in    ${data}[user][name]

    Go to task form  
    Submit task form            ${data}[task]
    Task should be registred    ${data}[task][name]

Nao deve cadastrar tarefa com nome duplicado
    [Tags]    dup

    ${data}    Get fixture    tasks    duplicate

    # Dado que eu tenho um novo usario
    Clean user from database     ${data}[user][email]
    Insert user from database    ${data}[user]

    # E que esse usario ja cadastrou uma tarefa
    POST user session    ${data}[user]
    POST a new task      ${data}[task]

    # E que estou logado na aplicacao web
    Submit login form           ${data}[user]
    User should be logged in    ${data}[user][name]

    # Quando faco um cadastro dessa mesma tarefa que ja foi cadastrada
    Go to task form
    Submit task form            ${data}[task]

    # Entao devo ver uma notificao de duplicidade
    Notice should be    Oops! Tarefa duplicada.

Nao deve cadastrar uma nova tarefa quando atinge o limite de tags
    [Tags]    tags_limit

    ${data}    Get fixture    tasks    tags_limit

    Clean user from database     ${data}[user][email]
    Insert user from database    ${data}[user]


    Submit login form           ${data}[user]
    User should be logged in    ${data}[user][name]

    Go to task form
    Submit task form            ${data}[task]

    Notice should be    Oops! Limite de tags atingido.


