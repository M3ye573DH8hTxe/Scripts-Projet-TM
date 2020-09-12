local DATABASE = {}
DATABASE.host = "37.44.237.167"
DATABASE.username = "crp_server"
DATABASE.password = "mT4.Sc/BbMW#87<29j2M#xkT4t}h8:"
DATABASE.dbname = "crp_server_bdd"
DATABASE.useMysql = true

if ( DATABASE.useMysql ) then
    local boolSuccess, err = pcall(require, 'mysqloo')

    if !boolSuccess then
        return print('[CRP - FAMILY] - [MYSQL] : Mysql is not installed!')
    end    
    
    database = mysqloo.connect(DATABASE.host, DATABASE.username, DATABASE.password, DATABASE.dbname)
end

--[[
    desc: Replace query params
    return: string
]]--


function DATABASE:Replace(strQuery, strValue)
    local pattern = '?'

    if ( strValue == nil ) then
        strValue = 'NULL'
    end

    return string.gsub(strQuery, pattern, sql.SQLStr(strValue), 1)
end

--[[
    desc: Make prepare Query
    return: table
]]--

function DATABASE:Query(strQuery, tbl)
    if ( database == nil and self.useMysql ) then return end
    if strQuery == nil then return end

    if ( not self.useMysql ) then
        for k,v in ipairs(tbl or {}) do
            strQuery = self:Replace(strQuery, v)
        end 

        return sql.Query(strQuery), nil
    end

    local query = database:prepare(strQuery)

    function query:onSuccess(data) end

    function query:onAborted()
    end

    function query:onError(err)
        print("CRP - FAMILY [MYSQL] : ", err or "")
    end

    for k,v in ipairs(tbl or {}) do
        if( isnumber(v) ) then
            query:setNumber( k, v )
        end

        if( isstring(v) ) then
            query:setString( k, v )
        end

        if( isbool(v) ) then
            query:setBoolean( k, v )
        end
    end

    query:start()       

    query:wait()

    return query:getData(), query:lastInsert()
end

--[[
    desc: Create table on connect
    return: nil
]]--

function DATABASE:onConnected()
    local strQuery = [[
        CREATE TABLE IF NOT EXISTS `crp_family` (`name` VARCHAR(255) NOT NULL UNIQUE, `leader` VARCHAR(255) NOT NULL UNIQUE, `skins` LONGTEXT NOT NULL, `skin_leader` LONGTEXT NOT NULL, `members` LONGTEXT NOT NULL, `team_chief` VARCHAR(255) NOT NULL UNIQUE, `team_member` VARCHAR(255) NOT NULL UNIQUE );        
    ]]

    self:Query(strQuery)
end

if ( DATABASE.useMysql ) then
    database:connect()

    function database:onConnected()
        DATABASE:onConnected()
    end
else
    DATABASE:onConnected()
end


CitadelleRP.Family.SQL = DATABASE