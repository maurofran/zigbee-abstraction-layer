###
  get-device-key-set-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class GetDeviceKeyPairSetRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x3B

  constructor: (@ieeeAddress) ->
    super GetDeviceKeyPairSetRequest.OPCODE_GROUP, GetDeviceKeyPairSetRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 8
    builder.ieeeAddress @ieeeAddress

ZtcFrame.registerFrame GetDeviceKeyPairSetRequest

module.exports = GetDeviceKeyPairSetRequest