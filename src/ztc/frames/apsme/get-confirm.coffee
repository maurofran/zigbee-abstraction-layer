###
  get-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class GetConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x20

  @Id =
    APS_DEVICE_KEY_PAIR_SET: 0xAA
    APS_TRUST_CENTER_ADDRESS: 0xAB
    APS_SECURITY_TIMEOUT_PERIOD: 0xAC
    APS_ADDRESS_MAP: 0xC0
    APS_BINDING_TABLE: 0xC1
    APS_DESIGNATED_COORDINATOR: 0xC2
    APS_CHANNEL_MASK: 0xC3
    APS_USE_EXTENDED_PANID: 0xC4
    APS_GROUP_TABLE: 0xC5
    APS_NONMEMBER_RADIUS: 0xC6
    APS_USE_INSECURE_JOIN: 0xC8
    APS_INTERFRAME_DELAY: 0xC9
    APS_LAST_CHANNEL_ENERGY: 0xCA
    APS_LAST_CHANNEL_FAILURE_RATE: 0xCB
    APS_CHANNEL_TIMER: 0xCC
    APS_MAX_WINDOW_SIZE: 0xCD

  @Status =
    SUCCESS: 0x00
    UNSUPPORTED_ATTRIBUTE: 0x01
    APS_SUCCESS: 0x07
    APS_NOT_SUPPORTED: 0x84
    ZB_UNSUPPORTED_ATTRIBUTE: 0xC9

  constructor: (parser) ->
    super GetConfirm.OPCODE_GROUP, GetConfirm.OPCODE
    parser.uint8 "status"
    parser.uint8 "id"
    parser.uint8 "index"
    parser.uint8 "entries"
    parser.uint8 "entrySize"
    parser.uint16le "dataLength"
    parser.tap () ->
      @buffer "data", @vars.dataLength
      delete @vars.dataLength
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame GetConfirm

module.exports = GetConfirm