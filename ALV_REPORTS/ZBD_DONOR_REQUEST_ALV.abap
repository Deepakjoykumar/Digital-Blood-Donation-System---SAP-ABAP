REPORT zbd_donor_request_alv.

TABLES: zbd_donor.

SELECT-OPTIONS: s_bg FOR zbd_donor-blood_group,
                s_city FOR zbd_donor-city.

DATA: gt_donor TYPE STANDARD TABLE OF zbd_donor,
      go_alv   TYPE REF TO cl_salv_table.

START-OF-SELECTION.
  SELECT *
    FROM zbd_donor
    WHERE blood_group IN @s_bg
      AND city IN @s_city
      AND availability = 'Y'
    INTO TABLE @gt_donor.

  IF gt_donor IS INITIAL.
    MESSAGE 'No available donor profiles match the selection' TYPE 'I'.
    RETURN.
  ENDIF.

  TRY.
      cl_salv_table=>factory(
        IMPORTING r_salv_table = go_alv
        CHANGING  t_table      = gt_donor ).
      go_alv->get_functions( )->set_all( abap_true ).
      go_alv->get_columns( )->set_optimize( abap_true ).
      go_alv->display( ).
    CATCH cx_salv_msg.
      MESSAGE 'Unable to display donor ALV' TYPE 'E'.
  ENDTRY.
