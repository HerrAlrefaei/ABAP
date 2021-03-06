CLASS zabap010_ma_select_cust_itab DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZABAP010_MA_SELECT_CUST_ITAB IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    CONSTANTS: lc_customer_id TYPE /dmo/customer_id VALUE '000001'.

    DATA lt_travel TYPE ZRAPH_MA_TRAVEL_INFO_TAB.
    DATA ls_travel TYPE ZRAPH_MA_TRAVEL_INFO.
    DATA lv_concat TYPE string.

*ls_travel is a Structure
*lt_travel is a Table Type

    SELECT * FROM /dmo/travel
        WHERE customer_id = @lc_customer_id
            INTO CORRESPONDING FIELDS OF @ls_travel.

            ls_travel-dayamount = ls_travel-end_date - ls_travel-begin_date + 1.


                APPEND ls_travel TO lt_travel.

    ENDSELECT.

    SORT lt_travel BY dayamount.

    LOOP AT lt_travel INTO ls_travel.

        DATA(lv_dayamount) = CONV string( ls_travel-dayamount ).

        CONCATENATE ls_travel-travel_id
                    ls_travel-agency_id
                    ls_travel-customer_id
                    ls_travel-begin_date
                    ls_travel-end_date
                    lv_dayamount
                        INTO lv_concat SEPARATED BY space.
        out->write( EXPORTING data = lv_concat ).

    ENDLOOP.

*    out->write( EXPORTING data = lt_travel ).
  ENDMETHOD.
ENDCLASS.
