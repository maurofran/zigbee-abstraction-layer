###
  radio-register-read-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class RadioRegisterReadConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x3A

  constructor: (parser) ->
    super RadioRegisterReadConfirm.OPCODE_GROUP, RadioRegisterReadConfirm.OPCODE
    parser.uint16le "value"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame RadioRegisterReadConfirm

module.exports = RadioRegisterReadConfirm