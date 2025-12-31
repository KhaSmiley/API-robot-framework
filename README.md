Robot Framework is implemented with Python, so you need to have Python installed.
On Windows machines, make sure to add Python to PATH during installation.

## Installing Robot Framework with pip is simple:
```bash
pip install robotframework
pip install robotframework-requests
```

## Run
```bash
robot test_cases/booking_tests.robot
```

## Structure
```
├── test_cases/
│   └── booking_tests.robot       # Tests E2E
├── keywords/
│   └── booking_keywords.robot    # Keywords
└── variables.robot                # Variables
```

## 📝 Données de test

### Création de réservations

**Réservation 1 :**
- Prénom : Jean
- Nom : Dupont
- Prix total : 111€
- Dépôt payé : Oui
- Check-in : 2018-01-01
- Check-out : 2019-01-01

**Réservation 2 :**
- Prénom : Pierre
- Nom : Dubois
- Prix total : 111€
- Dépôt payé : Oui
- Check-in : 2018-01-01
- Check-out : 2019-01-01

### Modification appliquée

**Sur la réservation 1 (Jean Dupont) :**
- Nouvelles dates : Check-in 2025-12-31, Check-out 2026-01-01
- Besoins additionnels : Breakfast

**Format JSON (PATCH) :**
```json
{
  "bookingdates": {
    "checkin": "2025-12-01",
    "checkout": "2026-01-01"
  },
  "additionalneeds": "Breakfast"
}
```

Documentation : https://restful-booker.herokuapp.com/apidoc/index.html