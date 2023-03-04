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
            Tracker:FindObjectForCode('@Explore/Abandoned Aqueduct/Chest').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Abyssal Depths/Chest').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Aphelian Sanctuary/Chest').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Distant Roost (2)/Chest').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Distant Roost/Chest').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Rallypoint Delta/Chest').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Scorched Acres/Chest').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Siphoned Forest/Chest').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sirens Call/Chest').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sky Meadow/Chest').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sulfur Pools/Chest').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sundered Grove/Chest').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Titanic Plains (2)/Chest').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Titanic Plains/Chest').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Wetland Aspect/Chest').AvailableChestCount = value
		elseif k == "shrinesPerStage" then
            Tracker:FindObjectForCode('@Explore/Abandoned Aqueduct/Shrine').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Abyssal Depths/Shrine').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Aphelian Sanctuary/Shrine').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Distant Roost (2)/Shrine').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Distant Roost/Shrine').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Rallypoint Delta/Shrine').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Scorched Acres/Shrine').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Siphoned Forest/Shrine').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sirens Call/Shrine').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sky Meadow/Shrine').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sulfur Pools/Shrine').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sundered Grove/Shrine').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Titanic Plains (2)/Shrine').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Titanic Plains/Shrine').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Wetland Aspect/Shrine').AvailableChestCount = value
		elseif k == "altarsPerStage" then	
            Tracker:FindObjectForCode('@Explore/Abandoned Aqueduct/Newt Altar').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Abyssal Depths/Newt Altar').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Aphelian Sanctuary/Newt Altar').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Distant Roost (2)/Newt Altar').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Distant Roost/Newt Altar').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Rallypoint Delta/Newt Altar').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Scorched Acres/Newt Altar').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Siphoned Forest/Newt Altar').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sirens Call/Newt Altar').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sky Meadow/Newt Altar').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sulfur Pools/Newt Altar').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sundered Grove/Newt Altar').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Titanic Plains (2)/Newt Altar').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Titanic Plains/Newt Altar').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Wetland Aspect/Newt Altar').AvailableChestCount = value
		elseif k == "scannerPerStage" then	
            Tracker:FindObjectForCode('@Explore/Abandoned Aqueduct/Radio Scanner').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Abyssal Depths/Radio Scanner').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Aphelian Sanctuary/Radio Scanner').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Distant Roost (2)/Radio Scanner').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Distant Roost/Radio Scanner').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Rallypoint Delta/Radio Scanner').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Scorched Acres/Radio Scanner').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Siphoned Forest/Radio Scanner').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sirens Call/Radio Scanner').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sky Meadow/Radio Scanner').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sulfur Pools/Radio Scanner').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sundered Grove/Radio Scanner').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Titanic Plains (2)/Radio Scanner').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Titanic Plains/Radio Scanner').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Wetland Aspect/Radio Scanner').AvailableChestCount = value
		elseif k == "scavengersPerStage" then	
            Tracker:FindObjectForCode('@Explore/Abandoned Aqueduct/Scavenger').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Abyssal Depths/Scavenger').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Aphelian Sanctuary/Scavenger').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Distant Roost (2)/Scavenger').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Distant Roost/Scavenger').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Rallypoint Delta/Scavenger').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Scorched Acres/Scavenger').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Siphoned Forest/Scavenger').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sirens Call/Scavenger').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sky Meadow/Scavenger').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sulfur Pools/Scavenger').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Sundered Grove/Scavenger').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Titanic Plains (2)/Scavenger').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Titanic Plains/Scavenger').AvailableChestCount = value
            Tracker:FindObjectForCode('@Explore/Wetland Aspect/Scavenger').AvailableChestCount = value
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
