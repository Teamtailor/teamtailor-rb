## Unreleased

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
