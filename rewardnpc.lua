local vote_npc = 60017;
local token = 3;

function vote_onTalk(unit,event,plr)
	unit:GossipCreateMenu(7, plr, 0)
	unit:GossipMenuAddItem(1,"Exchange for Forge Token",1,0);
	unit:GossipMenuAddItem(6,"Tier 9 Gear 1 token",2,0);
	unit:GossipMenuAddItem(6,"Arena Season Gear - 1 token",3,0);
	unit:GossipMenuAddItem(6,"Exchange for Mounts- 1 token",4,0);
	unit:GossipMenuAddItem(2,"Exchange for Weapons (TBA)",9,0);
	unit:GossipSendMenu(plr);
end


function vote_onChoose(unit, Event, plr, id, intid, code, pMisc)
	if(plr:HasItem(token)~= true)then
		plr:SendBroadcastMessage("|cffFF1111 You dont have a Vote token!|r");
		return;
	end
	if(intid == 1) then --forge token
		plr:AddItem(4,1);
		plr:RemoveItem(token,1);

	elseif(intid == 2)then --Tier 9 Gear
		local class=plr:GetPlayerClass();
		local setid = 0;
		if(class == "Warrior") then
			setid = 867;
		elseif(class=="Paladin") then
			setid= 876;
		elseif(class=="Rogue")then
			setid=857;
		elseif(class=="Mage")then
			setid=844;
		elseif(class=="Warlock")then
			setid=845;
		elseif(class=="Priest")then
			setid=848;
		elseif(class=="Druid")then
			setid=856;
		elseif(class=="Hunter")then
			setid=859;
		elseif(class=="Shaman")then
			setid=861;
		elseif(class=="Death Knight")then
			setid=874;
		end
		if(setid ~= nil) then
			plr:AddItemSet(setid);
			plr:RemoveItem(token,1);
		else
			plr:SendBroadcastMessage("Something Went wrong...contact an admin! the setid given was 0");
		end
	elseif(intid == 3)then --Arena gear
		local class=plr:GetPlayerClass();
		local setid = 0;

		if(class == "Warrior") then
			setid = 765;
		elseif(class=="Paladin") then
			setid= 767;
		elseif(class=="Rogue")then
			setid=776;
		elseif(class=="Mage")then
			setid=779;
		elseif(class=="Warlock")then
			setid=780;
		elseif(class=="Priest")then
			setid=777;
		elseif(class=="Druid")then
			setid=773;
		elseif(class=="Hunter")then
			setid=772;
		elseif(class=="Shaman")then
			setid=770;
		elseif(class=="Death Knight")then
			setid=768;
		end
		plr:AddItemSet(setid);
		plr:RemoveItem(token,1);

	elseif(intid == 4)then --mounts
		plr:GossipComplete();
		unit:GossipCreateMenu(7, plr, 0);
		unit:GossipMenuAddItem(1,"Flying Proto Drake",5,0);
		unit:GossipMenuAddItem(1,"War Bear",6,0);
		unit:GossipMenuAddItem(1,"Flying Machine",7,0);
		unit:GossipMenuAddItem(1,"Flying Wyrm",8,0);
		unit:GossipSendMenu(plr);
	elseif(intid == 5) then
		plr:AddItem(44151,1);
		plr:RemoveItem(token,1);
	elseif(intid == 6) then
		plr:AddItem(44224,1);
	elseif(intid == 7) then
		plr:AddItem(34061,1);
		plr:RemoveItem(token,1);
	elseif(intid==8)then
		plr:AddItem(47840,1);
		plr:RemoveItem(token,1);
	else
		plr:GossipComplete();
	end

end
RegisterUnitGossipEvent(60017,1,"vote_onTalk");
RegisterUnitGossipEvent(60017,2,"vote_onChoose");
