###
  debug-event.js
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class DebugEvent extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0xFF

  constructor: (parser) ->
    super DebugEvent.OPCODE_GROUP, DebugEvent.OPCODE
    parser.uint16le "messageAddress"
    parser.uint8 "status"
    parser.uint8 "opCodeGroup"
    parser.uint8 "opCode"
    parser.buffer "data", 32
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame DebugEvent

module.exports = DebugEvent