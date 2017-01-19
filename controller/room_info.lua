local Model   = require("lapis.db.model").Model
local Servers = Model:extend("servers")
local json = require("json.json")
return function(self)
    self.page_title = "RoomInfo"
    require("lapis.db").query("set names utf8")
    local allData = Servers:select()
    local lastData = allData[#allData]
    self.roomInfo = json.decode(lastData.room_info)or {}
	return { render = "roominfo" }
end
