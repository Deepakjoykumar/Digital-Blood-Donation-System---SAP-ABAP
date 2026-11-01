REPORT zbd_blood_inventory_alv.

TABLES: zbd_blood_stock.

SELECT-OPTIONS: s_hid FOR zbd_blood_stock-hospital_id,
                s_bg  FOR zbd_blood_stock-blood_group.

DATA: gt_stock TYPE STANDARD TABLE OF zbd_blood_stock,
      go_alv   TYPE REF TO cl_salv_table.

START-OF-SELECTION.
  SELECT *
    FROM zbd_blood_stock
    WHERE hospital_id IN @s_hid
      AND blood_group IN @s_bg
    INTO TABLE @gt_stock.

  IF gt_stock IS INITIAL.
    MESSAGE 'No blood inventory records found' TYPE 'I'.
    RETURN.
  ENDIF.

  TRY.
      cl_salv_table=>factory(
        IMPORTING r_salv_table = go_alv
        CHANGING  t_table      = gt_stock ).
      go_alv->get_functions( )->set_all( abap_true ).
      go_alv->get_columns( )->set_optimize( abap_true ).
      go_alv->display( ).
    CATCH cx_salv_msg.
      MESSAGE 'Unable to display blood inventory ALV' TYPE 'E'.
  ENDTRY.
