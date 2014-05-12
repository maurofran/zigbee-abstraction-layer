###
  get-number-of-endpoints-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class GetNumberOfEndpointsConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x0C

  constructor: (parser) ->
    super GetNumberOfEndpointsConfirm.OPCODE_GROUP, GetNumberOfEndpointsConfirm.OPCODE
    parser.uint8 "status"
    parser.uint8 "activeEndpoints"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame GetNumberOfEndpointsConfirm

module.exports = GetNumberOfEndpointsConfirm