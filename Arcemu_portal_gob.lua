-- # Portal Gob
-- # By Rochet2
-- # Downloaded from http://projectcode.zzl.org/
-- # Bugs and contact with E-mail: Rochet2@post.com



local GOBID = 99010-- change to your gobid



function Portal_Gob_gossip_hello(pUnit, event, pPlayer, id, intid, code, pMisc) -- Main Menu

if (pPlayer:IsInCombat() == true) then
pPlayer:SendAreaTriggerMessage("|cffff0000You are in combat|r")
pPlayer:GossipComplete()
else

if(pPlayer:GetTeam() == 1) then

pUnit:GossipCreateMenu(300000, pPlayer, 0)

if pPlayer:GetAreaId() ~= 1637 then
pUnit:GossipMenuAddItem(2, "Orgrimmar", 1000, 0)
end

if pPlayer:GetAreaId() ~= 153 then
pUnit:GossipMenuAddItem(2, "Undercity", 1001, 0)
end

if pPlayer:GetAreaId() ~= 1638 then
pUnit:GossipMenuAddItem(2, "Thunderbluff", 1002, 0)
end

if pPlayer:GetAreaId() ~= 3487 then
pUnit:GossipMenuAddItem(2, "Silvermoon city", 1003, 0)
end
end

if(pPlayer:GetTeam() == 0)then

pUnit:GossipCreateMenu(300001, pPlayer, 0)

if pPlayer:GetAreaId() ~= 1519 then
pUnit:GossipMenuAddItem(2, "Stormwind", 1004, 0)
end

if pPlayer:GetAreaId() ~= 1662 then
pUnit:GossipMenuAddItem(2, "Darnassus", 1005, 0)
end

if pPlayer:GetAreaId() ~= 1 then
pUnit:GossipMenuAddItem(2, "Ironforge", 1006, 0)
end

if pPlayer:GetAreaId() ~= 3580 then
pUnit:GossipMenuAddItem(2, "Exodar", 1007, 0)
end
end

if pPlayer:GetPlayerLevel() >= 67 then
if pPlayer:GetAreaId() ~= 4553 then
pUnit:GossipMenuAddItem(2, "Dalaran", 1008, 0)
end
end

if pPlayer:GetPlayerLevel() >= 57 then
if pPlayer:GetAreaId() ~= 3703 then
pUnit:GossipMenuAddItem(2, "Shattrath", 1009, 0)
end
end

if pPlayer:GetPlayerLevel() >= 30 then
if pPlayer:GetAreaId() ~= 35 then
pUnit:GossipMenuAddItem(2, "Booty Bay", 1010, 0)
end

if pPlayer:GetAreaId() ~= 1741 then
pUnit:GossipMenuAddItem(2, "Gurubashi arena", 1011, 0)
end
end

pUnit:GossipMenuAddItem(3, "Eastern Kingdoms", 1012, 0)
pUnit:GossipMenuAddItem(3, "Kalimdor", 1013, 0)

if pPlayer:GetPlayerLevel() >= 58 then
pUnit:GossipMenuAddItem(3, "Outland", 1014, 0)
end

if pPlayer:GetPlayerLevel() >= 68 then
pUnit:GossipMenuAddItem(3, "Northrend", 1015, 0)
end

if pPlayer:GetPlayerLevel() >= 15 then
pUnit:GossipMenuAddItem(9, "Classic Dungeons", 1016, 0)
end

if pPlayer:GetPlayerLevel() >= 59 then
pUnit:GossipMenuAddItem(9, "BC Dungeons", 1017, 0)
end

if pPlayer:GetPlayerLevel() >= 69 then
pUnit:GossipMenuAddItem(9, "Wrath Dungeons", 1018, 0)
end

if pPlayer:GetPlayerLevel() >= 57 then
pUnit:GossipMenuAddItem(9, "Raid Teleports", 1019, 0)
end
pUnit:GossipSendMenu(pPlayer)
end

end


function Portal_Gob_gossip_select(pUnit, event, pPlayer, id, intid, code, pMisc)

if(intid == 1000) then
pPlayer:Teleport(1, 1601.08, -4378.69, 9.9846, 2.14362)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1001) then
pPlayer:Teleport(0, 1633.75, 240.167, -43.1034, 6.26128)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1002) then
pPlayer:Teleport(1, -1274.45, 71.8601, 128.159, 2.80623)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1003) then
pPlayer:Teleport(530, 9738.28, -7454.19, 13.5605, 0.043914)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1004) then
pPlayer:Teleport(0, -8842.09, 626.358, 94.0867, 3.61363)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1005) then
pPlayer:Teleport(1, 9869.91, 2493.58, 1315.88, 2.78897)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1006) then
pPlayer:Teleport(0, -4919.94, -982.083, 501.46, 5.12894)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1007) then
pPlayer:Teleport(530, -3864.92, -11643.7, -137.644, 5.50862)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1008) then
pPlayer:Teleport(571, 5809.55, 503.975, 657.526, 2.38338)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1009) then
pPlayer:Teleport(530, -1887.62, 5359.09, -12.4279, 4.40435)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1010) then
pPlayer:Teleport(0, -14281.9, 552.564, 8.90422, 0.860144)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1011) then
pPlayer:Teleport(0, -13283.1328, 128.3659, 25.953, 1.18013)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1012) then
pUnit:GossipCreateMenu(300004, pPlayer, 0)


