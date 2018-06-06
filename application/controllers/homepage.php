<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Homepage extends CI_Controller {

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
		$this->load->view('index');
	}
	
	public function getAnimeLatestUpdate(){
		$result = $this->db->query("CALL sp_GetAnimeLatestUpdate()")->result();
		echo json_encode($result);
	}

	public function getTopAiringAnime(){
		$arr = array(
			'InUsername' => $_POST['user']
		);
		$sp = "CALL sp_GetTopAiringAnime(?)";
		$result = $this->db->query($sp,$arr)->result();
		echo json_encode($result);
	}

	public function getNewsLatestUpdate(){
		$result = $this->db->query("CALL sp_GetNewsLatestUpdate()")->result();
		echo json_encode($result);
	}

	public function getDuration(){
		$result = $this->db->query("CALL sp_GetDuration()")->result();
		echo json_encode($result);
	}

	public function getGenre(){
		$result = $this->db->query("CALL sp_GetGenre()")->result();
		echo json_encode($result);
	}

	public function getTags(){
		$result = $this->db->query("CALL sp_GetTags()")->result();
		echo json_encode($result);
	}

	public function checkUser(){
		$arr = array(
			'InUsername' => $_POST['user']
		);
		$sp = "CALL sp_CheckUsername(?)";
		$result = $this->db->query($sp,$arr)->result();
		echo json_encode($result);
	}

	public function loginCheck(){
		$arr = array(
			'InUsername' => $_POST['user'],
			'InPass' => base64_encode($_POST['pass'])
		);
		$sp = "CALL sp_loginCheck(?,?)";
		$result = $this->db->query($sp,$arr)->result();
		echo json_encode($result);
	}

	public function registerAccount(){
		$arr = array(
			'InUsername' => $_POST['user'],
			'InPass' => base64_encode($_POST['pass']),
			'InEmail' => $_POST['email'],
			'InGender' => $_POST['gender']
		);

		$sp = "CALL sp_InsertUser(?,?,?,?)";
		$result = $this->db->query($sp,$arr);
		if($result)
			echo "Success";
		else
			echo "Failed";
	}

	public function loginAccount(){
		$arr = array(
			'InUsername' => $_POST['user']
		);

		$sp = "CALL sp_CheckPass(?)";
		$result = $this->db->query($sp,$arr)->result();

		$dbPass = $result[0]->Password;
		if(base64_encode($_POST['pass']) == $dbPass){
			$sp2 = "CALL sp_CheckSubStatus(?)";
			mysqli_next_result( $this->db->conn_id );
			$result2 = $this->db->query($sp2,$arr)->result();

			$this->load->library('session');

			$data = array(
                   'loginUser' => $_POST['user'],
                   'loginSubStatus' => $result2[0]->SubStatus,
                   'loginExpStatus' => $result2[0]->Status
            	);
			$this->session->set_userdata($data);
			echo "Success";
		}
		else
			echo "Failed";
	}

	public function getSessionData(){
		$arr = array(
			'InUsername' => $_POST['user']
		);
		$sp = "CALL sp_CheckSubStatus(?)";
		$result = $this->db->query($sp,$arr)->result();

		if($result){
			$this->load->library('session');

			$data = array(
	               'loginUser' => $_POST['user'],
	               'loginSubStatus' => $result[0]->SubStatus,
	               'loginExpStatus' => $result[0]->Status
	        	);
			$this->session->set_userdata($data);
		}
		else{
			$data = array(
	               'loginUser' => null,
	               'loginSubStatus' => null,
	               'loginExpStatus' => null
	        	);
		}
		echo json_encode($data);
	}

	public function getFollowing(){
		$arr = array(
			'InUsername' => $_POST['user']
		);
		$sp = "CALL sp_GetFollowing(?)";
		$result = $this->db->query($sp,$arr)->result();
		echo json_encode($result);
	}

	public function getMostPopular(){
		$sp = "CALL sp_GetMostPopular()";
		$result = $this->db->query($sp)->result();
		echo json_encode($result);
	}

	public function logout(){
		$this->load->library('session');
		$data = ['loginUser', 'loginSubStatus'];
		$this->session->unset_userdata($data);
		$this->session->sess_destroy();
		echo "Logged Out";
	}


	
}
