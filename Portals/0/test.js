var TarikheEmrooz = moment().format("YYYY MM DD");
var ZamaneAmadegiBarayeShoorooeAmaliyat = form.fields.ZamaneAmadegiBarayeShoorooeAmaliyat.value;
var ZamaneAmadegiBarayeShoorooeAmaliyatMiladiString = ShamsiToMiladi(parseInt(ZamaneAmadegiBarayeShoorooeAmaliyat.substr(0, 4))

if (moment(ZamaneAmadegiBarayeShoorooeAmaliyatMiladiString).isValid()) {
    if (moment(ZamaneAmadegiBarayeShoorooeAmaliyatMiladiString) < TarikheEmrooz) {
        swal({
                title: "خطایی رخ داده است!", text: "تاریخ نمی تواند روزی قبل از امروز باشد.",
                type: "warning", showCancelButton: false, confirmButtonColor: "#DD6B55",
                confirmButtonText: "توضیح بیشتر", closeOnConfirm: false, allowOutsideClick: true },
            function () {
                var win = window.open("/سایر-خدمات/آموزش", '_blank');
                win.focus();
            });
        return false;
    }
}