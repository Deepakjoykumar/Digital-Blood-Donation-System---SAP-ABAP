# ZBD_REQUEST – SE11 specification

| Field | Suggested type | Key | Description |
|---|---|---:|---|
| MANDT | MANDT | Yes | Client |
| REQUEST_ID | CHAR10 | Yes | Request identifier |
| HOSPITAL_ID | CHAR10 | No | Requesting hospital |
| BLOOD_GROUP | CHAR3 | No | Required blood group |
| UNITS_REQUIRED | INT4 | No | Units requested |
| REQUEST_DATE | DATS | No | Request date |
| STATUS | CHAR15 | No | OPEN/MATCHED/CLOSED |

Create and activate as a transparent table. Consider foreign keys to the hospital table.
