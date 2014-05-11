###
  key.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

class Key
  @LENGTH = 16

  constructor: (@buffer) ->

  asBuffer: () ->
    @buffer

module.exports = Key