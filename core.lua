local addonName, TRP3_UnitFrames = ...;
local L = TRP3_UnitFrames.L;

TRP3_UnitFrames.trpTarget = CreateFrame("Frame")
TRP3_UnitFrames.trpPlayer = CreateFrame("Frame")

local defaultsTable = {
	Target = {
		show = true,
		position = 1,
		point = "CENTER",
		relativePoint =
		"BOTTOMLEFT",
		scale = 1.5,
		colorText = {r = 1, g = 1, b = 1, a = 1,},
		colorBack = {r = 0, g = 0, b = 0, a = 1,},
		colorTextCustom = false,
		colorTextClass = true,
		colorBackCustom = true,
		colorBackClass = false,
	},
	Player = {
		show = true,
		position = 1,
		point = "CENTER",
		relativePoint = "BOTTOMRIGHT",
		scale = 1.5,
		colorText = {r = 1, g = 1, b = 1, a = 1,},
		colorBack = {r = 0, g = 0, b = 0, a = 1,},
		colorTextCustom = false,
		colorTextClass = true,
		colorBackCustom = true,
		colorBackClass = false,
	},

	Border = {
		show = false,
		style = "rare-elite",
		color = {r = 1, g = 1, b = 1, a = 1, custom = false, class = false,},
		status = false,
	},

	Setting = {
		locked = true,
		charSpecific = false,
		NPCs = false,
		FullNamePlayer = true,
		FullNameTarget = true,
		UseTRPName = true,
	},

	CurrNotifier = {show = true,
		Border = {r = 1, g = 1, b = 1, a = 1, custom = true, class = false, style = "Interface\\Tooltips\\UI-Tooltip-Background", size = 8,},
		Backdrop = {r = 0, g = 0, b = 0, a = .7, custom = true, class = false, style = "Interface\\Tooltips\\UI-Tooltip-Border", size = 8, tile = false, inset = 3,},
		Text = {r = 1, g = 1, b = 1, custom = false, class = false,},
		Position = {x = 0, y = 0, width = 300, height = 100, scale = 1,},
	},

	SecondaryPower = {
		posX = 30-80,
		posY = 25,
		showModels = true,
	},
};


function TRP3_UnitFrames.SetColors()
	if TRP3_UF_DB.Target.colorTextCustom then
		TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetTextColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorText))
		if TRP3_UFRepTextDummyTarget then
			TRP3_UFRepTextDummyTarget:SetTextColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorText))
		end
		if TRP3_UFSettingsRepTextDummyTarget then
			TRP3_UFSettingsRepTextDummyTarget:SetTextColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorText))
		end
	end

	if TRP3_UF_DB.Target.colorBackCustom then
		TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorBack))
		if TRP3_UFRepDummyTarget then
			TRP3_UFRepDummyTarget:SetVertexColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorBack))
		end
		if TRP3_UFSettingsRepDummyTarget then
			TRP3_UFSettingsRepDummyTarget:SetVertexColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorBack))
		end
	end

	if TRP3_UF_DB.Player.colorTextCustom then
		PlayerName:SetTextColor(ColorMixin.GetRGBA(TRP3_UF_DB.Player.colorText))
		if TRP3_UFRepTextDummyPlayer then
			TRP3_UFRepTextDummyPlayer:SetTextColor(ColorMixin.GetRGBA(TRP3_UF_DB.Player.colorText))
		end
		if TRP3_UFSettingsRepTextDummyPlayer then
			TRP3_UFSettingsRepTextDummyPlayer:SetTextColor(ColorMixin.GetRGBA(TRP3_UF_DB.Player.colorText))
		end
	end

	if TRP3_UF_DB.Player.colorBackCustom then
		PlayerFrameReputationColor:SetVertexColor(ColorMixin.GetRGBA(TRP3_UF_DB.Player.colorBack))
		if TRP3_UFRepDummyPlayer then
			TRP3_UFRepDummyPlayer:SetVertexColor(ColorMixin.GetRGBA(TRP3_UF_DB.Player.colorBack))
		end
		if TRP3_UFSettingsRepDummyPlayer then
			TRP3_UFSettingsRepDummyPlayer:SetVertexColor(ColorMixin.GetRGBA(TRP3_UF_DB.Player.colorBack))
		end
	end
end

