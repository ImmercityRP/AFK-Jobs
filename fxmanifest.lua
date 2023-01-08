fx_version 'cerulean'
game  'gta5'
lua54  'yes'

author 'Skeetzy#5765'
description 'AFK Jobs Script'
version '1.1'

shared_scripts {
	'config.lua',
    '@es_extended/imports.lua',
}

client_scripts {	
	'client/*.lua',
}

server_scripts {
	'server/*.lua',
}

dependencies {
	'es_extended',
	'mythic_progbar'
}
