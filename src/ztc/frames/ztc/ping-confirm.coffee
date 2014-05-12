###
  ping-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class PingConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x38

  constructor: (parser, size) ->
    super PingConfirm.OPCODE_GROUP, PingConfirm.OPCODE
    parser.buffer "data", size
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame PingConfirm

module.exports = PingConfirm