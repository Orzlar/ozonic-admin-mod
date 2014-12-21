--------------------------------------------------------------------------
--						Ozonic Admin Mod								--
--																		--
--				File: Read and Write SQL								--
--				Info: Will read tables on start							--
--				Also every SQL function goes here						--
--------------------------------------------------------------------------

-- GET ALL GROUPS ON SERVER START
local groups = sql.Query([[ SELECT id,rank,groupname,color,defaultteam FROM OZA_groups ]])
if(istable(groups)) then


	table.foreach(groups, function( key, value )
		
		local S = string.Explode(",",value["color"])
		local COLOR = Color( tonumber(S[1]),tonumber(S[2]),tonumber(S[3]))
		
		OZA.groups[tonumber(value["id"])] = {}
        OZA.groups[tonumber(value["id"])]["id"] = tonumber(value["id"])
		OZA.groups[tonumber(value["id"])]["rank"] = tonumber(value["rank"])
		OZA.groups[tonumber(value["id"])]["groupname"] = value["groupname"]
		OZA.groups[tonumber(value["id"])]["color"] = COLOR
		
		--SQL Boolean is just "1" or "0", force it to a boolean here.
		if(value["defaultteam"] == "1") then
			OZA.groups[tonumber(value["id"])]["defaultteam"] = true
		else
			OZA.groups[tonumber(value["id"])]["defaultteam"] = false
		end
		
		OZA.groupperms[tonumber(value["rank"])] = {}
	end)
else
	print(" GROUPS LOAD ERROR ")
	print( sql.LastError( ) )
end

-- GET ALL PERMISSIONS FOR GROUP ON SERVER START
local groupperms = sql.Query([[ SELECT id,rank,usekey,canuse,cantarget FROM OZA_groupperms ]])
if(istable(groupperms)) then
	
	table.foreach(groupperms, function(key, value )
		
		local Perm = {}
		Perm["usekey"] = value["usekey"]
		
		--SQL Boolean is just "1" or "0", force it to a boolean here.
		if(value["canuse"] == "1") then
			Perm["canuse"] = true
		else
			Perm["canuse"] = false
		end
		
		Perm["cantarget"] = value["cantarget"]
		Perm["id"] = tonumber(value["id"])
		
		table.Add(OZA.groupperms[value["rank"]],{Perm})
	
	end)
	
else
	print(" GROUP PERMISSIONS LOAD ERROR ")
end