*** Settings ***
Documentation     API Tests for auth
...               Note: The API always returns HTTP 200, regardless of success or failure.
...               Authentication success is determined by the presence of a token in the response.
...               Valid credentials will include a 'token' field, while invalid credentials will not.
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

Unsuccessful Authentification (Nothing)
    ${response}=    Auth with Nothing
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Not Contain Key    ${response.json()}    token