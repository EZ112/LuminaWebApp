<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class AnimeSearch extends CI_Controller {

	public function index()
	{
		$this->load->view('anime/animeSearch');
	}

	public function getAnimeSearch(){
		$search = $_POST['search'];
		$duration = $_POST['duration'];
		if(empty($_POST['genre']))
			$genre = '';
		else 
			$genre = implode("|",$_POST['genre']);
		$offset = $_POST['offset'];
		$limit = $_POST['limit'];

		$arr = array(
			'inSearch' => $search,
			'inDuration' => $duration,
			'inGenre' => $genre,
			'inLimit' => $limit,
			'inOffset' => $offset
		);

		$sp = "CALL sp_GetAnimeSearch(?,?,?,?,?,@Total)";
		$result = $this->db->query($sp,$arr)->result();
		mysqli_next_result( $this->db->conn_id );
		$result2 = $this->db->query("SELECT @Total as TotalRow;")->result();
		$arrRes = array('AnimeTbl' => $result, 
				   		'TotalRow' => $result2);
		echo json_encode($arrRes);
	}

	public function getEpisodeSearch(){
		$search = $_POST['search'];
		$duration = $_POST['duration'];
		if(empty($_POST['genre']))
			$genre = '';
		else 
			$genre = implode("|",$_POST['genre']);
		$offset = $_POST['offset'];
		$limit = $_POST['limit'];

		$arr = array(
			'inSearch' => $search,
			'inDuration' => $duration,
			'inGenre' => $genre,
			'inLimit' => $limit,
			'inOffset' => $offset
		);

		$sp = "CALL sp_GetEpisodeSearch(?,?,?,?,?,@Total);";
		$result = $this->db->query($sp,$arr)->result();
		mysqli_next_result( $this->db->conn_id );
		$result2 = $this->db->query("SELECT @Total as TotalRow;")->result();
		$arrRes = array('EpisodesTbl' => $result, 
				   		'TotalRow' => $result2);
		echo json_encode($arrRes);
	}
}
