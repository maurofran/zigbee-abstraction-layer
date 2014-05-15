###
  set-interframe-delay-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class SetInterframeDelayConfirm extends ZtcFrame
  @OPCODE_GROUP = 0x9D
  @OPCODE = 0x15

  @Status =
    SUCCESS: 0x00

  constructor: (parser) ->
    super SetInterframeDelayConfirm.OPCODE_GROUP, SetInterframeDelayConfirm.OPCODE
    parser.uint8 "status"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame SetInterframeDelayConfirm

module.exports = SetInterframeDelayConfirm