if(pPlayer:GetTeam() == 1)then

pUnit:GossipMenuAddItem(2, "Eversong Woods", 1021, 0)

pUnit:GossipMenuAddItem(2, "Tirisfal Glades", 1023, 0)

if pPlayer:GetPlayerLevel() >= 10 then
pUnit:GossipMenuAddItem(2, "Ghostlands", 1024, 0)

pUnit:GossipMenuAddItem(2, "Silverpine Forest", 1026, 0)
end

end


if(pPlayer:GetTeam() == 0)then

pUnit:GossipMenuAddItem(2, "Elwynn Forest", 1020, 0)

pUnit:GossipMenuAddItem(2, "Dun Morogh", 1022, 0)

if pPlayer:GetPlayerLevel() >= 10 then
pUnit:GossipMenuAddItem(2, "Loch modan", 1025, 0)

pUnit:GossipMenuAddItem(2, "Westfall", 1027, 0)
end

if pPlayer:GetPlayerLevel() >= 15 then
pUnit:GossipMenuAddItem(2, "Redridge mountains", 1028, 0)
end

if pPlayer:GetPlayerLevel() >= 18 then
pUnit:GossipMenuAddItem(2, "Duskwood", 1029, 0)
end

if pPlayer:GetPlayerLevel() >= 20 then
pUnit:GossipMenuAddItem(2, "Wetlands", 1031, 0)
end

end


if pPlayer:GetPlayerLevel() >= 20 then
pUnit:GossipMenuAddItem(2, "Hillsbrad Foothills", 1030, 0)
end

if pPlayer:GetPlayerLevel() >= 30 then
pUnit:GossipMenuAddItem(2, "Alterac Mountains", 1032, 0)

pUnit:GossipMenuAddItem(2, "Arathi Highlands", 1033, 0)

pUnit:GossipMenuAddItem(2, "Stranglethorn Vale", 1034, 0)
end

if pPlayer:GetPlayerLevel() >= 35 then
pUnit:GossipMenuAddItem(2, "Badlands", 1035, 0)

pUnit:GossipMenuAddItem(2, "Swamp of Sorrows", 1036, 0)
end

if pPlayer:GetPlayerLevel() >= 40 then
pUnit:GossipMenuAddItem(2, "The Hinterlands", 1037, 0)
end

if pPlayer:GetPlayerLevel() >= 43 then
pUnit:GossipMenuAddItem(2, "Searing Gorge", 1038, 0)
end

if pPlayer:GetPlayerLevel() >= 45 then
pUnit:GossipMenuAddItem(2, "The Blasted Lands", 1039, 0)
end

if pPlayer:GetPlayerLevel() >= 50 then
pUnit:GossipMenuAddItem(2, "Burning Steppes", 1040, 0)
end

if pPlayer:GetPlayerLevel() >= 51 then
pUnit:GossipMenuAddItem(2, "Western Plaguelands", 1041, 0)
end

if pPlayer:GetPlayerLevel() >= 53 then
pUnit:GossipMenuAddItem(2, "Eastern Plaguelands", 1042, 0)
end

if pPlayer:GetPlayerLevel() >= 70 then
pUnit:GossipMenuAddItem(2, "Isle of Quel'Danas", 1043, 0)
end

pUnit:GossipMenuAddItem(7, "Back..", 9999, 0)
pUnit:GossipSendMenu(pPlayer)
end

if(intid == 1013) then
pUnit:GossipCreateMenu(300004, pPlayer, 0)


if(pPlayer:GetTeam() == 1) then

pUnit:GossipMenuAddItem(2, "Durotar", 1046, 0)

pUnit:GossipMenuAddItem(2, "Mulgore", 1047, 0)

if pPlayer:GetPlayerLevel() >= 10 then
pUnit:GossipMenuAddItem(2, "The Barrens", 1050, 0)
end

if pPlayer:GetPlayerLevel() >= 25 then
pUnit:GossipMenuAddItem(2, "Thousand Needles", 1053, 0)
end

end


if(pPlayer:GetTeam() == 0) then

