--[====================[
										Ozonic Admin Mod
							
							File:			Player Set-up
							
							Desc:	PlayerSpawn and PlayerInitialSpawn hooks
									To set-up players team and such
									
--]====================]

hook.Add("PlayerInitialSpawn","ozamod-onjoin",function(ply)

	
	--[=[
		Find Player in MYSQL if not, Write them.
	--]=]
	local Query = [[ SELECT id,name,steamid,groupid,groupname,ptitle,IP FROM OZA_users WHERE steamid = '%s' ]]
	local SQL = sql.Query( string.format(Query,ply:SteamID()) )

	local ID
	local name
	local steamid
	local ptitle
	local IP
	local groupid
	local groupname

	if(istable(SQL)) then
		
		local Tab = SQL[1]
		
		ID = Tab["id"]
		name = Tab["name"]
		steamid = Tab["steamid"]
		groupid = Tab["groupid"]
		groupname = Tab["groupname"]
		ptitle = Tab["ptitle"]
		IP = Tab["IP"]
		
		local Update = false
		if(name != ply:Nick()) then Update = true end
		if(IP != ply:IPAddress( )) then Update = true end
		
		if(Update) then
			local Query = [[ UPDATE OZA_users SET name = '%s', IP = '%s' WHERE steamid = '%s' ]]
			local SQL = sql.Query( string.format(Query, ply:Name(), ply:IPAddress() ,steamid ) )
		end
		
	else
		
		name = ply:Nick()
		steamid = ply:SteamID()
		ptitle = ""
		IP = ply:IPAddress( )
		for k,v in pairs(OZA.groups) do
			if(v["defaultteam"]) then
				groupname = v["groupname"]
				groupid = v["id"]
			end
		end		

		 local Query = [[INSERT INTO OZA_users(name,steamid,groupid,groupname,ptitle,IP) VALUES
		('%s','%s','%s','%s','%s','%s')]]
		local SQL = sql.Query( string.format(Query,name,steamid,groupid,groupname,ptitle,IP) )
		
		local Query = [[ SELECT id FROM OZA_users WHERE steamid = '%s' ]]
		ID = sql.QueryValue( string.format(Query, steamid) )
	end
	
	--[=[
		Fill OZ.users with information gotten.
	--]=]
	
	OZA.users[ply:SteamID()] = {}
	OZA.users[ply:SteamID()]["ID"] = tonumber(ID)
	OZA.users[ply:SteamID()]["name"] = name
	OZA.users[ply:SteamID()]["steamid"] = steamid
	OZA.users[ply:SteamID()]["groupid"] = tonumber(groupid)
	OZA.users[ply:SteamID()]["groupname"] = groupname
	OZA.users[ply:SteamID()]["IP"] = IP
	
	
	--[=[
		Wait 5 seconds before syncing teams ( gives a chance for things to get ready. )
	--]=]
	timer.Simple(5, function()
		OZA.SyncTeams()
	end)
	
	--[=[    SetTeam    --]=]
	ply:SetTeam(groupid)
	
	
	--[=[
		Get User Permissions IF user has permissions.
		OZA.userperms[steamid] = {id,steamid,usekey,canuse,cantarget}
	--]=]
	
	local Query = [[ SELECT id,steamid,usekey,canuse,cantarget FROM OZA_userperms WHERE steamid = '%s' ]]
	local SQL = sql.Query( string.format(Query, steamid ) )
	if(istable(SQL)) then
	
		local Tab = SQL[1]
		local CanUse = false
		if(Tab["canuse"] == "1") then CanUse = true end
		
		OZA.userperms[Tab["steamid"]] = {}
		OZA.userperms[Tab["steamid"]]["id"] = Tab["id"]
		OZA.userperms[Tab["steamid"]]["steamid"] = Tab["steamid"]
		OZA.userperms[Tab["steamid"]]["usekey"] = Tab["usekey"]
		OZA.userperms[Tab["steamid"]]["canuse"] = CanUse
		OZA.userperms[Tab["steamid"]]["cantarget"] = tonumber(Tab["cantarget"])
		
	end
	
end)

hook.Add("PlayerSpawn","ozamod-onspawn",function(ply)
	ply:SetTeam( OZA.users[ply:SteamID()]["groupid"] )
end)