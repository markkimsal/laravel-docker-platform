<?php

$versions = [
	'7.3' => [
		'release' => '7.3.33',
	],
	'7.4' => [
		'release' => '7.4.28',
	],
	'8.0' => [
		'release' => '8.0.18',
	],
];

foreach ($versions as $majorVersion => $version) {
	extract($version);
	ob_start();
	include('dockerfile-template');
	$dockerfile = ob_get_contents();
	ob_end_clean();

	file_put_contents($majorVersion.'/nginx-fpm/Dockerfile', $dockerfile);
	echo ( "Wrote $majorVersion/nginx-fpm/Dockerfile ...");
	echo PHP_EOL;
}