pUnit:GossipMenuAddItem(2, "Azuremyst Isle", 1044, 0)

pUnit:GossipMenuAddItem(2, "Teldrassil", 1045, 0)

if pPlayer:GetPlayerLevel() >= 15 then
pUnit:GossipMenuAddItem(2, "Bloodmyst Isle", 1048, 0)
end

if pPlayer:GetPlayerLevel() >= 10 then
pUnit:GossipMenuAddItem(2, "Darkshore", 1049, 0)
end

end


if pPlayer:GetPlayerLevel() >= 15 then
pUnit:GossipMenuAddItem(2, "Stonetalon Mountains", 1051, 0)
end

if pPlayer:GetPlayerLevel() >= 18 then
pUnit:GossipMenuAddItem(2, "Ashenvale Forest", 1052, 0)
end

if pPlayer:GetPlayerLevel() >= 30 then
pUnit:GossipMenuAddItem(2, "Desolace", 1054, 0)
end

if pPlayer:GetPlayerLevel() >= 35 then
pUnit:GossipMenuAddItem(2, "Dustwallow Marsh", 1055, 0)
end

if pPlayer:GetPlayerLevel() >= 40 then
pUnit:GossipMenuAddItem(2, "Feralas", 1056, 0)

pUnit:GossipMenuAddItem(2, "Tanaris Desert", 1057, 0)
end

if pPlayer:GetPlayerLevel() >= 45 then
pUnit:GossipMenuAddItem(2, "Azshara", 1058, 0)
end

if pPlayer:GetPlayerLevel() >= 48 then
pUnit:GossipMenuAddItem(2, "Felwood", 1059, 0)

pUnit:GossipMenuAddItem(2, "Un'Goro Crater", 1060, 0)
end

if pPlayer:GetPlayerLevel() >= 55 then
pUnit:GossipMenuAddItem(2, "Silithus", 1061, 0)

pUnit:GossipMenuAddItem(2, "Winterspring", 1062, 0)
end

pUnit:GossipMenuAddItem(7, "Back..", 9999, 0)
pUnit:GossipSendMenu(pPlayer)
end

if(intid == 1014) then
pUnit:GossipCreateMenu(300004, pPlayer, 0)

if pPlayer:GetPlayerLevel() >= 58 then
pUnit:GossipMenuAddItem(2, "Hellfire Peninsula", 1063, 0)
end

if pPlayer:GetPlayerLevel() >= 60 then
pUnit:GossipMenuAddItem(2, "Zangarmarsh", 1064, 0)
end

if pPlayer:GetPlayerLevel() >= 62 then
pUnit:GossipMenuAddItem(2, "Terokkar Forest", 1065, 0)
end

if pPlayer:GetPlayerLevel() >= 64 then
pUnit:GossipMenuAddItem(2, "Nagrand", 1066, 0)
end

if pPlayer:GetPlayerLevel() >= 65 then
pUnit:GossipMenuAddItem(2, "Blade's Edge Mountains", 1067, 0)
end

if pPlayer:GetPlayerLevel() >= 67 then
pUnit:GossipMenuAddItem(2, "Netherstorm", 1068, 0)

pUnit:GossipMenuAddItem(2, "Shadowmoon Valley", 1069, 0)
end

pUnit:GossipMenuAddItem(7, "Back..", 9999, 0)
pUnit:GossipSendMenu(pPlayer)
end

if(intid == 1015) then
pUnit:GossipCreateMenu(300004, pPlayer, 0)

if pPlayer:GetPlayerLevel() >= 68 then
pUnit:GossipMenuAddItem(2, "Borean Tundra", 1070, 0)

pUnit:GossipMenuAddItem(2, "Howling Fjord", 1071, 0)
end

if pPlayer:GetPlayerLevel() >= 71 then
pUnit:GossipMenuAddItem(2, "Dragonblight", 1072, 0)
end

if pPlayer:GetPlayerLevel() >= 73 then
pUnit:GossipMenuAddItem(2, "Grizzly Hills", 1073, 0)
end

if pPlayer:GetPlayerLevel() >= 74 then
pUnit:GossipMenuAddItem(2, "Zul'Drak", 1074, 0)
end

if pPlayer:GetPlayerLevel() >= 76 then
pUnit:GossipMenuAddItem(2, "Sholazar Basin", 1075, 0)
end

if pPlayer:GetPlayerLevel() >= 77 then
pUnit:GossipMenuAddItem(2, "Crystalsong Forest", 1076, 0)

pUnit:GossipMenuAddItem(2, "Storm Peaks", 1077, 0)

pUnit:GossipMenuAddItem(2, "Icecrown", 1078, 0)

pUnit:GossipMenuAddItem(2, "Wintergrasp", 1079, 0)
end

