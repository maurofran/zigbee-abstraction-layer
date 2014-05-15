###
  get-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

   C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class GetRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x20

  @Id =
    SAP_APS_TC_MASTER_KEY: 0xE7
    SAP_APS_TC_LINK_KEY: 0xE8
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
    APS_MAX_FRAGMENT_LENGTH: 0xCE
  
  constructor: (@id, @index, @entries, @entrySize) ->
    super GetRequest.OPCODE_GROUP, GetRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 4
    builder.uint8 @id
    builder.uint8 @index
    builder.uint8 @entries
    builder.uint8 @entrySize

ZtcFrame.registerFrame GetRequest

module.exports = GetRequest