--[====================[
										Ozonic Admin Mod
							
							Created by: 	Orzlar
							Inspired by:	ULX
							For:			OZONIC Server

							File:			Core file.

--]====================]
							
if SERVER then

	--[=[
		Declare Tables for use later.
		
		OZA 			- Table for information
		OZlib			- Table for functions
		OZA.users		- Holds information of players	( OZA.users[steamid] = {id,name,steamid,groupid,groupname,ip} )
		OZA.groups		- Holds information of groups	( OZA.groups[groupid] = {id,rank,groupname,color,defaultteam} )
		OZA.groupperms	- Holds permissions for groups	( OZA.groupperms[rank] = {id,rank,usekey,canuse,cantarget} )
		OZA.userperms	- Holds permission for players	( OZA.userperms[steamid] = {id,steamid,usekey,canuse,cantarget} )
		OZA.commands	- Holds functions for the mod	( OZA.commands["funcname"] = function(chattruefalse,...)
	--]=]
	
	OZA 			= {}
	OZLib 			= {}
	OZA.users 		= {}
	OZA.groups 		= {}
	OZA.groupperms 	= {}
	OZA.userperms 	= {}
	OZA.commands 	= {}
	
	
	--[=[
		Tags and Colors saved
	--]=]
	
	OZA.tag 			= "[OZA]"
	OZA.broadcasttag	= "Ozonic Admin Mod"
	OZA.color1 			= Color(255, 150, 0)
	OZA.color2 			= Color(100, 150, 200)
	include("../version.lua")
	
	
	--[=[
		Initial Printing for debugging issues
	--]=]
	
	print( "[OZA] Plugin Loaded!")
	print( "[OZA] Version: " .. OZA.version )
	
	
	--[=[
		Send Client Files
	--]=]
	
	AddCSLuaFile( )
	AddCSLuaFile( "../module/colorfunc/sh_colorcc.lua" )	-- Color Chat and Console
	AddCSLuaFile( "../initial/sh_teamsetup.lua" )			-- Team Set-up
	
	
	--[=[
		Include Server Files
	--]=]
	
	include( "../sql/sv_create.lua" )						-- Checks if Tables are up
	include( "../sql/sv_load.lua" )							-- Loads said tables
	include( "../module/sh_colorfunc.lua" )					-- Color Chat and Console
	include( "../module/sv_findplayer.lua" )				-- Useful FindPlayer commands
	include( "../initial/sh_teamsetup.lua" )				-- Team Set-up
	include( "../initial/sv_playersetup.lua" )				-- Player Set-up	
end


if CLIENT then
	
	--[=[
		Tag is for "garrysmod/lua/ozonic-admin-mod/lua/", when in addons it should be ""
	--]=]
	
	local Tag = "ozonic-admin-mod/lua/"			
	
	
	--[=[
		Include Client Files
	--]=]
	
	timer.Simple(1, function()
		include( Tag .. "module/sh_colorfunc.lua" )				-- Color Chat and Console
		include( Tag  .. "initial/sh_teamsetup.lua" )			-- Team Set-up
	end)
end