pUnit:GossipMenuAddItem(7, "Back..", 9999, 0)
pUnit:GossipSendMenu(pPlayer)
end




if(intid == 1016) then
pUnit:GossipCreateMenu(300002, pPlayer, 0)

if(pPlayer:GetTeam() == 0) then

if pPlayer:GetPlayerLevel() >= 25 then
pUnit:GossipMenuAddItem(2, "Gnomeregan", 1080, 0)
end

if pPlayer:GetPlayerLevel() >= 17 then
pUnit:GossipMenuAddItem(2, "The Deadmines", 1081, 0)
end

if pPlayer:GetPlayerLevel() >= 22 then
pUnit:GossipMenuAddItem(2, "The Stockade", 1082, 0)
end

end

if(pPlayer:GetTeam() == 1) then

if pPlayer:GetPlayerLevel() >= 15 then
pUnit:GossipMenuAddItem(2, "Ragefire Chasm", 1083, 0)
end

if pPlayer:GetPlayerLevel() >= 34 then
pUnit:GossipMenuAddItem(2, "Razorfen Downs", 1084, 0)
end

if pPlayer:GetPlayerLevel() >= 24 then
pUnit:GossipMenuAddItem(2, "Razorfen Kraul", 1085, 0)
end

if pPlayer:GetPlayerLevel() >= 32 then
pUnit:GossipMenuAddItem(2, "Scarlet Monastery", 1086, 0)
end

if pPlayer:GetPlayerLevel() >= 18 then
pUnit:GossipMenuAddItem(2, "Shadowfang Keep", 1087, 0)
end

if pPlayer:GetPlayerLevel() >= 17 then
pUnit:GossipMenuAddItem(2, "Wailing Caverns", 1088, 0)
end

end


if pPlayer:GetPlayerLevel() >= 21 then
pUnit:GossipMenuAddItem(2, "Blackfathom Deeps", 1089, 0)
end

if pPlayer:GetPlayerLevel() >= 53 then
pUnit:GossipMenuAddItem(2, "Blackrock Depths", 1090, 0)
end

if pPlayer:GetPlayerLevel() >= 57 then
pUnit:GossipMenuAddItem(2, "Blackrock Spire", 1091, 0)
end

if pPlayer:GetPlayerLevel() >= 55 then
pUnit:GossipMenuAddItem(2, "Dire Maul", 1092, 0)
end

if pPlayer:GetPlayerLevel() >= 45 then
pUnit:GossipMenuAddItem(2, "Maraudon", 1093, 0)
end

if pPlayer:GetPlayerLevel() >= 55 then
pUnit:GossipMenuAddItem(2, "Scholomance", 1094, 0)

pUnit:GossipMenuAddItem(2, "Stratholme", 1095, 0)
end

if pPlayer:GetPlayerLevel() >= 47 then
pUnit:GossipMenuAddItem(2, "Sunken Temple", 1096, 0)
end

if pPlayer:GetPlayerLevel() >= 37 then
pUnit:GossipMenuAddItem(2, "Uldaman", 1097, 0)
end

if pPlayer:GetPlayerLevel() >= 35 then
pUnit:GossipMenuAddItem(2, "Zul'Farrak", 1098, 0)
end

pUnit:GossipMenuAddItem(7, "Back..", 9999, 0)
pUnit:GossipSendMenu(pPlayer)
end

if(intid == 1017) then
pUnit:GossipCreateMenu(300002, pPlayer, 0)

if pPlayer:GetPlayerLevel() >= 64 then
pUnit:GossipMenuAddItem(2, "Auchidoun", 1099, 0)
end

if pPlayer:GetPlayerLevel() >= 66 then
pUnit:GossipMenuAddItem(2, "Caverns of Time", 1100, 0)
end

if pPlayer:GetPlayerLevel() >= 62 then
pUnit:GossipMenuAddItem(2, "Coilfang Reservoir", 1101, 0)
end

if pPlayer:GetPlayerLevel() >= 59 then
pUnit:GossipMenuAddItem(2, "Hellfire Citadel", 1102, 0)
end

if pPlayer:GetPlayerLevel() >= 70 then
pUnit:GossipMenuAddItem(2, "Magisters' Terrace", 1103, 0)

pUnit:GossipMenuAddItem(2, "Tempest Keep", 1103, 0)
end

pUnit:GossipMenuAddItem(7, "Back..", 9999, 0)
pUnit:GossipSendMenu(pPlayer)
end

if(intid == 1018) then
pUnit:GossipCreateMenu(300002, pPlayer, 0)

if pPlayer:GetPlayerLevel() >= 73 then
pUnit:GossipMenuAddItem(2, "Azjol-Nerub", 1105, 0)
end

