###
  data-fragment-indication.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class DataFragmentIndication extends ZtcFrame
  @OPCODE_GROUP = 0x9D
  @OPCODE = 0x02

  constructor: (parser) ->
    super DataFragmentIndication.OPCODE_GROUP, DataFragmentIndication.OPCODE
    parser.uint8 "blockNumber"
    parser.boolean "moreBlocks"
    parser.uint8 "dataLength"
    parser.tap () ->
      @buffer "data", @vars.dataLength
      delete @vars.dataLength
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame DataFragmentIndication

module.exports = DataFragmentIndication