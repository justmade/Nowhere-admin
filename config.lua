local config = require "lapis.config"

config("development", {
    code_cache = "off",
	site_name  = "Nowhere Admin Dev",
	port       = 9090,
	mysql      = {
        host = "127.0.0.1",
        port = "3306",
        user = "root",
        password = "sty",
        database = "nowhere",
	},
})

config("production", {
    code_cache = "on",
    site_name  = "Nowhere Admin",
    port       = 9090,
    mysql      = {
        host = "127.0.0.1",
        port = "3306",
        user = "root",
        password = "sty",
        database = "nowhere",
    },
})
