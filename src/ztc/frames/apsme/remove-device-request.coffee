###
  remove-device-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

   C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class RemoveDeviceRequest extends ZtcFrame
  @OPCODE_GROUP = 0x99
  @OPCODE = 0xF4
  
  constructor: (@parentAddress, @childAddress) ->
    super RemoveDeviceRequest.OPCODE_GROUP, RemoveDeviceRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 16
    builder.ieeeAddress @parentAddress
    builder.ieeeAddress @childAddress

ZtcFrame.registerFrame RemoveDeviceRequest

module.exports = RemoveDeviceRequest