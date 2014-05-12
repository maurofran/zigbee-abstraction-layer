###
  write-memory-block-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class WriteMemoryBlockRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x30

  constructor: (@startAddress, @data) ->
    super WriteMemoryBlockRequest.OPCODE_GROUP, WriteMemoryBlockRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 3 + @data.length
    builder.uint16le @startAddress
    builder.uint8 @data.length
    builder.buffer @data

ZtcFrame.registerFrame WriteMemoryBlockRequest

module.exports = WriteMemoryBlockRequest