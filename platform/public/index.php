<?php 

for ($x=0; $x<8; $x++) {
	sleep(1);
	echo "\n<br/>\n$x";
}
	sleep(1);
echo substr(md5(random_bytes(5)), 24);