if pPlayer:GetPlayerLevel() >= 79 then
pUnit:GossipMenuAddItem(2, "The Culling of Stratholme", 1106, 0)

pUnit:GossipMenuAddItem(2, "Trial of the Champion", 1107, 0)
end

if pPlayer:GetPlayerLevel() >= 74 then
pUnit:GossipMenuAddItem(2, "Drak'Tharon Keep", 1108, 0)
end

if pPlayer:GetPlayerLevel() >= 71 then
pUnit:GossipMenuAddItem(2, "Gundrak", 1109, 0)
end

if pPlayer:GetPlayerLevel() >= 79 then
pUnit:GossipMenuAddItem(2, "Icecrown Citadel Dungeons", 1110, 0)
end

if pPlayer:GetPlayerLevel() >= 71 then
pUnit:GossipMenuAddItem(2, "The Nexus Dungeons", 1111, 0)
end

if pPlayer:GetPlayerLevel() >= 75 then
pUnit:GossipMenuAddItem(2, "The Violet Hold", 1112, 0)
end

if pPlayer:GetPlayerLevel() >= 79 then
pUnit:GossipMenuAddItem(2, "Halls of Lightning", 1113, 0)
end

if pPlayer:GetPlayerLevel() >= 77 then
pUnit:GossipMenuAddItem(2, "Halls of Stone", 1114, 0)
end

if pPlayer:GetPlayerLevel() >= 69 then
pUnit:GossipMenuAddItem(2, "Utgarde Keep", 1115, 0)
end

if pPlayer:GetPlayerLevel() >= 75 then
pUnit:GossipMenuAddItem(2, "Utgarde Pinnacle", 1116, 0)
end

pUnit:GossipMenuAddItem(7, "Back..", 9999, 0)
pUnit:GossipSendMenu(pPlayer)
end

if(intid == 1019) then
pUnit:GossipCreateMenu(300003, pPlayer, 0)

if pPlayer:GetPlayerLevel() >= 70 then
pUnit:GossipMenuAddItem(2, "Black Temple", 1117, 0)
end

if pPlayer:GetPlayerLevel() >= 60 then
pUnit:GossipMenuAddItem(2, "Blackwing Lair", 1118, 0)
end

if pPlayer:GetPlayerLevel() >= 70 then
pUnit:GossipMenuAddItem(2, "Hyjal Summit", 1119, 0)

pUnit:GossipMenuAddItem(2, "Serpentshrine Cavern", 1120, 0)
end

if pPlayer:GetPlayerLevel() >= 80 then
pUnit:GossipMenuAddItem(2, "Trial of the Crusader", 1121, 0)
end

if pPlayer:GetPlayerLevel() >= 70 then
pUnit:GossipMenuAddItem(2, "Gruul's Lair", 1122, 0)

pUnit:GossipMenuAddItem(2, "Magtheridon's Lair", 1123, 0)
end

if pPlayer:GetPlayerLevel() >= 80 then
pUnit:GossipMenuAddItem(2, "Icecrown Citadel", 1124, 0)
end

if pPlayer:GetPlayerLevel() >= 70 then
pUnit:GossipMenuAddItem(2, "Karazhan", 1125, 0)
end

if pPlayer:GetPlayerLevel() >= 60 then
pUnit:GossipMenuAddItem(2, "Molten Core", 1126, 0)
end

if pPlayer:GetPlayerLevel() >= 80 then
pUnit:GossipMenuAddItem(2, "Naxxramas", 1127, 0)

pUnit:GossipMenuAddItem(2, "Onyxia's Lair", 1128, 0)
end

if pPlayer:GetPlayerLevel() >= 60 then
pUnit:GossipMenuAddItem(2, "Ruins of Ahn'Qiraj", 1129, 0)
end

if pPlayer:GetPlayerLevel() >= 70 then
pUnit:GossipMenuAddItem(2, "Sunwell Plateau", 1130, 0)
end

if pPlayer:GetPlayerLevel() >= 67 then
pUnit:GossipMenuAddItem(2, "The Eye", 1131, 0)
end

if pPlayer:GetPlayerLevel() >= 60 then
pUnit:GossipMenuAddItem(2, "Temple of Ahn'Qiraj", 1132, 0)
end

if pPlayer:GetPlayerLevel() >= 80 then
pUnit:GossipMenuAddItem(2, "The Eye of Eternity", 1133, 0)

pUnit:GossipMenuAddItem(2, "The Obsidian Sanctum", 1134, 0)

pUnit:GossipMenuAddItem(2, "Ulduar", 1135, 0)

pUnit:GossipMenuAddItem(2, "Vault of Archavon", 1136, 0)
end

