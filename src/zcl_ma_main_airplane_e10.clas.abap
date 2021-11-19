CLASS zcl_ma_main_airplane_e10 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_MA_MAIN_AIRPLANE_E10 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA l_rental TYPE REF TO lcl_rental.

    DATA l_carrier TYPE REF TO lcl_carrier.
    DATA l_basic_airplane TYPE REF TO lcl_airplane.
    DATA l_cargo_plane TYPE REF TO lcl_cargo_plane.
    DATA l_passenger_plane TYPE REF TO lcl_passenger_plane.

* schön gemacht in Local Type
*    DATA airplanes TYPE TABLE OF REF TO lcl_airplane.
*    lcl_airplane=>display_number_of_airplanes(  out ).

    l_rental = NEW #( im_name = 'ABC' ).


    l_carrier = new #( 'WEFEL - We fly everything lines' ).

    l_basic_airplane = NEW #( im_name = 'Basic Plane' im_planetype = 'A320-200' ).
    l_carrier->add_airplane( l_basic_airplane ).

    l_cargo_plane = NEW #( im_name = 'Cargo Plane' im_planetype = '747-400' im_max_cargo = 1000 ).
    l_carrier->add_airplane( l_cargo_plane ).

    l_passenger_plane = NEW #( im_name = 'Passenger Plane' im_planetype = 'Airbus'  im_max_seats = 500 ).
    l_carrier->add_airplane( l_passenger_plane ).

    l_carrier->display_attributes( out ).

*    LOOP AT airplanes INTO DATA(l_airplane).
*        l_airplane->display_attributes(  out ).
*    ENDLOOP.

  ENDMETHOD.
ENDCLASS.

