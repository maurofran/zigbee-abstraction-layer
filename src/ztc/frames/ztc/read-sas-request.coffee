###
  read-sas-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class ReadSASRequest extends ZtcFrame
  @OPCODE_GROUP = 0x50
  @OPCODE = 0x02

  @Source =
    RAM: 0x00
    ROM: 0x01

  constructor: (@source) ->
    super ReadSASRequest.OPCODE_GROUP, ReadSASRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 1
    builder.uint8 @source

ZtcFrame.registerFrame ReadSASRequest

module.exports = ReadSASRequest