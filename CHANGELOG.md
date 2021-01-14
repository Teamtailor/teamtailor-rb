## Unreleased

## v0.3.2 - 2021-01-14

- Added `Client#create_candidate`
- Added `Client#create_job_application`

## v0.3.1 - 2020-11-13

- Update metadata in the `teamtailor.gemspec`

## v0.3.0 - 2020-06-30

- [BREAKING] Update `Teamtailor::Relationship` to always return multiple records
- Add `Teamtailor::Requisition` and `Client#requisitions`
- Add `Teamtailor::RequisitionStepVerdict`
- Fix accessing nested relationships on `Relationship`

## v0.2.6 - 2020-05-18

- Add `Teamtailor::PartnerResult` and `Client#partner_results`
- Add `Teamtailor::Referral` and `Client#referrals`
- Add `Teamtailor::CustomField` and `Teamtailor::CustomFieldValue`
- Add `Client#custom_fields` and `Client#custom_field_values`

## v0.2.5 - 2020-05-15

- Add `filters:` as an argument to `Client#jobs`

## v0.2.4 - 2020-04-07

- Add `Teamtailor::Location` and `Client#locations`
- Add `Teamtailor::Department` and `Client#departments`
- Add `Teamtailor::RejectReason` and `Client#reject_reasons`
- Add `Teamtailor::Stage` and `Client#stages` for fetching it (`2179b1`)

## v0.2.3 - 2020-04-06

- Add `Teamtailor::Company` and `Client#company` for fetching it (`05dde0`)

## v0.2.2 - 2020-03-31

- Move serialization logic in the `Teamtailor::Record` base class (`9ec63a0`)
- Fix serializing/deserializing loaded relationships for
  `Teamtailor::JobApplication` (`428e2d`)

## v0.2.1 - 2020-03-31

- Add `Teamtailor::JobApplication` and `Client#job_applications` (`062fa7`)

## v0.2.0 - 2020-03-31

- Add support for accessing relationships on records (`1218aa`)
- Add support for including relationships when querying the API (`90f25d`)
