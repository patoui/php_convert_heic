<?php
 
$im = new Imagick();
$im->setSize(1280, 1280);
$im->setFormat('heic');
$im->readImage( __DIR__ . '/IMG_8019.heic' );
$im->cropThumbnailImage( 1280, 1280 );
$im->setImageCompressionQuality(80);
$im->writeImage( __DIR__ . '/IMG_8019.jpg' );
$im->destroy();

