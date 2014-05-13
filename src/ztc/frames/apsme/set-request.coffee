###
  set-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class SetRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x21

  @Id =
    SAS_APS_TC_MASTER_KEY: 0xE7
    SAS_APS_TC_LINK_KEY: 0xE8
    APS_DEVICE_KEY_PAIR_SET: 0xAA
    APS_TRUST_CENTER_ADDRESS: 0xAB
    APS_SECURITY_TIMEOUT_PERIOD: 0xAC
    APS_ADDRESS_MAP: 0xC0
    APS_BINDING_TABLE: 0xC1
    APS_DESIGNATED_COORDINATOR: 0xC2
    APS_CHANNEL_MASK: 0xC3
    APS_USE_EXTENDED_PAN_ID: 0xC4
    APS_GROUP_TABLE: 0xC5
    APS_NONMEMBER_RADIUS: 0xC6
    APS_USE_INSECURE_JOIN: 0xC8
    APS_INTERFRAME_DELAY: 0xC9
    APS_MAX_WINDOW_SIZE: 0xCD
    APS_MAX_FRAGMENT_LENGTH: 0xCE

  @KeyType =
    TRUST_CENTER_MASTER_KEY: 0x00
    TRUST_CENTER_LINK_KEY: 0x04
    APPLICATION_MASTER_KEY: 0x02
    APPLICATION_LINK_KEY: 0x03

  constructor: (@id, @index, @data) ->
    super SetRequest.OPCODE_GROUP, SetRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 @_getPayloadLength()
    builder.uint8 @id
    builder.uint8 @index
    builder.uint8 if _.isArray(@data) then @data.length else 1
    builder.uint8 0
    switch @id
      when SetRequest.Id.SAS_APS_TC_MASTER_KEY then builder.key @data
      when SetRequest.Id.SAS_APS_TC_LINK_KEY then builder.key @data
      when SetRequest.Id.APS_DEVICE_KEY_PAIR_SET
        _.forEach @data, (el) ->
          builder.uint8 el.deviceAddressIndex
          builder.key el.key
          builder.uint8 el.keyType
          builder.uint32le el.outgoingFrameCounter
          builder.uint32le el.incomingFrameCounter
        builder
      when SetRequest.Id.APS_TRUST_CENTER_ADDRESS then builder.ieeeAddress @data
      when SetRequest.Id.APS_SECURITY_TIMEOUT_PERIOD then builder.uint16le @data
      when SetRequest.Id.APS_ADDRESS_MAP
        _.forEach @data, (el) ->
          builder.ieeeAddress el.ieeeAddress
          builder.shortAddress el.networkAddress
        builder
      when SetRequest.Id.APS_BINDING_TABLE
        _.forEach @data, (el) ->
          builder.uint8 el.srcEndpoint
          builder.shortAddress el.destination
          builder.uint8 el.dstEndpoint
          builder.uint8 el.clusters.length
          builder.uint16le clusterId for clusterId in el.clusters
        builder
      when SetRequest.Id.APS_DESIGNATED_COORDINATOR then builder.boolean @data
      when SetRequest.Id.APS_CHANNEL_MASK then builder.uint32le @data
      when SetRequest.Id.APS_USE_EXTENDED_PAN_ID then builder.panId @data
      when SetRequest.Id.APS_GROUP_TABLE
        _.forEach @data, (el) ->
          builder.shortAddress el.groupId
          builder.uint8 el.endpoint
        builder
      when SetRequest.Id.APS_NONMEMBER_RADIUS then builder.uint8 @data
      when SetRequest.Id.APS_USE_INSECURE_JOIN then builder.uint8 @data
      when SetRequest.Id.APS_INTERFRAME_DELAY then builder.uint8 @data
      when SetRequest.Id.APS_MAX_WINDOW_SIZE then builder.uint8 @data
      when SetRequest.Id.APS_MAX_FRAGMENT_LENGTH then builder.uint8 @data

  _getPayloadLength: () ->
    switch @id
      when SetRequest.Id.SAS_APS_TC_MASTER_KEY then 4 + 16
      when SetRequest.Id.SAS_APS_TC_LINK_KEY then 4 + 16
      when SetRequest.Id.APS_DEVICE_KEY_PAIR_SET then 4 + 26 * @data.length
      when SetRequest.Id.APS_TRUST_CENTER_ADDRESS then 4 + 8
      when SetRequest.Id.APS_SECURITY_TIMEOUT_PERIOD then 4 + 2
      when SetRequest.Id.APS_ADDRESS_MAP then 4 + 10 * @data.length
      when SetRequest.Id.APS_BINDING_TABLE then 4 + _.reduce @data, ((sum, el) -> sum + 5 + 2 * el.clusters.length), 0
      when SetRequest.Id.APS_DESIGNATED_COORDINATOR then 4 + 1
      when SetRequest.Id.APS_CHANNEL_MASK then 4 + 4
      when SetRequest.Id.APS_USE_EXTENDED_PAN_ID then 4 + 8
      when SetRequest.Id.APS_GROUP_TABLE then 4 + 3 * @data.length
      when SetRequest.Id.APS_NONMEMBER_RADIUS then 4 + 1
      when SetRequest.Id.APS_USE_INSECURE_JOIN then 4 + 1
      when SetRequest.Id.APS_INTERFRAME_DELAY then 4 + 1
      when SetRequest.Id.APS_MAX_WINDOW_SIZE then 4 + 1
      when SetRequest.Id.APS_MAX_FRAGMENT_LENGTH then 4 + 1

ZtcFrame.registerFrame SetRequest

module.exports = SetRequest