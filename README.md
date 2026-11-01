# Digital Blood Donation Management System – SAP ABAP

A sample SAP ABAP project for maintaining donor profiles, hospital information, blood stock, donation requests and donation records.

## Prerequisites
Create and activate the transparent tables described in `TABLES/` using SE11 before running the reports:
- `ZBD_DONOR`
- `ZBD_HOSPITAL`
- `ZBD_BLOOD_STOCK`
- `ZBD_REQUEST`
- `ZBD_DONATION`

The ABAP reports reference these table and field names. Adjust data elements and syntax for your SAP release.

## Repository structure
- `REPORTS/` – donor, hospital, blood-stock and request CRUD reports.
- `TABLES/` – SE11 table specifications.
- `ALV_REPORTS/` – blood inventory and donation-request ALV reports.
- `MODULES/` – module documentation.
- `SCREENSHOTS/` – add screenshots from your SAP system.

## Setup
1. Create the five transparent tables in SE11 with the fields documented in `TABLES/`.
2. Activate all tables.
3. Create each report in SE38/SE80 using its filename as the program name.
4. Paste the ABAP source, activate, and test with fictional records.
5. Add screenshots of selection screens and ALV output.

## Privacy and safety
Use fictional test data in this public repository. Do not upload real donor names, phone numbers, addresses, medical details, credentials or confidential hospital information. This sample is for learning and is not a production blood-bank system.
