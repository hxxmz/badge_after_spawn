require "moonloader"
require "sampfuncs"
local sampev = require "lib.samp.events"

script_name("toggable_badge_after_spawn")

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	sampAddChatMessage("--- {FFFFFF}Badge after Spawn (Toggable) by {AAAAFF}Hyam {FFFFFF}| Use {AAAAFF}/togbas {FFFFFF}to toggle.", -1)
	sampRegisterChatCommand("togbas", cmd)
	while true do
		wait(0)
	end
end

local toggle = false

function sampev.onServerMessage(c, text)
	local result, msg = string.find(text, "Your hospital bill was paid for by your faction insurance.")
	if result and toggle then
		sampSendChat("/badge")
	end
end

function cmd()
	toggle = not toggle
	if not toggle then
		sampAddChatMessage("*** {FFFFFF}Badge After Spawn: {AAAAFF}Off", -1)
	else 
		sampAddChatMessage("*** {FFFFFF}Badge After Spawn: {AAAAFF}On", -1)
	end
end