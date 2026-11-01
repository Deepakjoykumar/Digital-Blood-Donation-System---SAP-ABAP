REPORT zbd_hospital_report.

PARAMETERS:
  p_act  TYPE c LENGTH 1 DEFAULT 'R',
  p_hid  TYPE zbd_hospital-hospital_id,
  p_name TYPE zbd_hospital-hospital_name,
  p_city TYPE zbd_hospital-city,
  p_ph   TYPE zbd_hospital-phone.

DATA: wa_hospital TYPE zbd_hospital.

START-OF-SELECTION.
  CASE p_act.
    WHEN 'C'.
      CLEAR wa_hospital.
      wa_hospital-hospital_id   = p_hid.
      wa_hospital-hospital_name = p_name.
      wa_hospital-city          = p_city.
      wa_hospital-phone         = p_ph.
      INSERT zbd_hospital FROM wa_hospital.
      IF sy-subrc = 0.
        COMMIT WORK AND WAIT.
        WRITE: / 'Hospital registered'.
      ELSE.
        ROLLBACK WORK.
        WRITE: / 'Registration failed; check key and table definition'.
      ENDIF.

    WHEN 'R'.
      SELECT SINGLE * FROM zbd_hospital
        INTO @wa_hospital
        WHERE hospital_id = @p_hid.
      IF sy-subrc = 0.
        WRITE: / wa_hospital-hospital_id, wa_hospital-hospital_name,
                 wa_hospital-city, wa_hospital-phone.
      ELSE.
        WRITE: / 'Hospital not found'.
      ENDIF.

    WHEN 'U'.
      UPDATE zbd_hospital
        SET hospital_name = @p_name,
            city          = @p_city,
            phone         = @p_ph
        WHERE hospital_id = @p_hid.
      IF sy-subrc = 0.
        COMMIT WORK AND WAIT.
        WRITE: / 'Hospital details updated'.
      ELSE.
        ROLLBACK WORK.
        WRITE: / 'Hospital not found or update failed'.
      ENDIF.

    WHEN 'D'.
      DELETE FROM zbd_hospital WHERE hospital_id = @p_hid.
      IF sy-subrc = 0.
        COMMIT WORK AND WAIT.
        WRITE: / 'Hospital deleted'.
      ELSE.
        ROLLBACK WORK.
        WRITE: / 'Hospital not found'.
      ENDIF.

    WHEN OTHERS.
      WRITE: / 'Use C=Create, R=Read, U=Update, D=Delete'.
  ENDCASE.