if pPlayer:GetPlayerLevel() >= 57 then
pUnit:GossipMenuAddItem(2, "Zul'Gurub", 1137, 0)
end

if(pPlayer:GetTeam() == 1) then
if pPlayer:GetPlayerLevel() >= 70 then
pUnit:GossipMenuAddItem(2, "Zul'Aman", 1138, 0)
end
end

pUnit:GossipMenuAddItem(7, "Back..", 9999, 0)
pUnit:GossipSendMenu(pPlayer)
end






if(intid == 9999) then -- Back to main menu
return Portal_Gob_gossip_hello(pUnit, event, pPlayer)
end








if(intid == 1020) then
pPlayer:Teleport(0, -9449.06, 64.8392, 56.3581, 3.07047)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1021) then
pPlayer:Teleport(530, 9024.37, -6682.55, 16.8973, 3.14131)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1022) then
pPlayer:Teleport(0, -5603.76, -482.704, 396.98, 5.23499)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1023) then
pPlayer:Teleport(0, 2274.95, 323.918, 34.1137, 4.24367)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1024) then
pPlayer:Teleport(530, 7595.73, -6819.6, 84.3718, 2.56561)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1025) then
pPlayer:Teleport(0, -5405.85, -2894.15, 341.972, 5.48238)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1026) then
pPlayer:Teleport(0, 505.126, 1504.63, 124.808, 1.77987)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1027) then
pPlayer:Teleport(0, -10684.9, 1033.63, 32.5389, 6.07384)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1028) then
pPlayer:Teleport(0, -9447.8, -2270.85, 71.8224, 0.283853)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1029) then
pPlayer:Teleport(0, -10531.7, -1281.91, 38.8647, 1.56959)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1030) then
pPlayer:Teleport(0, -385.805, -787.954, 54.6655, 1.03926)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1031) then
pPlayer:Teleport(0, -3517.75, -913.401, 8.86625, 2.60705)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1032) then
pPlayer:Teleport(0, 275.049, -652.044, 130.296, 0.502032)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1033) then
pPlayer:Teleport(0, -1581.45, -2704.06, 35.4168, 0.490373)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1034) then
pPlayer:Teleport(0, -11921.7, -59.544, 39.7262, 3.73574)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1035) then
pPlayer:Teleport(0, -6782.56, -3128.14, 240.48, 5.65912)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1036) then
pPlayer:Teleport(0, -10368.6, -2731.3, 21.6537, 5.29238)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1037) then
pPlayer:Teleport(0, 112.406, -3929.74, 136.358, 0.981903)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1038) then
pPlayer:Teleport(0, -6686.33, -1198.55, 240.027, 0.916887)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1039) then
pPlayer:Teleport(0, -11184.7, -3019.31, 7.29238, 3.20542)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1040) then
pPlayer:Teleport(0, -7979.78, -2105.72, 127.919, 5.10148)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1041) then
pPlayer:Teleport(0, 1743.69, -1723.86, 59.6648, 5.23722)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1042) then
pPlayer:Teleport(0, 2280.64, -5275.05, 82.0166, 4.7479)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1043) then
pPlayer:Teleport(530, 12806.5, -6911.11, 41.1156, 2.22935)
pPlayer:GossipComplete() --CHANGE
end







if(intid == 1044) then
pPlayer:Teleport(530, -4192.62, -12576.7, 36.7598, 1.62813)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1045) then
pPlayer:Teleport(1, 9889.03, 915.869, 1307.43, 1.9336)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1046) then
pPlayer:Teleport(1, 228.978, -4741.87, 10.1027, 0.416883)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1047) then
pPlayer:Teleport(1, -2473.87, -501.225, -9.42465, 0.6525)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1048) then
pPlayer:Teleport(530, -2095.7, -11841.1, 51.1557, 6.19288)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1049) then
pPlayer:Teleport(1, 6463.25, 683.986, 8.92792, 4.33534)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1050) then
pPlayer:Teleport(1, -575.772, -2652.45, 95.6384, 0.006469)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1051) then
pPlayer:Teleport(1, 1574.89, 1031.57, 137.442, 3.8013)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1052) then
pPlayer:Teleport(1, 1919.77, -2169.68, 94.6729, 6.14177)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1053) then
pPlayer:Teleport(1, -5375.53, -2509.2, -40.432, 2.41885)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1054) then
pPlayer:Teleport(1, -656.056, 1510.12, 88.3746, 3.29553)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1055) then
pPlayer:Teleport(1, -3350.12, -3064.85, 33.0364, 5.12666)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1056) then
pPlayer:Teleport(1, -4808.31, 1040.51, 103.769, 2.90655)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1057) then
pPlayer:Teleport(1, -6940.91, -3725.7, 48.9381, 3.11174)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1058) then
pPlayer:Teleport(1, 3117.12, -4387.97, 91.9059, 5.49897)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1059) then
pPlayer:Teleport(1, 3898.8, -1283.33, 220.519, 6.24307)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1060) then
pPlayer:Teleport(1, -6291.55, -1158.62, -258.138, 0.457099)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1061) then
pPlayer:Teleport(1, -6815.25, 730.015, 40.9483, 2.39066)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1062) then
pPlayer:Teleport(1, 6658.57, -4553.48, 718.019, 5.18088)
pPlayer:GossipComplete() --CHANGE
end








