CitadelleRP = CitadelleRP or {}
CitadelleRP.API = CitadelleRP.API or {}

CitadelleRP.API.DevMode = false

function CitadelleRP.API:AddFile(strPath,boolInclude)
    local files, folders = file.Find(strPath .. "*","LUA")
    
    for _,v in pairs(files or { }) do
        if boolInclude then
            include(strPath .. v)
        else
            AddCSLuaFile(strPath .. v)
        end
    end

    for _,v in pairs(folders) do
        self:AddFile(strPath .. v .. "/",boolInclude)
    end
end

if ( SERVER ) then
    -- Load Shared Files
   CitadelleRP.API:AddFile("citadellerp_api/shared/",true)
   CitadelleRP.API:AddFile("citadellerp_api/shared/",false)

    -- Load Server Files
   CitadelleRP.API:AddFile("citadellerp_api/server/",true)

    -- Load Client Files
   CitadelleRP.API:AddFile("citadellerp_api/client/",false)

    -- Load Themes Files
   CitadelleRP.API:AddFile("citadellerp_api/themes/",true)
   CitadelleRP.API:AddFile("citadellerp_api/themes/",false)

    print("--------------------------------------------------")
    print("||     CitadelleRP - LOAD | API BY TITOUNS      ||")
    print("--------------------------------------------------")

    return 
end

-- Load Shared Files
CitadelleRP.API:AddFile("citadellerp_api/shared/",true)

-- Load Client Files
CitadelleRP.API:AddFile("citadellerp_api/client/",true)

-- Load Themes Files
CitadelleRP.API:AddFile("citadellerp_api/themes/",true)