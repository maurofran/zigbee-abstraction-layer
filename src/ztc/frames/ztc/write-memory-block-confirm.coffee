###
  write-memory-block-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class WriteMemoryBlockConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x30

  constructor: (parser) ->
    super WriteMemoryBlockConfirm.OPCODE_GROUP, WriteMemoryBlockConfirm.OPCODE
    parser.uint8 "numberOfBytes"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame WriteMemoryBlockConfirm

module.exports = WriteMemoryBlockConfirm