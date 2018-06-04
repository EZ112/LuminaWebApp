<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Streaming extends CI_Controller {

	public function index()
	{
		$this->load->library('session');
		$subStatus = $this->session->userdata('loginSubStatus');
		$expStatus = $this->session->userdata('loginExpStatus');

		if($subStatus != 'FREE' && $subStatus != null && $expStatus == 'Active')
			$this->load->view('anime/streaming');
		else {
			if($expStatus != null)
				$this->load->view('expire');
			else
				$this->load->view('restrict');
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

	public function getViews(){
		$code = $_POST['code'];

		$curl = curl_init();

		curl_setopt_array($curl, array(
		  CURLOPT_URL => "https://api.wistia.com/v1/stats/medias/".$code.".json",
		  CURLOPT_RETURNTRANSFER => true,
		  CURLOPT_ENCODING => "",
		  CURLOPT_MAXREDIRS => 10,
		  CURLOPT_TIMEOUT => 30,
		  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		  CURLOPT_CUSTOMREQUEST => "GET",
		  CURLOPT_HTTPHEADER => array(
		    "Authorization: Basic UHVibGljIFRva2VuOmJmMmY1MDA4OTQ5MmRiNjQxYWViZjMyMzliOGJjMzNiN2Y1YThkMWU2NTRhNTUzMDU5OGJhNzBiMmFiZjliMmQ=",
		    "Cache-Control: no-cache",
		    "Postman-Token: 377ff553-34ca-4e71-9630-ea5d70007363"
		  ),
		));

		$response = curl_exec($curl);
		$err = curl_error($curl);

		curl_close($curl);

		if ($err) {
		  echo "cURL Error #:" . $err;
		} else {
		  echo $response;
		}
	}

	public function updateTotalViews(){
		$arr = array(
			'InEpisodeID' => $_POST['episodeID'],
			'InViews' => $_POST['views']
		);

		$sp = "CALL sp_UpdateTotalViews(?,?)";
		$result = $this->db->query($sp,$arr);
		if($result)
			echo "Success";
		else
			echo "Failed";
	}


}
