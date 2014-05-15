###
  set-security-materials-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class SetSecurityMaterialsRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA2
  @OPCODE = 0xFA

  @AibAttribute =
    DEVICE_KEY_PAIR_SET: 0xAA
    TRUST_CENTER_ADDRESS: 0xAB
    DEVICE_KEY_PAIR_CURRENT: 0xAD

  constructor: (@attribute, value) ->
    super SetSecurityMaterialsRequest.OPCODE_GROUP, SetSecurityMaterialsRequest.OPCODE
    switch @attribute
      when SetSecurityMaterialsRequest.AibAttribute.DEVICE_KEY_PAIR_SET
        {@deviceAddress, @masterKey, @linkKey, @outgoingFrameCounter, @incomingFrameCounter} = value
      when SetSecurityMaterialsRequest.AibAttribute.TRUST_CENTER_ADDRESS
        @trustCenterAddress = value
      when SetSecurityMaterialsRequest.AibAttribute.DEVICE_KEY_PAIR_CURRENT
        @deviceKeyPairCurrent = value

  _writePayload: (builder) ->
    switch @attribute
      when SetSecurityMaterialsRequest.AibAttribute.DEVICE_KEY_PAIR_SET
        builder.uint8 49
        builder.uint8 @attribute
        builder.ieeeAddress @deviceAddress
        builder.key @masterKey
        builder.key @linkKey
        builder.uint32le @outgoingFrameCounter
        builder.uint32le @incomingFrameCounter
      when SetSecurityMaterialsRequest.AibAttribute.TRUST_CENTER_ADDRESS
        builder.uint8 9
        builder.uint8 @attribute
        builder.ieeeAddress @trustCenterAddress
      when SetSecurityMaterialsRequest.AibAttribute.DEVICE_KEY_PAIR_CURRENT
        builder.uint8 2
        builder.uint8 @attribute
        builder.uint8 @deviceKeyPairCurrent

ZtcFrame.registerFrame SetSecurityMaterialsRequest

module.exports = SetSecurityMaterialsRequest