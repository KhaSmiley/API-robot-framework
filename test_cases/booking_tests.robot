*** Settings ***
Library           RequestsLibrary
Library           Collections
Resource         ../keywords/booking_keywords.robot
Resource         ../variables.robot
Suite Setup       Create Session    auth    ${URL}

*** Test Cases ***

Successful Authentication
    ${response}=    Auth with valid credentials    ${USERNAME}    ${PASSWORD}
    Status Should Be    200    ${response}
    Dictionary Should Contain Key    ${response.json()}    token

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
    ${create_user}=    Booking with one customer    ToCheck    Test
    ${id}=    Set Variable    ${create_user.json()['bookingid']}
    ${response}    Check booking details    ${id}
    Status Should Be    200    ${response}

Admin can modify a booking partially and system check
    ${create_user}=    Booking with one customer    ToModify    Test
    ${id}=    Set Variable    ${create_user.json()['bookingid']}
    ${replace}=    Create Dictionary    firstname=Patricia    additionalneeds=Dinner    
    ${response}=    Modify booking partially    ${id}    ${replace}
    Status Should Be    200    ${response}
    Should Be Equal    ${response.json()['firstname']}       ${replace['firstname']}
    Should Be Equal    ${response.json()['additionalneeds']}  ${replace['additionalneeds']}

Admin can delete a booking and system check
    ${response}=    Booking with one customer    ToDelete    Test
    ${id}=    Set Variable    ${response.json()['bookingid']}
    ${response}=    Delete a booking    ${id}
    Status Should Be    201    ${response}


Complete Booking
    [Documentation]    Test E2E complet

    # Authentification
    ${auth_response}=    Auth with valid credentials    ${USERNAME}    ${PASSWORD}
    Status Should Be    200    ${auth_response}
    
    # Creer 2 reservations pour differents clients
    ${booking_1}=    Booking with one customer    Jean    Dupont
    ${id_1}=    Set Variable    ${booking_1.json()['bookingid']}

    ${booking_2}=    Booking with one customer    Pierre    Dubois
    ${id_2}=    Set Variable    ${booking_2.json()['bookingid']}

    # Recup ids des reservations
    ${all_bookings}    GET On Session    auth    /booking
    Status Should Be    200    ${all_bookings}
    
    # Consulter le détail d'une réservation
    ${booking_details_1}=    Check booking details    ${id_1}
    Status Should Be    200    ${booking_details_1}
    Should Be Equal    ${booking_details_1.json()['firstname']}    Jean
    
    # Modifier partiellement une réservation existante
    ${booking_dates}=    Create Dictionary    checkin=2025-12-31    checkout=2026-01-01
    ${replace}=    Create Dictionary    bookingdates=${booking_dates}    additionalneeds=Breakfast
    ${modified_booking}=    Modify booking partially    ${id_1}    ${replace}
    
    # Confirmation systeme des modifs
    Status Should Be    200    ${modified_booking}
    Should Be Equal    ${modified_booking.json()['bookingdates']['checkin']}    2025-12-31
    Should Be Equal    ${modified_booking.json()['bookingdates']['checkout']}    2026-01-01
    Should Be Equal    ${modified_booking.json()['additionalneeds']}    Breakfast

    # Supprimer une réservation et confirmation systeme
    ${delete_response}=    Delete a booking    ${id_2}
    Status Should Be    201    ${delete_response}
