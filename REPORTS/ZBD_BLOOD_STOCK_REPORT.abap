REPORT zbd_blood_stock_report.

PARAMETERS:
  p_act TYPE c LENGTH 1 DEFAULT 'R',
  p_hid TYPE zbd_blood_stock-hospital_id,
  p_bg  TYPE zbd_blood_stock-blood_group,
  p_qty TYPE zbd_blood_stock-units_available.

DATA: wa_stock TYPE zbd_blood_stock.

START-OF-SELECTION.
  CASE p_act.
    WHEN 'C'.
      CLEAR wa_stock.
      wa_stock-hospital_id     = p_hid.
      wa_stock-blood_group     = p_bg.
      wa_stock-units_available = p_qty.
      wa_stock-last_updated    = sy-datum.
      INSERT zbd_blood_stock FROM wa_stock.
      IF sy-subrc = 0.
        COMMIT WORK AND WAIT.
        WRITE: / 'Blood stock record created'.
      ELSE.
        ROLLBACK WORK.
        WRITE: / 'Create failed; record may already exist'.
      ENDIF.

    WHEN 'R'.
      SELECT SINGLE * FROM zbd_blood_stock
        INTO @wa_stock
        WHERE hospital_id = @p_hid
          AND blood_group = @p_bg.
      IF sy-subrc = 0.
        WRITE: / wa_stock-hospital_id, wa_stock-blood_group,
                 wa_stock-units_available, wa_stock-last_updated.
      ELSE.
        WRITE: / 'Stock record not found'.
      ENDIF.

    WHEN 'U'.
      UPDATE zbd_blood_stock
        SET units_available = @p_qty,
            last_updated    = @sy-datum
        WHERE hospital_id = @p_hid
          AND blood_group = @p_bg.
      IF sy-subrc = 0.
        COMMIT WORK AND WAIT.
        WRITE: / 'Blood stock updated'.
      ELSE.
        ROLLBACK WORK.
        WRITE: / 'Stock record not found or update failed'.
      ENDIF.

    WHEN 'D'.
      DELETE FROM zbd_blood_stock
        WHERE hospital_id = @p_hid
          AND blood_group = @p_bg.
      IF sy-subrc = 0.
        COMMIT WORK AND WAIT.
        WRITE: / 'Blood stock record deleted'.
      ELSE.
        ROLLBACK WORK.
        WRITE: / 'Stock record not found'.
      ENDIF.

    WHEN OTHERS.
      WRITE: / 'Use C=Create, R=Read, U=Update, D=Delete'.
  ENDCASE.
