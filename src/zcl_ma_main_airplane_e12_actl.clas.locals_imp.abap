*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

INTERFACE lif_partner.
  METHODS display_partner
    IMPORTING im_out TYPE REF TO if_oo_adt_classrun_out.
ENDINTERFACE.

CLASS lcl_rental DEFINITION.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        im_name TYPE string.

    INTERFACES lif_partner.

  PROTECTED SECTION.
    DATA name TYPE string.
ENDCLASS.


CLASS lcl_rental IMPLEMENTATION.
  METHOD lif_partner~display_partner.
    im_out->write( 'Displaying rental. ' && me->name ).
  ENDMETHOD.
  METHOD constructor.
    me->name = im_name.

  ENDMETHOD.
ENDCLASS.

CLASS lcl_airplane DEFINITION.
  PUBLIC SECTION.
    EVENTS airplane_created.
*   METHODS set_attributes
*      IMPORTING
*        im_name      TYPE string
*        im_planetype TYPE /dmo/plane_type_id.

    METHODS constructor
      IMPORTING
        im_name      TYPE string
        im_planetype TYPE /dmo/plane_type_id.

    METHODS display_attributes
      IMPORTING im_out TYPE REF TO if_oo_adt_classrun_out.

    CLASS-METHODS display_number_of_airplanes
      IMPORTING im_out TYPE REF TO if_oo_adt_classrun_out.

    CLASS-METHODS get_number_of_airplanes
      RETURNING VALUE(re_number_of_airplanes) TYPE i.

  PROTECTED SECTION.
    DATA name TYPE string.
    DATA planetype TYPE /dmo/plane_type_id.

  PRIVATE SECTION.
    CLASS-DATA number_of_airplanes TYPE i.

    METHODS get_technical_attributes
      IMPORTING im_planetype     TYPE /dmo/plane_type_id
*      EXPORTING ex_weight        TYPE ZRAPH_MA_AIRPLANE_WEIGHT
      EXPORTING ex_weight        TYPE i
*                ex_tank_capacity TYPE i gelöscht
      RAISING   zcx_ma_unknown_planetype.

ENDCLASS.

CLASS lcl_airplane IMPLEMENTATION.
*  METHOD set_attributes.
* me-> declare that this is the implementation variables.
* me-> Only we use it when we have the same name.
*    me->name = im_name.
*    me->planetype = im_planetype.
*    lcl_airplane=>number_of_airplanes = lcl_airplane=>number_of_airplanes + 1.
*  ENDMETHOD.
*  METHOD set_attributes.
*            name = im_name.
*            planetype = im_planetype.
*            number_of_airplanes = number_of_airplanes + 1.
*  ENDMETHOD.

  METHOD constructor.
    me->name = im_name.
    me->planetype = im_planetype.
    lcl_airplane=>number_of_airplanes = lcl_airplane=>number_of_airplanes + 1.
*RAISING EVENT
    RAISE EVENT airplane_created.

  ENDMETHOD.

*  METHOD display_attributes.
*    im_out->write( |{ me->name }: { me->planetype }| ).
*    im_out->write( |{ name }: { planetype }| ).
*    me->get_technical_attributes(
*        EXPORTING im_planetype = me->planetype
*        IMPORTING ex_weight = DATA(l_weight)
*    ).
*    im_out->write( |{ me->name }: { me->planetype }, weight: { l_weight }| ).
*  ENDMETHOD.

  METHOD display_attributes.
    TRY.
        me->get_technical_attributes(
            EXPORTING im_planetype = me->planetype
            IMPORTING ex_weight = DATA(l_weight)
        ).
        im_out->write( |{ me->name }: { me->planetype }, weight: { l_weight }| ).
      CATCH zcx_ma_unknown_planetype INTO DATA(lx_unknown_planetype).
        im_out->write( lx_unknown_planetype->get_text(  ) ).
        im_out->write( lx_unknown_planetype->planetype ).
        im_out->write( |{ me->name }: { me->planetype }, weight: unknown| ).
    ENDTRY.

  ENDMETHOD.

  METHOD display_number_of_airplanes.
*    im_out->write( |Number of airplanes: { lcl_airplane=>number_of_airplanes }| ).
    im_out->write( |Number of airplanes: { lcl_airplane=>number_of_airplanes }| ).
  ENDMETHOD.

  METHOD get_number_of_airplanes.
    re_number_of_airplanes = lcl_airplane=>number_of_airplanes.
*   re_number_of_airplanes = number_of_airplanes.
*Das ist falsch weil die attribute Name sind gleiche
  ENDMETHOD.

  METHOD get_technical_attributes.
    SELECT SINGLE weight
        FROM zraph_ma_airpln
        WHERE type_id = @im_planetype
        INTO @ex_weight.

    IF sy-subrc NE 0.
