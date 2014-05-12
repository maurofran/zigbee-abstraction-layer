###
  read-ext-addr-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class ReadExtAddrConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0xD2

  constructor: (parser) ->
    super ReadExtAddrConfirm.OPCODE_GROUP, ReadExtAddrConfirm.OPCODE
    parser.uint8 "status"
    parser.ieeeAddress "deviceAddr"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame ReadExtAddrConfirm

module.exports = ReadExtAddrConfirm