if(intid == 1063) then
pPlayer:Teleport(530, -207.335, 2035.92, 96.464, 1.59676)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1064) then
pPlayer:Teleport(530, -220.297, 5378.58, 23.3223, 1.61718)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1065) then
pPlayer:Teleport(530, -2266.23, 4244.73, 1.47728, 3.68426)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1066) then
pPlayer:Teleport(530, -1610.85, 7733.62, -17.2773, 1.33522)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1067) then
pPlayer:Teleport(530, 2029.75, 6232.07, 133.495, 1.30395)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1068) then
pPlayer:Teleport(530, 3271.2, 3811.61, 143.153, 3.44101)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1069) then
pPlayer:Teleport(530, -3681.01, 2350.76, 76.587, 4.25995)
pPlayer:GossipComplete() --CHANGE
end












if(intid == 1070) then
pPlayer:Teleport(571, 2954.24, 5379.13, 60.4538, 2.55544)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1071) then
pPlayer:Teleport(571, 682.848, -3978.3, 230.161, 1.54207)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1072) then
pPlayer:Teleport(571, 2678.17, 891.826, 4.37494, 0.101121)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1073) then
pPlayer:Teleport(571, 4017.35, -3403.85,290, 5.35431)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1074) then
pPlayer:Teleport(571, 5560.23, -3211.66, 371.709, 5.55055)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1075) then
pPlayer:Teleport(571, 5614.67, 5818.86, -69.722, 3.60807)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1076) then
pPlayer:Teleport(571, 5411.17, -966.37, 167.082, 1.57167)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1077) then
pPlayer:Teleport(571, 6120.46, -1013.89, 408.39, 5.12322)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1078) then
pPlayer:Teleport(571, 8323.28, 2763.5, 655.093, 2.87223)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1079) then
pPlayer:Teleport(571, 4522.23, 2828.01, 389.975, 0.215009)
pPlayer:GossipComplete() --CHANGE
end














if(intid == 1080) then
pPlayer:Teleport(0, -5163.54, 925.423, 257.181, 1.57423)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1081) then
pPlayer:Teleport(0, -11209.6, 1666.54, 24.6974, 1.42053)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1082) then
pPlayer:Teleport(0, -8799.15, 832.718, 97.6348, 6.04085)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1083) then
pPlayer:Teleport(1, 1811.78, -4410.5, -18.4704, 5.20165)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1084) then
pPlayer:Teleport(1, -4657.3, -2519.35, 81.0529, 4.54808)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1085) then
pPlayer:Teleport(1, -4470.28, -1677.77, 81.3925, 1.16302)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1086) then
pPlayer:Teleport(0, 2873.15, -764.523, 160.332, 5.10447)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1087) then
pPlayer:Teleport(0, -234.675, 1561.63, 76.8921, 1.24031)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1088) then
pPlayer:Teleport(1, -731.607, -2218.39, 17.0281, 2.78486)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1089) then
pPlayer:Teleport(1, 4249.99, 740.102, -25.671, 1.34062)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1090) then
pPlayer:Teleport(0, -7179.34, -921.212, 165.821, 5.09599)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1091) then
pPlayer:Teleport(0, -7527.05, -1226.77, 285.732, 5.29626)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1092) then
pPlayer:Teleport(1, -3520.14, 1119.38, 161.025, 4.70454)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1093) then
pPlayer:Teleport(1, -1421.42, 2907.83, 137.415, 1.70718)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1094) then
pPlayer:Teleport(0, 1269.64, -2556.21, 93.6088, 0.620623)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1095) then
pPlayer:Teleport(0, 3352.92, -3379.03, 144.782, 6.25978)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1096) then
pPlayer:Teleport(0, -10177.9, -3994.9, -111.239, 6.01885)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1097) then
pPlayer:Teleport(0, -6071.37, -2955.16, 209.782, 0.015708)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1098) then
pPlayer:Teleport(1, -6801.19, -2893.02, 9.00388, 0.158639)
pPlayer:GossipComplete() --CHANGE
end






