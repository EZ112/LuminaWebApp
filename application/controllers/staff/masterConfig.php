<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class masterConfig extends CI_Controller {

	public function index()
	{
		$this->load->view('staff/masterConfig');
	}

	public function getSeries(){
		$result = $this->db->query("CALL sp_GetSeries()")->result();
		echo json_encode($result);
	}
	
	public function getStudio(){
		$result = $this->db->query("CALL sp_GetStudio()")->result();
		echo json_encode($result);
	}

	public function getSource(){
		$result = $this->db->query("CALL sp_GetSource()")->result();
		echo json_encode($result);
	}
}
