###
  get-endpoint-id-list-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class GetEndpointIdListRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x0E

  constructor: () ->
    super GetEndpointIdListRequest.OPCODE_GROUP, GetEndpointIdListRequest.OPCODE

ZtcFrame.registerFrame GetEndpointIdListRequest

module.exports = GetEndpointIdListRequest