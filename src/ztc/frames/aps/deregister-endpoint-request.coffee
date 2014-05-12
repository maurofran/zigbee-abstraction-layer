###
  deregister-endpoint-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class DeregisterEndpointRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x0A

  constructor: (@endpointNumber) ->
    super DeregisterEndpointRequest.OPCODE_GROUP, DeregisterEndpointRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 1
    builder.uint8 @endpointNumber

ZtcFrame.registerFrame DeregisterEndpointRequest

module.exports = DeregisterEndpointRequest