CitadelleRP.API.Fonts = CitadelleRP.API.Fonts or {}

function CitadelleRP.API:RespFontX(size) 
    return (size/1920)*ScrW() 
end

function CitadelleRP.API:RespFontY(weight  ) 
    return (weight/1080)*ScrH() 
end


function CitadelleRP.API:CreateFont(intSize,strType,intWeight)
    intSizee = CitadelleRP.API:RespFontX(intSize)
    intWeighte = CitadelleRP.API:RespFontY(intWeight or 500)

    local strFont = "CitadelleRP:Fonts:" .. strType .. ":" .. intSize .. ":" .. intWeight

    if !CitadelleRP.API.Fonts[strFont] then            
        surface.CreateFont(strFont,{
            font = strType,
            size = intSizee,
            weight = intWeighte
        })

        CitadelleRP.API.Fonts[strFont] = true 
    end

    return strFont
end



CitadelleRP.API.Fonts = {

    titre = CitadelleRP.API:CreateFont(40, "Righteous", 800),

    label2 = CitadelleRP.API:CreateFont(30, "Righteous", 500),
    label3 = CitadelleRP.API:CreateFont(25, "Righteous", 400),
    label4 = CitadelleRP.API:CreateFont(20, "Righteous", 300),

    button1 = CitadelleRP.API:CreateFont(40, "Righteous", 800),
    button2 = CitadelleRP.API:CreateFont(35, "Righteous", 700),
    button3 = CitadelleRP.API:CreateFont(30, "Righteous", 600),
    button4 = CitadelleRP.API:CreateFont(25, "Righteous", 500),
    button5 = CitadelleRP.API:CreateFont(20, "Righteous", 400),

    titleHUD = CitadelleRP.API:CreateFont(25, "Coolvetica Rg", 700),
    valueHUD = CitadelleRP.API:CreateFont(25, "Coolvetica Rg", 350),


    titleDoor = CitadelleRP.API:CreateFont(40, "Coolvetica Rg", 450),
    valueDoor = CitadelleRP.API:CreateFont(20, "Coolvetica Rg", 300),
    
}


function CitadelleRP.API:GetIcon(strType,intSize,unicode,tbl)
    strType = string.lower(strType)

    local tblFont = {
        size = intSize,
        weight = 500,
        extended = true
    }

    for k,v in pairs(tbl or {}) do
        tblFont[k] = v
    end

    if strType == "fas" || strType == "fa" then
        tblFont['font'] = "Font Awesome 5 Free Solid"
    elseif strType == "far" then
        tblFont['font'] = "Font Awesome 5 Free Regular"
    else
        return {text = "Type invalid", "Trebuchet18"}
    end

    local strFont = "GCore:Font:A:" .. strType .. ":" .. intSize

    if !tblFontsCreated[strFont..intSize] then        
        surface.CreateFont(strFont,tblFont)
        tblFontsCreated[strFont..intSize] = true 
    end

    return {
        text = utf8.char(tonumber("0x" .. unicode)),
        font = strFont
    }
end


function CitadelleRP.API:GetFont(font)


    local fonts = CitadelleRP.API.Fonts

    return fonts[font]

end

