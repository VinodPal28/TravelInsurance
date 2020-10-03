$(function () {
    /*Function for City(textbox)*/
    $.fn.City = function () {
        $(this).bind('keyup', function (e) {
            if (this.value.match(/[^a-zA-Z0-9 ]/g)) {
                this.value = this.value.replace(/[^a-zA-Z0-9 ]/g, '');
            }
        });
    }

    $.fn.name = function () {
        $(this).bind('keyup', function (e) {
            if (this.value.match(/[^a-zA-Z ]/g)) {
                this.value = this.value.replace(/[^a-zA-Z ]/g, '');
            }
        });
    }

    $.fn.numeric = function () {
        $(this).bind('keyup', function (e) {
            if (this.value.match(/[^0-9]/g)) {
                this.value = this.value.replace(/[^0-9]/g, '');
            }
        });
    }

    $.fn.AlphaNum = function () {
        $(this).bind('keypress', function (event) {
            var kc = event.which;
            if ((kc >= 65 && kc <= 90) || (kc >= 97 && kc <= 122) || (kc == 0 || kc == 8) || (kc >= 48 && kc <= 57))
            { }
            else {
                event.preventDefault();
            }
        });
    }

    $.fn.AlphaNumeric = function () {
        $(this).bind('keyup', function (e) {
            if (this.value.match(/[^a-zA-Z0-9]/g)) {
                this.value = this.value.replace(/[^a-zA-Z0-9]/g, '');
            }
        });
    }

    $.fn.mobile = function () {
        $(this).bind('keyup', function (e) {
            if (this.value.match(/[^0-9]/g)) {
                this.value = this.value.replace(/[^0-9]/g, '');
            }
        });
    }

    $.fn.AlphaNumSpace = function () {
        $(this).bind('keyup', function (e) {
            if (this.value.match(/[^a-zA-Z0-9%() ]/g)) {
                this.value = this.value.replace(/[^a-zA-Z0-9%() ]/g, '');
            }
        });
    }

    $.fn.numericdot = function () {
        $(this).bind('keyup', function (e) {
            if (this.value.match(/[^0-9.]/g)) {
                this.value = this.value.replace(/[^0-9.]/g, '');
            }
        });
    }

});
