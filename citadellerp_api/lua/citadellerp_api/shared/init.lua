CitadelleRP.API.Themes = CitadelleRP.API.Themes or {}
CitadelleRP.API.Themes.List = CitadelleRP.API.Themes.List or {}

function CitadelleRP.API.Themes:Add(name,tbl)
    CitadelleRP.API.Themes.List[name] = tbl
end
function CitadelleRP.API.Themes:GetCurrent()
    return CitadelleRP.API.Themes.Selected
end

function CitadelleRP.API.Themes:CreateFont(intSize,strType,intWeight)
    return CitadelleRP.API:CreateFont(intSize,strType,intWeight)
end
CitadelleRP.API.Themes.Selected = "dark"