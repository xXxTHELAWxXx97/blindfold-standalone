fx_version 'cerulean'
game 'gta5'

name "blindfold"
description "blindfold resource"
author "xXxTHE_LAWxXx97"
version "1.0.0"

shared_scripts {
	'shared/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}

files {
	'html/index.html',
	'html/assets/images/blindfold.png',
	'html/assets/css/style.css',
	'html/assets/js/jquery.js',
	'html/assets/js/init.js',
}

ui_page 'html/index.html'