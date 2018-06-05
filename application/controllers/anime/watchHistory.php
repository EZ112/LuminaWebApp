<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class WatchHistory extends CI_Controller {

	public function index()
	{
		$this->load->library('session');
		$subStatus = $this->session->userdata('loginSubStatus');

		if($subStatus != null)
			$this->load->view('anime/watchHistory');
		else
			header("Location: /LuminaWebApp");
		
	}
}
