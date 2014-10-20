function mydnnOpenDatePickerN(vv) {
    var myUrl = 'javascript:mydnnOpenDatePickerN("[DATEINPUTID]")';
    var mydnnbtnid = $("a[href$='" + myUrl + "']").attr('id').replace('mydnnOpenDatePickerN("', '').replace('")', '');

    Calendar.setup({
        inputField: '[DATEINPUTID]',
        button: mydnnbtnid,
        telerikDatePicker: 'NONETELERIK',
        ifFormat: '%Y/%m/%d',
        dateType: 'jalali',
        showOthers: true,
        weekNumbers: true,
        showsTime: true,
        timeFormat: "12"
    });
    $('#' + mydnnbtnid).trigger('click');
}