###
  data-fragment-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class DataFragmentRequest extends ZtcFrame
  @OPCODE_GROUP = 0x9C
  @OPCODE = 0x01

  constructor: (@blockNumber, @moreBlocks, @data) ->
    super DataFragmentRequest.OPCODE_GROUP, DataFragmentRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 3 + @data.length
    builder.uint8 @blockNumber
    builder.boolean @moreBlocks
    builder.uint8 @data.length
    builder.buffer @data

ZtcFrame.registerFrame DataFragmentRequest

module.exports = DataFragmentRequest