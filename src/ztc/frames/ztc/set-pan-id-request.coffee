###
  set-pan-id-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class SetPanIDRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x15

  constructor: (@panId) ->
    super SetPanIDRequest.OPCODE_GROUP, SetPanIDRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 2
    builder.panId @panId

ZtcFrame.registerFrame SetPanIDRequest

module.exports = SetPanIDRequest