*** Settings ***
Documentation    Acoes e elementos da pagina de cadastro de tarefas

Library    Browser

*** Keywords ***
Submit task form
    [Arguments]    ${task}
# para buscar elementos no css, ao usar ^ = começa com, $ = termina com e * = contém.
    Fill Text    css=input[placeholder$=tarefa]    ${task}[name]
    
    ${tags_ement}    Set Variable    css=input[name=tags]

    FOR    ${tag}    IN    @{task}[tags]
        Fill Text     ${tags_ement}    ${tag}
        Sleep    1
        Press Keys    ${tags_ement}    Enter 
    END

    Click    css=button >> text=Cadastrar
 