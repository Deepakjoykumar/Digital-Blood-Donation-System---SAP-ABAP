REPORT zbd_donation_report.

PARAMETERS:
  p_act TYPE c LENGTH 1 DEFAULT 'C',
  p_dnid TYPE zbd_donation-donation_id,
  p_did TYPE zbd_donation-donor_id,
  p_hid TYPE zbd_donation-hospital_id,
  p_bg TYPE zbd_donation-blood_group,
  p_date TYPE zbd_donation-donation_date DEFAULT sy-datum,
  p_qty TYPE zbd_donation-units_donated.

DATA: wa_donation TYPE zbd_donation.

START-OF-SELECTION.
  CASE p_act.
    WHEN 'C'.
      CLEAR wa_donation.
      wa_donation-donation_id   = p_dnid.
      wa_donation-donor_id      = p_did.
      wa_donation-hospital_id   = p_hid.
      wa_donation-blood_group   = p_bg.
      wa_donation-donation_date = p_date.
      wa_donation-units_donated = p_qty.
      INSERT zbd_donation FROM wa_donation.
      IF sy-subrc = 0.
        COMMIT WORK AND WAIT.
        WRITE: / 'Donation record created'.
      ELSE.
        ROLLBACK WORK.
        WRITE: / 'Donation record creation failed'.
      ENDIF.

    WHEN 'R'.
      SELECT SINGLE * FROM zbd_donation
        INTO @wa_donation
        WHERE donation_id = @p_dnid.
      IF sy-subrc = 0.
        WRITE: / wa_donation-donation_id, wa_donation-donor_id,
                 wa_donation-hospital_id, wa_donation-blood_group,
                 wa_donation-donation_date, wa_donation-units_donated.
      ELSE.
        WRITE: / 'Donation record not found'.
      ENDIF.

    WHEN 'D'.
      DELETE FROM zbd_donation WHERE donation_id = @p_dnid.
      IF sy-subrc = 0.
        COMMIT WORK AND WAIT.
        WRITE: / 'Donation record deleted'.
      ELSE.
        ROLLBACK WORK.
        WRITE: / 'Donation record not found'.
      ENDIF.

    WHEN OTHERS.
      WRITE: / 'Supported actions: C=Create, R=Read, D=Delete'.
  ENDCASE.
