@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZRAPH_MA_C_TravelWDTP'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}


@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel.semanticKey: ['TravelID']

define root view entity ZRAPH_MA_C_TravelWDTP  provider contract transactional_query
  as projection on ZRAPH_MA_I_TravelWDTP
{
  key     TravelUUID,

          @Search.defaultSearchElement: true
          TravelID,

          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 0.7
          @ObjectModel.text.element: ['AgencyName']
// here the next Consumption view to be set in the filter later
          @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Agency', element: 'AgencyID'  } }]
          AgencyID,
          _Agency.Name       as AgencyName,

          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 0.7
          @ObjectModel.text.element: ['CustomerName']
          @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Customer', element: 'CustomerID'  } }]
          CustomerID,
          _Customer.LastName as CustomerName,

          BeginDate,
          EndDate,
          @Semantics.amount.currencyCode: 'CurrencyCode'
          BookingFee,
          @Semantics.amount.currencyCode: 'CurrencyCode'
          TotalPrice,

          @Consumption.valueHelpDefinition: [{entity: {name: 'I_Currency', element: 'Currency' }}]
          CurrencyCode,
          Description,

          @Consumption.valueHelpDefinition: [{entity: { name:    'ZRAPH_I_OverallStatus',
                                                        element: 'TravelStatus' } }]
          @ObjectModel.foreignKey.association: '_TravelStatus'
          OverallStatus,
          LocalCreatedBy,
          LocalCreatedAt,
          LocalLastChangedBy,
          LocalLastChangedAt,
          LastChangedAt,

          /* Associations */
          _Booking         : redirected to composition child ZRAPH_MA_C_BookingWDTP,
          _RoomReservation : redirected to composition child ZRAPH_MA_C_RoomReservationWDTP,
          _Agency,
          _Currency,
          _Customer,
          _TravelStatus

}
