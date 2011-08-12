ASSN = {};
ASSN.players = {};  --target, points,pointer
assassin_on = false;
local register_npc = 60013;

local cTime;
local RoundTime =  300000; --minutes
local ext_help = 0;
--[[NPC ]]--
function ASSN.OnTalk(unit,event,plr)
	unit:GossipCreateMenu(100, plr, 0);
	unit:GossipMenuAddItem(3,"I wanna be an Assassino! Let me try!",1,0);
	unit:GossipMenuAddItem(5,"Can you explain the rules?",3,0);
	unit:GossipMenuAddItem(1,"Never mind...",2,0);
	unit:GossipSendMenu(plr);
end

function ASSN.onChoose(unit,event,plr,msg,intid)
	if (intid == 1) then
		local signed = false;

		for i,k in pairs(ASSN.players) do
			if(k.pointer:GetName() == plr:GetName()) then
				signed=true;
			end
		end

		if(signed == false) then
			plr:SendBroadcastMessage("Signing you up right now! ");
			local sname= plr:GetName();
			ASSN.players[sname] = {};
			ASSN.players[sname].target = "no one";
			ASSN.players[sname].points = 0;
			ASSN.players[sname].mult= 0;
			ASSN.players[sname].pointer = plr;
			ASSN.players[sname].hunters = {};
		else
			plr:SendBroadcastMessage("You already singed up for this event...");
			plr:GossipComplete();
			return;
		end

		--we dont want to check the size, if the game has already started

		--the game hasnt started...we will check to see if we have over 3 players signed up

		if(assassin_on == false and signed == false) then

			local size = 0;
			for i, k in pairs (ASSN.players) do
				size = size +1;
			end

			if(size > 2) then  --we have enough to start
				assassin_on=true;
				cTime= os.time()+RoundTime;
				ext_help = os.time()+30000; --30 secs from now
				start_game();

				local x =1;
				----[[teleport to Gurubashi
				for i, k in pairs(ASSN.players) do
					k.pointer:Teleport(530,-2091.45,6626.619,13.05,1.15);

				end  --]]

			else  --we need more
				SendWorldMessage("|cffd3a1FF "..plr:GetName().."|r Has signed up for Assassination Game!, we need "..(3-size).." players to start the event!",1);
			end

		else --game has started...so just give the player a new target
			get_newTarget(plr);
			Plr:Teleport(0,-13189.809,316.904,33.233,1.15);
		end
		plr:GossipComplete();

	elseif (intid==2) then
		unit:SendChatMessage(0,0,"Well...maybe next time you can play...");
		plr:GossipComplete();

	elseif(intid == 3) then
		unit:GossipCreateMenu(102, plr, 0);
		unit:GossipSendMenu(plr);
	else
		plr:GossipComplete();
	end
end

RegisterUnitGossipEvent(register_npc, 1, "ASSN.OnTalk");
RegisterUnitGossipEvent(register_npc, 2,  "ASSN.onChoose");


function start_game()
	SendWorldMessage("|cff3366FF ASSASSIN Mission started!|r lets see who is the best Assassin out there!",1);
	for i,k in pairs(ASSN.players) do
		get_newTarget(k.pointer);
	end
	assassin_on = true;
end


function get_newTarget(plr)
	local size = 0;
	for i, k in pairs (ASSN.players) do
		size = size +1;
	end
	--math.randomseed(os.time());
	local rand = math.random(1,size);
	local x = 1;
	for i, k in pairs (ASSN.players) do
		if(x == rand) then
			if(plr:GetName() == k.pointer:GetName())then --same target
				get_newTarget(plr);
				return;
			end
			local gender = k.pointer:GetGender();
			if(gender == 0) then
				plr:SendBroadcastMessage("Your Target is  a |cffFF3333 Male |r and is |cff33dd33 "..plr:GetDistance(k.pointer).."|r meters from you");
			else
				plr:SendBroadcastMessage("Your Target is  a |cffFF3333 Female |r and is |cff33dd33 "..plr:GetDistance(k.pointer).."|r meters from you");
			end
			ASSN.players[plr:GetName()].target = k.pointer; --assign the target for the player
			ASSN.players[plr:GetName()].mult = 5;

			--assign the hunters to target
			k.hunters[plr:GetName()] = plr;
			--check to see if they are in the arena
			if(k.pointer:GetAreaId() ~= 3701) then
				k.pointer:Teleport(530,-2030.40,6631.89,13.05,2.2);
			end
			k.pointer:SendBroadcastMessage("You have a new Assassin after You!");
		end
		x = x+1;
	end
	size = 0;
