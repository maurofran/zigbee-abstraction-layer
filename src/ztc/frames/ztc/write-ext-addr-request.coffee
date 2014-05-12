###
  write-ext-addr-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class WriteExtAddrRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0xDB

  constructor: (@address) ->
    super WriteExtAddrRequest.OPCODE_GROUP, WriteExtAddrRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 8
    builder.ieeeAddress @address

ZtcFrame.registerFrame WriteExtAddrRequest

module.exports = WriteExtAddrRequest