###
  get-mode-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"


class GetModeRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x02

  constructor: () ->
    super GetModeRequest.OPCODE_GROUP, GetModeRequest.OPCODE

ZtcFrame.registerFrame GetModeRequest

module.exports = GetModeRequest