###
  remove-from-address-map-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class RemoveFromAddressMapRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0xC1

  constructor: (@ieeeAddress) ->
    super RemoveFromAddressMapRequest.OPCODE_GROUP, RemoveFromAddressMapRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 8
    builder.ieeeAddress @ieeeAddress

ZtcFrame.registerFrame RemoveFromAddressMapRequest

module.exports = RemoveFromAddressMapRequest