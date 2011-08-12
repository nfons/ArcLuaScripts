--[[ Zerg Mode.
player will protect an artifact from being distroyed by zerglings....

this is a multi realm thing, so horde/alliance must work together to protect it]]


--###variable decl

--player stuff
local num_players=0;
players_table={};
players_table.players = {};
players_table.score = {};
--round details
local rounds=50;  --total rounds
local cRound=0;  --current round
local round_cutoff=10; --after this round...you cannot join any game in progress
local round_time=120000; --if they cant kill/end round in this time...we will start the next...sucks to be them!
local cTime=0;
local mx_lives=10; --max number of lives you get per game


--mob stuff
mob_table={}; --keeps track of all the zergs spawned
--civ ids
local civID= 60023;
local civVIPID=60024;
local NumMobs = 8; --number of mobs to start...each round will add more mobs!
local totalMobs=0; --track of total mobs spawn

local rest_time=150; --the time player gets to rest and relax :)
local game_started=false;


--start the round

function start_zerg(unit,event)
	if(game_started == false) then
		return;
	end
	cRound=cRound+1;
	NumMobs=NumMobs+cRound; --each round will have more mobs
	math.randomseed(os.time());
	local num_plrs= #players_table.players
	--is it a boss round?
	local x = -1236.2058;
	local y = 450.612;
	local z = 4.84;
	local o = 2.72;
	if (cRound % 5 ==0) then --mini boss
		unit:SpawnCreature(60031,x,y,z,o,14,0,0,0,0,2,0);
		local rand = math.random(1,num_plrs);
		if(players_table.players[rand]:IsInWorld()) then
			players_table.players[rand]:AddItem(10,1);
			players_table.players[rand]:SendBroadcastMessage("You have been given a Turret Spawner");
		end
	end
	if(cRound % 10 == 0) then --boss
		unit:SpawnCreature(60032,x,y,z,o,14,0,0,0,0,2,0);
		unit:SpawnCreature(60032,x+2,y+2,z,o,14,0,0,0,0,2,0);
	end


	totalMobs=NumMobs+cRound+num_plrs+1;
	--spawn zergs
	local i;
	for i=0, totalMobs do
		local rand=math.random(1,7);
		if(rand == 1) then
			 x = -1236.2058;
			 y = 450.612;
			 z = 4.84;
			 o = 2.72;
		elseif (rand == 2) then
			x = -1244.702;
			y = 448.559;
			z = 5.00;
			o = 1.74;
		elseif (rand == 3) then
			x = -1246.914;
			y = 444.34;
			z = 4.60;
			o = 1.69;
		elseif (rand == 4) then
			x = -1243.551;
			y = 446.29;
			z = 4.49;
			o = 1.703;
		elseif (rand ==5) then
			x=-1254/889;
			y=455.505;
			z=6.77;
		else
			x= -1242.353;
			y= 441.17;
			z= 3.885;
			o= 1.7;
		end
		unit:SpawnCreature(60030,x,y,z,o,14,0,0,0,0,2,0);
	end

	SendWorldMessage("Zergs have arrived!",1);
	unit:SendChatMessage(12,0,"Wave number "..cRound.." Has arrived!");

end


