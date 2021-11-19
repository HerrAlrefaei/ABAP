CLASS zcl_ma_main_airplane_e13 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_MA_MAIN_AIRPLANE_E13 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*old    DATA l_rental TYPE REF TO lcl_rental.

    DATA l_carrier TYPE REF TO lcl_carrier.

    DATA l_basic_airplane TYPE REF TO lcl_airplane.
    DATA l_cargo_plane TYPE REF TO lcl_cargo_plane.
    DATA l_passenger_plane TYPE REF TO lcl_passenger_plane.

    DATA l_rental1 TYPE REF TO lcl_rental.
    DATA l_rental2 TYPE REF TO lcl_rental.
    DATA l_travel_agency TYPE REF TO lcl_travel_agency.

* schön gemacht in Local Type
*    DATA airplanes TYPE TABLE OF REF TO lcl_airplane.
*    lcl_airplane=>display_number_of_airplanes(  out ).

*old    l_rental = NEW #( im_name = 'ABC' ).

* Creating carrier with airplanes

    l_carrier = new #( 'WEFEL - We fly everything lines' ).

    l_basic_airplane = NEW #( im_name = 'Basic Plane' im_planetype = 'A320-200' ).
*event job    l_carrier->add_airplane( l_basic_airplane ).

    l_cargo_plane = NEW #( im_name = 'Cargo Plane' im_planetype = '747-400' im_max_cargo = 1000 ).
*event job    l_carrier->add_airplane( l_cargo_plane ).

    l_passenger_plane = NEW #( im_name = 'Passenger Plane' im_planetype = 'Airbus'  im_max_seats = 500 ).
*event job    l_carrier->add_airplane( l_passenger_plane ).

*old    l_carrier->display_attributes( out ).
*    LOOP AT airplanes INTO DATA(l_airplane).
*        l_airplane->display_attributes(  out ).
*    ENDLOOP.

* Creating two rentals
    l_rental1 = NEW lcl_rental( 'Rental1' ).
    l_rental2 = NEW lcl_rental( 'Rental2' ).

*Creating two hotels
    DATA(l_hotel1) = NEW zcl_ma_hotel( im_name = 'Hotel1' im_max_bed = 100 ).
    DATA(l_hotel2) = NEW zcl_ma_hotel( im_name = 'Hotel2' im_max_bed = 2222 ).

* Creating travel agency and adding partners
    l_travel_agency = NEW #( 'my travel agency' ).
    l_travel_agency->add_partner( l_carrier ).
    l_travel_agency->add_partner( l_rental1 ).
    l_travel_agency->add_partner( l_rental2 ).

    l_travel_agency->add_partner( l_hotel1 ).
    l_travel_agency->add_partner( l_hotel2 ).

* Checking the result
    l_travel_agency->display_agency_partners( out ).


  ENDMETHOD.
ENDCLASS.

