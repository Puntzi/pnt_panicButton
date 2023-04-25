fx_version "cerulean"
game 'gta5'
lua54 'yes'

author 'Puntzi'
description 'Panic Button script'
version '2.0.0'

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua'
}

files {
    'locales/*.json',
}