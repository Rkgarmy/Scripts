local Scripts = {
	{
		PlacesIds = {2753915549, 4442272183, 7449423635},
		Path = "Games/BloxFruits.luau"
	}
}

local fetcher = {}
local urls = {}

urls.Owner = "https://raw.githubusercontent.com/rkgarmy/"
urls.Repository = urls.Owner .. "Scripts/refs/heads/main/"

function fetcher.get(url)
	local success, result = pcall(function()
		return game:HttpGet(url)
	end)

	if success then
		return result
	else
		error("Failed to fetch URL: " .. url)
	end
end

function fetcher.load(url)
	local raw = fetcher.get(url)
	local func, err = loadstring(raw)
	if func then
		return func
	else
		error("Syntax error at URL: " .. url .. "\n" .. tostring(err))
	end
end

local function isPlace(data)
	for _, id in pairs(data.PlacesIds) do
		if id == game.PlaceId then
			return true
		end
	end
	return false
end

for _, data in pairs(Scripts) do
	if isPlace(data) then
		return fetcher.load(urls.Repository .. data.Path)(fetcher, ...)
	end
end
