local Model   = require("lapis.db.model").Model
local Servers = Model:extend("servers")
local json = require("json.json")

return function(self)
    require("lapis.db").query("set names utf8")
    self.page_title = "User"
    self.userID = self.params.userID
    print("self.userID",self.userID)
    local allData = Servers:select()
    local lastData = allData[#allData]
    self.userData = json.decode(lastData.online_users)or {}
    self.userData = self.userData[tonumber(self.userID)]
    return {render = "user"}
end
