###
  index.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

module.exports =
  AddGroup:
    Request: require "./add-group-request"
    Confirm: require "./add-group-confirm"
  Authenticate:
    Request: require "./authenticate-request"
    Confirm: require "./authenticate-confirm"
    Indication: require "./authenticate-indication"