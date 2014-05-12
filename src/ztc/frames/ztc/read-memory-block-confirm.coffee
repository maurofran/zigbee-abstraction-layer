###
  read-memory-block-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class ReadMemoryBlockConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x31

  constructor: (parser, size) ->
    super ReadMemoryBlockConfirm.OPCODE_GROUP, ReadMemoryBlockConfirm.OPCODE
    parser.buffer "data", size
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame ReadMemoryBlockConfirm

module.exports = ReadMemoryBlockConfirm