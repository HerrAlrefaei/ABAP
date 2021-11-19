@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Reservation'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZRAPH_MA_RESERVATION
  as select from zraph_ma_roomrsv as AR
  association[1..1] to zraph_ma_hotel as BH on BH.hotel_id = AR.hotel_id
{
  key roomrsv_uuid          as RoomReservationUUID,
      parent_uuid           as ParentUUID,
      roomrsv_id            as RoomReservationID,
      hotel_id              as HotelID,
      begin_date            as BeginDate,
      end_date              as EndDate,
      room_type             as RoomType,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      roomrsv_price         as RoomReservationPrice,
      currency_code         as CurrencyCode,
      local_last_changed_at as LocalLastChangedAt,
          
      BH.name           as Name,
      BH.city           as City,
      BH.country        as Country
}
