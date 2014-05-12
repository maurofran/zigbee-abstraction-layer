
/*
  index.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
 */

(function() {
  module.exports = {
    AddToAddressMap: {
      Request: require("./add-to-address-map-request"),
      Confirm: require("./add-to-address-map-confirm")
    },
    CPUReset: require("./cpu-reset"),
    DebugEvent: require("./debug-event"),
    ErrorEvent: require("./error-event"),
    Event: require("./event"),
    GetChannel: {
      Request: require("./get-channel-request"),
      Confirm: require("./get-channel-confirm")
    },
    GetMode: {
      Request: require("./get-mode-request"),
      Confirm: require("./get-mode-confirm")
    },
    GetNumOfMsgs: {
      Request: require("./get-num-of-msgs-request"),
      Confirm: require("./get-num-of-msgs-confirm")
    },
    GetPanId: {
      Request: require("./get-pan-id-request"),
      Confirm: require("./get-pan-id-confirm")
    },
    GetSeed: {
      Request: require("./get-seed-request"),
      Confirm: require("./get-seed-confirm")
    },
    ModeSelect: {
      Request: require("./mode-select-request"),
      Confirm: require("./mode-select-confirm")
    },
    NVGetDataSetDesc: {
      Request: require("./nv-get-dataset-desc-request"),
      Confirm: require("./nv-get-dataset-desc-confirm")
    },
    NVGetPageHeaders: {
      Request: require("./nv-get-page-headers-request"),
      Confirm: require("./nv-get-page-headers-confirm")
    },
    Ping: {
      Request: require("./ping-request"),
      Confirm: require("./ping-confirm")
    },
    RadioRegisterRead: {
      Request: require("./radio-register-read-request"),
      Confirm: require("./radio-register-read-confirm")
    },
    RadioRegisterWrite: {
      Request: require("./radio-register-write-request"),
      Confirm: require("./radio-register-write-confirm")
    },
    ReadExtAddr: {
      Request: require("./read-ext-addr-request"),
      Confirm: require("./read-ext-addr-confirm")
    },
    ReadMemoryBlock: {
      Request: require("./read-memory-block-request"),
      Confirm: require("./read-memory-block-confirm")
    },
    ReadSAS: {
      Request: require("./read-sas-request"),
      Confirm: require("./read-sas-confirm")
    },
    RemoveFromAddressMap: {
      Request: require("./remove-from-address-map-request"),
      Confirm: require("./remove-from-address-map-confirm")
    },
    SaveConfirm: require("./save-confirm"),
    SetChannel: {
      Request: require("./set-channel-request"),
      Confirm: require("./set-channel-confirm")
    },
    SetPanId: {
      Request: require("./set-pan-id-request"),
      Confirm: require("./set-pan-id-confirm")
    },
    WriteExtAddr: {
      Request: require("./write-ext-addr-request"),
      Confirm: require("./write-ext-addr-confirm")
    },
    WriteMemoryBlock: {
      Request: require("./write-memory-block-request"),
      Confirm: require("./write-memory-block-confirm")
    },
    WriteSAS: {
      Request: require("./write-sas-request"),
      Confirm: require("./write-sas-confirm")
    }
  };

}).call(this);

//# sourceMappingURL=index.js.map
