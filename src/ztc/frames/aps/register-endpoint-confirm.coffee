###
  deregister-endpoint-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class RegisterEndpointConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x0B

  constructor: (parser) ->
    super RegisterEndpointConfirm.OPCODE_GROUP, RegisterEndpointConfirm.OPCODE
    parser.uint8 "status"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame RegisterEndpointConfirm

module.exports = RegisterEndpointConfirm