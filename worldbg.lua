

local MaxScore = 500 --The score you need to win
local PerUpdate = 1 --How many points each team gets per flag and score update
local UpdateTimer = 5 --How often the score is updated in seconds (1-3600)


local Flag1_n = 99000 --Entry id of the flag (if it doesnt exist the script automaticly creates it)
local Flag2_n =99001;
local Flag3_n = 99002;



local WorldDB = "world" --Name of your world database
local StartMsg = "#startbg" --Chat message you start the event with

--Do not edit anything beyond this point.

local Flags = {}
local AllianceScore = 0
local HordeScore = 0
local Started = false

Flags[1]=2;
Flags[2]=2;
Flags[3]=2;

function ScoreCounter_FlagTakena(go, event, player)
	if Started == true then
		if player:IsInCombat() then
			player:SendBroadcastMessage("You cannot take a flag while in combat!")
		else
			local team = player:GetTeam()
			local owner = Flags[1]
			if team ~= owner then
				local tmp
				if team == 0 then
					tmp = "|cff0000FF Alliance|r"
				else
					tmp = "|cffFF0000 Horde|r"
				end
				SendWorldMessage(player:GetName().." has captured a Control Point 1 for the "..tmp.."!", 1)
				Flags[1] = team
			else
				player:SendBroadcastMessage("Your team already owns this Control Point.")
			end
		end
	end
end


function ScoreCounter_FlagTakenb(go, event, player)
	if Started == true then
		if player:IsInCombat() then
			player:SendBroadcastMessage("You cannot take a flag while in combat!")
		else
			local team = player:GetTeam()
			local owner = Flags[2]
			if team ~= owner then
				local tmp
				if team == 0 then
					tmp = "|cff0000FF Alliance|r"
				else
					tmp = "|cffFF0000 Horde|r"
				end
				SendWorldMessage(player:GetName().." has captured a Control Point 2 for the "..tmp.."!", 1)
				Flags[2] = team
			else
				player:SendBroadcastMessage("Your team already owns this Control Point.")
			end
		end
	end
end

function ScoreCounter_FlagTakenc(go, event, player)
	if Started == true then
		if player:IsInCombat() then
			player:SendBroadcastMessage("You cannot take a flag while in combat!")
		else
			local team = player:GetTeam()
			local owner = Flags[3]
			if team ~= owner then
				local tmp
				if team == 0 then
					tmp = "|cff0000FF Alliance|r"
				else
					tmp = "|cffFF0000 Horde|r"
				end
				SendWorldMessage(player:GetName().." has captured a Control Point 3 for the "..tmp.."!", 1)
				Flags[3] = team
			else
				player:SendBroadcastMessage("Your team already owns this Control Point.")
			end
		end
	end
end


function ScoreCounter_Create()
	if Started == true then
		ScoreCounter_Destroy()
	end
	local p = LuaPacket:CreatePacket(706, 18)
	p:WriteULong(1)
	p:WriteULong(1377)
	p:WriteULong(0)
	p:WriteUShort(1)
	p:WriteULong(0)
	p:WriteULong(1)
	SendPacketToWorld(p)
	p = LuaPacket:CreatePacket(707, 8)
	p:WriteULong(2317)
	p:WriteULong(MaxScore)
	SendPacketToWorld(p)
	p = LuaPacket:CreatePacket(707, 8)
	p:WriteULong(2313)
	p:WriteULong(AllianceScore)
	SendPacketToWorld(p)
	p = LuaPacket:CreatePacket(707, 8)
	p:WriteULong(2314)
	p:WriteULong(HordeScore)
	SendPacketToWorld(p)
	Started = true
	SendWorldMessage("Azshara World BG event has started. |cFF11FF00 Get to Azshara Malls!|r", 1)
end
function ScoreCounter_OnLogin(event, player)
	if Started == true and player:GetMapId() == 37 then
		RegisterTimedEvent("ScoreCounter_CreateForPlayer", 100, 1, player)

	else
	local p = LuaPacket:CreatePacket(707, 8)
	p:WriteULong(2317)
	p:WriteULong(0)
	player:SendPacketToPlayer(p)
	p = LuaPacket:CreatePacket(707, 8)
	p:WriteULong(2313)
	p:WriteULong(0)
	player:SendPacketToPlayer(p)
	p = LuaPacket:CreatePacket(707, 8)
	p:WriteULong(2314)
	p:WriteULong(0)
	SendPacketToWorld(p)
	p = LuaPacket:CreatePacket(706, 18)
	p:WriteULong(0)
	p:WriteULong(0)
	player:SendPacketToPlayer(p)
	end
