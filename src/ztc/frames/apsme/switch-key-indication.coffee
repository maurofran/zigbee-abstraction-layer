###
  switch-key-indication.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class SwitchKeyIndication extends ZtcFrame
  @OPCODE_GROUP = 0x98
  @OPCODE = 0xF1

  constructor: (parser) ->
    super SwitchKeyIndication.OPCODE_GROUP, SwitchKeyIndication.OPCODE
    parser.ieeeAddress "srcAddress"
    parser.uint8 "keySeqNumber"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame SwitchKeyIndication

module.exports = SwitchKeyIndication