function TRP3_UnitFrames.updateSVs() -- the color picker really does not like the old settings, so the settings move to their own var
	if TRP3_UF_DB.Target.colorText.custom ~= nil or TRP3_UF_DB.Target.colorText.class ~= nil then
		TRP3_UF_DB.Target.colorTextCustom = TRP3_UF_DB.Target.colorText.custom
		TRP3_UF_DB.Target.colorTextClass = TRP3_UF_DB.Target.colorText.class
		TRP3_UF_DB.Target.colorText.custom = nil
		TRP3_UF_DB.Target.colorText.class = nil
	end
	if TRP3_UF_DB.Target.colorBack.custom ~= nil or TRP3_UF_DB.Target.colorBack.class ~= nil then
		TRP3_UF_DB.Target.colorBackCustom = TRP3_UF_DB.Target.colorBack.custom
		TRP3_UF_DB.Target.colorBackClass = TRP3_UF_DB.Target.colorBack.class
		TRP3_UF_DB.Target.colorBack.custom = nil
		TRP3_UF_DB.Target.colorBack.class = nil
	end
	if TRP3_UF_DB.Player.colorText.custom ~= nil or TRP3_UF_DB.Player.colorText.class ~= nil then
		TRP3_UF_DB.Player.colorTextCustom = TRP3_UF_DB.Player.colorText.custom
		TRP3_UF_DB.Player.colorTextClass = TRP3_UF_DB.Player.colorText.class
		TRP3_UF_DB.Player.colorText.custom = nil
		TRP3_UF_DB.Player.colorText.class = nil
	end
	if TRP3_UF_DB.Player.colorBack.custom ~= nil or TRP3_UF_DB.Player.colorBack.class ~= nil then
		TRP3_UF_DB.Player.colorBackCustom = TRP3_UF_DB.Player.colorBack.custom
		TRP3_UF_DB.Player.colorBackClass = TRP3_UF_DB.Player.colorBack.class
		TRP3_UF_DB.Player.colorBack.custom = nil
		TRP3_UF_DB.Player.colorBack.class = nil
	end
	if not TRP3_UF_DB.Target.colorText.a then TRP3_UF_DB.Target.colorText.a = 1 end
	if not TRP3_UF_DB.Player.colorText.a then TRP3_UF_DB.Player.colorText.a = 1 end
end

-- here, we just pass in the table containing our saved color config
function TRP3_UnitFrames.ShowColorPicker(configTable)
	local r, g, b, a = configTable.r, configTable.g, configTable.b, configTable.a;
	local function OnColorChanged()
		local newR, newG, newB = ColorPickerFrame:GetColorRGB();
		local newA = ColorPickerFrame:GetColorAlpha();
		configTable.r, configTable.g, configTable.b, configTable.a = newR, newG, newB, newA;
		TRP3_UnitFrames.SetColors()
	end
	local function OnCancel()
		configTable.r, configTable.g, configTable.b, configTable.a = r, g, b, a;
		TRP3_UnitFrames.SetColors()
	end
	local options = {
		swatchFunc = OnColorChanged,
		opacityFunc = OnColorChanged,
		cancelFunc = OnCancel,
		hasOpacity = a ~= nil,
		opacity = a,
		r = r, g = g, b = b,
	};
	ColorPickerFrame:SetupColorPickerAndShow(options);
end

local function onStart()
	if TRP3_UF_DB == nil then
		TRP3_UF_DB = CopyTable(defaultsTable)
	end

	if TRP3_UF_DB.Setting.FullNamePlayer == nil then TRP3_UF_DB.Setting.FullNamePlayer = defaultsTable.Setting.FullNamePlayer end
	if TRP3_UF_DB.Setting.FullNameTarget == nil then TRP3_UF_DB.Setting.FullNameTarget = defaultsTable.Setting.FullNameTarget end
	if TRP3_UF_DB.Setting.UseTRPName == nil then TRP3_UF_DB.Setting.UseTRPName = defaultsTable.Setting.UseTRPName end
	if TRP3_UF_DB.SecondaryPower == nil then TRP3_UF_DB.SecondaryPower = defaultsTable.SecondaryPower end

	TRP3_UnitFrames.updateSVs()

	if TRP3_UnitFrames.InitializeSettingsUI then
		TRP3_UnitFrames.InitializeSettingsUI()
	end

	if TRP3_UnitFrames.CheckSettings then
		TRP3_UnitFrames.CheckSettings()
	end

	local SETTINGS_PAGE_ID = "main_unitframesplugin";
	local SETTINGS_MENU_ID = "main_91_config_main_config_unitframesplugin";

	TRP3_API.navigation.page.registerPage({
		id = SETTINGS_PAGE_ID,
		frame = TRP3_UFSettingsFrame,
	});

	TRP3_API.navigation.menu.registerMenu({
		id = SETTINGS_MENU_ID,
		text = TRP3_API.utils.Oldgodify(L["PluginColored"]),
		isChildOf = "main_90_config",
		onSelected = function() TRP3_API.navigation.page.setPage(SETTINGS_PAGE_ID); end,
	});

	TRP3_API.RegisterCallback(TRP3_Addon, "REGISTER_DATA_UPDATED", function()
		local trpPlayer = TRP3_UnitFrames.trpPlayer
		local trpTarget = TRP3_UnitFrames.trpTarget
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
	end)
end

local totalRP3_UnitFrames = {
	["name"] = "Total RP 3: Unit Frames",
	["description"] = "Modifies the target and player frames to have some additional profile info.",
	["version"] = 3.5, -- Your version number
	["id"] = "trp3_unitframes", -- Your module ID
	["onStart"] = onStart, -- Your starting function
	["minVersion"] = 131, -- Whatever TRP3 minimum build you require, 131 is 11.0.0
};

TRP3_API.module.registerModule(totalRP3_UnitFrames);