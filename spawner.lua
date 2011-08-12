local game_started=true;

function OnGossipTalk(item, event, player, pMisc)
	item:GossipCreateMenu(100, player, 0)

	if(player:GetPhase() == 2) then
		item:GossipMenuAddItem(4, "Spawn a Attack Turret", 1, 0)
		item:GossipMenuAddItem(4, "Spawn a Defensive Turret", 2, 0)
	else
		item:GossipMenuAddItem(4, "Sorry...Zerg Rush Game Hasnt started yet", 3, 0)
	end
	item:GossipSendMenu(player)
end

function OnGossipSelect(item, event, player, id, intid, code, pMisc)
	if(intid == 1) then
		player:SpawnCreature(60027,player:GetX(),player:GetY(),player:GetZ(),player:GetO(),1625,0,0,0,0,player:GetPhase(),0)
		player:GossipComplete();
		player:RemoveItem(10,1);
	elseif (intid == 2) then
		player:SpawnCreature(60028,player:GetX(),player:GetY(),player:GetZ(),player:GetO(),1625,0,0,0,0,player:GetPhase(),0)
		player:GossipComplete();
		player:RemoveItem(10,1);
	end
end

RegisterItemGossipEvent(10, 1, "OnGossipTalk")
RegisterItemGossipEvent(10, 2, "OnGossipSelect")
