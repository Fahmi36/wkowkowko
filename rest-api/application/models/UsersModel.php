<?php
/**
 * @author Sony Surahman
 * 
 */
class UsersModel extends CI_Model
{
    function getPemohon($id)
    {
        if($id){
            $this->db->where('id',$id);
        }
        $q = $this->db->get('pemohon');
        return $q;
    }

    function cekPermohonan($no_token)
    {
        $this->db->select('per.token,pe.*');        
        $this->db->join('pemohon pe',' pe.id = per.id_pemohon','INNER');
        $this->db->where('per.token',$no_token);
        $q = $this->db->get('permohonan per');
        return $q;
    }
    
    function prosesVerified($code,$token)
    {
        $this->db->where('code',$code);
        $this->db->where('token',$token);
        $q = $this->db->get('permohonan');
        return $q;
    }
}
