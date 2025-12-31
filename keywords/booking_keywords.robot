*** Keywords ***

Auth with valid credentials
    [Arguments]    ${USERNAME}    ${PASSWORD}
    ${payload}=    Create Dictionary    username=${USERNAME}    password=${PASSWORD}
    ${response}=   POST On Session    auth    /auth    json=${payload}
    RETURN    ${response}

Get admin token
    ${user}=    Create Dictionary    username=${USERNAME}    password=${PASSWORD}    
    ${get_token}=   POST On Session    auth    /auth    json=${user}
    ${token}=    Set Variable    ${get_token.json()}[token]
    RETURN    ${token}

Booking with one customer
    [Arguments]    ${firstname}    ${lastname}
    ${payload}=    Create Dictionary    firstname=${firstname}    lastname=${lastname}    totalprice=111    depositpaid=${true}
    ${booking_dates}=    Create Dictionary    checkin=2018-01-01    checkout=2019-01-01
    Set to Dictionary    ${payload}    bookingdates    ${booking_dates}
    ${response}    POST On Session    auth    /booking    json=${payload}
    RETURN    ${response}

Check booking details
    [Arguments]    ${id}
    ${response}    GET On Session    auth    /booking/${id}
    RETURN    ${response}

Modify booking partially
    [Arguments]    ${bookingid}    ${to_replace}    ${username}=${USERNAME}    ${password}=${PASSWORD}
    ${token}=      Get admin token
    ${headers}=    Create Dictionary    Cookie=token=${token}    Content-Type=application/json
    ${response}=   PATCH On Session    auth    /booking/${bookingid}    headers=${headers}    json=${to_replace}
    Status Should Be    200    ${response}
    RETURN      ${response}

Delete a booking
    [Arguments]    ${bookingid}
    ${token}=    Get admin token
    ${headers}=    Create Dictionary    Cookie=token=${token}
    ${response}=    DELETE On Session    auth    /booking/${bookingid}    headers=${headers}
    RETURN    ${response}