fx_version 'adamant'

game 'gta5'

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",

    "src/components/*.lua",

    "src/menu/elements/*.lua",

    "src/menu/items/*.lua",

    "src/menu/panels/*.lua",

    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",

}

client_scripts {
    '@es_extended/locale.lua',
    'locales/fr.lua',
    'client/cl_menu.lua',
    'client/cl_vestiaire_police.lua',
    'client/cl_garagepolice.lua',
    'client/cl_coffre.lua',
    'client/cl_Itemachat.lua', 
    'client/cl_boss.lua',
    'client/cl_vestiaire.lua', 
    'config.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'locales/fr.lua',
    'config.lua',
    'server/main.lua',
    'server/sv_kaito.lua'
}

dependencies {
    'es_extended'
}



--################ RUN #####################

client_scripts {
    'script_runkaitolocales/fr.lua',
    'script_runkaito/recoltebdpkaito.lua',
    'script_runkaito/traitementcouisse.lua',
    'script_runkaito/creationtenderskaito.lua',
    'script_runkaito/ventetenderskaito.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'script_runkaito/serverkaito.lua'
}