--[[
this is the ending of the game. we will need to empty out the players_table, the mobs_table
]]
local function end_game()

	--save round to DB
	for i,j in pairs (players_table.players) do
		local query=CharDBQuery("Select * from `zerg` where `name`='"..j:GetName().."'");
			local score;
			if(players_table.score[j:GetName()] == nil) then
				score = 0;
			else
				score = players_table.score[j:GetName()];
			end

		if(query == nil) then
			CharDBQuery("Insert into `zerg` (`name`,`hs`,`score`) VALUES ('"..j:GetName().."','"..cRound.."','"..score.."');");
		else
			--get high round
			local max_round=query:GetColumn(2):GetShort()
			local max_score=query:GetColumn(1):GetFloat()
			if(max_round < cRound) then --new high score for player
				CharDBQuery("Update `zerg` set `hs`='"..cRound.."' WHERE `name`='"..j:GetName().."';");
			end
			if(max_score < players_table.score[j:GetName()]) then
				CharDBQuery("Update `zerg` set `score`='"..players_table.score[j:GetName()].."' WHERE `name`='"..j:GetName().."';");
			end
		end
		if (cRound < rounds) then
			j:SendBroadcastMessage("You faught well...but the zerg rush was too strong!");
		elseif cRound == rounds then
			j:SendBroadcastMessage("You did the impossible...you WON!");
		end



		j:SetPhase(1);
		j:RemoveItem(1,10);
		players_table.players[i]=nil;
	end

	--clean out tables

	for i,j in pairs(players_table.score) do
		players_table.score[i]=nil;
	end
	--empty mobs
	for i,k in pairs(mob_table) do
		k:RemoveEvents();
		k:Despawn(1,0);
		mob_table[i]=nil;
	end

	for i,k in pairs(ZERG.wp) do
		ZERG.wp[i]=nil;
	end

	--clean out turrets
	for i,k in pairs(TOWER.twr) do
		k:Despawn(1,0);
		TOWER.twr[i]=nil;
	end
	SendWorldMessage("Zerg Rush Game Ended! ",1);
	game_started=false;

end

--[[this is the npc that will deal with zerg rush ]]
local npc_id=60022;

function NPC_zerg(Unit,event, pPlayer)
   Unit:GossipCreateMenu(68, pPlayer, 0)
   Unit:GossipMenuAddItem(2, "I want to try to defend against the zerg rush", 1, 0);
   Unit:GossipMenuAddItem(1, "What is Zerg D?!",2,0);
   Unit:GossipSendMenu(pPlayer);
end

function zergGossipOnSelect(Unit, Event, player, id, intid, code, pMisc)
	if(intid==1) then
		player:GossipComplete();

		if(player:IsInGroup()) then
			--get group members and add them to table
			local joined = false;
			for k, v in pairs(player:GetGroupPlayers()) do
				for i,j in pairs (players_table.players) do
					if(j:GetName() == v:GetName()) then
						joined=true;
					end
				end
				if(joined==false) then
					table.insert(players_table.players,v);
				end
				players_table.score[v:GetName()] = 0;
			end

		else

			local signed = false;
			--insert the player to DB
			for k,v in pairs (players_table.players) do
				if(v:GetName()==player:GetName()) then
					player:SendBroadcastMessage("You have already signed up.");
					signed=true;
					player:GossipComplete();
					return;
				end
			end

			--they have not signed up, so we will add them
			if(signed==false) then
				table.insert(players_table.players,player);
				players_table.score[player:GetName()] = 0;
			end

		end

		local num_players=#players_table.players;
		if(num_players >= 1) then
			player:SendBroadcastMessage("Let the Games Begin!. "..num_players.." will fight the zerg!");
			SendWorldMessage("Zerg Rush Game started!! join fast!",1);
			if(game_started==false) then  --game hasnet started yet...so we start it
			--teleport all the players in que
				for i,k in pairs(players_table.players) do
					k:SetPhase(2,1);
					k:Teleport(0,-1247.2812,551.028,25.87,0);
				end

			else
					--no need to start game
				player:SetPhase(2,1);
				player:Teleport(0,-1247.2812,551.028,25.87,0);
			end
		else --less than 2 people have signed up.
			Unit:SendChatMessage(12,0,"Not enough players have signed up ("..num_players.."). talk to me again when 2+ people have joined the fight!");
			Unit:SendChatMessage(12,1,"You may also join in a group, and I will send them as well! The following players have signed up: ");
			for i,k in pairs(players_table.players) do
				Unit:SendChatMessage(12,0," Player : "..k:GetName());
			end
			SendWorldMessage("|cFF66FF11 "..player:GetName().." |r has signed up for Zerg Rush! visit a Zerg NPC to sign yourself up",1);
			--Unit:SendChatMessage(12,0,players_table[1]:GetName());

		end
	end

	if(intid==2) then
		Unit:GossipCreateMenu(101, player, 0);
		Unit:GossipSendMenu(player);
	end
