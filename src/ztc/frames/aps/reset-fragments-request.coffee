###
  reset-fragments-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class ResetFragmentsRequest extends ZtcFrame
  @OPCODE_GROUP = 0x9C
  @OPCODE = 0x10

  constructor: () ->
    super ResetFragmentsRequest.OPCODE_GROUP, ResetFragmentsRequest.OPCODE

ZtcFrame.registerFrame ResetFragmentsRequest

module.exports = ResetFragmentsRequest