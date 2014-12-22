--[====================[
										Ozonic Admin Mod
							
							File:			Color Functions
							
							Desc:	Gives access to color in chat and console

--]====================]

if SERVER then
	util.AddNetworkString("colorchat")

	--[=[
		Add Chat will Accepts tables with colors and strings, much like chat.AddText
	--]=]
	
	OZLib.AddChat = function(...)

		local Tab = {...}
		local Ply = {}
		local Msg = {}
		
		table.foreach(Tab, function(key, value)
		
			if(IsEntity(value)) then
				table.insert(Ply,value)
			else
				table.insert(Msg,value)
			end
		end)
		
		if(#Ply < 1) then Ply = player.GetAll() end
		net.Start("colorchat")
			net.WriteTable(Msg)
		net.Send( Ply )

	end

	--[=[
		ChatMessage is similar to the one above, except its given the OZA tag at start.
	--]=]
	
	OZLib.ChatMessage = function(...)
		local Tab = {...}
		local Ply = {}
		local Msg = {}
		
		table.insert(Msg,OZA.color1)
		table.insert(Msg,OZA.tag.." ")
		table.insert(Msg,OZA.color2)

		table.foreach(Tab, function(key, value)
		
			if(IsEntity(value)) then
				table.insert(Ply,value)
			else
				table.insert(Msg,value)
			end
		end)
		
		if(#Ply < 1) then Ply = player.GetAll() end
		net.Start("colorchat")
			net.WriteTable(Msg)
		net.Send( Ply )
		
	end
end

if CLIENT then

	net.Receive("colorchat", function(len)

		chat.AddText( unpack( net.ReadTable() ) )
		
	end)
	
end