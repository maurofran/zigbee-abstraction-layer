###
  set-frag-window-size-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class SetFragWindowSizeConfirm extends ZtcFrame
  @OPCODE_GROUP = 0x9D
  @OPCODE = 0x14

  @Status =
    SUCCESS: 0x00

  constructor: (parser) ->
    super SetFragWindowSizeConfirm.OPCODE_GROUP, SetFragWindowSizeConfirm.OPCODE
    parser.uint8 "status"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame SetFragWindowSizeConfirm

module.exports = SetFragWindowSizeConfirm