script_name("toggable_badge_after_spawn")
script_author("Hyam - Inspired by Bear")
script_version("1.0.0")

require "moonloader"
require "sampfuncs"

local sampev = require "lib.samp.events"
local inicfg = require "inicfg"

-----------------------------------------------------
-- CONFIG
-----------------------------------------------------

local config_dir_path = getWorkingDirectory() .. "\\config\\"
if not doesDirectoryExist(config_dir_path) then createDirectory(config_dir_path) end

local config_file_path = config_dir_path .. "BadgeAfterSpawnHyam.ini"

config_dir_path = nil

local config_table

if doesFileExist(config_file_path) then
	config_table = inicfg.load(nil, config_file_path)
else
	local new_config = io.open(config_file_path, "w+")
	if new_config then
		new_config:write("Options = {\nisBadgeAfterSpawnEnabled = true\n}")
		new_config:close()
		config_table = inicfg.load(nil, config_file_path)
  	else
		sampAddChatMessage("--- {FFFFFF}Badge after Spawn by {AAAAFF}Hyam{FFFFFF}: Config file creation failed - contact the developer for help.", -1)
  	end
end


-----------------------------------------------------
-- MAIN
-----------------------------------------------------

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	sampAddChatMessage("--- {FFFFFF}Badge after Spawn (Toggable) v" .. script.this.version .. "by {AAAAFF}Hyam {FFFFFF}| Use {AAAAFF}/togbas {FFFFFF}to toggle.", -1)
	sampRegisterChatCommand("togbas", cmd)
	while true do
		wait(0)
	end
end

-----------------------------------------------------
-- API-SPECIFIC FUNCTIONS
-----------------------------------------------------

function sampev.onServerMessage(c, text)
	local result, msg = string.find(text, "Your hospital bill was paid for by your faction insurance.")
	if result and config_table.Options.isBadgeAfterSpawnEnabled then
		sampSendChat("/badge")
	end
end

-----------------------------------------------------
-- LOCALLY DECLARED FUNCTIONS
-----------------------------------------------------

local function cmd()
    
	config_table.Options.isBadgeAfterSpawnEnabled = not config_table.Options.isBadgeAfterSpawnEnabled
    
    if inicfg.save(config_table, config_file_path) then
        local status = config_table.Options.isBadgeAfterSpawnEnabled and "On" or "Off"
        sampAddChatMessage("*** {FFFFFF}Badge After Spawn: {AAAAFF}" .. status, -1)
    else
        sampAddChatMessage("--- {AAAAFF}Badge After Spawn: {FFFFFF}Badge toggle in config failed - contact the developer for help.", -1)
    end
end
