-- this is an example/ default implementation for AP autotracking
-- it will use the mappings defined in item_mapping.lua and location_mapping.lua to track items and locations via thier ids
-- it will also load the AP slot data in the global SLOT_DATA, keep track of the current index of on_item messages in CUR_INDEX
-- addition it will keep track of what items are local items and which one are remote using the globals LOCAL_ITEMS and GLOBAL_ITEMS
-- this is useful since remote items will not reset but local items might
ScriptHost:LoadScript("scripts/ap_item_mapping.lua")
ScriptHost:LoadScript("scripts/ap_location_mapping.lua")

CUR_INDEX = -1
SLOT_DATA = nil
LOCAL_ITEMS = {}
GLOBAL_ITEMS = {}

function onClear(slot_data)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onClear, slot_data:\n%s", dump_table(slot_data)))
    end
    SLOT_DATA = slot_data
    CUR_INDEX = -1
	
	
    -- reset locations
    for _, v in pairs(LOCATION_MAPPING) do
        if v[1] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing location %s", v[1]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[1]:sub(1, 1) == "@" then
                    obj.AvailableChestCount = obj.ChestCount
                else
                    obj.Active = false
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
    -- reset items
    for _, v in pairs(ITEM_MAPPING) do
        if v[1] and v[2] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing item %s of type %s", v[1], v[2]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[2] == "toggle" then
                    obj.Active = false
                elseif v[2] == "progressive" then
                    obj.CurrentStage = 0
                    obj.Active = false
                elseif v[2] == "consumable" then
                    obj.AcquiredCount = 0
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: unknown item type %s for code %s", v[2], v[1]))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
    LOCAL_ITEMS = {}
    GLOBAL_ITEMS = {}
	
	for k, v in pairs(SETTINGS_MAPPING) do
		obj = Tracker:FindObjectForCode(v)

		local value = SLOT_DATA[k]
		
		print("-----------------------------------------------------------")
		print(k, value)
		print("-----------------------------------------------------------")
		
		if k == "goal" then
			if value == 0 then
				Tracker:FindObjectForCode("exploreCheck").Active = false
				Tracker:FindObjectForCode("classicCheck").Active = true
			elseif value == 1 then
				Tracker:FindObjectForCode("exploreCheck").Active = true
				Tracker:FindObjectForCode("classicCheck").Active = false
			end
		elseif k == "chestsPerStage" then
            Tracker:FindObjectForCode('@Explore/Abandoned Aqueduct Chest/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Abyssal Depths Chest/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Aphelian Sanctuary Chest/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Distant Roost (2) Chest/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Distant Roost Chest/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Rallypoint Delta Chest/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Scorched Acres Chest/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Siphoned Forest Chest/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sirens Call Chest/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sky Meadow Chest/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sulfur Pools Chest/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sundered Grove Chest/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Titanic Plains (2) Chest/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Titanic Plains Chest/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Wetland Aspect Chest/1').AvailableChestCount = value
		elseif k == "shrinesPerStage" then
            Tracker:FindObjectForCode('@Explore/Abandoned Aqueduct Shrine/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Abyssal Depths Shrine/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Aphelian Sanctuary Shrine/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Distant Roost (2) Shrine/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Distant Roost Shrine/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Rallypoint Delta Shrine/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Scorched Acres Shrine/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Siphoned Forest Shrine/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sirens Call Shrine/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sky Meadow Shrine/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sulfur Pools Shrine/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sundered Grove Shrine/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Titanic Plains (2) Shrine/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Titanic Plains Shrine/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Wetland Aspect Shrine/1').AvailableChestCount = value
		elseif k == "altarsPerStage" then	
            Tracker:FindObjectForCode('@Explore/Abandoned Aqueduct Newt Altar/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Abyssal Depths Newt Altar/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Aphelian Sanctuary Newt Altar/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Distant Roost (2) Newt Altar/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Distant Roost Newt Altar/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Rallypoint Delta Newt Altar/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Scorched Acres Newt Altar/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Siphoned Forest Newt Altar/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sirens Call Newt Altar/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sky Meadow Newt Altar/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sulfur Pools Newt Altar/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sundered Grove Newt Altar/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Titanic Plains (2) Newt Altar/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Titanic Plains Newt Altar/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Wetland Aspect Newt Altar/1').AvailableChestCount = value
		elseif k == "scannerPerStage" then	
            Tracker:FindObjectForCode('@Explore/Abandoned Aqueduct Radio Scanner/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Abyssal Depths Radio Scanner/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Aphelian Sanctuary Radio Scanner/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Distant Roost (2) Radio Scanner/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Distant Roost Radio Scanner/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Rallypoint Delta Radio Scanner/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Scorched Acres Radio Scanner/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Siphoned Forest Radio Scanner/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sirens Call Radio Scanner/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sky Meadow Radio Scanner/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sulfur Pools Radio Scanner/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sundered Grove Radio Scanner/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Titanic Plains (2) Radio Scanner/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Titanic Plains Radio Scanner/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Wetland Aspect Radio Scanner/1').AvailableChestCount = value
		elseif k == "scavengersPerStage" then	
            Tracker:FindObjectForCode('@Explore/Abandoned Aqueduct Scavenger/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Abyssal Depths Scavenger/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Aphelian Sanctuary Scavenger/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Distant Roost (2) Scavenger/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Distant Roost Scavenger/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Rallypoint Delta Scavenger/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Scorched Acres Scavenger/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Siphoned Forest Scavenger/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sirens Call Scavenger/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sky Meadow Scavenger/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sulfur Pools Scavenger/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sundered Grove Scavenger/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Titanic Plains (2) Scavenger/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Titanic Plains Scavenger/1').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Wetland Aspect Scavenger/1').AvailableChestCount = value
		elseif k == "totalLocations" then	
			Tracker:FindObjectForCode('@Classic/Item Pickup/ItemPickup').AvailableChestCount = value
			
		end
	end
		
end

-- called when an item gets collected
function onItem(index, item_id, item_name, player_number)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onItem: %s, %s, %s, %s, %s", index, item_id, item_name, player_number, CUR_INDEX))
    end
    if index <= CUR_INDEX then
        return
    end
    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index;
    local v = ITEM_MAPPING[item_id]
    if not v then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: could not find item mapping for id %s", item_id))
        end
        return
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: code: %s, type %s", v[1], v[2]))
    end
    if not v[1] then
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[2] == "toggle" then
            obj.Active = true
        elseif v[2] == "progressive" then
            if obj.Active then
                obj.CurrentStage = obj.CurrentStage + 1
            else
                obj.Active = true
            end
        elseif v[2] == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount + obj.Increment
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: unknown item type %s for code %s", v[2], v[1]))
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: could not find object for code %s", v[1]))
    end
end


--called when a location gets cleared
function onLocation(location_id, location_name)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onLocation: %s, %s", location_id, location_name))
    end
    local v = LOCATION_MAPPING[location_id]
    if not v and AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onLocation: could not find location mapping for id %s", location_id))
    end
    if not v[1] then
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[1]:sub(1, 1) == "@" then
            obj.AvailableChestCount = obj.AvailableChestCount - 1
        else
            obj.Active = true
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onLocation: could not find object for code %s", v[1]))
	end
end




-- add AP callbacks
-- un-/comment as needed
Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
-- Archipelago:AddScoutHandler("scout handler", onScout)
-- Archipelago:AddBouncedHandler("bounce handler", onBounce)
