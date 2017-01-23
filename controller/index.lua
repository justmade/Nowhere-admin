local Model   = require("lapis.db.model").Model
local Servers = Model:extend("users")
local json = require("json.json")
local db    = require("lapis.db")
local menu = {
    "userlist","roominfo"
}

return function(self)
    db.query("set names utf8")
    self.page_title = "Index"
    self.menu = menu
    local allData = Servers:select()
    self.allData = allData
    -- self.userData = json.decode(lastData.online_users)or {}
    -- local allRooms = json.decode(lastData.room_info) or {}
    -- self.roomCounts = 0
    -- for i,room in ipairs(allRooms) do
    --     if room.snakeCount ~= 0 then
    --         self.roomCounts = self.roomCounts +1
    --     end
    -- end


    return {render = "index"}
end
