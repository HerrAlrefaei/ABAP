CLASS zabap010_ma_itab_loop DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZABAP010_MA_ITAB_LOOP IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*    DATA lc_index TYPE i VALUE '5'.
    CONSTANTS: lc_index TYPE i VALUE '5'.
*    CONSTANTS: lc_index TYPE i VALUE '45'.



* /dmo/flight is Database Table  ... /dmo/t_flight is Table Type
    DATA lt_flight TYPE /dmo/t_flight.
    DATA ls_flight TYPE /dmo/flight.

    SELECT * FROM /dmo/flight INTO TABLE @lt_flight.

    TRY.
        ls_flight = lt_flight[ lc_index ].
        MESSAGE ID 'ZABAP010_MA' TYPE 'I' NUMBER '001' WITH lc_index INTO DATA(lv_msg).
        out->write( EXPORTING data = lv_msg ).
        out->write( EXPORTING data = ls_flight ).
        out->write( EXPORTING data = '------------------------------------------' ).
    CATCH cx_sy_itab_line_not_found.
        MESSAGE ID 'ZABAP010_MA' TYPE 'I' NUMBER '002' WITH 5 INTO lv_msg.
           out->write( EXPORTING data = lv_msg ).
    ENDTRY.


    LOOP AT lt_flight INTO ls_flight.
        out->write( EXPORTING data = ls_flight ).
    ENDLOOP.


  ENDMETHOD.
ENDCLASS.
