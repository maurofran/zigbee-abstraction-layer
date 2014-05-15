###
  set-device-key-set-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class SetDeviceKeyPairSetRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x3E

  constructor: (@ieeeAddress, @keyType, @apsKey) ->
    super SetDeviceKeyPairSetRequest.OPCODE_GROUP, SetDeviceKeyPairSetRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 25
    builder.ieeeAddress @ieeeAddress
    builder.uint8 @keyType
    builder.key @apsKey

ZtcFrame.registerFrame SetDeviceKeyPairSetRequest

module.exports = SetDeviceKeyPairSetRequest