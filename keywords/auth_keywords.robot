*** Keywords ***
Auth with Username and Password Valid
    [Arguments]    ${USERNAME}    ${PASSWORD}
    ${payload}=    Create Dictionary    username=${USERNAME}    password=${PASSWORD}
    ${response}=   POST On Session    auth    /auth    json=${payload}
    RETURN    ${response}

Auth with Only Username
    [Arguments]    ${USERNAME}
    ${payload}=    Create Dictionary    username=${USERNAME}
    ${response}=   POST On Session    auth    /auth    json=${payload}
    RETURN    ${response}

Auth with Only Password
    [Arguments]    ${PASSWORD}
    ${payload}=    Create Dictionary    password=${PASSWORD}
    ${response}=   POST On Session    auth    /auth    json=${payload}
    RETURN    ${response}