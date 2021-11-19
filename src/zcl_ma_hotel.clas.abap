CLASS zcl_ma_hotel DEFINITION PUBLIC.


  PUBLIC SECTION.
  INTERFACES zif_ma_partner_act.
    METHODS constructor
        IMPORTING
        im_name TYPE string
        im_max_bed TYPE i.

     METHODS display_attributes
        IMPORTING
            im_out TYPE REF TO  if_oo_adt_classrun_out .

  PROTECTED SECTION.

  PRIVATE SECTION.
  DATA name TYPE string.
  DATA max_bed TYPE i.

ENDCLASS.



CLASS zcl_ma_hotel IMPLEMENTATION.

   METHOD constructor.
        me->name = im_name.
        me->max_bed = im_max_bed.
   ENDMETHOD.

   METHOD display_attributes.
        im_out->write( |{ me->name }: { me->max_bed }| ).
     ENDMETHOD.

   METHOD
        zif_ma_partner_act~display_partner.
        me->display_attributes( im_out ).
   ENDMETHOD.

ENDCLASS.
