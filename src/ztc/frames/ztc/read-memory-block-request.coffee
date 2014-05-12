###
  read-memory-block-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class ReadMemoryBlockRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x31

  constructor: (@startAddress, @numberOfBytes) ->
    super ReadMemoryBlockRequest.OPCODE_GROUP, ReadMemoryBlockRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 3
    builder.uint16le @startAddress
    builder.uint8 @numberOfBytes

ZtcFrame.registerFrame ReadMemoryBlockRequest

module.exports = ReadMemoryBlockRequest