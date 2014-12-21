--------------------------------------------------------------------------
--						Ozonic Admin Mod								--
--			Created by: 	Orzlar										--
--			Inspired by:	ULX											--
--			For:			OZONIC Server								--
--																		--
--																		--
--			Initial file for Server AND Client.							--
--																		--
--																		--
--------------------------------------------------------------------------


--ServerSide
if SERVER then

	--Declare all the tables.
	OZA = {}	-- Will hold information of players, groups and such.
	OZLib = {} 	-- For helpful functions like FindPlayerByName
	
	OZA.users = {}		-- OZA.users["steamid"] = {id, name, steamid, groupid,groupname, IP}
	OZA.groups = {}		-- OZA.groups["groupname"] = {id, rank, groupname, color, defaultteam}
	OZA.groupperms = {}	-- OZA.groupperms["groupname"] = {id,rank, usekey ,canuse , cantarget}
	OZA.userperms = {}	-- OZA.userperms["steamid"] = {id, steamid,usekey,canuse,cantarget}
	OZA.commands = {}	-- OZA.commands["commandsay"] = function( //TODO\\ ) -----------------------------------
	
	-- TAGS AND DEFAULT COLORS AND SUCH
	OZA.tag = "[OZA]"
	OZA.broadcasttag = "Ozonic Admin Mod"
	OZA.color1 = Color(255,150,0)
	OZA.color2 = Color(100,150,200)
	
	-- Initial Printing and debug.
	print( "[OZA] Plugin Loaded!" )
	
	
	-- CLIENT STUFF
	AddCSLuaFile( )
	AddCSLuaFile("../module/colorstuff/sh_colorstruff.lua") -- Color Stuff
	AddCSLuaFile("../initial/sh_teamsetup.lua")				-- Team Setup
	
	
	-- SERVER STUFF
	include("../sql/sv_create.lua")							-- Checks if Tables are up
	include("../sql/sv_load.lua")							-- Loads said tables
	include("../module/colorstuff/sh_colorstuff.lua")		-- Color Stuff
	include("../initial/sh_teamsetup.lua")					-- Setup Teams
	include("../initial/sv_playersetup.lua")				-- Player Setup	
end

if CLIENT then
	
	local Tag = "ozamod/lua/"			
	--local Tag = ""     -- UNCOMMENT THIS LINE WHEN IN ADDONS FOLDER
	
	-- Wait 1 second ( to make sure its all been included. )
	timer.Simple(1, function()
		include(Tag.."module/colorstuff/sh_colorstuff.lua")
		include(Tag.."initial/sh_teamsetup.lua")
	end)
end