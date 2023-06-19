Assets = { }
Assets.Fonts = { }
Assets.Textures = { }

local textures = {
	"all_vehs_label",
	"checkbox", 
	"checkbox_active", 
	"close", 
	"copy", 
	"cover", 
	"cover_bg", 
	"edit", 
	"main_bg", 
	"my_music_label", 
	"next", 
	"no_saved", 
	"pause", 
	"play", 
	"player_label",
	"prev", 
	"round", 
	"saved", 
	"saved_btn", 
	"search", 
	"search_btn", 
	"search_label", 
	"settings", 
	"settings_bg", 
	"settings_btn", 
	"sound", 
	"string_bg", 
	"volume-low", 
	"volume-up",
	"volume-low-small", 
	"volume-up-small",
	"loading",

	"repeate",
	"reverse",
	"like",
	"like_active",
}


addEventHandler( "onClientResourceStart", resourceRoot, function ( )
	for i,v in pairs( textures ) do
		Assets.Textures[ v ] = DxTexture( "assets/images/" .. v .. ".png" )
	end

	Assets.Fonts[ "bold" ] = DxFont( "assets/fonts/bold.ttf", 25 )
	Assets.Fonts[ "medium" ] = DxFont( "assets/fonts/medium.ttf", 18)
	Assets.Fonts[ "bold_small" ] = DxFont( "assets/fonts/bold.ttf", 20 )
end )