end

RegisterUnitGossipEvent(npc_id, 1, "NPC_zerg");
RegisterUnitGossipEvent(npc_id, 2, "zergGossipOnSelect");



--[[  CIVILIAN DETAILS
CIVilian CIVilian CIVilian CIVilian CIVilian CIVilian CIVilian
v
CIVilian CIVilian CIVilian CIVilian CIVilian
CIVilian CIVilian CIVilian CIVilian CIVilian CIVilian CIVilian CIVilian CIVilian CIVilian CIVilian
CIVilian CIVilian CIVilian CIVilian CIVilian CIVilian CIVilian CIVilian CIVilian CIVilian CIVilian CIVilian CIVilian CIVilian
]]--

--civilian spawning

function on_cvsp_death(unit,event,killer)
	unit:SendChatMessage(12,0,"|cFF33FF99"..killer:GetName().."|r has Started the game, it will begin shortly");
	game_started=true;

	local x = -1344.86
	local y = 573.82
	local z = 103.52
	local o = 2.123
	unit:SpawnCreature(civVIPID,x,y,z,o,35,0,0,0,0,2,0);
	unit:SpawnCreature(60026,unit:GetX(),unit:GetY(),unit:GetZ(),unit:GetO(),35,0,0,0,0,2,0);

	--[[ Spawn Civilians ]]--
	local x = -1339.2214;
	local y = 566.184;
	local o = 5.354;
	--get rid of this fool
	local spawners = 4;
	local num_plrs = #players_table.players

	if (num_plrs <=spawners) then
		spawners = spawners/num_plrs;
		spawners = math.floor(spawners);
		for i,k in pairs(players_table.players) do
			k:AddItem(10,spawners);
		end
	else --give every 1, atleast 1 spawners
		for i,k in pairs(players_table.players) do
			k:AddItem(10,1);
		end
	end

	unit:Despawn(1,0);


end
RegisterUnitEvent(60025,4,"on_cvsp_death");



--zerg overlord
function zerg_lord(unit,event)
	if(game_started == true) then
	unit:SendChatMessage(12,0,"You have |CFF3399FF 2 minutes|r to prepare you defenses..get to it!");

	--insert the unit to the mob table
	table.insert(mob_table,unit);
	unit:RegisterEvent("start_zerg",round_time,rounds);
	else
		unit:SendChatMessage(12,0,"Something went wrong...the game did not start yet");
	end
end

function zergLordGossip(unit,event,plr)
	unit:GossipCreateMenu(100,plr,0);
	unit:GossipMenuAddItem(2, "I want another Turret Spawner!", 1, 0);
	unit:GossipSendMenu(plr);
end

function zergLordGossipSelect(Unit, Event, player, id, intid, code, pMisc)
	if(intid == 1) then
		local name=player:GetName();
		local points = players_table.score[name];
		if(points == nil) then
			player:SendBroadcastMessage("You dont have enough Points to get a Turret Spawner");
			return;
		end
		if ( points > 10) then
			player:AddItem(1,1);
			players_table.score[name]=points-10;
		end
		player:GossipComplete();
	else
		player:GossipComplete();
	end
end

RegisterUnitEvent(60026,18,"zerg_lord");
RegisterUnitGossipEvent(60026,1,"zergLordGossip");
RegisterUnitGossipEvent(60026,2,"zergLordGossipSelect");

--[[

ZERG STUFF...ALL RELATING TO ZERGS!!!!!
ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG
ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG
ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG
ZERG
ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG
ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG
ZERG
ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG
ZERG
ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG ZERG

]]--

