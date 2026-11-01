REPORT zbd_donor_report.

PARAMETERS:
  p_act  TYPE c LENGTH 1 DEFAULT 'R',
  p_did  TYPE zbd_donor-donor_id,
  p_name TYPE zbd_donor-donor_name,
  p_bg   TYPE zbd_donor-blood_group,
  p_ph   TYPE zbd_donor-phone,
  p_city TYPE zbd_donor-city,
  p_last TYPE zbd_donor-last_donation,
  p_avail TYPE zbd_donor-availability DEFAULT 'Y'.

DATA: wa_donor TYPE zbd_donor.

START-OF-SELECTION.
  CASE p_act.
    WHEN 'C'.
      CLEAR wa_donor.
      wa_donor-donor_id      = p_did.
      wa_donor-donor_name    = p_name.
      wa_donor-blood_group   = p_bg.
      wa_donor-phone         = p_ph.
      wa_donor-city          = p_city.
      wa_donor-last_donation = p_last.
      wa_donor-availability  = p_avail.
      INSERT zbd_donor FROM wa_donor.
      IF sy-subrc = 0.
        COMMIT WORK AND WAIT.
        WRITE: / 'Donor profile created'.
      ELSE.
        ROLLBACK WORK.
        WRITE: / 'Create failed; check key and table definition'.
      ENDIF.

    WHEN 'R'.
      SELECT SINGLE * FROM zbd_donor
        INTO @wa_donor
        WHERE donor_id = @p_did.
      IF sy-subrc = 0.
        WRITE: / wa_donor-donor_id, wa_donor-donor_name,
                 wa_donor-blood_group, wa_donor-city,
                 wa_donor-availability.
      ELSE.
        WRITE: / 'Donor not found'.
      ENDIF.

    WHEN 'U'.
      UPDATE zbd_donor
        SET donor_name    = @p_name,
            blood_group   = @p_bg,
            phone         = @p_ph,
            city          = @p_city,
            last_donation = @p_last,
            availability  = @p_avail
        WHERE donor_id = @p_did.
      IF sy-subrc = 0.
        COMMIT WORK AND WAIT.
        WRITE: / 'Donor profile updated'.
      ELSE.
        ROLLBACK WORK.
        WRITE: / 'Donor not found or update failed'.
      ENDIF.

    WHEN 'D'.
      DELETE FROM zbd_donor WHERE donor_id = @p_did.
      IF sy-subrc = 0.
        COMMIT WORK AND WAIT.
        WRITE: / 'Donor profile deleted'.
      ELSE.
        ROLLBACK WORK.
        WRITE: / 'Donor not found'.
      ENDIF.

    WHEN OTHERS.
      WRITE: / 'Use C=Create, R=Read, U=Update, D=Delete'.
  ENDCASE.
