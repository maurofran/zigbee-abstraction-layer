/*
 * index.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

module.exports = {
    Consts: require("./consts"),

    ReadSAS: {
        Request: require("./readsas"),
        Confirm: require("./readsasconfirm")
    },
    WriteSAS: {
        Request: require("./writesas"),
        Confirm: require("./saveconfirm")
    },

    CPUReset: require("./cpureset"),
    DebugEvent: require("./debugevent"),
    ErrorEvent: require("./errorevent"),
    Event: require("./event"),

    GetChannel: {
        Request: require("./getchannelrequest"),
        Confirm: require("./getchannelconfirm")
    },
    GetMode: {
        Request: require("./getmoderequest"),
        Confirm: require("./getmodeconfirm")
    },
    GetNumOfMsgs: {
        Request: require("./getnumofmsgsrequest"),
        Confirm: require("./getnumofmsgsconfirm")
    },
    GetPanID: {
        Request: require("./getpanidrequest"),
        Confirm: require("./getpanidconfirm")
    },
    ModeSelect: {
        Request: require("./modeselectrequest"),
        Confirm: require("./modeselectconfirm")
    },
    NVGetDataSetDesc: {
        Request: require("./nvgetdatasetdescrequest"),
        Confirm: require("./nvgetdatasetdescconfirm")
    },
    NVGetPageHeaders: {
        Request: require("./nvgetpageheadersrequest"),
        Confirm: require("./nvgetpageheadersconfirm")
    }
};