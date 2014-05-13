###
  index.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

module.exports =
  AddGroup:
    Request: require "./add-group-request"
    Confirm: require "./add-group-confirm"
  Authenticate:
    Request: require "./authenticate-request"
    Confirm: require "./authenticate-confirm"
    Indication: require "./authenticate-indication"
  Bind:
    Request: require "./bind-request"
    Confirm: require "./bind-confirm"
  EstablishKey:
    Request: require "./establish-key-request"
    Confirm: require "./establish-key-confirm"
    Indication: require "./establish-key-indication"
    Response: require "./establish-key-response"
  Get:
    Request: require "./get-request"
    Confirm: require "./get-confirm"
  RemoveAllGroups:
    Request: require "./remove-all-groups-request"
    Confirm: require "./remove-all-groups-confirm"
  RemoveDevice:
    Request: require "./remove-device-request"
    Indication: require "./remove-device-indication"
  RemoveGroup:
    Request: require "./remove-group-request"
    Confirm: require "./remove-group-confirm"
  RequestKey:
    Request: require "./request-key-request"
    Indication: require "./request-key-indication"
  Reset:
    Request: require "./reset-request"
    Confirm: require "./reset-confirm"

