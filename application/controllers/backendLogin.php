<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class backendLogin extends CI_Controller {

	/**
	 * Index Page for this controller.
	 *
	 * Maps to the following URL
	 * 		http://example.com/index.php/welcome
	 *	- or -
	 * 		http://example.com/index.php/welcome/index
	 *	- or -
	 * Since this controller is set as the default controller in
	 * config/routes.php, it's displayed at http://example.com/
	 *
	 * So any other public methods not prefixed with an underscore will
	 * map to /index.php/welcome/<method_name>
	 * @see https://codeigniter.com/user_guide/general/urls.html
	 */

	public function index()
	{
		$this->load->view('backendLogin');
	}

	public function loginStaff(){
		$arr = array(
			'InStaffName' => $_POST['staffName'],
			'InStaffPass' => base64_encode($_POST['staffPass'])
		);
		$sp = "CALL sp_loginStaff(?,?)";
		$result = $this->db->query($sp,$arr)->result();
		echo json_encode($result);
	}

}