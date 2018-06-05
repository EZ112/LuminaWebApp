<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Success extends CI_Controller {

	public function index()
	{
		$this->load->library('session');
		$subStatus = $this->session->userdata('loginSubStatus');

		if($subStatus != null)
			$this->load->view('success');
		else
			header("Location: /LuminaWebApp");
	}
}