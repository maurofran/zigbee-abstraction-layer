###
  reset-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class ResetConfirm extends ZtcFrame
  @OPCODE_GROUP = 0x98
  @OPCODE = 0x0B

  @Status =
    SUCCESS: 0x00
    APS_NOT_SUPPORTED: 0x84
    DISABLE_TRX_FAILURE: 0xE3

  constructor: (parser) ->
    super ResetConfirm.OPCODE_GROUP, ResetConfirm.OPCODE
    parser.uint8 "status"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame ResetConfirm

module.exports = ResetConfirm