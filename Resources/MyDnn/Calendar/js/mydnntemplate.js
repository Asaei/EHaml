Calendar.setup({
    inputField: '[DATEINPUTID]',
	button: "[BUTTON]",   
    telerikDatePicker:'[CLIENTID]',
    ifFormat: '[DATEFORMAT]',       
    dateType: '[DATETYPE]',
    showOthers: true,
    weekNumbers: true,
    showsTime: true,
    timeFormat: "12"
});

$("#[DATEINPUTID]").val('[DATETEXT]');

$(document).ready(function () {

    $("#[DATEINPUTID]").click(function () {
        $("#[BUTTON]").trigger('click');
    });

});

