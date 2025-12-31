*** Settings ***
Documentation     Test API pour un système de gestion de réservations hôtelières
Library           RequestsLibrary
Library           Collections
Resource         ../variables.robot
Resource         ../keywords/auth_keywords.robot
Suite Setup       Create Session    auth    ${URL}

*** Test Cases ***
Successful Authentication
    ${response}=    Auth with Username and Password Valid    ${USERNAME}    ${PASSWORD}
    Status Should Be    200    ${response}
    Dictionary Should Contain Key    ${response.json()}    token

Unsuccessful Authentification (No Password)
    ${response}=    Auth with Only Username    ${USERNAME}
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Not Contain Key    ${response.json()}    token

Unsuccessful Authentification (No Username)
    ${response}=    Auth with Only Password    ${PASSWORD}
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Not Contain Key    ${response.json()}    token