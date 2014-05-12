###
  clear-device-key-set-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class ClearDeviceKeyPairSetRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x3F

  constructor: (@ieeeAddress) ->
    super ClearDeviceKeyPairSetRequest.OPCODE_GROUP, ClearDeviceKeyPairSetRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 8
    builder.ieeeAddress @ieeeAddress

ZtcFrame.registerFrame ClearDeviceKeyPairSetRequest

module.exports = ClearDeviceKeyPairSetRequest