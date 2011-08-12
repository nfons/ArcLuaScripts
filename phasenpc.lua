--fix a players state

function onSpeakFixer(unit,event,plr)
	unit:GossipCreateMenu(2, plr, 0);
	plr:SetPhase(1,0);
	plr:AddItemSet(825);
end

RegisterUnitGossipEvent(60016,1,"onSpeakFixer");

