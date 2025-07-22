
fx_version "bodacious"
game "gta5"
lua54 "yes"
author "Rafael_EG"
shared_scripts {
	"lib/Utils.lua",
	"shared/*",
}
client_scripts {
	"@vrp/config/Global.lua",
	"@PolyZone/client.lua",
	"@vrp/config/Native.lua",
	"client/*"
}
server_scripts {
	"@vrp/config/Global.lua",
	"@vrp/config/Vehicle.lua",
	"@vrp/config/Item.lua",
	"lib/Utils.lua",
	"server/*"
}