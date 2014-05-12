###
  add-to-address-map-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require("../../ztc-frame")

class AddToAddressMapRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0xC0

  # Creates a new AddToAddressMapRequest.
  #
  # @param [IEEEAddress] ieeeAddress the IEEE address to add to the map
  # @param [ShortAddress] shortAddress the address to bind to
  constructor: (@ieeeAddress, @shortAddress) ->
    super AddToAddressMapRequest.OPCODE_GROUP, AddToAddressMapRequest.OPCODE

  _writePayload: (bldr) ->
    bldr.uint8 10
    bldr.ieeeAddress @ieeeAddress
    bldr.shortAddress @shortAddress

ZtcFrame.registerFrame AddToAddressMapRequest

module.exports = AddToAddressMapRequest