local zergling_id=60030;
local mini_boss= 60031;
local boss= 60032;
local move=0;
local total_wp=10;
ZERG = {}
ZERG.wp = {};


 function ZERG.OnReachWaypoint(pUnit, Event, WaypointId)
	if(game_started == false) then
		return;
	end



	local sunit = tostring(pUnit);
	ZERG.wp[sunit].wp=WaypointId;
	--pUnit:SendChatMessage(12,0,"We Reached Waypoint: "..WaypointId);
	if(WaypointId == 10) then
		mx_lives=mx_lives-1;
		if (mx_lives <= 0) then
			pUnit:SpawnCreature(60025,-1233.3599,555.619,33.235,3.777,7,0,0,0,0,2,0);
			pUnit:Despawn(1,0);
			end_game();
		else
			for i,k in pairs (players_table.players) do
				k:SendBroadcastMessage("a |cFFFF2222 Civilian|r has died!, you have |cFFFF0022"..mx_lives.."|r lives left!");
		end
		pUnit:RemoveEvents();
		pUnit:Despawn(1,0);

		end
	end
 end

 function ZERG.continue_move(unit,event)
	local sunit = tostring(unit);
	local wp = ZERG.wp[sunit].wp;
	unit:MoveToWaypoint(wp+1);
	--unit:SendChatMessage(12,0,"We on the MOOOVEEE");
end


 --load function
 function ZERG.OnLoad(pUnit, Event)
	pUnit:CreateCustomWaypointMap();
	local wait = math.random(1000,2000);
    pUnit:CreateCustomWaypoint(1,-1250.09252, 576.184, 30.600, 1.824457, 1000, 256, 0)   --Will be waypoint
  	pUnit:CreateCustomWaypoint(2,-1330.253052, 649.809, 50.682, 2.39, wait, 256, 0);
	pUnit:CreateCustomWaypoint(3,-1381.132, 627.69, 52.553, 3.55, wait, 256, 0);
	pUnit:CreateCustomWaypoint(4, -1401.987, 599.642,60.531,4.06,wait,256,0);
	pUnit:CreateCustomWaypoint(5,-1400.631,581.722,69.544,0.55,wait,256,0);
	pUnit:CreateCustomWaypoint(6,-1396.347, 538.995, 77.969, 4.07, wait, 256, 0);
	pUnit:CreateCustomWaypoint(7,-1363.658, 511.867, 88.94, 5.59, wait, 256, 0);
	pUnit:CreateCustomWaypoint(8,-1336.5521, 514.76102, 97.207, 0.045, wait, 256, 0);
	pUnit:CreateCustomWaypoint(9,-1326.185, 545.518, 100.778, 1.25, wait, 256, 0);
	pUnit:CreateCustomWaypoint(10,-1333.6561, 558.939, 102.357, 2.17, wait, 256, 0);
	table.insert(mob_table,pUnit);
	local sunit=tostring(pUnit);
	ZERG.wp[sunit]= {};
	ZERG.wp[sunit].wp = 0;
	pUnit:RegisterEvent("ZERG.continue_move",10000,0);

 end

 function ZERG.onLeaveCombat(unit,event)
	unit:SendChatMessage(12, 0,"Screeeeeeecccchhhh");
	local sunit = tostring(unit);
	local wp =ZERG.wp[sunit].wp;
	unit:MoveToWaypoint(wp+1);
end


 --death functions
 function ZERG.OnDeath(unit,event,killer)
	local sunit=tostring(unit);
	ZERG.wp[sunit]=nil;
	if(killer:IsPlayer()) then

		unit:DestroyCustomWaypointMap();
		local name=killer:GetName();
		local points=players_table.score[name];

		if(points == nil) then
			points=0;
		end
		points=points+1;
		players_table.score[name]=points

		killer:SendBroadcastMessage("You have "..points.." zerg kill points");
	else --was killed by a turret, give it to player 1
		local name=players_table.players[1]:GetName();
		unit:DestroyCustomWaypointMap();
		local points=players_table.score[name];

		if(points == nil) then
			points=0;
		end
		points=points+1;
		players_table.score[name]=points
		players_table.players[1]:SendBroadcastMessage("You have "..points.." zerg kill points");
	end

	local sunit=tostring(pUnit);
	ZERG.wp[sunit]= nil;
	unit:RemoveEvents();
	unit:Despawn(1,0);


end

