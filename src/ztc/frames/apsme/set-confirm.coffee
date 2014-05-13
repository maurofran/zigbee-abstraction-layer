###
  set-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class SetConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x21

  @Status =
    SUCCESS: 0x00
    READ_ONLY: 0xFA
    NOT_SUPPORTED: 0xFC
    TOO_BIG: 0xFF

  constructor: (parser) ->
    super SetConfirm.OPCODE_GROUP, SetConfirm.OPCODE
    parser.uint8 "status"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame SetConfirm

module.exports = SetConfirm