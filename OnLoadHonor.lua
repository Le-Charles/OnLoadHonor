function RpRanges()
	local rankbottom = 0
	local nextbottom = 0
	local rank = (UnitPVPRank("player")-4)
	
	if rank >= 3 then
		rankbottom = ((rank-3)*5000)+5000
		nextbottom = ((rank-2)*5000)+5000
	elseif rank==2 then
		rankbottom = 2000
		nextbottom = 5000
	else
		rankbottom = "15 Honor Kills"
		nextbottom = 2000
	end
	
	return rank, rankbottom, nextbottom
end

function RpDecay()
	local progress = GetPVPRankProgress("player")
	local _, rankbottom, _ = RpRanges()
	local rankpoints = rankbottom+(5000*progress)
	local decay = rankpoints*.2
	local delta = rankpoints-decay
	
	return decay 
end

function HonorInfo()
	local name, _ = UnitPVPName("player")
	local progress = GetPVPRankProgress("player")
	local decay = RpDecay()
	local rank, rankbottom, nextbottom = RpRanges()
	local rankpoints = rankbottom+(5000*progress)
	local nextweek = rankpoints-decay
	local tonext = nextbottom-nextweek
	DEFAULT_CHAT_FRAME:AddMessage("Greetings " .. name .. ".",0,.6,1)
	DEFAULT_CHAT_FRAME:AddMessage("You are |cffffffff"..round(progress*100,2).."%|r through rank |cffffffff"..rank..".|r",0,.6,1)
	DEFAULT_CHAT_FRAME:AddMessage("You have |cffffffff"..round(rankpoints,0).."|r ranking points and will lose |cffffffff"..round(decay,0).."|r to decay.",0,.6,1)
	DEFAULT_CHAT_FRAME:AddMessage("You will need to gain |cffffffff"..round(tonext,0).."|r ranking points for your next rank.  Happy hunting.",0,.6,1)
end

function round(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

local frame = CreateFrame("FRAME", "OnLoadHonorFrame")
frame:RegisterEvent("PLAYER_LOGIN")
local function eventHandler(self, event, ...)
 DEFAULT_CHAT_FRAME:AddMessage(HonorInfo() .. event)
end
frame:SetScript("OnEvent", eventHandler)
