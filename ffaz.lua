FFAZ = {};
local zombie_id = 60040;
local register_npc = 70001;
local stoneid = 99011;
FFAZ.players = {};
FFAZ.units = {};
FFAZ.alive = {};

local rounds = 0;
local game_started = false;

local roundtime = 240000; --time that a round last (4 mins)


--[[End Game
We need to Tell who the last man is.
DB Query update
]]

function endgame(name)
	for i,k in pairs (FFAZ.players) do
		FFAZ.players[i] = nil;
	end

	for i,k in pairs (FFAZ.units) do
		k:Despawn(1,0);
		FFAZ.units[i]=nil;
	end

	for i,k in pairs(FFAZ.alive) do
		FFAZ.alive[i] = nil;
	end
	local query=CharDBQuery("Select * from `zombie` where `name`='"..name.."'");

		if(query == nil)then --new player
			CharDBQuery("Insert into `zombie` (`name`,`waves`) VALUES ('"..name.."','"..rounds.."');");
		else
			local waves = query:GetColumn(1):GetShort();
			if(waves < rounds) then
				CharDBQuery("Update `zombie` set `waves`='"..rounds.."' WHERE `name`='"..name.."';");
			end
		end

	SendWorldMessage("Zombie Event ended! |cff66FF22"..name.."|r Was the last man standing against the waves of |cff222232 "..rounds.."|r",1);

	game_started = false;
	rounds= 0;

end

--[[RANDOM MOVEMENT

randomly move the unit --]]

function get_randmove(unit)
	local x,y,z,o;
	local size = 0;

	for i, k in pairs (FFAZ.alive) do
		size = size +1;
	end

	local rand = math.random(1,size);
	local x = 1;

	for i,k in pairs(FFAZ.alive) do
		if(x == rand) then
			if(k:GetAreaId() ~= 2177) then
				--teleport plr back to arena
				k:Teleport(0,-13208.1679,292.72,21.85,5.54);
			end

			if(k:IsStealthed() == true) then
				k:RemoveStealth();
			end

			x=k:GetX();
			y=k:GetY();
			z=k:GetZ();
			o=k:GetO();

			unit:MoveTo(x,y,z,o);
		end

		x = x +1;
	end

	x = nil;
	size = nil;
	rand = nil;

end

--[[ZOMBIES
DONE  ]]--

function FFAZ.OnSpawn(unit,event)
	local sunit = tostring(unit);
	FFAZ.units[sunit] = unit;
	get_randmove(unit);
	unit:SetMoveRunFlag(1);
	unit:ModifyRunSpeed(8);
	unit:RegisterEvent("get_randmove",60000,0);
end

function FFAZ.onKill(unit,event,target)
	--unit:CastSpellOnTarget(43869, target)
	local splr= tostring(target);
	FFAZ.alive[splr] = nil;

	--check to see if we have last man left
	local size = 0;
	local last_man= "NO ONE";
	for i,k in pairs(FFAZ.alive) do
		if(k:IsAlive()) then
			size= size+1;
			last_man=k:GetName();
		end
	end

	--something went wrong..we killed the last man standing...
	if (last_man == "NO ONE") then
		last_man= target:GetName();
	end

	--rez the killed target
	unit:ResurrectPlayer()
	--last man standing? or is there more?
	if(size > 1) then
		get_randmove(unit);
	else
		endgame(last_man);
	end


end

function FFAZ.OnDied(unit,event)
	local sunit= tostring(unit);
	FFAZ.units[sunit]= nil;
	unit:Despawn(2,0);
end

RegisterUnitEvent(zombie_id,18,"FFAZ.OnSpawn");
RegisterUnitEvent(zombie_id,4,"FFAZ.OnDied");
RegisterUnitEvent(zombie_id,3,"FFAZ.onKill");

--[[REGISTER NPC
DONE]]--

function FFAZ.RegisterOnSpeak(unit,event,plr)
	unit:GossipCreateMenu(50020, plr, 0);
	unit:GossipMenuAddItem(0,"Register me for Free For ALL Zombie match!",1,0);
	unit:GossipMenuAddItem(6,"What is Zombie Mode?",3,0);
	unit:GossipMenuAddItem(1,"Never mind...i dont know if i can stand an zombie attack",2,0);
	unit:GossipSendMenu(plr);
end

function FFAZ.onRegisterChose(unit,event,plr,msg,intid)
	if(intid == 1)then
		local signed = false;
		--check to see if player has already signed up
		for i,k in pairs(FFAZ.players) do
			if(k:GetName() == plr:GetName()) then
				signed = true;
			end
		end
		if(signed == true and game_started==false) then
			unit:SendChatMessage(12,0,"You have already signed up! please wait till atleast 2 other people sign up to do this!");
		else
			--add the players to the tables
			local splr = tostring (plr);
			FFAZ.players[splr] = plr;
			FFAZ.alive[splr] = plr;

			local size = 0;
			for i,k in pairs(FFAZ.players) do
				size= size+1;
			end

			if(size >= 1) then
				game_started=true;
				SendWorldMessage("|cffFFd3d3 Free For All Zombie mode |r started!!! the game will begin shortly, get to the Arena to participate",1);
				unit:SpawnGameObject(stoneid,-13189.809,316.904,33.233,1.15,0,1);
				plr:MovePlayerTo(-13201.16,268.52,21.857,2.2,256);

			else
				SendWorldMessage("We Need More people for Free For All Zombie Mode!, Come to the Arena if you want to participate!",1);
			end
			plr:GossipComplete();
		end


	elseif(intid==3) then
		unit:GossipCreateMenu(103,plr,0);
		unit:GossipSendMenu(plr);
	else
		plr:GossipComplete();
	end
end

RegisterUnitGossipEvent(register_npc, 1, "FFAZ.RegisterOnSpeak");
RegisterUnitGossipEvent(register_npc, 2,  "FFAZ.onRegisterChose");


--[[Zombie stone..

this will actually spawn the mobs  ]]--




function SpawnMobs(gobj)
	rounds = rounds +1;
	SendWorldMessage("Wave "..rounds.." of Zombies have arrived!",1);

	local rounToMob = rounds * 2;
	local rounToMob = rounToMob+5;

	--spawn mobs
	local i;
	for i = 0, rounToMob do
		--get random spawn
		local sp = i % 5;
		if(sp == 0)then
			FFAZ.units[1]:SpawnCreature(zombie_id,-13167.63,297.28,21.85,3.89,14,0);
		elseif(sp == 1)then
			FFAZ.units[1]:SpawnCreature(zombie_id,-13167.94,848.20,21.85,2.74,14,0);
		elseif(sp == 2)then
			FFAZ.units[1]:SpawnCreature(zombie_id,-13222.968,238.51,21.85,074,14,0);
		else
			FFAZ.units[1]:SpawnCreature(zombie_id,-13245.968,290.182,21.857,5.4,14,0);
		end
	end
end

function FFAZ.StoneOnSpawn(gobj)
	--CreateLuaEvent
	table.insert(FFAZ.units,gobj);
	gobj:RegisterEvent("SpawnMobs",3000,1);
	gobj:RegisterEvent("SpawnMobs",roundtime,0);

	--FFAZ.units[gobj:GetName()] = gobj;
end

function FFAZ.StoneDespawn()
end

RegisterGameObjectEvent(stoneid, 2, "FFAZ.StoneOnSpawn");
RegisterGameObjectEvent(stoneid, 6,"FFAZ.StoneDespawn");
