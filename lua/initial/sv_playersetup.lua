
-- PLAYER INITIAL SPAWN HOOK
hook.Add("PlayerInitialSpawn","ozamod-onjoin",function(ply)

	
	
	-- Search for user
	local Query = [[ SELECT id,name,steamid,groupid,groupname,ptitle,IP FROM OZA_users WHERE steamid = '%s' ]]
	local SQL = sql.Query( string.format(Query,ply:SteamID()) )
	
	-- Fill variables of SQL info
	local ID
	local name
	local steamid
	local ptitle
	local IP
	local groupid
	local groupname
	
	
	-- If User Exists
	if(istable(SQL)) then
		table.foreach(SQL, function(key, value)
			ID = value["id"]
			name = value["name"]
			steamid = value["steamid"]
			groupid = value["groupid"]
			groupname = value["groupname"]
			ptitle = value["ptitle"]
			IP = value["IP"]
		end)
		
		-- Check if NAME or IP has changed if so update them
		local Update = false
		if(name != ply:Nick()) then Update = true end
		if(IP != ply:IPAddress( )) then Update = true end
		
		if(Update) then
			local Query = [[ UPDATE OZA_users SET name = '%s', IP = '%s' WHERE steamid = '%s' ]]
			local SQL = sql.Query( string.format(Query, ply:Name(), ply:IPAddress() ,steamid ) )
		end
		
	
	-- If User Does NOT Exist
	else
		
		-- Fill variables with info FOR SQL
		name = ply:Nick()
		steamid = ply:SteamID()
		ptitle = ""
		IP = ply:IPAddress( )
		for k,v in pairs(OZA.groups) do
			if(v["defaultteam"]) then
				groupname = k
				groupid = v["id"]
			end
		end		

		-- Insert into SQL
		 local Query = [[INSERT INTO OZA_users(name,steamid,groupid,groupname,ptitle,IP) VALUES
		('%s','%s','%s','%s','%s','%s')]]
		local SQL = sql.Query( string.format(Query,name,steamid,groupid,groupname,ptitle,IP) )
		
		--GetID of Player
		local Query = [[ SELECT id FROM OZA_users WHERE steamid = '%s' ]]
		ID = sql.QueryValue( string.format(Query, steamid) )
	end
	
	--OZA.users["steamid"] = {id, name, steamid, groupid,groupname, IP}
	OZA.users[ply:SteamID()] = {}
	OZA.users[ply:SteamID()]["ID"] = ID
	OZA.users[ply:SteamID()]["name"] = name
	OZA.users[ply:SteamID()]["steamid"] = steamid
	OZA.users[ply:SteamID()]["groupid"] = groupid
	OZA.users[ply:SteamID()]["groupname"] = groupname
	OZA.users[ply:SteamID()]["IP"] = IP
	
	-- Sync Teams, and set team on join.
	timer.Simple(5, function()
		OZA.SyncTeams()
	end)
	
	ply:SetTeam(groupid)
	
end)

hook.Add("PlayerSpawn","ozamod-onspawn",function(ply)
	
	--Set Team on Spawn
	ply:SetTeam( OZA.users[ply:SteamID()]["groupid"] )
end)