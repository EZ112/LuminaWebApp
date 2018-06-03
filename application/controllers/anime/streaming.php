<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Streaming extends CI_Controller {

	public function index()
	{
		$this->load->library('session');
		$subStatus = $this->session->userdata('loginSubStatus');
		if($subStatus != 'FREE' && $subStatus != null)
			$this->load->view('anime/streaming');
		else {
			redirect($_SERVER['HTTP_REFERER']);
		}
	}

	public function getEpisodeStream(){
		$arr = array(
			'InAnimeID' => $_POST['animeID'],
			'InEpisodeID' => $_POST['episodeID']
		);

		$sp = "CALL sp_getEpisodeStream(?,?);";
		$result = $this->db->query($sp,$arr)->result();
		echo json_encode($result);
	}

	public function getPrevNextEps(){
		$arr = array(
			'InAnimeID' => $_POST['animeID'],
			'InCurrEps' => $_POST['currEps']
		);

		$sp = "CALL sp_GetPrevEps(?,?);";
		$sp2 = "CALL sp_GetNextEps(?,?);";
		$result = $this->db->query($sp,$arr)->result();
		mysqli_next_result( $this->db->conn_id );
		$result2 = $this->db->query($sp2,$arr)->result();

		$arrRes = array('PrevEps' => $result, 
				   		'NextEps' => $result2);
		echo json_encode($arrRes);
	}

	public function getRecomendedAnime(){
		$arr = array(
			'InAnimeID' => $_POST['animeID'],
			'InSeriesID' => $_POST['currSeries'],
			'InOffset' => $_POST['offset'],
			'InLimit' => $_POST['limit']
		);

		$sp = "CALL sp_getRecomendedAnime(?,?,?,?);";
		$result = $this->db->query($sp,$arr)->result();
		echo json_encode($result);
	}


}
