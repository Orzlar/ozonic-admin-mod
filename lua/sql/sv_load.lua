--[====================[
										Ozonic Admin Mod
							
							File:			SQL Load Tables
							
							Desc:	Loads groups and perms on start.

--]====================]

--[=[
	Load GROUPS table
--]=]
local groups = sql.Query([[ SELECT id,rank,groupname,color,defaultteam FROM OZA_groups ]])
if(istable(groups)) then

	for k,v in pairs(groups) do
		
		local S = string.Explode(",",v["color"])
		local COLOR = Color( tonumber(S[1]), tonumber(S[2]), tonumber(S[3]))
		
		local DefaultTeam = false
		if(v["defaultteam"] == "1") then DefaultTeam = true end
		
		OZA.groups[tonumber(v["id"])] = {}
		OZA.groups[tonumber(v["id"])]["id"] = tonumber(v["id"])
		OZA.groups[tonumber(v["id"])]["rank"] = tonumber(v["rank"])
		OZA.groups[tonumber(v["id"])]["groupname"] = v["groupname"]
		OZA.groups[tonumber(v["id"])]["color"] = COLOR
		OZA.groups[tonumber(v["id"])]["defaultteam"] = DefaultTeam
		
		OZA.groupperms[tonumber(v["rank"])] = {}
		
	end
	
else
	print(" GROUPS LOAD ERROR ")
	print( sql.LastError( ) )
end

--[=[
	load GROUPPERMS table
--]=]

local groupperms = sql.Query([[ SELECT id,rank,usekey,cantarget FROM OZA_groupperms ]])
if(istable(groupperms)) then
	
	for k,v in pairs(groupperms) do
		
		OZA.groupperms[tonumber(v["rank"])][v["usekey"]] = tonumber(v["cantarget"])
		
	end
else
	print(" GROUP PERMISSIONS LOAD ERROR ")
end