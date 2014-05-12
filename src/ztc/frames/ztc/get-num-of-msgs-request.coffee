###
  get-num-of-msgs-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class GetNumOfMsgsRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x24

  constructor: () ->
    super GetNumOfMsgsRequest.OPCODE_GROUP, GetNumOfMsgsRequest.OPCODE

ZtcFrame.registerFrame GetNumOfMsgsRequest

module.exports = GetNumOfMsgsRequest