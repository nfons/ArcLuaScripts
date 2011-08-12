zombie = {} --main table, only contains functions


zombie.group = {} --instance id, group
zombie.rounds = {} --instance, round count;
zombie.units={};

local register_npc=70001;
local kill_npc = 70002;
local beacon_npc = 70003;
local zombie1;
local zombie2;
local zombie3;

function zombie.hasAlive(player)
	for i,k in pairs(player:GetGroupPlayers()) do
		--check instance
		if(k:IsAlive() and k:IsInInstance() and k:GetInstanceID()==player:GetInstanceID()) then
			return true;
		end
	end

	return false;
end

function random_move(unit)
	--move the unit
	local x;
	local y;
	local z;
	local o;

	local id=unit:GetInstanceID();
	local alive_plr = {};


	for i,k in pairs(zombie.group[id]) do
		if(k:IsAlive()) then
			table.insert(alive_plrs,k);
		end
	end


	local num_plrs = #alive_plr;
	local rand = math.random(1,num_plrs);
	for i,k in pairs(alive_plr) do
		if(i==rand) then
			x=k:GetX();
			y=k:GetY();
			z=k:GetZ();
			o=k:GetO();
		end
	end

	unit:MoveTo(x,y,z,o);

	--clean table out
	for i,k in pairs(alive_plr) do
		alive_plr[i]=nil;
	end

end

function zombie.endGame(instanceID)
	for i,k in pairs(zombie.group[instanceID]) do
		k:SendBroadcastMessage("Zombie round has ended! You survived |cffe3e3FF"..zombie.rounds[instanceID].."|r");
		--teleport the player
	end
	collectgarbage();
end

--[[

ZOMBIES!!!  ZOMBIESSS
ZOMBIES!!! OMG ZOMBIES

]]

function zombie.OnLoad(unit,event)
	local sunit = tostring(unit);
	zombie.units[sunit]={};
	zombie.units[sunit].unit = unit;

	--randomly move the unit to a player in the instance

	random_move(unit);

end

function zombie.OnKill(unit,event,target)
	if(zombie.hasAlive(target) == false) then
		zombie.endGame(unit:GetInstanceID());
	else
		random_move(unit)
	end
end

function zombie.OnDied(unit,event,killer)
	local sunit = tostring(unit);
	zombie.units[sunit] =nil;

	--randomly check to see if the player deserves a gun
end


--[[ register_npc

register_npc
register_npc
]]

function zombie.RegisterOnSpeak(unit,event,plr)
	unit:GossipCreateMenu(50020, plr, 0);
	unit:GossipMenuAddItem(1,"Register my Group for Zombies",1,0);
	unit:GossipMenuAddItem(1,"Never mind...i dont know if i can stand an zombie attack",2,0);
	unit:GossipSendMenu(plr);
end

function zombie.RegisterOnChoose(unit,event,plr,msg,intid)
	if (intid ==1)then
		if(plr:IsInGroup()) then
			zombie.group[plr:GetInstanceID()] = plr:GetGroupPlayers();
			--spawn the kill npc
		else
			unit:SendChatMessage(12,0, "You are not in a group!");
			plr:GossipComplete();
			return;
		end
		plr:GossipComplete();
	else
		plr:GossipComplete();
	end
end


