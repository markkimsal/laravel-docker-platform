<?php

$versions = [
	'7.3' => [
		'release' => '7.3.33',
		'debian_release' => 'bullseye',
	],
	'7.4' => [
		'release' => '7.4.29',
		'debian_release' => 'bullseye',
	],
	'8.0' => [
		'release' => '8.0.30',
		'debian_release' => 'bullseye',
	],
	'8.1' => [
		'release' => '8.1.33',
		'debian_release' => 'trixie',
	],
	'8.2' => [
		'release' => '8.2.25',
		'debian_release' => 'trixie',
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

	ob_start();
	include('dockerfile-tools-template');
	$dockerfile = ob_get_contents();
	ob_end_clean();

	`mkdir -p $majorVersion/tools `;
	file_put_contents($majorVersion.'/tools/Dockerfile', $dockerfile);
	echo ( "Wrote $majorVersion/tools/Dockerfile ...");
	echo PHP_EOL;
}
