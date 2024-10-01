function Zone1Access()
	local value = 
        Tracker:ProviderCountForCode("Distant Roost") +
        Tracker:ProviderCountForCode("Distant Roost (2)") +
        Tracker:ProviderCountForCode("Titanic Plains") +
        Tracker:ProviderCountForCode("Titanic Plains (2)") +
        Tracker:ProviderCountForCode("Siphoned Forest") +
        Tracker:ProviderCountForCode("Verdant Fall") 

	if (value > 0) and (Tracker:ProviderCountForCode("Stage 1") > 0) then
		return 1
	elseif (value > 0) and (Tracker:ProviderCountForCode("Progressive Stage") > 0) then
		return 1
    end
	
	return 0
end




function Zone2Access()
	local value = 
        Tracker:ProviderCountForCode("Abandoned Aqueduct") +
        Tracker:ProviderCountForCode("Wetland Aspect") +
        Tracker:ProviderCountForCode("Aphelian Sanctuary")
		
	if (value > 0) and (Tracker:ProviderCountForCode("Stage 2") > 0) then
		return 1
	elseif (value > 0) and (Tracker:ProviderCountForCode("Progressive Stage") > 1) then
		return 1
    end
	
	return 0
end

function Zone3Access()
    local value = 
        Tracker:ProviderCountForCode("Rallypoint Delta") +
        Tracker:ProviderCountForCode("Sulfur Pools") +
        Tracker:ProviderCountForCode("Scorched Acres")

	if (value > 0) and (Tracker:ProviderCountForCode("Stage 3") > 0) then
		return 1
	elseif (value > 0) and (Tracker:ProviderCountForCode("Progressive Stage") > 2) then
		return 1
    end
	
		return 0
end

function Zone4Access()
    local value = 
        Tracker:ProviderCountForCode("Abyssal Depths") +
        Tracker:ProviderCountForCode("Sirens Call") +
        Tracker:ProviderCountForCode("Sundered Grove")

	if (value > 0) and (Tracker:ProviderCountForCode("Stage 4") > 0) then
		return 1
	elseif (value > 0) and (Tracker:ProviderCountForCode("Progressive Stage") > 3) then
		return 1
    end
	
	return 0
end