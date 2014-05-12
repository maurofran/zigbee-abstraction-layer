###
  get-ep-max-window-size-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class GetEPMaxWindowSizeConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x09

  @Status =
    SUCCESS: 0x00

  constructor: (parser) ->
    super GetEPMaxWindowSizeConfirm.OPCODE_GROUP, GetEPMaxWindowSizeConfirm.OPCODE
    parser.uint8 "status"
    parser.uint8 "windowSize"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame GetEPMaxWindowSizeConfirm

module.exports = GetEPMaxWindowSizeConfirm