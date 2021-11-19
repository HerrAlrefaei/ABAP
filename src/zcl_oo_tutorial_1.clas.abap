CLASS zcl_oo_tutorial_1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
    TYPES:
             sample_table_type TYPE STANDARD TABLE OF string.
    DATA sample_internal_table TYPE sample_table_type.

*    ! <p class="shorttext synchronized" lang="en>My First Method</p>

    METHODS my_first_method
        IMPORTING
                        !import TYPE string "import parameter"
        RETURNING VALUE(export) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_oo_tutorial_1 IMPLEMENTATION.

  METHOD my_first_method.
    export = import.
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
    out->write( 'Starting OO #1 Test' ).
    out->write( me->my_first_method( 'Input Value' ) ).
  ENDMETHOD.

ENDCLASS.
