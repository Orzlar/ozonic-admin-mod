--[====================[
										Ozonic Admin Mod
							
							File:			SQL Create Tables
							
							Desc:	Create tables if they do not exist.

--]====================]



--[=[
	USERS table
--]=]
if(!sql.TableExists("OZA_users")) then
	local SQL = sql.Query([[ CREATE TABLE OZA_users ( id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(32),
	steamid VARCHAR(32),
	groupid INTEGER,
	groupname VARCHAR(32),
	ptitle VARCHAR(32),
	IP VARCHAR(32)
	)]] )
	
	
	if(SQL != false) then
		print("OZA_USERS CREATED")
	else
		print("OZA_USER FAULT OCCURED")
		print( sql.LastError( ) )
	end
end


--[=[
	GROUPS table
--]=]

if(!sql.TableExists("OZA_groups")) then
	local SQL = sql.Query([[ CREATE TABLE OZA_groups ( id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	rank INTEGER,
	groupname VARCHAR(32),
	color VARCHAR(19),
	defaultteam BOOLEAN
	) ]] )
	
	if(SQL != false) then
		sql.Query([[ INSERT INTO OZA_groups(rank, groupname, color, defaultteam) VALUES (0, "Player", "50,50,255",1) ]] )
		sql.Query([[ INSERT INTO OZA_groups(rank, groupname, color, defaultteam) VALUES (1, "Member", "100,100,255",0) ]] )
		sql.Query([[ INSERT INTO OZA_groups(rank, groupname, color, defaultteam) VALUES (2, "Regular", "255,100,255",0) ]] )
		sql.Query([[ INSERT INTO OZA_groups(rank, groupname, color, defaultteam) VALUES (3, "Trusted", "255,50,0", 0) ]] )
		sql.Query([[ INSERT INTO OZA_groups(rank, groupname, color, defaultteam) VALUES (4, "Moderator", "100,100,100", 0) ]] )
		sql.Query([[ INSERT INTO OZA_groups(rank, groupname, color, defaultteam) VALUES (5, "Admin", "255,50,50",0) ]] )
		sql.Query([[ INSERT INTO OZA_groups(rank, groupname, color, defaultteam) VALUES (6,"SuperAdmin", "50,255,50",0) ]] )
	
		print("OZA_GROUPS TABLE CREATED")
	else
		print("OZA_GROUPS FAULT OCCURED")
		print( sql.LastError( ) )
	end
end


--[=[
	GROUPPERMS table
--]=]

if(!sql.TableExists("OZA_groupperms")) then
	local SQL = sql.Query([[CREATE TABLE OZA_groupperms (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	rank VARCHAR(32),
	usekey VARCHAR(32),
	canuse BOOLEAN,
	cantarget INTEGER
	)]])
	
	if(SQL != false) then
		sql.Query([[ INSERT INTO OZA_groupperms(rank,usekey,canuse,cantarget) VALUES (0,"OZA.GOTO",1,99) ]])
		sql.Query([[ INSERT INTO OZA_groupperms(rank,usekey,canuse,cantarget) VALUES (5,"OZA.PUNISH.KICK",1,7) ]])
		sql.Query([[ INSERT INTO OZA_groupperms(rank,usekey,canuse,cantarget) VALUES (5,"OZA.PUNISH.BAN",1,99) ]])
		sql.Query([[ INSERT INTO OZA_groupperms(rank,usekey,canuse,cantarget) VALUES (5,"OZA.PUNISH.UNBAN",1,99) ]])
	
		print("OZA_GROUPPERMS TABLE CREATED")
	else
		print("OZA_GROUPPERMS FAULT OCCURED")
		print( sql.LastError( ) )
	end
end


--[=[
	USERPERMS table
--]=]

if(!sql.TableExists("OZA_userperms")) then
	local SQL = sql.Query([[CREATE TABLE OZA_userperms (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	steamid VARCHAR(32),
	usekey VARCHAR(32),
	canuse BOOLEAN,
	cantarget INTEGER
	)]])
	
	if(SQL != false) then
		print("OZA_USERPERMS TABLE CREATED")
	else
		print("OZA_USERPERMS FAULT OCCURED")
		print( sql.LastError( ) )
	end
end