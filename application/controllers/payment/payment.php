<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Payment extends CI_Controller {

	public function index()
	{
		$this->load->library('session');
		$subStatus = $this->session->userdata('loginSubStatus');

		if($subStatus != null)
			$this->load->view('payment/payment');
		else
			header("Location: /LuminaWebApp");
	}

	public function getBankDetail(){
		$result = $this->db->query("CALL sp_GetBankDetail()")->result();
		echo json_encode($result);
	}
}
