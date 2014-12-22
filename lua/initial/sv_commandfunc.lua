--[====================[
										Ozonic Admin Mod
							
							File:			Commands Set-up
							
							Desc:	Functions to be used for adding commands
									Also permission checks.
									
									
--]====================]


--[=[
	The Function Permission check
--]=]
function OZA.Permissions(ply, key)
	
	-- Grab the group rank ( who knew it'd be so many locals to grab 1 thing :P )
	local tab = OZA.users[ply:SteamID()]
	local groupid = tab["groupid"]
	local group = OZA.groups[groupid]
	local rank = group["rank"]
	local gpermissions = OZA.groupperms[rank]
	local CanTarget = -1
	
	-- If userpermissions exist then run them
	local upermissions,runuserpermissions
	if(istable(OZA.userperms[ply:SteamID])) then 
		runuserpermissions = true
		upermissions = OZA.userperms[ply:SteamID]
	end
	
	-- Buffer each section of a permission ( oza.* for instance ) to make sure thats fine
	local buffer = {}
	local bufferstr = ""
	for k,v in pairs(string.Explode(".",key)) do 
		if(k != #string.Explode(".",key)) then
			table.insert( buffer, bufferstr.. v .. ".*" )
			bufferstr = bufferstr .. v .. "."
		end
	end
	
	-- Check direct permissions
	for k,v in pairs(gpermissions) do 
		if(k == "*") then if(v > CanTarget) then CanTarget = v end end
		if(k == key) then
			if(v > CanTarget) then CanTarget = v end
		end
		
		-- Check the buffer for global(*) permissions
		for l,n in pairs(buffer) do
			if(n == k) then
				if(v > CanTarget) then CanTarget = v end
			end
		end
	end
	
	-- The user permissions bit
	if(runuserpermissions) then
		for k,v in pairs(upermissions) do
			if(k == "*") then if(v > CanTarget) then CanTarget = v end end
			if(k == key) then
				if(v > CanTarget) then CanTarget = v end
			end

			for l,n in pairs(buffer) do 
				if(n == k) then 
					if(v > CanTarget) then CanTarget = v end
				end
			end
		end
	end
	
	--Return the highest CanTarget that could be found.
	if(CanTarget != -1) then return CanTarget else return false end
end

--[=[
	The Add Command Function
	
	OZA.AddCommand(AlsoChat, ... )
--]=]

