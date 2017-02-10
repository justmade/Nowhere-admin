local Model   = require("lapis.db.model").Model
local Servers = Model:extend("users")
local json = require("json.json")
local db    = require("lapis.db")
local menu = {
    "userlist","roominfo"
}

-- return Index
return {

    before = function (self)
        -- body...
    end,
    on_error = function(self)
        self.errormsg = "error message"
        return { render = "error"}
    end,
    POST = function(self)
        db.query("set names utf8")
        local name = "%"..self.params.searchname.."%"
        -- local _user = Servers:select("where id = ?",1)
        local allData = Servers:select()
        self.allData = allData
        self.page_title = "userinfo"
        for i,v in ipairs(self.allData) do
            if v.nick == self.params.searchname then
                self.userData = v
            end
        end
        -- ngx.say(_user.id)
        -- self.userData = _user

        if not self.userData then
            self.errormsg = "can't find user"
            return {render = "error"}
        end

        return { render = "user_info" }
    end,
    GET = function(self)
        db.query("set names utf8")
        self.page_title = "Index"
        self.menu = menu
        local allData = Servers:select()
        self.allData = allData
		return { render = "index" }
	end
}
