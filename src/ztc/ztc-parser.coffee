###
  ztc-parser.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

Dissolve = require "dissolve"
moment = require "moment"
{ShortAddress} = require "./datatypes"
{IEEEAddress} = require "./datatypes"
{PANId} = require "./datatypes"
{Key} = require "./datatypes"
ZtcFrame = require("./ztc-frame")

require("./frames");

class ZtcParser extends Dissolve
  # Parse a ZTC frame.
  #
  # @param [String] name the name of the field
  # @returns [ZtcParser] this
  ztcFrame: (name) ->
    @uint8 "syn"
    @uint8 "opCodeGroup"
    @uint8 "opCode"
    @uint8 "size"
    @tap () ->
      @vars[name] = ZtcFrame.create @vars.opCodeGroup, @vars.opCode, @vars.size, this
      delete @vars.opCodeGroup
      delete @vars.opCode
      delete @vars.size
    @uint8 "checksum"

  # Parse a moment in time.
  #
  # @param [String] name the name of the field
  # @returns [ZtcParser] this
  moment: (name) ->
    @uint32le name
    @tap () ->
      @vars[name] = moment().year(2000).startOf("year").add("s", @vars[name])

  # Parse a boolean value.
  #
  # @param [String] name the name of the field
  # @returns [ZtcParser] this
  boolean: (name) ->
    @uint8 name
    @tap () ->
      @vars[name] = not not @vars[name]

  # Parse a short address.
  #
  # @param [String] name the name of the field
  # @returns [ZtcParser] this
  shortAddress: (name) ->
    @buffer name, ShortAddress.LENGTH
    @tap () ->
      @vars[name] = new ShortAddress @vars[name]

  # Parse an IEEE address
  #
  # @param [String] name the name of the field
  # @returns [ZtcParser] this
  ieeeAddress: (name) ->
    @buffer name, IEEEAddress.LENGTH
    @tap () ->
      @vars[name] = new IEEEAddress @vars[name]

  # Parse a PAN Id value
  #
  # @param [String] name the name of the field
  # @returns [ZtcParser] this
  panId: (name) ->
    @buffer name, PANId.LENGTH
    @tap () ->
      @vars[name] = new PANId @vars[name]

  # Parse a Key value.
  #
  # @param [String] name the name of the field
  # @returns [ZtcParser] this
  key: (name) ->
    @buffer name, Key.LENGTH
    @tap () ->
      @vars[name] = new Key @vars[name]

module.exports = ZtcParser