end


--[[EXTRA PLAYER HELP

this tells people more details ]]--

function get_target_detail()
	--math.randomseed(os.time());
	local extra_help = math.random(1,5);
	for i,k in pairs(ASSN.players) do
		k.pointer:SendBroadcastMessage("Your Target is |cff12CC11"..k.pointer:GetDistance(k.target).."|r meters from you!");

		if(extra_help == 3) then
			k.pointer:SendBroadcastMessage("|cff66FF22 [EXTRA HELP!]|r Your target is a :"..k.target:GetPlayerClass().."!");
		end
		k.mult = k.mult - 1;
		if(k.mult <= 0) then
			k.mult = 1;
		end
	end
end

function ASNupdate()
	WorldAnnounceTEST();
	if(assassin_on == false) then
		return;
	elseif(assassin_on == true)then
		local diff = os.time() - cTime;
		if (diff <= 120000) and (diff > 80000) then
			SendWorldMessage("Assassin Game, has less than 2 minutes left!",1);
		end

		if(os.time() > cTime) then --game ended
			end_game();
		end
	end
	get_target_detail();
end

function end_game()
local first,second,third = 0,0,0;
local winner,runner,last= "none","none","none";
local win,run,las;

  --we need to get the top 3 players
  for i,k in pairs(ASSN.players) do
	if(k.points > first) then --has highest score
		first = k.points;
		winner = k.pointer:GetName();
		win = k.pointer;
	elseif(k.points > second) then
		second = k.points;
		runner = k.pointer:GetName();
		run = k.pointer;
	elseif(k.points >third) then
		third = k.points;
		last = k.pointer:GetName();
		las=k.pointer;
	end
  end
  SendWorldMessage("[ASSN] Game ended! 1st place: |cff662211 "..winner.."|r 2nd place: |cff226611:"..runner.." 3rd place: |cff221166 "..last,1);

  assassin_on = false;
  local winner,runner,last,first,third,second = nil,nil,nil,nil,nil,nil;

  --give the rewards
  win:SendBroadcastMessage("|cff55EE22 You Won! [ASSN] Mode! |r");
  win:AddItem(1,3);
  run:SendBroadcastMessage("|cff66ee33 Close! you got 2nd place at [ASSN] mode!");
  run:AddItem(1,2);
  las:SendBroadcastMessage("|cff77ee44 Almost! you got 3rd at [ASSN] mode!");
  las:AddItem(1,1);

	--SQL queries
  --empty out table
  for i,k in pairs(ASSN.players) do
		local query=CharDBQuery("Select * from `assassin` WHERE `name`='"..k.pointer:GetName().."';");
		local name = k.pointer:GetName();
		if(query == nil) then  --new user
			if(name == winner) then
				CharDBQuery("Insert into `assassin` (`name`,`wins`,`points`) VALUES ('"..winner.."',1);");
			end
		else  -- not new
			if(name == winner) then
				CharDBQuery("update `assassin` set `wins` = `wins`+1 WHERE `name`='"..winner.."';");
			end
		end

		ASSN.players[i]=nil;
  end

  collectgarbage();

end



--[[

pvp setup

]]


function OnKillPlayer(event, player, victim)
	if(assassin_on== false) then
		return;
	end
	local id = player:GetName();
	local points = ASSN.players[id].points;

	 --we dont want random people to play the game..
	if(ASSN.players[id] == nil) then
		return;
	end

	if(assassin_on ==true) then
		local id= player:GetName();
		local target = ASSN.players[id].target:GetName();
		if (victim:GetName() ~= target) then --wrong target
			points=points-10;
			player:SendBroadcastMessage("Wrong Target! |cffFF1111 -10 |r Points Lost. Total: "..points);
		end

		if(victim:GetName() == target) then --right target
			local multiplier = ASSN.players[id].mult;
			points=points+(10*multiplier);
			player:SendBroadcastMessage("SUCCESS! |cff11FF11 "..10*multiplier.." |r Points earned! Total: "..points);
		end

		ASSN.players[id].points = points;
		get_newTarget(player);

		--remove the hunters, and get them a new target
		for i,k in pairs (ASSN.players[victim:GetName()].hunters) do
			if(k:GetName() ~= player:GetName())then
			k:SendBroadcastMessage("Some one Else killed your target! getting a new one!");
			get_newTarget(k);
			end
		end

		id = nil;
		points = nil;
		collectgarbage();

	end
end

RegisterServerHook(2, "OnKillPlayer")
