*** Settings ***
Library           RequestsLibrary
Library           Collections
Resource         ../keywords/booking_keywords.robot
Resource         ../variables.robot
Suite Setup       Create Session    auth    ${URL}

*** Test Cases ***

Booking with multiple customers
    ${response}    Booking with one customer        Jean    Dupont
    Status Should Be    200    ${response}
    Dictionary Should Contain Key    ${response.json()}    bookingid
    ${response}    Booking with one customer        Pierre    Dubois
    Status Should Be    200    ${response}
    Dictionary Should Contain Key    ${response.json()}    bookingid


Admin get the booking ids
    ${response}    GET On Session    auth    /booking
    Status Should Be    200    ${response}


Admin can check booking details
    ${response}    Check booking details    1
    Status Should Be    200    ${response}

Admin can modify a booking partially and system check
    ${id}=    Set Variable    1
    ${replace}=    Create Dictionary    firstname=Patricia    additionalneeds=Dinner    
    ${response}=    Modify Booking Partially    ${id}    ${replace}
    Status Should Be    200    ${response}
    # System check
    ${check}=    GET On Session    auth    /booking/${id}
    Should Be Equal    ${check.json()['firstname']}       ${replace['firstname']}
    Should Be Equal    ${check.json()['additionalneeds']}  ${replace['additionalneeds']}
