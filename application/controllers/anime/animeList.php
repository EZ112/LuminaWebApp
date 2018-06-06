<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class AnimeList extends CI_Controller {

	public function index()
	{
		$this->load->view('anime/animeList');
	}

	public function getAnimeList(){
		$arr = array(
			'inYear' => $_POST['year'],
			'inSeason' => $_POST['season'],
			'inStat' => $_POST['status'],
			'inDuration' => $_POST['duration'],
			'inSort' => $_POST['sort']
		);
		$sp = "CALL sp_GetAnimeList(?,?,?,?,?)";
		$result = $this->db->query($sp,$arr)->result();
		echo json_encode($result);
	}
}
