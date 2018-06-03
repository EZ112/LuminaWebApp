<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class AnimePage extends CI_Controller {

	public function index()
	{
		$this->load->view('anime/animePage');
	}

	public function getAnimeDetail(){
		$arr = array(
			'InAnimeID' => $_POST['animeID']
		);

		$sp = "CALL sp_GetAnimeDetail(?);";
		$result = $this->db->query($sp,$arr)->result();
		echo json_encode($result);
	}

	public function getAnimeRank(){
		$arr = array(
			'InAnimeID' => $_POST['animeID']
		);

		$sp = "CALL sp_GetAnimeRank(?);";
		$result = $this->db->query($sp,$arr)->result();
		echo json_encode($result);
	}

	public function getRelatedAnime(){
		$arr = array(
			'InAnimeID' => $_POST['animeID']
		);

		$sp = "CALL sp_GetRelatedAnime(?);";
		$result = $this->db->query($sp,$arr)->result();
		echo json_encode($result);
	}

	public function getAnimePageEpisodes(){
		$arr = array(
			'InAnimeID' => $_POST['animeID'],
			'InSort' => $_POST['sort']
		);

		$sp = "CALL sp_GetAnimePageEpisodes(?,?);";
		$result = $this->db->query($sp,$arr)->result();
		echo json_encode($result);
	}
}
