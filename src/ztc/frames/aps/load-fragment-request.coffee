###
  load-fragment-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class LoadFragmentRequest extends ZtcFrame
  @OPCODE_GROUP = 0x9C
  @OPCODE = 0x11

  constructor: (@octects) ->
    super LoadFragmentRequest.OPCODE_GROUP, LoadFragmentRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 1+ @octects.length
    builder.uint8 @octects.length
    builder.buffer @octects

ZtcFrame.registerFrame LoadFragmentRequest

module.exports = LoadFragmentRequest