*** Settings ***
Library     SeleniumLibrary
Resource    common.robot

*** Variable ***
${login_btn}    dt_login_button
${email_field}  name=email

*** Test Cases ***
Open Deriv
    Login   ${my_email}     ${my_pw}    ${login_btn}    ${email_field}

Open Task3
    Task3

*** Keywords ***
Provided precondition
    Setup system under test