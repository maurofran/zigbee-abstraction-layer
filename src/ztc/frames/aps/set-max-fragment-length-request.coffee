###
  set-max-fragment-length-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class SetMaxFragmentLengthRequest extends ZtcFrame
  @OPCODE_GROUP = 0x9C
  @OPCODE = 0x13

  constructor: (@maxLen) ->
    super SetMaxFragmentLengthRequest.OPCODE_GROUP, SetMaxFragmentLengthRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 1
    builder.uint8 @maxLen

ZtcFrame.registerFrame SetMaxFragmentLengthRequest

module.exports = SetMaxFragmentLengthRequest