end
function ScoreCounter_CreateForPlayer(player)
	local p = LuaPacket:CreatePacket(706, 18)
	p:WriteULong(1)
	p:WriteULong(1377)
	p:WriteULong(0)
	p:WriteUShort(1)
	p:WriteULong(0)
	p:WriteULong(1)
	player:SendPacketToPlayer(p)
	p = LuaPacket:CreatePacket(707, 8)
	p:WriteULong(2317)
	p:WriteULong(MaxScore)
	player:SendPacketToPlayer(p)
	p = LuaPacket:CreatePacket(707, 8)
	p:WriteULong(2313)
	p:WriteULong(AllianceScore)
	player:SendPacketToPlayer(p)
	p = LuaPacket:CreatePacket(707, 8)
	p:WriteULong(2314)
	p:WriteULong(HordeScore)
	player:SendPacketToPlayer(p)
end

function ScoreCounter_Update()
	if Started == true then
		local Alliance = AllianceScore
		local Horde = HordeScore
		for k, v in pairs (Flags) do
			if v == 0 then
				Alliance = Alliance + PerUpdate
			elseif v == 1 then
				Horde = Horde + PerUpdate
			end
		end
		if Alliance == AllianceScore and Horde == HordeScore then
			return
		else
			if Alliance >= MaxScore and Horde >= MaxScore then
				ScoreCounter_Destroy()
				SendWorldMessage("No side won the world BG event.", 1)
				Started = false
			elseif Alliance >= MaxScore then
				ScoreCounter_Destroy()
				SendWorldMessage("The |cFF1110FF Alliance|r has won the world BG event.", 1)
				for k,v in pairs(GetPlayersInWorld()) do
					if(v:GetTeam() == 0) then
						v:SendBroadcastMessage("Your Faction won |cFFe2d2f3 World PvP Event!|r, you have been given a |cffFFEE33 Victory Token!|r")
						v:AddItem(2,1);
						v:CastSpell(71354);  --or 57353
					end
				end

				Started = false
			elseif Horde >= MaxScore then
				ScoreCounter_Destroy()
				SendWorldMessage("The |cFFFF1011 Horde|r has won the world BG event.", 1)
				for k,v in pairs(GetPlayersInWorld()) do
					if(v:GetTeam() == 1) then
						v:SendBroadcastMessage("Your Faction won |cFFe2d2f3 World PvP Event!|r, you have been given a |cffFFEE33 Victory Token!|r")
						v:AddItem(2,1);
					end
				end
				Started = false
			else
				AllianceScore = Alliance
				HordeScore = Horde
				local p = LuaPacket:CreatePacket(707, 8)
				p:WriteULong(2313)
				p:WriteULong(Alliance)
				SendPacketToWorld(p)
				p = LuaPacket:CreatePacket(707, 8)
				p:WriteULong(2314)
				p:WriteULong(Horde)
				SendPacketToWorld(p)
			end
		end
	end
end

function ScoreCounter_Destroy()
	AllianceScore = 0
	HordeScore = 0
	for k, v in pairs (Flags) do
		Flags[k] = 2
	end
	local p = LuaPacket:CreatePacket(707, 8)
	p:WriteULong(2317)
	p:WriteULong(0)
	SendPacketToWorld(p)
	p = LuaPacket:CreatePacket(707, 8)
	p:WriteULong(2313)
	p:WriteULong(0)
	SendPacketToWorld(p)
	p = LuaPacket:CreatePacket(707, 8)
	p:WriteULong(2314)
	p:WriteULong(0)
	SendPacketToWorld(p)
	p = LuaPacket:CreatePacket(706, 18)
	p:WriteULong(0)
	p:WriteULong(0)
	SendPacketToWorld(p)
	Started = false
end

ScoreCounter_Create();
function ScoreCounter_Start(event, player, message)
	if message == StartMsg and player:IsGm() then
		if Started == false then
			ScoreCounter_Create()
		else
			player:SendAreaTriggerMessage("World BG event is already on.")
		end
		return 0
	end
end



	--CP 1
	RegisterGameObjectEvent(Flag1_n, 4, "ScoreCounter_FlagTakena")


	--cp2
	RegisterGameObjectEvent(Flag2_n, 4, "ScoreCounter_FlagTakenb")


	--cp3
	RegisterGameObjectEvent(Flag3_n, 4, "ScoreCounter_FlagTakenc")



	RegisterServerHook(4, "ScoreCounter_OnLogin")
	RegisterTimedEvent("ScoreCounter_Update", UpdateTimer*1000, 0)
	RegisterServerHook(16, "ScoreCounter_Start")
