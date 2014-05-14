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
  GetEPMaxWindowSize:
    Request: require "./get-ep-max-window-size-request"
    Confirm: require "./get-ep-max-window-size-confirm"
  GetMaxApplicationPaylod:
    Request: require "./get-max-application-payload-request"
    Confirm: require "./get-max-application-payload-confirm"
  GetNumberOfEndpoints:
    Request: require "./get-number-of-endpoints-request"
    Confirm: require "./get-number-of-endpoints-confirm"
  LoadFragment:
    Request: require "./load-fragment-request"
    Confirm: require "./load-fragment-confirm"
  ProcessSecureFrame:
    Report: require "./process-secure-frame-report"
  RegisterEndpoint:
    Request: require "./register-endpoint-request"
    Confirm: require "./register-endpoint-confirm"
