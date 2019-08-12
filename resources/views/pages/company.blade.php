<form id="msform">
    @csrf
    <!--            ALERT-->
    <div id="alerts"></div>

    <!-- progressbar -->
    <ul id="progressbar">
        <li class="active">Luas Bangunan</li>
        <li>NPWP</li>
        <li>Upload Data</li>
        <li>Selesai</li>
    </ul>
    <!-- fieldsets -->
    <fieldset>
        <h3 class="form__heading"> Luas Bangunan<span class="text-danger">*</span> </h3>
        <p class="form__text text-muted">Pilih luas bangunan yang anda miliki</p>
        <button type="button" class="btn w-100 btn--main btn--main_luas" id="min5k">< 5000 m<sup>2</sup></button>
        <hr>
        <button type="button" class="btn w-100 btn--main btn--main_luas next" id="len5k">> 5000 m<sup>2</sup></button>
        <!--                <button type="button" class="btn w-100 btn&#45;&#45;main btn&#45;&#45;main_luas" id="len5k">> 5000 m<sup>2</sup></button>-->
    </fieldset>
    <fieldset>
        <h3 class="form__heading"> NPWP<span class="text-danger">*</span> </h3>
        <p class="form__text text-muted">Masukan nomor NPWP anda</p>
        <input autocomplete="off" aria-label="Search" type="search" placeholder="" class="form__field mb-0 npwpI" name="npwpF" id="npwpF" style="height: 40px">
        <ul class="dropdown-search npwpResult">

        </ul>
        <input type="button" name="previous" class="previous action-button-previous" value="Kembali"/>
        <button type="button" name="next" class="btn btn--main btn-npwp next" disabled>Selanjutnya</button>
    </fieldset>
    <fieldset>
        <h3 class="form__heading"> UPLOAD DATA PERUSAHAAN<span class="text-danger">*</span> </h3>
        <p class="form__text text-muted">Lengkapi data berikut untuk keperluan lebih lanjut</p>
        <!--                <input type="file" placeholder="" class="form__field" id="bb">-->
        <div class="custom-file mb-2">
            <input type="file" class="custom-file-input" id="customFile1">
            <label class="custom-file-label" for="customFile1">Sertifikat Lahan</label>
        </div>
        <div class="custom-file mb-2">
            <input type="file" class="custom-file-input" id="customFile2">
            <label class="custom-file-label" for="customFile2">File AutoCAD Bangunan</label>
        </div>
        <div class="form-group">
            <select class="form-control" id="konsultan1">
                <option>- Konsultan Perencanaan -</option>
                <option>PT Mencari</option>
                <option>PT Cinta</option>
                <option>PT Sejati</option>
            </select>
        </div>
        <hr>
        <span class="text-muted">Optional</span>
        <div class="form-group">
            <select class="form-control" id="konsultan2">
                <option>- Konsultan Perizinan -</option>
                <option>PT Mencari</option>
                <option>PT Cinta</option>
                <option>PT Sejati</option>
            </select>
        </div>
        <input type="button" name="previous" class="previous action-button-previous" value="Kembali"/>
        <button type="button" name="next" class="btn btn--main next">DAFTAR IZIN</button>
    </fieldset>
    <fieldset style="color: #ff6704;">
        <i class="mdi mdi-check-circle mdi-48px"></i>
        <h3 class="form__heading"> DATA BERHASIL DIKIRIM </h3>
        <p class="form__text text-muted">Mohon menunggu maksimal 20 Hari kerja untuk proses verifikasi pendataan bangunan anda. Notifikasi akan dikirimkan ke Email anda.</p>
        <button type="button" name="submit" class="btn btn--main submit">SELESAI</button>
    </fieldset>
</form>