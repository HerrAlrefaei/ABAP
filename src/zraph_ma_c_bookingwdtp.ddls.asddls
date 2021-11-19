@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZRAPH_MA_C_BookingWDTP'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}


@Metadata.allowExtensions: true
@Search.searchable: true

define view entity ZRAPH_MA_C_BookingWDTP
  as projection on ZRAPH_MA_I_BookingWDTP
{
  key     BookingUUID,

          TravelUUID,

          @Search.defaultSearchElement: true
          BookingID,
          BookingDate,

          @ObjectModel.text.element: ['CustomerName']
          @Search.defaultSearchElement: true
          @Consumption.valueHelpDefinition: [{entity: {name: '/DMO/I_Customer', element: 'CustomerID' }}]
          CustomerID,
          _Customer.LastName as CustomerName,

          @ObjectModel.text.element: ['CarrierName']
          @Consumption.valueHelpDefinition: [{entity: {name: '/DMO/I_Carrier', element: 'AirlineID' }}]
          CarrierID,
          _Carrier.Name      as CarrierName,

          @Consumption.valueHelpDefinition: [ {entity: {name: '/DMO/I_Flight', element: 'ConnectionID'},
                         additionalBinding: [ { localElement: 'FlightDate',   element: 'FlightDate'},
                                              { localElement: 'CarrierID',    element: 'AirlineID'},
                                              { localElement: 'FlightPrice',  element: 'Price', usage: #RESULT},
                                              { localElement: 'CurrencyCode', element: 'CurrencyCode', usage: #RESULT } ] } ]
          ConnectionID,
          FlightDate,

          @Consumption.valueHelpDefinition: [ {entity: {name: '/DMO/I_Flight', element: 'ConnectionID'},
                         additionalBinding: [ { localElement: 'FlightDate',   element: 'FlightDate'},
                                              { localElement: 'CarrierID',    element: 'AirlineID'},
                                              { localElement: 'FlightPrice',  element: 'Price', usage: #RESULT },
                                              { localElement: 'CurrencyCode', element: 'CurrencyCode', usage: #RESULT } ] } ]
          @Semantics.amount.currencyCode: 'CurrencyCode'
          FlightPrice,

          @Consumption.valueHelpDefinition: [{entity: {name: 'I_Currency', element: 'Currency' }}]
          CurrencyCode,
          BookingStatus,
          Criticality,
          
          @ObjectModel.virtualElementCalculatedBy:'ABAP:ZRAPH_MA_CL_DAYS_TO_FLIGHT'
 virtual  DaysToFlight : abap.int2,
          
                 
          LocalLastChangedAt,

          /* Associations */
          _BookingSupplement : redirected to composition child ZRAPH_MA_C_BookingSupplWDTP,
          _Carrier,
          _Connection,
          _Customer,
          _Travel            : redirected to parent ZRAPH_MA_C_TravelWDTP
}
