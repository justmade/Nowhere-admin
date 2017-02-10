print(package.path)
local lapis = require("lapis")
local json = require("json.json")
local app = lapis.Application()
local capture_errors = require("lapis.application").capture_errors
local csrf = require "lapis.csrf"
local db    = require("lapis.db")
local Model   = require("lapis.db.model").Model
local Servers = Model:extend("servers")
local respond_to = require ("lapis.application").respond_to

local check_auth  = require "controller.check_auth"
local UserList      = require("controller.userlist")
local RoomInfo    = require("controller.room_info")
local Index       = require("controller.index")
local User        = require("controller.user")

local app = lapis.Application()
app:enable("etlua")
app.layout = require "views.layout"

app:before_filter(check_auth)

app:match("/", respond_to(Index))

app:post("/user/", function(self)
    db.query("set names utf8")
    ngx.req.read_body()
	-- print("self.params.ip %s",ngx.req.get_body_data())
    local body_data = json.decode(ngx.req.get_body_data())
    local host_ip = self.req.headers["X-Real-IP"] or self.req.remote_addr

    local onlineUsers = (body_data).users
    local roomInfo = (body_data).room
    local roomPlayerCounts = (body_data).roomNum

    Servers:create({
      ip = host_ip,
      online_users = json.encode(onlineUsers),
      room_info    = json.encode(roomInfo),
      room_counts  = json.encode(roomPlayerCounts),
      ts           = db.raw("now()"),
    })

    return {render = "index"}
end)

app:match("/userlist", UserList)

app:match("/user/search", respond_to(Index))

app:match("/roominfo", RoomInfo)
app:match("/checkuser/:userID", User)
return app
