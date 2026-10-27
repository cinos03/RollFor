RollFor = RollFor or {}
local m = RollFor

if m.PlayerInfo then return end

---@class PlayerInfo
---@field get_name fun(): string
---@field get_class fun(): string
---@field is_master_looter fun(): boolean
---@field is_leader fun(): boolean
---@field is_assistant fun(): boolean

local M = {}

---@param api table
function M.new( api )
  local function get_name()
    return api.UnitName( "player" )
  end

  local function get_class()
    return api.UnitClass( "player" )
  end

  local function is_master_looter()
    if not api.IsInGroup() then return false end

    local loot_method, party_id, raid_id = api.GetLootMethod()
    if loot_method ~= "master" then return false end

    if api.IsInRaid() then
      if not raid_id then return false end
      local name = api.GetRaidRosterInfo( raid_id )
      return name == get_name()
    end

    if party_id == 0 then return true end
    if not party_id then return false end

    return api.UnitName( "party" .. party_id ) == get_name()
  end

  local function is_leader()
    return api.UnitIsGroupLeader( "player" )
  end

  local function is_assistant()
    if not api.IsInRaid() then return false end
    local my_name = get_name()

    for i = 1, 40 do
      local name, rank = api.GetRaidRosterInfo( i )

      if name and name == my_name then
        return rank and rank > 0 or false
      end
    end
  end

  ---@type PlayerInfo
  return {
    get_name = get_name,
    get_class = get_class,
    is_master_looter = is_master_looter,
    is_leader = is_leader,
    is_assistant = is_assistant
  }
end

m.PlayerInfo = M
return M
