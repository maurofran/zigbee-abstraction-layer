###
  get-pan-id-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class GetPanIdRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x14

  constructor: () ->
    super GetPanIdRequest.OPCODE_GROUP, GetPanIdRequest.OPCODE

ZtcFrame.registerFrame GetPanIdRequest

module.exports = GetPanIdRequest