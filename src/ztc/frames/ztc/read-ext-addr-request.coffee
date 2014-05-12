###
  read-ext-addr-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class ReadExtAddrRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0xD2

  constructor: () ->
    super ReadExtAddrRequest.OPCODE_GROUP, ReadExtAddrRequest.OPCODE

ZtcFrame.registerFrame ReadExtAddrRequest

module.exports = ReadExtAddrRequest