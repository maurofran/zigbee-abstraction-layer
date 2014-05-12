###
  get-endpoint-description-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class GetEndpointDescriptionRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x0D

  constructor: (@endpoint) ->
    super GetEndpointDescriptionRequest.OPCODE_GROUP, GetEndpointDescriptionRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 1
    builder.uint8 @endpoint

ZtcFrame.registerFrame GetEndpointDescriptionRequest

module.exports = GetEndpointDescriptionRequest