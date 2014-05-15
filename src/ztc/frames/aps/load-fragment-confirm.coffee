###
  load-fragment-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class LoadFragmentConfirm extends ZtcFrame
  @OPCODE_GROUP = 0x9D
  @OPCODE = 0x11

  @Status =
    SUCCESS: 0x00
    OUT_OF_MESSAGES: 0xF4

  constructor: (parser) ->
    super LoadFragmentConfirm.OPCODE_GROUP, LoadFragmentConfirm.OPCODE
    parser.uint8 "status"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame LoadFragmentConfirm

module.exports = LoadFragmentConfirm