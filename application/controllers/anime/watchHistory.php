<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class WatchHistory extends CI_Controller {

	public function index()
	{
		$this->load->view('anime/watchHistory');
	}

	public function getWatchHistory(){
		$arr = array(
			'InUsername' => $_POST['username']
		);

		$sp = "CALL sp_getWatchHistory(?)";
		$result = $this->db->query($sp,$arr)->result();
		echo json_encode($result);
	}

	public function deleteWatchHistory(){
		$arr = array(
			'InUsername' => $_POST['username'],
			'InHistoryID' => $_POST['historyID']
		);

		$sp = "CALL sp_deleteWatchHistory(?, ?)";
		$result = $this->db->query($sp,$arr);
		//echo json_encode($result);
		if($result)
			echo "Success";
		else 
			echo "Failed";
	}
}
