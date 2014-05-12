###
  index.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

module.exports =
  ClearDeviceKeyPairSet:
    Request: require "./clear-device-key-pair-set-request"
    Confirm: require "./clear-device-key-pair-set-confirm"
  ConfirmId:
    Report: require "./confirm-id-report"
  DataFragment:
    Request: require "./data-fragment-request"
    Indication: require "./data-fragment-indication"
  DeregisterEndpoint:
    Request: require "./deregister-endpoint-request"
    Confirm: require "./deregister-endpoint-confirm"
  GetDeviceKeyPairSet:
    Request: require "./get-device-key-pair-set-request"
    Confirm: require "./get-device-key-pair-set-confirm"
  GetEndpointDescription:
    Request: require "./get-endpoint-description-request"
    Confirm: require "./get-endpoint-description-confirm"
  GetEndpointIdList:
    Request: require "./get-endpoint-id-list-request"
    Confirm: require "./get-endpoint-id-list-confirm"
