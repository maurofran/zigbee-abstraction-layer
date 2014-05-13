###
  authenticate-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

   C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class AuthenticateRequest extends ZtcFrame
  @OPCODE_GROUP = 0x99
  @OPCODE = 0xF5

  @Action =
    INITIATE: 0x00
    RESPOND_ACCEPT: 0x01
    RESPOND_REJECT: 0x02
  
  constructor: (@partnerAddress, @action, @randomChallenge) ->
    super AuthenticateRequest.OPCODE_GROUP, AuthenticateRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 25
    builder.ieeeAddress @partnerAddress
    builder.uint8 @action
    builder.buffer @randomChallenge

ZtcFrame.registerFrame AuthenticateRequest

module.exports = AuthenticateRequest