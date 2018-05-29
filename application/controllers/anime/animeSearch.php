<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class AnimeSearch extends CI_Controller {

	public function index()
	{
		$this->load->database();
		$this->load->view('anime/animeSearch');
	}

	public function getAnimeSearch(){
		$search = $_POST['search'];
		$duration = $_POST['duration'];
		if(empty($_POST['genre']))
			$genre = '';
		else 
			$genre = implode("|",$_POST['genre']);

		$arr = array(
			'inSearch' => $search,
			'inDuration' => $duration,
			'inGenre' => $genre
		);

		$sp = "CALL sp_GetAnimeSearch(?,?,?)";
		$result = $this->db->query($sp,$arr)->result();
		echo json_encode($result);
	}

	public function getEpisodeSearch(){
		$search = $_POST['search'];
		$duration = $_POST['duration'];
		if(empty($_POST['genre']))
			$genre = '';
		else 
			$genre = implode("|",$_POST['genre']);

		$arr = array(
			'inSearch' => $search,
			'inDuration' => $duration,
			'inGenre' => $genre
		);

		$sp = "CALL sp_GetEpisodeSearch(?,?,?)";
		$result = $this->db->query($sp,$arr)->result();
		echo json_encode($result);
	}
}
