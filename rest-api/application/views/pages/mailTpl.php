<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>
	<table cellpadding="0" cellspacing="0">
		<tbody>
			<tr>
				<td></td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="background-color:#f5f5f5;padding:22px 16px;margin-bottom:6px;direction:ltr;padding-bottom:7px" width="100%">
						<tbody>
							<tr>
								<td align="left" width="52"><img class="CToWUd" height="52" src="http://localhost/wkowkowko/pelayanan/assets/img/logopemprov.png" width="52"></td>
								<td align="left" style="font-family:Roboto-Light,Helvetica,Arial,sans-serif"><label style="font-family:Roboto-Light,Helvetica,Arial,sans-serif">Perizinan DKI</label></td>
								<td align="right"  style="font-family:Roboto-Light,Helvetica,Arial,sans-serif"><label style="font-family:Roboto-Light,Helvetica,Arial,sans-serif">
									Informasi
								</td>
							</tr>
						</tbody>
					</table>
					<!-- <div style="background-color:#f5f5f5;padding:22px 16px;margin-bottom:6px">
						<table border="0" cellpadding="0" cellspacing="0" class="m_6838505644809902572v2rsp" width="100%">
							<tbody>
								<tr>
									<td style="vertical-align:top"><img class="CToWUd" height="40px" src=""></td>
									<td width="16px"></td>
									<td><span style="font-family:Roboto-Regular,Helvetica,Arial,sans-serif;font-size:13px;color:rgba(0,0,0,0.87);line-height:1.6;color:rgba(0,0,0,0.54)">Anda menerima email ini karena telah mendaftar di VClass dan <a style="text-decoration:none;color:rgba(0,0,0,0.87)">sony.surahman98@gmail.com</a> dicantumkan sebagai email untuk pendaftaran.</span></span></td>
								</tr>
							</tbody>
						</table>
					</div> -->
				</td>
				<td></td>
			</tr>
			<tr>
				<td><p style="margin:10px 0;"></p></td>
			</tr>
			<tr>
				<td style="" width="6">
					<p>&nbsp;</p>
				</td>
				<td style="box-shadow: 0 0 15px 2px rgba(0,0,0,.4);">
					<div style="word-break:break-word">
						<div style="text-align:center;font-family:Roboto-Regular,Helvetica,Arial,sans-serif;padding-left:20px;padding-right:20px;border-bottom:thin solid #f0f0f0;color:#ff6704;font-size:24px;padding-bottom:8px;padding-top:5px;" class="m_6838505644809902572v2sp">
							<?php echo (@$title=="")?'Informasi Pendaftaran':@$title; ?><br>
							<a style="font-family:Roboto-Regular,Helvetica,Arial,sans-serif;color:rgba(0,0,0,0.87);font-size:16px;line-height:1.8"><?=$nama_pemohon ." - #". $nomor_token?></a>
						</div>
						<div style="padding: 0 20px;font-family:Roboto-Regular,Helvetica,Arial,sans-serif;font-size:15px;color:rgba(0,0,0,0.87);">
							
						<?php if($type=='verifikasikode'){ ?>

						<table style="border:solid 1px rgba(0,0,0,.2);width:100%;padding:10px;margin-top:10px;word-break: break-all;word-wrap:break-word;">
							<tr>
								<td colspan="3">
									<h4 style="margin:0;font-family:Roboto-Regular,Helvetica,Arial,sans-serif;color:#ff6704;font-size:16px;line-height:1.8">Halo <?=$nama_pemohon?>,</h4>
                                    <small  style="margin:0;font-family:Roboto-Regular,Helvetica,Arial,sans-serif;color:rgba(0,0,0,0.87);font-size:12px;line-height:1.8">berikut verifikasi kode yang dibutuhkan untuk melacak permohonan kamu</small>
								</td>
							</tr>
							<tr>
								<td><h2 style="margin:0;font-family:Roboto-Regular,Helvetica,Arial,sans-serif;color:#ff6704;font-size:24px;line-height:1.8"><?=@$generatedCode?></h2></td>
							</tr>
						</table>
						<?php } ?>
						<?php if($type=='ditolaksedih'){ ?>
							<div style="background:rgba(245, 245, 245, 1);text-align:center;font-family:Roboto-Regular,Helvetica,Arial,sans-serif;padding-left:20px;padding-right:20px;color:rgba(97, 84, 84, 0.87);font-size:24px;padding-bottom:8px;padding-top:5px;margin:20px 0;font-size: 19px;">Oops! Bukti pembayaran Anda ditolak. Silahkan login kemudian upload kembali bukti pembayaran yang valid. 
							</div>
							<center><a href="http://pajakvclass.com/signc/fLoginAct?uname=<?=$kode_pendaftaran?>&passwd=<?=$retype_password?>"><button style="cursor:pointer;background: #335589;height:auto;padding:20px;width:auto;border: none;border-radius: 2px;color:#f9f9f9;box-shadow: 0 0 8px 2px rgba(0,0,0,0.2)">Login Sekarang!</button></a></center>
						<?php } ?>
						<?php if($type=='verifikasikode'){ ?>
							<div style="background:rgba(245, 245, 245, 1);text-align:center;font-family:Roboto-Regular,Helvetica,Arial,sans-serif;padding-left:20px;padding-right:20px;color:rgba(97, 84, 84, 0.87);font-size:14px;padding-bottom:8px;padding-top:5px;margin:20px 0;">Mohon jangan berikan kode diatas pada siapapun
							</div>
							<!-- <center><a href="http://pajakvclass.com/signc/fLoginAct?uname=<?=$kode_pendaftaran?>&passwd=<?=$retype_password?>"><button style="cursor:pointer;background: #335589;height:auto;padding:20px;width:auto;border: none;border-radius: 2px;color:#f9f9f9;box-shadow: 0 0 8px 2px rgba(0,0,0,0.2)">Login Sekarang!</button></a></center> -->
						<?php } ?>


                        <!-- Buat Pemohon baru -->
						<?php if ($type=='daftarbaru') {?>
						<table style="border:solid 1px rgba(0,0,0,.2);width:100%;padding:10px;margin-top:10px;word-break: break-all;word-wrap:break-word;">
							<tr>
								<td colspan="3">
									<h4 style="margin:0;font-family:Roboto-Regular,Helvetica,Arial,sans-serif;color:rgba(0,0,0,0.87);font-size:16px;line-height:1.8">Data Pendaftaran</h4>
								</td>
							</tr>
							<tr>
								<td width="20%">Kode Pendaftaran</td><td style="width: 20px">:</td><td><b><?=$kode_pendaftaran?></b></td>
							</tr>
							<tr>
								<td width="20%">Batch</td><td style="width: 20px">:</td><td><b><?=$nama_batch. ' - ' .$kode_batch;?></b></td>
							</tr>
							<tr>
								<td>Nama</td><td style="width: 20px">:</td><td><?=$nama_pendaftar?></td>
							</tr>
							<tr>
								<td>Jenis Kelamin</td><td style="width: 20px">:</td><td><?=($jenis_kelamin==1)?'Laki-Laki':'Perempuan';?></td>
							</tr>
							<tr>
								<td>Alamat</td><td style="width: 20px">:</td><td><?=$alamat_pendaftar?></td>
							</tr>
							<tr>
								<td>Universitas</td><td style="width: 20px">:</td><td><?=$institution?></td>
							</tr>
							<tr>
								<td>No Telp</td><td style="width: 20px">:</td><td><?=$no_telp?></td>
							</tr>
							<tr>
								<td>Biaya Pendaftaran</td><td style="width: 20px">:</td><td><b>Rp. <?=number_format($biaya_pendaftaran,2,',','.');?></b></td>
							</tr>
						</table>
						
						<table style="border:solid 1px rgba(0,0,0,.2);width:100%;padding:10px;margin-top:10px;word-break: break-all;word-wrap:break-word;">
							<tr>
								<td colspan="3">
									<h4 style="margin:0;font-family:Roboto-Regular,Helvetica,Arial,sans-serif;color:rgba(0,0,0,0.87);font-size:16px;line-height:1.8">Daftar Rekening Bank</h4>
								</td>
							</tr>
							<tr>
								<td width="20%"><?=$rekening->nama_rekening?></td><td style="width:20px;">:</td><td><?php echo $rekening->no_rek; ?> a.n <?php echo $rekening->atas_nama; ?></td>
							</tr>
							<tr>
								<td width="20%"><?=$rekening->nama_rekening2?></td><td style="width:20px;">:</td><td><?php echo $rekening->no_rek2; ?> a.n <?php echo $rekening->atas_nama2; ?></td>
							</tr>
							
						</table>
                        <?php } ?>
                        <!-- Buat Pemohon baru -->
						</div>
					</div>
					<div style="font-family:Roboto-Regular,Helvetica,Arial,sans-serif;font-size:13px;color:rgba(0,0,0,0.87);line-height:1.6;padding-left:20px;padding-right:20px;padding-bottom:12px;padding-top:24px">
						<?php if ($type=='daftarbaru') {?>

						<div class="m_6838505644809902572v2sp">
							Lakukan pembayaran kemudian login ke system menggunakan username dan password yang telah diberikan untuk konfirmasi pembayaran.
							<div style="padding-top:24px">
								
							</div>
							</div>
						</div>
						<?php } ?>
					</td>
					<td style="" width="6">
						<div></div>
					</td>
				</tr>
				<tr>
					<td></td>
					<td>
						<div style="text-align:left">
							<div style="font-family:Roboto-Regular,Helvetica,Arial,sans-serif;color:rgba(0,0,0,0.54);font-size:12px;line-height:20px;padding-top:10px">
								<div>
									Anda menerima email ini sebagai pemberitahuan tentang <?php echo $title; ?> yang tersedia di layanan system Perizinan DKI.
								</div>
								<div style="direction:ltr">
									© <?=date('Y')?> Perizinan DKI.
								</div>
							</div>
							<div style="display:none!important;max-height:0px;max-width:0px">
								et:91
							</div>
						</div>
					</td>
					<td></td>
				</tr>
			</tbody>
		</table>
	</body>
	</html>
