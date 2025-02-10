*** Settings ***
Documentation    Acoes e elementos da pagina de listagem de tarefas

Library    Browser

*** Keywords ***
Task should be registred
    [Arguments]    ${task_name}

    Wait For Elements State    css=.task-todo>> text=${task_name}
    ...    visible    5
   
Task should be complete
    [Arguments]    ${task_name}
    
    ${element}    Set Variable    css=.task-done>> text=${task_name}

    Wait For Elements State    ${element}    
    ...    visible    5

    Get Style    ${element}    text-decoration-line    equal    line-through

Mark task as completed
    [Arguments]    ${task_name}

    ${element}    Set Variable      
    ...    xpath=//strong[text()="${task_name}"]/..//button[@class="item-toggle"]
    #O xpath acima foi o utilizado na aula
  
    Wait For Elements State    ${element}    visible    5

    Click    ${element}

    #Exemplo de xpath criado pelo ChatGPT ao enviar uma print da tela e pedir o XPATH = //strong[contains(text(), 'Criar uma nova IA')]/preceding-sibling::button[@class='item-toggle']

Request removal
    [Arguments]    ${task_name}

    ${element}    Set Variable
    ...    xpath=//strong[text()="${task_name}"]/..//button[@class="task-remove"]
    
    Wait For Elements State    ${element}    visible    5

    Click    ${element}

Task should not exist
    [Arguments]    ${task_name}

    Wait For Elements State    css=.task-todo>> text=${task_name}
    ...    detached    5