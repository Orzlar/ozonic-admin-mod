--[====================[
										Ozonic Admin Mod
							
							File:			Player Find Functions
							
							Desc:	Adds easy way to get players
									
--]====================]

OZLib.FindPlayerByName = function(s,b)

	local n = 0
	local e
	if(b) then e = {} end
	
	for k,v in pairs(player.GetAll()) do 
		if(string.find(string.lower(v:Nick()),string.lower(s))) then
			n = n + 1
			if(b)
				table.insert(e,v)
			else
				e = v
			end
		end
	end
	
	if(n == 0 or n > 1 and b) then return false end
	
	return e
end

OZLib.FindPlayerBySteamID = function(s)
	
	local n = 0
	for k,v in pairs(player.GetAll()) do
		if(v:SteamID() == string.upper(s)) then
			n = n + 1
			return v
		end
	end
	
	if(n == 0 or n > 1) then return false end
end