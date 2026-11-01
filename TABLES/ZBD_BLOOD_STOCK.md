# ZBD_BLOOD_STOCK – SE11 specification

| Field | Suggested type | Key | Description |
|---|---|---:|---|
| MANDT | MANDT | Yes | Client |
| HOSPITAL_ID | CHAR10 | Yes | Hospital identifier |
| BLOOD_GROUP | CHAR3 | Yes | Blood group |
| UNITS_AVAILABLE | INT4 | No | Available units |
| LAST_UPDATED | DATS | No | Stock update date |

Use the combined key MANDT + HOSPITAL_ID + BLOOD_GROUP. Create and activate as a transparent table.
