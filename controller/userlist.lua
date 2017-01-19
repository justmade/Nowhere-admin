local Model   = require("lapis.db.model").Model
local Servers = Model:extend("servers")
local json = require("json.json")
return function(self)
    self.page_title = "UserList"
    require("lapis.db").query("set names utf8")
    local allData = Servers:select()
    local lastData = allData[#allData]
    self.userData = json.decode(lastData.online_users)or {}
	return { render = "userlist" }
end
