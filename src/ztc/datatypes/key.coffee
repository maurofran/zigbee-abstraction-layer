###
  key.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

_ = require "lodash"

class Key
  @LENGTH = 16

  constructor: (@buffer) ->
    @buffer = new Buffer @buffer, "hex" if _.isString @buffer

  asBuffer: () ->
    @buffer

  toHexString: () ->
    @buffer.toString "hex"

module.exports = Key