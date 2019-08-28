<?php
/**
 * @author Sony Surahman
 * 
 */
defined('BASEPATH') OR exit('No direct script access allowed');

class Users extends CI_Controller {

	/**
	 * Index Page for this controller.
	 *
	 * Maps to the following URL
	 * 		http://example.com/index.php/users
	 *	- or -
	 * 		http://example.com/index.php/users/index
	 *	- or -
	 * Since this controller is set as the default controller in
	 * config/routes.php, it's displayed at http://example.com/
	 *
	 * So any other public methods not prefixed with an underscore will
	 * map to /index.php/users/<method_name>
	 * @see https://codeigniter.com/user_guide/general/urls.html
	 */

    function __construct() {
        parent::__construct();
        header('Access-Control-Allow-Origin:*');
        header("Access-Control-Allow-Credentials: true");
        header('Access-Control-Allow-Methods: GET, PUT, POST, DELETE, OPTIONS');
        header('Access-Control-Max-Age: 1000');
        header('Access-Control-Allow-Headers: Content-Type, Content-Range, Content-Disposition, Content-Description');
        
        $this->load->model('UsersModel', 'um');
    }

    /**
     * @method GET
     * @param id INT (idpemohon)
     * This Function is for searching pemohon account data
     */
    public function getPemohon()
    {
        try {
            $id = htmlspecialchars($this->input->get('id'));
            $data = $this->um->getPemohon($id);
            if($data){
                $res = $this->returnResult($data);
            }else{
                $res = $this->returnResultErrorDB();
            }

            echo json_encode($res);
        } catch (\Throwable $th) {
            throw $th;
        }
    }


    /**
     * @method GET
     * @param token VARCHAR (idpemohon)
     * This Function is for searching permohonan data
     */
    public function cekPermohonan($tokenGet=NULL)
    {
        try {
            $token = htmlspecialchars($this->input->get('token'));
            if($tokenGet!=null){
                $token = $tokenGet;
            }
            if($token){
                $data = $this->um->cekPermohonan($token);
                $res = $this->returnResult($data);
            }else{
                $res = $this->returnResultCustom(false,"Oops, missing parameter");
            }

            if($tokenGet!=null){
                return json_encode($res);
            }else{
                echo json_encode($res);
            }
        } catch (\Throwable $th) {
            throw $th;
        }
    }


    /**
     * @method POST
     * @param token VARCHAR (token)
     * This Function is for sending mail
     */
    public function sendMail()
    {
        try {
            $token = $this->input->get('token');
            if($token!=""){

                $dPemohon = $this->cekPermohonan($token);
                $decoder = json_decode($dPemohon);
                $decodeData = $decoder->row[0];
                $emailpemohon = $decodeData->email;
                $tokenpemohon = $decodeData->token;
                $generatedCode = $this->incrementalHash();
                $data = array();
                $data['title'] = "Verifikasi Kode";
                $data['type'] = "verifikasikode";
                $data['generatedCode'] = $generatedCode;
                $data['nomor_token'] = $tokenpemohon;
                $data['nama_pemohon'] = $decodeData->nama_pemohon;
                $config = array(
                    'protocol'  => 'smtp',
                    'smtp_host' => 'ssl://smtp.gmail.com',
                    'smtp_port' => 465,
                    'smtp_user' => 'tester4pps@gmail.com',
                    'smtp_pass' => '5exP1stol2105',
                    'mailtype'  => 'html',
                    'wordwrap'  => TRUE,
                    'charset'   => 'utf-8',
                    'priority'  => 1
                );
                $this->email->initialize($config);
                
                $this->email->set_mailtype("html");
                $this->email->set_newline("\r\n");
                $mesg = $this->load->view('pages/mailTpl', $data, true);
                $this->email->to($emailpemohon);
                $this->email->from('tester4pps@gmail.com', 'Telkomcel E-Topup');
                $this->email->reply_to('tester4pps@gmail.com', 'Telkomcel E-Topup');
                
                $this->email->subject('Invoices E-topup');
                $this->email->message($mesg);
                // $this->email->attach('./uploads/pdf/' . $namaPdf . '.pdf');
                // $email = $this->email->send();
                if ($this->email->send()) {
                    $result = $this->returnResultCustom(true,'Success send mail');
                    //Update DB Permohonan
                    $this->db->query("UPDATE permohonan SET code='$generatedCode' WHERE token='$tokenpemohon'");
                } else {
                    $result = $this->returnResultCustom(false,'Failed to send mail');
                    // show_error($this->email->print_debugger());
                }
            }else{
                $result = $this->returnResultCustom(false,'Oops, missing parameter');
            }
            echo json_encode($result);

        } catch (\Throwable $th) {
            throw $th;
        }
    }
    

    public function prosesVerifikasi()
    {
        try{
            $code = $this->input->post('code');
            $token = $this->input->post('token');
            if($code=="" OR $token==""){
                $result = $this->returnResultCustom("Oops, missing parameter");
            }else{
                $data = $this->um->prosesVerified($code,$token);
                $result = $this->returnResult($data);
            }
            echo json_encode($result);
        } catch (\Throwable $th) {
            throw $th;
        }
    }

    //Utilities
    function returnResult($data)
    {
        $result = array(
                    'success'=>true,
                    'rowCount'=>$data->num_rows(),
                    'row'=>$data->result()
                );
        return $result;
    }

    function returnResultErrorDB()
    {
        return array(
                    'success'=>false,
                    'msg'=>'Failed fetch data from database'
                );
    }
    function returnResultCustom($t,$msg)
    {
        return array(
            'success'=>$t,
            'msg'=>$msg
        );
    }

    function incrementalHash($len = 5){
        $charset = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        $base = strlen($charset);
        $result = '';
      
        $now = explode(' ', microtime())[1];
        while ($now >= $base){
          $i = $now % $base;
          $result = $charset[$i] . $result;
          $now /= $base;
        }
        return substr($result, -5);
      }

}