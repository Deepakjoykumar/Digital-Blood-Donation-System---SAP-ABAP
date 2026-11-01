REPORT zbd_request_report.

PARAMETERS:
  p_act TYPE c LENGTH 1 DEFAULT 'R',
  p_rid TYPE zbd_request-request_id,
  p_hid TYPE zbd_request-hospital_id,
  p_bg  TYPE zbd_request-blood_group,
  p_qty TYPE zbd_request-units_required,
  p_stat TYPE zbd_request-status DEFAULT 'OPEN'.

DATA: wa_request TYPE zbd_request.

START-OF-SELECTION.
  CASE p_act.
    WHEN 'C'.
      CLEAR wa_request.
      wa_request-request_id    = p_rid.
      wa_request-hospital_id   = p_hid.
      wa_request-blood_group   = p_bg.
      wa_request-units_required = p_qty.
      wa_request-request_date  = sy-datum.
      wa_request-status        = p_stat.
      INSERT zbd_request FROM wa_request.
      IF sy-subrc = 0.
        COMMIT WORK AND WAIT.
        WRITE: / 'Blood request created'.
      ELSE.
        ROLLBACK WORK.
        WRITE: / 'Request creation failed; check key and table definition'.
      ENDIF.

    WHEN 'R'.
      SELECT SINGLE * FROM zbd_request
        INTO @wa_request
        WHERE request_id = @p_rid.
      IF sy-subrc = 0.
        WRITE: / wa_request-request_id, wa_request-hospital_id,
                 wa_request-blood_group, wa_request-units_required,
                 wa_request-request_date, wa_request-status.
      ELSE.
        WRITE: / 'Request not found'.
      ENDIF.

    WHEN 'U'.
      UPDATE zbd_request
        SET hospital_id    = @p_hid,
            blood_group    = @p_bg,
            units_required = @p_qty,
            status         = @p_stat
        WHERE request_id = @p_rid.
      IF sy-subrc = 0.
        COMMIT WORK AND WAIT.
        WRITE: / 'Request status/details updated'.
      ELSE.
        ROLLBACK WORK.
        WRITE: / 'Request not found or update failed'.
      ENDIF.

    WHEN 'D'.
      DELETE FROM zbd_request WHERE request_id = @p_rid.
      IF sy-subrc = 0.
        COMMIT WORK AND WAIT.
        WRITE: / 'Request deleted'.
      ELSE.
        ROLLBACK WORK.
        WRITE: / 'Request not found'.
      ENDIF.

    WHEN OTHERS.
      WRITE: / 'Use C=Create, R=Read, U=Update, D=Delete'.
  ENDCASE.
