CLASS zcl_ma_main_airplane_e2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ma_main_airplane_e2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    out->write( 'Hello Airplanes' ).

  ENDMETHOD.
ENDCLASS.

