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


Admin get the reseveration ids
    ${response}    GET On Session    auth    /booking
    Status Should Be    200    ${response}


Admin can check reservation details
    ${response}    Check reservation details
    Status Should Be    200    ${response}

