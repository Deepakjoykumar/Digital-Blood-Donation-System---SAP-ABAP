# ZBD_DONOR – SE11 specification

| Field | Suggested type | Key | Description |
|---|---|---:|---|
| MANDT | MANDT | Yes | Client |
| DONOR_ID | CHAR10 | Yes | Donor identifier |
| DONOR_NAME | CHAR40 | No | Donor name |
| BLOOD_GROUP | CHAR3 | No | A+, A-, B+, B-, AB+, AB-, O+, O- |
| PHONE | CHAR15 | No | Contact number |
| CITY | CHAR30 | No | City |
| LAST_DONATION | DATS | No | Last donation date |
| AVAILABILITY | CHAR1 | No | Y/N availability flag |

Create as a transparent table. Use suitable data elements/domains and activate it.
