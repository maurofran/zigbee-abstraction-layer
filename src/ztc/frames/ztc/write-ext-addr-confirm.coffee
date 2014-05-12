###
  write-ext-addr-confirm.coffe
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class WriteExtAddrConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0xDB

  constructor: (parser) ->
    super WriteExtAddrConfirm.OPCODE_GROUP, WriteExtAddrConfirm.OPCODE
    parser.uint8 "status"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame WriteExtAddrConfirm

module.exports = WriteExtAddrConfirm