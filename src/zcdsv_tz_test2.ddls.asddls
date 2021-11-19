@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZCDSV_TZ_TEST2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDSV_TZ_TEST2 
as
select from zraph_ma_travel as test2
association[1..1] to /dmo/agency as _agency on _agency.agency_id = test2.agency_id
{
    key test2.agency_id as AgencyID,
    _agency.city        as City
}
