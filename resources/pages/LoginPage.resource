*** Settings ***
Documentation    Acoes e elementos da pagina de login

Library    Browser
Resource    components/notice.resource

*** Keywords ***
Submit login form
    [Arguments]    ${user}
    # Aqui, para localizar o elemento na pagina web, usou-se o placeholder, que pode ser localizado da forma apresentada abaixo
    # O cifrao $ foi utilizado para indicar que o campo a ser localizado termina com 'mail'
    Fill Text    css=input[placeholder$=mail]    ${user}[email]
    Fill Text    css=input[placeholder=Senha]    ${user}[password]
    # Aqui, deixei o XPATH para ter um exemplo de como localizar um elemento utilizando XPATH
    # Poderia ter sido feito com localizador css, sendo 'css=buton >> text=Entrar'
    Click        xpath=//button[text()="Entrar"]        