<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class WatchHistory extends CI_Controller {

	public function index()
	{
		$this->load->database();
		$this->load->view('anime/watchHistory');
	}
}
