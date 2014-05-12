###
  get-mode-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class GetModeConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x02

  @Status =
    SUCCESS: 0x00
    INVALID_REQUEST: 0xFF

  @Mode =
    DISABLE: 0x00
    HOOK: 0x01
    MONITOR: 0x02
    NOT_SUPPORTED: 0xFF

  constructor: (parser) ->
    super GetModeConfirm.OPCODE_GROUP, GetModeConfirm.OPCODE
    parser.uint8 "status"
    parser.uint8 "uartTxBlocking"
    parser.tap "modes", () =>
      parser.uint8 "mcps"
      parser.uint8 "mlme"
      parser.uint8 "asp"
      parser.uint8 "nlde"
      parser.uint8 "nlme"
      parser.uint8 "apsde"
      parser.uint8 "apsme"
      parser.uint8 "afde"
      parser.uint8 "zdp"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame GetModeConfirm

module.exports = GetModeConfirm