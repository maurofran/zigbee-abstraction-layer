###
  mode-select-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class ModeSelectConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x00

  @Status =
    SUCCESS: 0x00
    INVALID_REQUEST: 0xFF

  constructor: (parser) ->
    super ModeSelectConfirm.OPCODE_GROUP, ModeSelectConfirm.OPCODE
    parser.uint8 "status"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame ModeSelectConfirm

module.exports = ModeSelectConfirm