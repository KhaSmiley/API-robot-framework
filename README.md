Robot Framework is implemented with Python, so you need to have Python installed.
On Windows machines, make sure to add Python to PATH during installation.

## Installing Robot Framework with pip is simple:
```bash
pip install robotframework
pip install robotframework-requests
```

## Exécution
```bash
robot test_cases/booking_tests.robot
```

## Structure
```
├── test_cases/
│   └── booking_tests.robot       # Tests E2E
├── keywords/
│   └── booking_keywords.robot    # Keywords réutilisables
└── variables.robot                # Configuration
```

Documentation : https://restful-booker.herokuapp.com/apidoc/index.html