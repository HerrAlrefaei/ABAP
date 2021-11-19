CLASS zabap010_ma_compute DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZABAP010_MA_COMPUTE IMPLEMENTATION.


    METHOD if_oo_adt_classrun~main.

        DATA : lv_int1 TYPE i,
               lv_int2 LIKE lv_int1,
               lv_op(1) TYPE c,
               lv_result TYPE p DECIMALS 2.
        lv_int1 = 0.
        lv_op = '/'.
        lv_int2 = 000.

        IF NOT ( lv_op = '+' OR
                 lv_op = '-' OR
                 lv_op = '*' OR
                 lv_op = '/' ).

            out->write( EXPORTING data = 'Invalid operator.' ).

        ELSEIF lv_op = '/' AND
               lv_int2 = 0.

            out->write( EXPORTING data = 'Division by zero.' ).

        ELSE.
            CASE lv_op.
                WHEN '+'.
                    lv_result = lv_int1 + lv_int2.
                WHEN '-'.
                    lv_result = lv_int1 - lv_int2.
                WHEN '*'.
                    lv_result = lv_int1 * lv_int2.
                WHEN '/'.
                    lv_result = lv_int1 / lv_int2.
            ENDCASE.

            DATA(lv_result_out) = |Result: | && lv_result.
            out->write( EXPORTING data = lv_result_out ).


        ENDIF.



    ENDMETHOD.
ENDCLASS.
