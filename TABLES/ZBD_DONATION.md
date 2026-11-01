# ZBD_DONATION – SE11 specification

| Field | Suggested type | Key | Description |
|---|---|---:|---|
| MANDT | MANDT | Yes | Client |
| DONATION_ID | CHAR10 | Yes | Donation record identifier |
| DONOR_ID | CHAR10 | No | Donor identifier |
| HOSPITAL_ID | CHAR10 | No | Hospital identifier |
| BLOOD_GROUP | CHAR3 | No | Donated blood group |
| DONATION_DATE | DATS | No | Donation date |
| UNITS_DONATED | INT4 | No | Units recorded |

Create and activate as a transparent table. Add suitable foreign-key relationships where appropriate.
