###
  reset-fragments-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class ResetFragmentsConfirm extends ZtcFrame
  @OPCODE_GROUP = 0x9D
  @OPCODE = 0x10

  constructor: (parser, length) ->
    super ResetFragmentsConfirm.OPCODE_GROUP, ResetFragmentsConfirm.OPCODE
    parser.buffer "data", length if length > 0
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame ResetFragmentsConfirm

module.exports = ResetFragmentsConfirm