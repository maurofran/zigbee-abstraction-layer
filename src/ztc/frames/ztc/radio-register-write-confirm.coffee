###
  radio-register-write-confirm.coffe
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class RadioRegisterWriteConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x39

  constructor: (parser) ->
    super RadioRegisterWriteConfirm.OPCODE_GROUP, RadioRegisterWriteConfirm.OPCODE
    parser.uint8 "status"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame RadioRegisterWriteConfirm

module.exports = RadioRegisterWriteConfirm