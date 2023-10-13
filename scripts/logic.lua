function Zone1Access()
	local value = 
        Tracker:ProviderCountForCode("Distant Roost") +
        Tracker:ProviderCountForCode("Distant Roost (2)") +
        Tracker:ProviderCountForCode("Titanic Plains") +
        Tracker:ProviderCountForCode("Titanic Plains (2)") +
        Tracker:ProviderCountForCode("Siphoned Forest") 

	if (value > 0) then
		return 1
    end
	
	return 0
end




function Zone2Access()
	local value = 
        Tracker:ProviderCountForCode("Abandoned Aqueduct") +
        Tracker:ProviderCountForCode("Wetland Aspect") +
        Tracker:ProviderCountForCode("Aphelian Sanctuary")
		
	if (value > 0) then
		return 1
    end
	return 0
end

function Zone3Access()
    local value = 
        Tracker:ProviderCountForCode("Rallypoint Delta") +
        Tracker:ProviderCountForCode("Sulfur Pools") +
        Tracker:ProviderCountForCode("Scorched Acres")

	if (value > 0) then
		return 1
    end
	
	return 0
end

function Zone4Access()
    local value = 
        Tracker:ProviderCountForCode("Abyssal Depths") +
        Tracker:ProviderCountForCode("Sirens Call") +
        Tracker:ProviderCountForCode("Sundered Grove")

	if (value > 0 ) then
		return 1
    end
	
	return 0
end