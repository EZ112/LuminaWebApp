<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class News extends CI_Controller {

	public function index()
	{
		$this->load->view('news/news');
	}

	public function getNewsDetail(){
		$arr = array(
			'InNewsID' => $_POST['newsID']
		);

		$sp = "CALL sp_getNewsDetail(?)";
		$result = $this->db->query($sp,$arr)->result();
		echo json_encode($result);
	}

	public function getLatestNews(){
		$arr = array(
			'InNewsID' => $_POST['newsID']
		);

		$sp = "CALL sp_getLatestNews(?)";
		$result = $this->db->query($sp, $arr)->result();
		echo json_encode($result);
	}
}
