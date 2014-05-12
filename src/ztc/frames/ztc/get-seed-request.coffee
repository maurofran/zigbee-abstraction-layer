###
  get-seed-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class GetSeedRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0xD0

  constructor: () ->
    super GetSeedRequest.OPCODE_GROUP, GetSeedRequest.OPCODE

ZtcFrame.registerFrame GetSeedRequest

module.exports = GetSeedRequest