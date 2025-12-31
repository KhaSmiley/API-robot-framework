*** Keywords ***

Booking with one customer
    [Arguments]    ${firstname}    ${lastname}
    ${payload}=    Create Dictionary    firstname=${firstname}    lastname=${lastname}    totalprice=111    depositpaid=${true}
    ${booking_dates}=    Create Dictionary    checkin=2018-01-01    checkout=2019-01-01
    Set to Dictionary    ${payload}    bookingdates    ${booking_dates}
    ${response}    POST On Session    auth    /booking    json=${payload}
    RETURN    ${response}

Check reservation details
    [Arguments]    ${id}
    ${response}    GET On Session    auth    /booking/${id}
    RETURN    ${response}