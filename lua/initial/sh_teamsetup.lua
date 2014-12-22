--[==========================================================================================[
										Ozonic Admin Mod
							
							File:			Team Set-up
							
							Desc:	Sets up team, and gives a sync function

--]==========================================================================================]

if SERVER then
	util.AddNetworkString("teamsync")
	function OZA.SyncTeams()
	
		net.Start("teamsync")
				net.WriteTable(OZA.groups)
		net.Broadcast()

	end

	
	for k,v in pairs(OZA.groups) do
		team.SetUp(v["id"], v["groupname"], v["color"], true )
		_G["TEAM_"..string.upper(v["groupname"])] = v["rank"]
	end
	
end

if CLIENT then
	
	net.Receive("teamsync", function(len)
		for k,v in pairs(net.ReadTable()) do
			team.SetUp(v["id"], v["groupname"], v["color"], true )
			_G["TEAM_"..string.upper(v["groupname"])] = v["rank"]
		end
	end)
	
end