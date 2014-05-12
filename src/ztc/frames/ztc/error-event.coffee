###
  error-event.js
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class ErrorEvent extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0xFE

  constructor: (parser) ->
    super ErrorEvent.OPCODE_GROUP, ErrorEvent.OPCODE
    parser.uint8 "status"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame ErrorEvent

module.exports = ErrorEvent