if(intid == 1099) then
pPlayer:Teleport(530, -3324.49, 4943.45, -101.239, 4.63901)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1100) then
pPlayer:Teleport(1, -8369.65, -4253.11, -204.272, -2.70526)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1101) then
pPlayer:Teleport(530, 738.865, 6865.77, -69.4659, 6.27655)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1102) then
pPlayer:Teleport(530, -347.29, 3089.82, 21.394, 5.68114)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1103) then
pPlayer:Teleport(530, 12884.6, -7317.69, 65.5023, 4.799)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1104) then
pPlayer:Teleport(530, 3100.48, 1536.49, 190.3, 4.62226)
pPlayer:GossipComplete() --CHANGE
end






if(intid == 1105) then
pPlayer:Teleport(571, 3707.86, 2150.23, 36.76, 3.22)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1106) then
pPlayer:Teleport(1, -8756.39, -4440.68, -199.489, 4.66289)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1107) then
pPlayer:Teleport(571, 8590.95, 791.792, 558.235, 3.13127)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1108) then
pPlayer:Teleport(571, 4765.59, -2038.24, 229.363, 0.887627)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1109) then
pPlayer:Teleport(571, 6722.44, -4640.67, 450.632, 3.91123)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1110) then
pPlayer:Teleport(571, 5643.16, 2028.81, 798.274, 4.60242)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1111) then
pPlayer:Teleport(571, 3782.89, 6965.23, 105.088, 6.14194)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1112) then
pPlayer:Teleport(571, 5693.08, 502.588, 652.672, 4.0229)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1113) then
pPlayer:Teleport(571, 9136.52, -1311.81, 1066.29, 5.19113)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1114) then
pPlayer:Teleport(571, 8922.12, -1009.16, 1039.56, 1.57044)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1115) then
pPlayer:Teleport(571, 1203.41, -4868.59, 41.2486, 0.283237)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1116) then
pPlayer:Teleport(571, 1267.24, -4857.3, 215.764, 3.22768)
pPlayer:GossipComplete() --CHANGE
end






if(intid == 1117) then
pPlayer:Teleport(530, -3649.92, 317.469, 35.2827, 2.94285)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1118) then
pPlayer:Teleport(229, 152.451, -474.881, 116.84, 0.001073)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1119) then
pPlayer:Teleport(1, -8177.89, -4181.23, -167.552, 0.913338)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1120) then
pPlayer:Teleport(530, 797.855, 6865.77, -65.4165, 0.005938)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1121) then
pPlayer:Teleport(571, 8515.61, 714.153, 558.248, 1.57753)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1122) then
pPlayer:Teleport(530, 3530.06, 5104.08, 3.50861, 5.51117)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1123) then
pPlayer:Teleport(530, -336.411, 3130.46, -102.928, 5.20322)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1124) then
pPlayer:Teleport(571, 5855.22, 2102.03, 635.991, 3.57899)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1125) then
pPlayer:Teleport(0, -11118.9, -2010.33, 47.0819, 0.649895)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1126) then
pPlayer:Teleport(230, 1126.64, -459.94, -102.535, 3.46095)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1127) then
pPlayer:Teleport(571, 3668.72, -1262.46, 243.622, 4.785)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1128) then
pPlayer:Teleport(1, -4708.27, -3727.64, 54.5589, 3.72786)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1129) then
pPlayer:Teleport(1, -8409.82, 1499.06, 27.7179, 2.51868)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1130) then
pPlayer:Teleport(530, 12574.1, -6774.81, 15.0904, 3.13788)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1131) then
pPlayer:Teleport(530, 3088.49, 1381.57, 184.863, 4.61973)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1132) then
pPlayer:Teleport(1, -8240.09, 1991.32, 129.072, 0.941603)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1133) then
pPlayer:Teleport(571, 3784.17, 7028.84, 161.258, 5.79993)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1134) then
pPlayer:Teleport(571, 3472.43, 264.923, -120.146, 3.27923)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1135) then
pPlayer:Teleport(571, 9222.88, -1113.59, 1216.12, 6.27549)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1136) then
pPlayer:Teleport(571, 5453.72, 2840.79, 421.28, 0)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1137) then
pPlayer:Teleport(0, -11916.7, -1215.72, 92.289, 4.72454)
pPlayer:GossipComplete() --CHANGE
end

if(intid == 1138) then
pPlayer:Teleport(530, 6851.78, -7972.57, 179.242, 4.64691)
pPlayer:GossipComplete() --CHANGE
end
end

RegisterGameObjectEvent(GOBID, 4, "Portal_Gob_gossip_hello")
RegisterGOGossipEvent(GOBID, 2, "Portal_Gob_gossip_select")

-- # Portal Gob
-- # By Rochet2
-- # Downloaded from http://projectcode.zzl.org/
-- # Bugs and contact with E-mail: Rochet2@post.com
