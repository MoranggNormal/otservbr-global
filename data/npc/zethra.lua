local internalNpcName = "Zethra"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 471,
	lookHead = 79,
	lookBody = 45,
	lookLegs = 12,
	lookFeet = 94,
	lookAddons = 0
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{text = 'Come over here if you have to resupply!'}
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop =
{
	{ itemName = "backpack", clientId = 2854, buy = 10 },
	{ itemName = "bag", clientId = 2853, buy = 4 },
	{ itemName = "fishing rod", clientId = 3483, buy = 150, sell = 30 },
	{ itemName = "rope", clientId = 3003, buy = 50, sell = 8 },
	{ itemName = "scroll", clientId = 2815, buy = 5 },
	{ itemName = "scythe", clientId = 3453, buy = 12 },
	{ itemName = "shovel", clientId = 3457, buy = 10, sell = 2 },
	{ itemName = "torch", clientId = 2920, buy = 2 },
	{ itemName = "worm", clientId = 3492, buy = 1 }
}

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, inBackpacks, name, totalCost)
	npc:sellItem(player, itemId, amount, subType, true, inBackpacks, 2854)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Bought %ix %s for %i %s.", amount, name, totalCost, ItemType(npc:getCurrency()):getPluralName():lower()))
end

-- On sell npc shop message
npcType.onSellItem = function(npc, player, clientId, subtype, amount, name, totalCost)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end

-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType)
end

-- npcType registering the npcConfig table
npcType:register(npcConfig)
