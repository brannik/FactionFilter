local playerFaction = UnitFactionGroup("player")

-- Languages by faction
local allianceLangs = { "[Common]", "[Darnassian]", "[Dwarvish]", "[Gnomish]", "[Draenei]" }
local hordeLangs    = { "[Orcish]", "[Taurahe]", "[Troll]", "[Gutterspeak]", "[Thalassian]" }

-- Pick which set to block
local blockedLangs = (playerFaction == "Horde") and allianceLangs or hordeLangs

-- Check if a message should be blocked
local function IsBlocked(msg)
    for _, lang in ipairs(blockedLangs) do
        if msg:find(lang) then
            return true
        end
    end
    return false
end

-- Chat filter function
local function FilterChat(self, event, msg, ...)
    if IsBlocked(msg) then
        return true -- block it
    end
end

-- Apply only to channels where opposite faction spam can appear
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", FilterChat)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", FilterChat)
ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", FilterChat)
ChatFrame_AddMessageEventFilter("CHAT_MSG_TEXT_EMOTE", FilterChat)
