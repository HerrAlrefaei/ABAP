@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZRAPH_MA_C_RoomReservationWDTP'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}


@Metadata.allowExtensions: true
@Search.searchable: true

define view entity ZRAPH_MA_C_RoomReservationWDTP
  as projection on ZRAPH_MA_I_RoomReservationWDTP
{
  key RoomRsvUUID,
      TravelUUID,
      RoomRsvID,

      @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['HotelName']
      @Consumption.valueHelpDefinition: [ {entity: {name: 'ZRAPH_I_HOTEL', element: 'HotelID' } } ]
      HotelID,
      _Hotel.Name as HotelName,
      
      _Hotel.City as City,

      BeginDate,

      EndDate,

      @Consumption.valueHelpDefinition: [{ entity: { name:    'ZRAPH_I_HotelRoomType',
                                                     element: 'Value'  } }]
      @ObjectModel.text.element: ['RoomTypeText']
      @Search.defaultSearchElement: true
      RoomType,
      _HotelRoomType.Text as RoomTypeText,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      RoomRsvPrice,

      @Consumption.valueHelpDefinition: [{entity: {name: 'I_Currency', element: 'Currency' }}]
      CurrencyCode,

      LocalLastChangedAt,
      
      /* Associations */
      _Hotel,
      _HotelRoomType,
      _Travel : redirected to parent ZRAPH_MA_C_TravelWDTP
}
