###
  ztc-builder.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer


  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

Concentrate = require "concentrate"
moment = require "moment"

class ZtcBuilder extends Concentrate
  # Writes a ZTC frame object.
  #
  # @param [ZtcFrame] frame the frame to write
  # @returns [ZtcBuilder] this
  ztcFrame: (frame) ->
    frame.write this

  # Writes a moment object.
  #
  # @param [Moment] time the moment to write
  # @returns [ZtcBuilder] this
  moment: (time) ->
    @uint32le time.second() - moment().year(2000).startOf("year").second()

  # Writes a boolean value.
  #
  # @param [Boolean] value the value to write
  # @returns [ZtcBuilder] this
  boolean: (value) ->
    @uint8 if value is true then 0x01 else 0x00

  # Writes a short address object
  #
  # @param [ShortAddress] shortAddress the address to write
  # @returns [ZtcBuilder] this
  shortAddress: (shortAddress) ->
    @buffer shortAddress.asBuffer()

  # Writes an IEEE address object.
  #
  # @param [IEEEAddress] ieeeAddress the address to write
  # @returns [ZtcBuilder] this
  ieeeAddress: (ieeeAddress) ->
    @buffer ieeeAddress.asBuffer()

  # Writes a PANId object.
  #
  # @param [PANId] panId the PAN id object to write
  # @returns [ZtcBuilder] this
  panId: (panId) ->
    @buffer panId.asBuffer()

  # Writes a key object.
  #
  # @param [Key] key the Key object to write
  # @returns [ZtcBuilder] this
  key: (key) ->
    @buffer key.asBuffer()

module.exports = ZtcBuilder;