function ZERG.OnMiniDeath(unit,event,killer)
	local sunit=tostring(unit);
	ZERG.wp[sunit]=nil;
	unit:DestroyCustomWaypointMap();

	local name=killer:GetName();
	local points=players_table.score[name];

	if(points == nil) then
		points=0;
	end
	points=points+5;
	players_table.score[name]=points
	killer:SendBroadcastMessage("You have "..points.." zerg kill points");

	local sunit=tostring(pUnit);
	ZERG.wp[sunit]= nil;
	unit:RemoveEvents();
	unit:Despawn(1,0);

end

function ZERG.OnBossDeath(unit,event,killer)
	local sunit=tostring(unit);
	ZERG.wp[sunit]=nil;
	pUnit:DestroyCustomWaypointMap();

	local name=killer:GetName();
	local points=players_table.score[name];

	if(points == nil) then
		points=0;
	end
	points=points+10;
	players_table.score[name]=points
	killer:SendBroadcastMessage("You have "..points.." zerg kill points");

	local sunit=tostring(pUnit);
	ZERG.wp[sunit]= nil;
	unit:RemoveEvents();
	unit:Despawn(1,0);

end

function ZERG.OnLeave(unit,event)
	local hp= unit:GetHealth();
	unit:SetMaxHealth(hp);
end

--

 RegisterUnitEvent(zergling_id, 18, "ZERG.OnLoad")
 RegisterUnitEvent(zergling_id, 19, "ZERG.OnReachWaypoint")
 RegisterUnitEvent(zergling_id,2,"ZERG.onLeaveCombat")
 RegisterUnitEvent(zergling_id,4,"ZERG.OnDeath")
 RegisterUnitEvent(zergling_id,2,"ZERG.OnLeave")
--mini boss
 RegisterUnitEvent(mini_boss, 18, "ZERG.OnLoad")
 RegisterUnitEvent(mini_boss, 19, "ZERG.OnReachWaypoint")
 RegisterUnitEvent(mini_boss,2,"ZERG.onLeaveCombat")
 RegisterUnitEvent(mini_boss,4,"ZERG.OnMiniDeath")
 RegisterUnitEvent(mini_boss,2,"ZERG.OnLeave")
 --boss

RegisterUnitEvent(boss, 18, "ZERG.OnLoad")
RegisterUnitEvent(boss, 19, "ZERG.OnReachWaypoint")
RegisterUnitEvent(boss,2,"ZERG.onLeaveCombat")
RegisterUnitEvent(boss,4,"ZERG.OnBossDeath")
RegisterUnitEvent(mini_boss,2,"ZERG.OnLeave")



TOWER = {};
TOWER.twr = {};
	--[[TOWER SPAWN ITEM ]]--


function TOWER.attackOnLoad(unit,event)
	unit:SendChatMessage(12,0,"|cff442233 Attack Tower...Deployed.|r");
	unit:RegisterEvent("TOWER.attack_turret_random", 1000,0);
	local sunit = tostring(unit);
	TOWER.twr[sunit]=unit;
end

function TOWER.attack_turret_random (unit,event)
	local target= unit:GetRandomEnemy();
	if(target ~= nil)then
		unit:CastSpellOnTarget(44614,target)
	else
		--unit:SendChatMessage(12,0, "no target in sight");
	end
end

RegisterUnitEvent(60027, 18, "TOWER.attackOnLoad")


function TOWER.defendOnLoad(unit,event)
	unit:SendChatMessage(12,0,"|cff113399 Defensive Turret Deployed. |r");
	unit:RegisterEvent("TOWER.defend", 1000,0);
end

function TOWER.defend(unit,event)
	local target=unit:GetRandomEnemy();
	if(target ~=nil)then
		unit:CastSpell(5209);
	else
		--unit:SendChatMessage(12,0, "no target in sight");
	end
end

function TOWER.defendOnLeave(unit,event)
	local hp= unit:GetHealth();
	unit:SetMaxHealth(hp+500);
end

RegisterUnitEvent(60028, 18, "TOWER.defendOnLoad");
RegisterUnitEvent(60028, 2, "TOWER.defendOnLeave");
