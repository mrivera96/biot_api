<!DOCTYPE html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<body>

<?php

	include ('BioTrackCmd.php');

	$cmd = new BioTrackCmd ('bioface', '192.168.0.172');

	$data = array(
		'userId' => '1032',
		'userName' => 'Jonathan Palencia',
		'userPassword' => 1032,
		'userPrivilege' => 0,
		'userEnabled' => true,
		'userFingerprints' => array(
			'',
			'',
			'',
			'',
			'',

			'',
			'',
			'TBNTUzIxAAAFUFUECAUHCc7QAAAdUWkBAAAAhf0yS1BLAGwPhwCQABRfwwBiAB0OowBgUG8PzABqAFgORVBtAOwPMQC9AF9fiQB6AHgPKAB6UCAOvgCAAOIPXFCIAF8PcwBOAARfMwCPAOEPSQCVUHwPAQGSAGcO51CgAC4PbwBjAFFfoQCnAI4PPACyUCYPFgC8AIgPolDIAJ4NCwEMAKNfxQDRAEcPLADUUDUPdgDXAIMPmlDhAK4NgAAkADhe/wDqADUOdQDuUMgOoADuAAMOK1DxAMwPkgA3AMVeiQD4ALsOwgH6UNIO9AAEAQYOgFAJAdMOdADJAc1fTQAXAdMPJAAbUdgPpwAhASYPfVAkAeYPTgDsAdtfmAAuAeoPDgA3UeEOXgA7AS8Pn1BEAfEPLgCCAeReVwBKAfEP+gBJUeYP0gBQAS4PP1FngW8W3qV3mbpDgYOq+H/9cwUHDWMSgIM9ezt+/MVngeYODXGgej+vQP5te8ppRIOrpfuGMY8iDJ4IIDNLDfLyiYbAp2DbXIpy9pqGeAaILifwfYNOde9+d1hDjSIN9VcX9ReJlxAq8Xc8vIK3pPv4C21jgsL3NKLvWJoRfYKXdS8hx6iWgDoV4wx3UEeRXQhmjp+KFLjo5S3y5fiwhmQufGadd/IA9ARUTS8IeRgxCHD83qhmguPzLAdw/JxGsf8N6HmC4BFY8hL8tfGNk9/scEgkDIUXsfQ05pxf6PXe6qYOz/iHSI4IAfnu9ncGUHJvFP79XQ0A9t+9eAnV+iIFQwjfpDf+7fg5Dr8FSFpfEi8Mrf1j8odXZAgNDkYV4AmQqof9TgxjFdr+8iyIyGCCAiCDAQeDJfgHALkI28P7kDwLAJcJDIk3RVMBiAwMwAPFhRZcwA8AfRsGl/z6r/5b/28MAGobFhZVWMADAEfn/fpeAX0jBv9P/UphRAFDLff+/wXAxX//PlhbBACPSHUnCwBSSfc9OMH4kP8UACdL4O8++pEwwP7/wMChCAUcT2t4eBcA7k/ukCpAOP7APpdGFFCLUww1/0+tWfqRBwCCVIDBTQ8F2lgQ/zf//zv/VwsEAGJmbcE6xCZQRW3twDH8g//4C/7/wf7A/Dv/+q7B/f/BwP86wMWQCADQbiD/gMBlVAGFdYClBsUtfA5qwhcAjHvW/vprRfww/v7C7FwNUDB8VsBa/wcMBdR9esSLg2XCAMXSJsA4wRIAsYfxrPo7QfvAKgQ4CFBUiGfDwMIEXE+QCABYjV7BB//HNBgANo7e/pD9+WH+//5UVSPzEAU/j2fDeG1YOGQNUJGSF/3AKjgEBX6SV1sSAIhWfcaUwIlYRv7CO8IeUAib10ZU/zv/MK78R8Evwf+eBAUjo/AaBwDjYCv6DMEPAGumWk5rPq/D/f8JAHBvVns7/wQA+rkpmAcF1rxXxGv+A8USuwPABQCOvhM4GABQGcBJVQUAT8NJksL/DgCmxmzFwZfHwf/Cwf87/fpTAY/MQ8MDxZXVasAMAMXURjoqxWyEBADt1DD8DAW41DT9/yj+B/w6VgHX1j3+/vAHBSXcRsDA/ifJAIW4O/38QGXBPwUFrew0+DoEADfwRncCACz0T8DkABSszsHAwMH+O8H4EcP9If/+/4XB+JD8//7+//7VERdQbMJ7/v/Ajmv7XRARC2t3LwX/Q1oQEhNkwFuBwBlAUxbaw8L/lv/4qv38/P39/zj8SZFSVgQQvRqh/cVVEUkbWv9dzBDET2Mr/20GEdUhYQj+AxBKLWIEBhRfNXfETwURzjxukUgDEBZPIAdSR1AKQwEAAAuAUgAAAAAAAA==',
			'',
			''
		),

		'userFace' => ''
	);

	if ($cmd->update_user_data ($data))
		echo '<b>OK</b>';
	else
		echo '<b>Error: ' . $cmd->get_last_error() . '</b>';

	echo '<br/>';

	var_dump($cmd->get_user_data('1032'));
