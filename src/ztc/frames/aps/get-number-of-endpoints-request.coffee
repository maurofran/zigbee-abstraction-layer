###
  get-number-of-endpoints-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class GetNumberOfEndpointsRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x0C

  constructor: () ->
    super GetNumberOfEndpointsRequest.OPCODE_GROUP, GetNumberOfEndpointsRequest.OPCODE

ZtcFrame.registerFrame GetNumberOfEndpointsRequest

module.exports = GetNumberOfEndpointsRequest