###
  update-device-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

   C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class UpdateDeviceRequest extends ZtcFrame
  @OPCODE_GROUP = 0x99
  @OPCODE = 0xF3

  @Status =
    SECURED_JOIN: 0x00
    UNSECURED_JOIN: 0x01
    LEFT: 0x02
  
  constructor: (@dstAddress, @deviceAddress, @deviceShortAddress, @status) ->
    super UpdateDeviceRequest.OPCODE_GROUP, UpdateDeviceRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 19
    builder.ieeeAddress @dstAddress
    builder.ieeeAddress @deviceAddress
    builder.shortAddress @deviceShortAddress
    builder.uint8 @status

ZtcFrame.registerFrame UpdateDeviceRequest

module.exports = UpdateDeviceRequest