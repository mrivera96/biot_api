<?php

namespace App\biotrackcmdphp;

	class BioTrackCmd
	{
		private $ipAddress;
		private $port;

		private $result;
		private $path;

		private $errmsg;

		public function __construct ($ipAddress, $port='')
		{
			$this->path = '';

			$this->ipAddress = $ipAddress;
			$this->port = $port;
		}

		private function escape ($str)
		{
			return '"' . $str . '"';
		}

		public function get_last_error()
		{
			return $this->errmsg;
		}

		private function execute ($cmd)
		{
			$res = shell_exec ($this->path.'biotrackcmd.exe ' . $this->ipAddress . ($this->port ? ':'.$this->port : '') . ' ' . $cmd);

			$i0 = strpos ($res, '#{#');
			if ($i0 === false) return false;

			$i1 = strpos ($res, '#}#');
			if ($i1 === false) return false;

			$res = substr($res, $i0+3, $i1-$i0-3);
			$res = iconv('CP437', 'UTF-8', $res);

			$this->result = json_decode ($res, true);
			if (!$this->result) return false;

			if ($this->result['error'] != '0')
			{
				$this->errmsg = $this->result['errormsg'];
				return false;
			}

			return true;
		}

		private function execute0 ($name)
		{
			return $this->execute($name);
		}

		private function execute1 ($name, $arg1)
		{
			return $this->execute($name . ' ' . $this->escape($arg1));
		}

		private function execute2 ($name, $arg1, $arg2)
		{
			return $this->execute($name . ' ' . $this->escape($arg1) . ' ' . $this->escape($arg2));
		}

		private function execute3 ($name, $arg1, $arg2, $arg3)
		{
			return $this->execute($name . ' ' . $this->escape($arg1) . ' ' . $this->escape($arg2) . ' ' . $this->escape($arg3));
		}

		private function execute4 ($name, $arg1, $arg2, $arg3, $arg4)
		{
			return $this->execute($name . ' ' . $this->escape($arg1) . ' ' . $this->escape($arg2) . ' ' . $this->escape($arg3) . ' ' . $this->escape($arg4));
		}

		public function get_serial ()
		{
			if (!$this->execute0 ('get-serial'))
				return '';

			return $this->result['serial_number'];
		}

		public function get_firmware_version ()
		{
			if (!$this->execute0 ('get-firmware-version'))
				return '';

			return $this->result['firmware_version'];
		}

		public function get_fingerprint_version ()
		{
			if (!$this->execute0 ('get-fingerprint-version'))
				return '';

			return $this->result['fingerprint_version'];
		}

		public function get_device_info ()
		{
			if (!$this->execute0 ('get-device-info'))
				return array();

			$data = array();

			$data['serial_number'] = $this->result['serial_number'];
			$data['firmware_version'] = $this->result['firmware_version'];
			$data['fingerprint_version'] = $this->result['fingerprint_version'];

			return $data;
		}

		public function get_users ()
		{
			if (!$this->execute0 ('get-users'))
				return array();

			/*
				Returns array of:
					userId, userName, userPassword, userPrivilege, userCardNumber, userEnabled
			*/

			return $this->result['data'];
		}

		public function get_user ($user_id)
		{
			if (!$this->execute1 ('get-user', $user_id))
				return array();

			/*
				Returns object with:
					userId, userName, userPassword, userPrivilege, userCardNumber, userEnabled
			*/

			return $this->result['data'];
		}

		public function get_user_data ($user_id)
		{
			if (!$this->execute1 ('get-user-data', $user_id))
				return array();

			/*
				Returns object with:
					userId, userName, userPassword, userPrivilege, userCardNumber, userEnabled, userFingerprints, userFace
			*/

			return $this->result['data'];
		}

		public function delete_user ($user_id)
		{
			if (!$this->execute1 ('delete-user', $user_id))
				return false;

			return true;
		}

		public function delete_user_password ($user_id)
		{
			if (!$this->execute1 ('delete-user-password', $user_id))
				return false;

			return true;
		}

		public function delete_user_fingerprints ($user_id)
		{
			if (!$this->execute1 ('delete-user-fingerprints', $user_id))
				return false;

			return true;
		}

		public function delete_user_face ($user_id)
		{
			if (!$this->execute1 ('delete-user-face', $user_id))
				return false;

			return true;
		}

		public function delete_all_users ()
		{
			if (!$this->execute0 ('delete-all-users'))
				return false;

			return true;
		}

		public function enable_user ($user_id)
		{
			if (!$this->execute1 ('enable-user', $user_id))
				return false;

			return true;
		}

		public function disable_user ($user_id)
		{
			if (!$this->execute1 ('disable-user', $user_id))
				return false;

			return true;
		}

		public function add_user ($user_id, $password, $name)
		{
			if (!$this->execute3 ('add-user', $user_id, $password, $name))
				return false;

			return true;
		}

		public function update_user_name ($user_id, $name)
		{
			if (!$this->execute2 ('update-user-name', $user_id, $name))
				return false;

			return true;
		}

		public function update_user_password ($user_id, $password)
		{
			if (!$this->execute2 ('update-user-password', $user_id, $password))
				return false;

			return true;
		}

		public function update_user_fingerprint ($user_id, $index, $data)
		{
			$fname = tempnam(sys_get_temp_dir(), 'bio');
			file_put_contents($fname, $data);

			if (!$this->execute3 ('update-user-fingerprint', $user_id, $index, '@'.$fname))
			{
				@unlink($fname);
				return false;
			}

			@unlink($fname);
			return true;
		}

		public function update_user_face ($user_id, $data)
		{
			$fname = tempnam(sys_get_temp_dir(), 'bio');
			file_put_contents($fname, $data);

			if (!$this->execute2 ('update-user-face', $user_id, '@'.$fname))
			{
				@unlink($fname);
				return false;
			}

			@unlink($fname);
			return true;
		}

		public function update_user_data ($data)
		{
			$lines = array(
				$data['userId'],
				$data['userName'],
				$data['userPassword'],
				$data['userPrivilege'],
				$data['userEnabled'],
				$data['userFingerprints'][0],
				$data['userFingerprints'][1],
				$data['userFingerprints'][2],
				$data['userFingerprints'][3],
				$data['userFingerprints'][4],
				$data['userFingerprints'][5],
				$data['userFingerprints'][6],
				$data['userFingerprints'][7],
				$data['userFingerprints'][8],
				$data['userFingerprints'][9],
				$data['userFace']
			);

			$fname = tempnam(sys_get_temp_dir(), 'bio');
			file_put_contents($fname, implode("\n", $lines));

			if (!$this->execute1 ('update-user-data', $fname))
			{
				@unlink($fname);
				return false;
			}

			@unlink($fname);
			return true;
		}

		public function sync_clock ()
		{
			if (!$this->execute0 ('sync-clock'))
				return false;

			return true;
		}

		public function get_log ()
		{
			if (!$this->execute0 ('get-log'))
				return array();

			/*
				Returns array of:
						logUserId, logVerifyMode, logInOutMode, logYear, logMonth, logDay, logHour, logMinute, logSecond, logWorkCode
			*/

			return $this->result['data'];
		}
	};
