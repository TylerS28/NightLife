const regged = [];

function RegisterInterfaceCallback(name, cb) {
    AddEventHandler(`_apx_uiReq:${name}`, cb);

    if (GetResourceState('srp-interface') === 'started') exports['srp-interface'].RegisterIntefaceEvent(name);

    regged.push(name);
}

function SendInterfaceMessage(data) {
    exports['srp-interface'].SendInterfaceMessage(data);
}

function SetInterfaceFocus(hasFocus, hasCursor) {
    exports['srp-interface'].SetInterfaceFocus(hasFocus, hasCursor);
}

function GetInterfaceFocus() {
    return exports['srp-interface'].GetInterfaceFocus();
}

AddEventHandler('_apx_uiReady', () => {
    regged.forEach((eventName) => exports['srp-interface'].RegisterIntefaceEvent(eventName));
});