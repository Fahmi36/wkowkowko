var api_url = 'http://192.168.100.2/wkowkowko/rest-api/',
    full_base_name = 'http://localhost/wkowkowko/';

//jQuery time
var current_fs, next_fs, previous_fs; //fieldsets
var left, opacity, scale; //fieldset properties which we will animate
var animating; //flag to prevent quick multi-click glitches

$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();

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

    $(document).on('keyup', '#noRegBang', function (event) {
        var reg = $(this).val();
        var regresult = $('.noregResult');
        var bnreg = $('.btn-noreg');
        var regresults = "";
        if (reg.length >= 1) {
            regresult.addClass('shows');
            bnreg.removeAttr("disabled");
            regresults += "<li>\n" +
                "<span class=\"font-weight-bold\">Data Bangunan di Temukan</span>\n" +
                "<hr class=\"mt-2 mb-0\">\n" +
                "</li>";
        }
        regresult.html(regresults);
    });

    $(".custom-file-input").on("change", function() {
        var fileName = $(this).val().split("\\").pop();
        $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
    });

    $("#btnDaftarAdm").click(function () {
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

    $("#btnAi").click(function () {
        var data = {dzona : $("#zona").val(),dsubzona : $("#subzona").val(),dlbangunan : $("#lbangunan").val(),dtbbangunan: $("#tbangunan").val(),dtltanah: $("#tltanah").val(),
            fbbangunan: $("#fungsi_bangunan").val(),

        }
        $.ajax({
            url: 'https://perizinan.pkkmart.com/getdata',
            type: 'POST',
            data: data,
            beforeSend:function() {
                // console.log(data);
            },
            success:function() {
                next();
            }
        });
    });

    $(".next").click(function(){
        if(animating) return false;
        animating = true;

        current_fs = $(this).parent();
        next_fs = $(this).parent().next();

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

    $(".nexts").click(function(){
        if(animating) return false;
        animating = true;

        current_fs = $(this).parent();
        next_fs = $(this).parent().next();

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

    $(".previouss").click(function(){
        if(animating) return false;
        animating = true;

        current_fs = $(this).parent();
        previous_fs = $(this).parent().prev();

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

    $('.submit').click(function () {
        location.reload();
    });


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

//    RADIO BUTTON
    $('.container').on('click', '.radioBtn a', function() {
        var sel = $(this).data('title');
        var tog = $(this).data('toggle');
        $(this).parent().next('.' + tog).prop('value', sel);
        $(this).parent().find('a[data-toggle="' + tog + '"]').not('[data-title="' + sel + '"]').removeClass('active').addClass('notActive');
        $(this).parent().find('a[data-toggle="' + tog + '"][data-title="' + sel + '"]').removeClass('notActive').addClass('active');
    });


    //CUSTOM PREVIOUS STEP
    $(".previous-check").click(function(){
        if(animating) return false;
        animating = true;

        current_fs = $(this).parent();
        previous_fs = $('#firstStep');

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
    $(".previous-sel").click(function(){
        if(animating) return false;
        animating = true;
        var nonForm = $(".selfForm, .compForm, .govForm, .npwpNik, .npwpI, .nipGov, .terkaitGov, .dirutComp, .selectSelfComp");

        current_fs = $(this).parent();
        previous_fs = $(this).parent().prev();

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
            // duration: 800,
            complete: function(){
                current_fs.hide();
                animating = false;
            },
            //this comes from the custom easing plugin
            // easing: 'easeInOutBack'
        });

        nonForm.show();
    });
    //CUSTOM NEXT STEP
    $('#onCheckToken').on('click', function () {
        var inputToken = $('#checkNoToken').val(),
            npemohon = $('#applicantName'),
            nident = $('#identityNumber'),
            dircom = $('#dirCompany'),
            npwpdir = $('#npwpDir'),
            mail = $('#applicantEmail'),
            phone = $('#applicantPhone'),
            status = $('#applicantStat'),
            submitted = $('#applicantSubmit');
        $.ajax({
            url: api_url + 'cek_permohonan?token='+inputToken,
            type: 'GET',
            dataType: 'json',
            beforeSend:function() {
                // loader;
            },
            success:function(data) {
                if(data.success){
                    if(data.rowCount == 1){
                        localStorage.setItem("isiDataToken", JSON.stringify(data.row));

                        nexts();

                        npemohon.html(data.row[0].nama_pemohon);
                        nident.html(data.row[0].no_identitas);
                        dircom.html(data.row[0].dirut_perusahaan);
                        npwpdir.html(data.row[0].npwp_dirut);
                        mail.html(data.row[0].email);
                        phone.html(data.row[0].no_telp);
                        status.html(data.row[0].status_kepengurusan);
                        submitted.html(data.row[0].create_date);

                    }else{
                        console.log('Tidak ada data.');
                    }
                }else{
                    console.log('Sistem Error');
                }
            }
        });
    });
    $('#btnCheckConfCode').on('click', function () {
        var inputCode = $('#checkConfCode').val(),
            currToken = JSON.parse(localStorage.getItem('isiDataToken'));

        $.ajax({
            url: api_url + 'users/prosesVerifikasi',
            type: 'POST',
            dataType: 'json',
            data:{token: currToken[0].token, code:inputCode},
            beforeSend:function() {
                // loader;
            },
            success:function(data) {
                if(data.success){
                    if(data.rowCount == 1){
                        console.log(data);
                    }else{
                        console.log('Tidak ada data.');
                    }
                }else{
                    console.log('Sistem Error');
                }
            }
        });
    });

    $('.self').on('click', function () {
        if(animating) return false;
        animating = true;
        var nonForm = $(".compForm, .govForm, .npwpI, .nipGov, .terkaitGov, .dirutComp");

        current_fs = $(this).parent();
        nonForm.hide();
        next_fs = $('#fourthStep');

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
    $('.company').on('click', function () {
        if(animating) return false;
        animating = true;
        var nonForm = $(".selfForm, .govForm, .npwpNik, .nipGov, .terkaitGov");

        current_fs = $(this).parent();
        nonForm.hide();
        next_fs = $('#fourthStep');

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
    $('.government').on('click', function () {
        if(animating) return false;
        animating = true;
        var nonForm = $(".selfForm, .compForm, .npwpNik, .npwpI, .dirutComp, .selectSelfComp");

        current_fs = $(this).parent();
        nonForm.hide();
        next_fs = $('#fourthStep');

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
    $('.noRegNext').on('click', function () {
        if(animating) return false;
        animating = true;

        current_fs = $(this).parent();
        next_fs = $('#lastStep');

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
    $('.notemptyLand').on('click', function () {
        if(animating) return false;
        animating = true;

        current_fs = $(this).parent();
        next_fs = $('#fourthStep');

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
    $('.checkPermi').on('click', function () {
        if(animating) return false;
        animating = true;

        current_fs = $(this).parent();
        next_fs = $('#checkPermission');

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
function nexts() {
    var tokenData = JSON.parse(localStorage.getItem('isiDataToken'));
    $.ajax({
        url: 'http://localhost/wkowkowko/rest-api/users/sendMail',
        type: 'POST',
        data: {token:tokenData[0].token},
        beforeSend:function() {
            // console.log(data);
        },
        success:function(data) {
            console.log(data)
        }
    });
    // users/sendMail?token=123

    if(animating) return false;
    animating = true;

    current_fs = $("#checkPermission");
    next_fs = $("#checkResume");

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

