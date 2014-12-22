--[====================[
										Ozonic Admin Mod
							
							File:			Commands Set-up
							
							Desc:	Functions to be used for adding commands
									Also permission checks.
									
									
--]====================]


--[=[
	The Function CanUse
--]=]
function OZA.CanUse(ply, key)
	
	local tab = OZA.users[ply:SteamID()]
	local groupid = tab["groupid"]
	local group = OZA.groups[groupid]
	local rank = group["rank"]
	local permissions = OZA.groupperms[rank]
		
	return false
end

--[=[
	The Add Command Function
	
	OZA.AddCommand(AlsoChat, ... )
--]=]



--[=[
	Run Commands on Chat and Console
--]=]
hook.Add("PlayerSay","ozamod-chathook",function(ply,txt,b)

	if(string.sub(txt,1,1) == "!" or string.sub(txt,1,1) == "/" or string.sub(txt,1,1) == "$") then
	
		local echo = false
		if(string.sub(txt,1,1) == "$") then if(OZA.CanUse(ply,"OZA_ADMIN_HIDDENECHO")) then echo = true end end 
	end
end)