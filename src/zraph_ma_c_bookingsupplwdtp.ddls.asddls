@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZRAPH_MA_C_BookingSupplWDTP'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}


@Metadata.allowExtensions: true
@Search.searchable: true

define view entity ZRAPH_MA_C_BookingSupplWDTP
  as projection on ZRAPH_MA_I_BookingSupplWDTP
{
  key BookSupplUUID,
      TravelUUID,
      BookingUUID,

      @Search.defaultSearchElement: true
      BookingSupplementID,

      @ObjectModel.text.element: ['SupplementDescription']
      @Consumption.valueHelpDefinition: [ {entity: {name: '/DMO/I_SUPPLEMENT', element: 'SupplementID' } ,
                     additionalBinding: [ { localElement: 'Price',  element: 'Price', usage: #RESULT },
                                          { localElement: 'CurrencyCode', element: 'CurrencyCode', usage: #RESULT }] }]
      SupplementID,
      _SupplementText.Description as SupplementDescription : localized,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,

      @Consumption.valueHelpDefinition: [{entity: {name: 'I_Currency', element: 'Currency' }}]
      CurrencyCode,

      LocalLastChangedAt,

      /* Associations */
      _Booking : redirected to parent ZRAPH_MA_C_BookingWDTP,
      _Product,
      _SupplementText,
      _Travel  : redirected to ZRAPH_MA_C_TravelWDTP
}
