//jQuery time
var current_fs, next_fs, previous_fs; //fieldsets
var left, opacity, scale; //fieldset properties which we will animate
var animating; //flag to prevent quick multi-click glitches

$(document).ready(function(){
    $('.selectpicker').selectpicker();

    $('#npwpF').focus();
    $('.submit').click(function () {
        location.reload();
    });
    $(document).on('keyup', '#npwpF', function (event) {
        var bak = $(this).val();
        var sresult = $('.npwpResult');
        var bnpwp = $('.btn-npwp');
        var sresulst = "";
        if (bak.length >= 1) {
            sresult.addClass('shows');
            bnpwp.removeAttr("disabled");
            sresulst += "<li>\n" +
                "                        <span class=\"font-weight-bold\">Data NPWP ditemukan</span>\n" +
                "                        <hr class=\"mt-2 mb-0\">\n" +
                "                        <div class=\"npwp-detail\">\n" +
                "                            <div class=\"npwp-detail_item\">\n" +
                "                                <div class=\"row w-100\">\n" +
                "                                    <div class=\"col-md-6 mb-1\">\n" +
                "                                        <label class=\"npwp-detail_item_label\">Nama :</label>\n" +
                "                                        <div class=\"npwp-detail_item_div\">\n" +
                "                                            <span class=\"npwp-detail_item_div_1\">Sdr. Alfamidi Mart</span>\n" +
                "                                        </div>\n" +
                "                                    </div>\n" +
                "                                    <div class=\"col-md-6 mb-1\">\n" +
                "                                        <label class=\"npwp-detail_item_label\">Perusahaan :</label>\n" +
                "                                        <div class=\"npwp-detail_item_div\">\n" +
                "                                            <span class=\"npwp-detail_item_div_1\">PT SP</span>\n" +
                "                                        </div>\n" +
                "                                    </div>\n" +
                "                                    <div class=\"col-md-6 mb-1\">\n" +
                "                                        <label class=\"npwp-detail_item_label\">NIK :</label>\n" +
                "                                        <div class=\"npwp-detail_item_div\">\n" +
                "                                            <span class=\"npwp-detail_item_div_1\">089653967913</span>\n" +
                "                                        </div>\n" +
                "                                    </div>\n" +
                "                                    <div class=\"col-md-6 mb-1\">\n" +
                "                                        <label class=\"npwp-detail_item_label\">NIP :</label>\n" +
                "                                        <div class=\"npwp-detail_item_div\">\n" +
                "                                            <span class=\"npwp-detail_item_div_1\">B 3865 EKD</span>\n" +
                "                                        </div>\n" +
                "                                    </div>\n" +
                "                                </div>\n" +
                "                            </div>\n" +
                "                        </div>\n" +
                "                    </li>";
        }
        sresult.html(sresulst);
    });

//    Alerts
    var alertwarning = "<div class='alert alert-danger' role='alert'>\n" +
        "  Maaf, fitur belum tersedia.\n" +
        "</div>";

    $("#min5k").click(function () {

        $("#alerts").html(alertwarning).fadeIn(1000, "easeInQuint", function () {}).delay(2000).fadeOut(1000, "easeInQuint", function (){});
    });

    $(".custom-file-input").on("change", function() {
        var fileName = $(this).val().split("\\").pop();
        $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
    });

    $("#len5k").click(function () {
        Swal.fire({
            text: "Apakah anda sudah mendaftar di OSS?",
            // type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#ff6704',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Ya, sudah',
            confirmButtonClass: 'next',
            cancelButtonText: 'Belum'
        }).then((result) => {
            if (!result.value) {
                Swal.fire(
                    'Maaf',
                    'Anda harus mendaftar dulu di OSS.',
                    setTimeout(() => {
                        location.reload()
                    }, 2000)
                )
            }
        })
    });

    $("#btnDaftarIzin").click(function () {
        Swal.fire({
            text: "Apakah anda sudah pastikah bahwa data yang anda masukan benar ?",
            // type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#ff6704',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Ya, sudah',
            confirmButtonClass: 'next',
            cancelButtonText: 'Belum'
        }).then((result) => {
            if (result.value) {
                next();
            }
        })
    });


    $(".next").click(function(){
        if(animating) return false;
        animating = true;

        current_fs = $(this).parent();
        next_fs = $(this).parent().next();
        debugger;
        //activate next step on progressbar using the index of next_fs
        $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");

        //show the next fieldset
        next_fs.show();
        //hide the current fieldset with style
        current_fs.animate({opacity: 0}, {
            step: function(now, mx) {
                //as the opacity of current_fs reduces to 0 - stored in "now"
                //1. scale current_fs down to 80%
                scale = 1 - (1 - now) * 0.2;
                //2. bring next_fs from the right(50%)
                left = (now * 50)+"%";
                //3. increase opacity of next_fs to 1 as it moves in
                opacity = 1 - now;
                current_fs.css({
                    'transform': 'scale('+scale+')',
                    // 'position': 'absolute',
                    'display' : 'none'
                });
                next_fs.css({'left': left, 'opacity': opacity});
            },
            duration: 800,
            complete: function(){
                current_fs.hide();
                animating = false;
            },
            //this comes from the custom easing plugin
            easing: 'easeInOutBack'
        });
    });

    $(".previous").click(function(){
        if(animating) return false;
        animating = true;

        current_fs = $(this).parent();
        previous_fs = $(this).parent().prev();

        //de-activate current step on progressbar
        $("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");

        //show the previous fieldset
        previous_fs.show();
        //hide the current fieldset with style
        current_fs.animate({opacity: 0}, {
            step: function(now, mx) {
                //as the opacity of current_fs reduces to 0 - stored in "now"
                //1. scale previous_fs from 80% to 100%
                scale = 0.8 + (1 - now) * 0.2;
                //2. take current_fs to the right(50%) - from 0%
                left = ((1-now) * 50)+"%";
                //3. increase opacity of previous_fs to 1 as it moves in
                opacity = 1 - now;
                current_fs.css({'left': left});
                previous_fs.css({'transform': 'scale('+scale+')', 'opacity': opacity});
            },
            duration: 800,
            complete: function(){
                current_fs.hide();
                animating = false;
            },
            //this comes from the custom easing plugin
            easing: 'easeInOutBack'
        });
    });

    $(".submit").click(function(){
        return false;
    })


    // Cache DOM
    const $goLogin = document.querySelector("#go-login"),
        $goRegister = document.querySelector("#go-register"),
        $container = document.querySelector(".container"),
        $overlayContainer = document.querySelector(".overlay-container");

    _toggleForm = () => {
        if ($container.classList.contains("go-register")) {
            $container.classList.remove("go-register");
            $container.classList.add("go-login");
            $overlayContainer.classList.add("animateWidth");
            $overlayContainer.addEventListener("webkitTransitionEnd", () =>
                $overlayContainer.classList.remove("animateWidth")
            );
        } else {
            $container.classList.remove("go-login");
            $container.classList.add("go-register");
            $overlayContainer.classList.add("animateWidth");
            $overlayContainer.addEventListener("webkitTransitionEnd", () =>
                $overlayContainer.classList.remove("animateWidth")
            );
        }
    };

    $goLogin.addEventListener("click", _toggleForm);
    // $goRegister.addEventListener("click", _toggleForm);
});

function next() {
    if(animating) return false;
    animating = true;

    current_fs = $(".izin").parent();
    next_fs = $(".izin").parent().next();

    //activate next step on progressbar using the index of next_fs
    $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");

    //show the next fieldset
    next_fs.show();
    //hide the current fieldset with style
    current_fs.animate({opacity: 0}, {
        step: function(now, mx) {
            //as the opacity of current_fs reduces to 0 - stored in "now"
            //1. scale current_fs down to 80%
            scale = 1 - (1 - now) * 0.2;
            //2. bring next_fs from the right(50%)
            left = (now * 50)+"%";
            //3. increase opacity of next_fs to 1 as it moves in
            opacity = 1 - now;
            current_fs.css({
                'transform': 'scale('+scale+')',
                // 'position': 'absolute',
                'display' : 'none'
            });
            next_fs.css({'left': left, 'opacity': opacity});
        },
        duration: 800,
        complete: function(){
            current_fs.hide();
            animating = false;
        },
        //this comes from the custom easing plugin
        easing: 'easeInOutBack'
    });
}