*      ex_weight = 100000.
      RAISE EXCEPTION TYPE zcx_ma_unknown_planetype EXPORTING im_planetype = im_planetype.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_passenger_plane DEFINITION INHERITING FROM lcl_airplane.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        im_name      TYPE string
        im_planetype TYPE /dmo/plane_type_id
        im_max_seats TYPE i.

    METHODS display_attributes REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA max_seats TYPE i.

ENDCLASS.

CLASS lcl_passenger_plane IMPLEMENTATION.

  METHOD constructor.
    super->constructor( im_name = im_name im_planetype = im_planetype ).
    me->max_seats = im_max_seats.
  ENDMETHOD.

  METHOD display_attributes.
* We cannot call get_technical_attributes directly, because it is private
*      me->get_technical_attributes(
*            exporting im_planetype = me->planetype
*            importing ex_weight = data(l_weight)
*        ).
*    im_out->write( |{ me->name }: { me->planetype }, weight: { l_weight }, max seats: { me->max_seats }| ).
    super->display_attributes( im_out = im_out ).
    im_out->write( |max seats: { me->max_seats }| ).
  ENDMETHOD.

ENDCLASS.

CLASS lcl_cargo_plane DEFINITION INHERITING FROM lcl_airplane.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        im_name      TYPE string
        im_planetype TYPE /dmo/plane_type_id
        im_max_cargo TYPE i.

    METHODS display_attributes REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA max_cargo TYPE i.

ENDCLASS.

CLASS lcl_cargo_plane IMPLEMENTATION.

  METHOD constructor.
    super->constructor( im_name = im_name im_planetype = im_planetype ).
    me->max_cargo = im_max_cargo.
  ENDMETHOD.

  METHOD display_attributes.
* We cannot call get_technical_attributes directly, because it is private
*      me->get_technical_attributes(
*            exporting im_planetype = me->planetype
*            importing ex_weight = data(l_weight)
*        ).
*    im_out->write( |{ me->name }: { me->planetype }, weight: { l_weight }, max cargo: { me->max_cargo }| ).
    super->display_attributes( im_out = im_out ).
    im_out->write( |max cargo: { me->max_cargo }| ).
  ENDMETHOD.

ENDCLASS.

CLASS lcl_carrier DEFINITION.

  PUBLIC SECTION.
    INTERFACES lif_partner.

    METHODS constructor
      IMPORTING
        im_name TYPE string.

    METHODS add_airplane
      IMPORTING
        im_airplane TYPE REF TO lcl_airplane.

    METHODS display_airplanes
      IMPORTING
        im_out TYPE REF TO if_oo_adt_classrun_out.

    METHODS display_attributes
      IMPORTING
        im_out TYPE REF TO if_oo_adt_classrun_out.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA name TYPE string.
    DATA airplanes TYPE TABLE OF REF TO lcl_airplane.

    METHODS on_airplane_created
      FOR EVENT airplane_created OF lcl_airplane
      IMPORTING sender.

ENDCLASS.

CLASS lcl_carrier IMPLEMENTATION.

  METHOD constructor.
    me->name = im_name.
*for event ACTIVATION X other wise nicht wird passiert es gibt auch ' ' = abap_false . abap_true = 'X'
*    SET HANDLER on_airplane_created FOR ALL INSTANCES ACTIVATION 'X'. default is ACTIVATION 'X'
    SET HANDLER on_airplane_created FOR ALL INSTANCES.
  ENDMETHOD.

  METHOD add_airplane.
    APPEND im_airplane TO me->airplanes.
  ENDMETHOD.

  METHOD lif_partner~display_partner.
    me->display_attributes(  im_out = im_out ).
  ENDMETHOD.

  METHOD display_airplanes.
    LOOP AT me->airplanes INTO DATA(l_airplane).
      l_airplane->display_attributes(  im_out ).
    ENDLOOP.
  ENDMETHOD.

  METHOD display_attributes.
    im_out->write( me->name ).
    me->display_airplanes(  im_out ).
  ENDMETHOD.

*event method
  METHOD on_airplane_created.
    me->add_airplane( sender ).
  ENDMETHOD.

ENDCLASS.

CLASS lcl_travel_agency DEFINITION.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        im_name TYPE string.

    METHODS add_partner
      IMPORTING
        im_partner TYPE REF TO lif_partner.

    METHODS display_agency_partners
      IMPORTING
        im_out TYPE REF TO if_oo_adt_classrun_out.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA name TYPE string.
    DATA partners TYPE TABLE OF REF TO lif_partner.

ENDCLASS.

CLASS lcl_travel_agency IMPLEMENTATION.

  METHOD constructor.
    me->name = im_name.
  ENDMETHOD.

  METHOD add_partner.
    APPEND im_partner TO me->partners.
  ENDMETHOD.

  METHOD display_agency_partners.
    im_out->write( me->name ).
    im_out->write(  '------' ).
    LOOP AT me->partners INTO DATA(partner).
      partner->display_partner(  im_out ).
      im_out->write(  '------' ).
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.