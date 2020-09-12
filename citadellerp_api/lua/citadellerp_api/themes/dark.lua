local TABLE = {}

TABLE.colors = {
    background = Color(20,20,20,200),
    primary =  Color(22,23,25),
    secondary =  Color(31,32,40),
    valid = Color(30,134,74),
    checkBoxColor = {default = color_white, to = Color(210,68,68)},
    buttonColor = {default = Color(31,32,36), to = Color(22,23,25)},

    outline = Color(250, 250, 250, 220),
    
    lightRed = Color(210,68,68),
    red = Color(134,45,30),
    blue = Color(37,99,143),
    lightBlue = Color(45,150,168),
    green = Color(30,134,74),
    lightGreen = Color(30,128,56),
    yellow = Color(177,179,32),
    lightYellow = Color(187,210,68),
    orange = Color(157,122,30),
    lightOrange = Color(210,130,68),
    pink = Color(179,32,103),
    lightPink = Color(210,68,140),
}


CitadelleRP.API.Themes:Add("dark",TABLE)
