<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Payment extends CI_Controller {

	public function index()
	{
		$this->load->library('session');
		$subStatus = $this->session->userdata('loginSubStatus');

		if($subStatus != null)
			$this->load->view('payment/payment');
		else
			header("Location: /LuminaWebApp");
	}

	public function getBankDetail(){
		$result = $this->db->query("CALL sp_GetBankDetail()")->result();
		echo json_encode($result);
	}

	public function doPayment(){
		$this->load->library('session');
		$loginUser = $this->session->userdata('loginUser');

		if($_POST['paymentMethod'] == 'TransferBank'){
			$arr = array(
				'InBankID' => $_POST['BankID'],
				'InPaymentStatus' => $_POST['paymentStatus'],
				'InPaymentPlan' => $_POST['paymentPlan'],
				'InUsername' => $loginUser,
				'InAccountNumber' => $_POST['AccountNum'],
				'InAccountName' => $_POST['AccountName'],
				'CardExpDate' => null
			);
		}
		else{
			$arr = array(
				'InBankID' => null,
				'InPaymentStatus' => $_POST['paymentStatus'],
				'InPaymentPlan' => $_POST['paymentPlan'],
				'InUsername' => $loginUser,
				'InAccountNumber' => $_POST['cardNum'],
				'InAccountName' => $_POST['cardName'],
				'CardExpDate' => $_POST['cardExpDate']
			);
		}

		$sp = "CALL sp_DoPayment(?,?,?,?,?,?,?)";

		$result = $this->db->query($sp,$arr);
		if($result)
			echo "Success";
		else
			echo "Failed";
	}
}
