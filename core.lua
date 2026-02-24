local addonName, TRP3_UnitFrames = ...;
local L = TRP3_UnitFrames.L;

TRP3_UnitFrames.trpTarget = CreateFrame("Frame")
TRP3_UnitFrames.trpPlayer = CreateFrame("Frame")

local defaultsTable = {
	Target = {
		show = true,
		position = 1,
		point = "CENTER",
		relativePoint = "BOTTOMLEFT",
		scale = 1.5,
		colorText = {r = 1, g = 1, b = 1, a = 1,},
		colorBack = {r = 0, g = 0, b = 0, a = 1,},
		colorTextCustom = false,
		colorTextClass = true,
		colorBackCustom = true,
		colorBackClass = false,
		nameWidth = 90,
		ringColor = {r = 1, g = 1, b = 1, a = 1,},
		ringColorCustom = false,
		frameTextureEnabled = false,
		frameTextureColor = {r = 1, g = 1, b = 1, a = 1,},
		frameTextureCustom = false,
		frameTextureClass = false,
		frameTextureTRP = false,
		showStatus = true,
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
		nameWidth = 96,
		ringColor = {r = 1, g = 1, b = 1, a = 1,},
		ringColorCustom = false,
		frameTextureEnabled = false,
		frameTextureColor = {r = 1, g = 1, b = 1, a = 1,},
		frameTextureCustom = false,
		frameTextureClass = false,
		frameTextureTRP = false,
		showStatus = true,
	},

	Border = {
		show = false,
		style = "rare-elite",
		color = {r = 1, g = 1, b = 1, a = 1, custom = false, class = false,},
		status = false,
	},

	ProfileBorders = {},

	Setting = {
		locked = true,
		charSpecific = false,
		NPCs = false,
		FullNamePlayer = true,
		FullNameTarget = true,
		UseTRPName = true,
		profileSpecificBorder = false,
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


local function ApplyRingColor(ring, colorTable, enabled)
	if not ring then return end
	if not colorTable then return end
	if enabled then
		ring:SetDesaturated(true);
		ring:SetVertexColor(colorTable.r, colorTable.g, colorTable.b, colorTable.a or 1);
	else
		ring:SetDesaturated(false);
		ring:SetVertexColor(1, 1, 1, 1);
	end
end

local STATUS_ICON_DISCONNECTED = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\DCd.png";
local STATUS_ICON_AFK = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\Away.png";
local STATUS_ICON_DND = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\Busy.png";

function TRP3_UnitFrames.UpdateStatusIcon(unit, tex, enabled)
	if not tex then return end
	if not enabled then
		tex:Hide();
		return
	end
	if not UnitIsConnected(unit) then
		tex:SetTexture(STATUS_ICON_DISCONNECTED);
		tex:Show();
	elseif UnitIsAFK(unit) then
		tex:SetTexture(STATUS_ICON_AFK);
		tex:Show();
	elseif UnitIsDND(unit) then
		tex:SetTexture(STATUS_ICON_DND);
		tex:Show();
	else
		tex:Hide();
	end
end

function TRP3_UnitFrames.GetBorderConfig()
	if TRP3_UF_DB.Setting.profileSpecificBorder and TRP3_API and TRP3_API.profile and TRP3_API.profile.getPlayerCurrentProfileID then
		local profileID = TRP3_API.profile.getPlayerCurrentProfileID();
		if profileID then
			if not TRP3_UF_DB.ProfileBorders[profileID] then
				TRP3_UF_DB.ProfileBorders[profileID] = CopyTable(TRP3_UF_DB.Border);
			end
			return TRP3_UF_DB.ProfileBorders[profileID];
		end
	end
	return TRP3_UF_DB.Border;
end

function TRP3_UnitFrames.SetColors()
	local TargetName = TargetFrame.TargetFrameContent.TargetFrameContentMain.Name;
	local ReputationColor = TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor;

	if TRP3_UF_DB.Target.colorTextCustom and TargetName then
		TargetName:SetTextColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorText))
		if TRP3_UFRepTextDummyTarget then
			TRP3_UFRepTextDummyTarget:SetTextColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorText))
		end
		if TRP3_UFSettingsRepTextDummyTarget then
			TRP3_UFSettingsRepTextDummyTarget:SetTextColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorText))
		end
	end

	if TRP3_UF_DB.Target.colorBackCustom and ReputationColor then
		ReputationColor:SetVertexColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorBack))
		if TRP3_UFRepDummyTarget then
			TRP3_UFRepDummyTarget:SetVertexColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorBack))
		end
		if TRP3_UFSettingsRepDummyTarget then
			TRP3_UFSettingsRepDummyTarget:SetVertexColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorBack))
		end
	end

	if TRP3_UF_DB.Player.colorTextCustom and PlayerName then
		PlayerName:SetTextColor(ColorMixin.GetRGBA(TRP3_UF_DB.Player.colorText))
		if TRP3_UFRepTextDummyPlayer then
			TRP3_UFRepTextDummyPlayer:SetTextColor(ColorMixin.GetRGBA(TRP3_UF_DB.Player.colorText))
		end
		if TRP3_UFSettingsRepTextDummyPlayer then
			TRP3_UFSettingsRepTextDummyPlayer:SetTextColor(ColorMixin.GetRGBA(TRP3_UF_DB.Player.colorText))
		end
	end

	if TRP3_UF_DB.Player.colorBackCustom and PlayerFrameReputationColor then
		PlayerFrameReputationColor:SetVertexColor(ColorMixin.GetRGBA(TRP3_UF_DB.Player.colorBack))
		if TRP3_UFRepDummyPlayer then
			TRP3_UFRepDummyPlayer:SetVertexColor(ColorMixin.GetRGBA(TRP3_UF_DB.Player.colorBack))
		end
		if TRP3_UFSettingsRepDummyPlayer then
			TRP3_UFSettingsRepDummyPlayer:SetVertexColor(ColorMixin.GetRGBA(TRP3_UF_DB.Player.colorBack))
		end
	end

	local trpPlayer = TRP3_UnitFrames.trpPlayer
	local trpTarget = TRP3_UnitFrames.trpTarget

	ApplyRingColor(
		trpPlayer.button and trpPlayer.button.ring,
		TRP3_UF_DB.Player.ringColor,
		TRP3_UF_DB.Player.ringColorCustom
	)
	ApplyRingColor(
		trpTarget.button and trpTarget.button.ring,
		TRP3_UF_DB.Target.ringColor,
		TRP3_UF_DB.Target.ringColorCustom
	)

	if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
	if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
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
	if TRP3_UF_DB.Player.ringColor == nil then TRP3_UF_DB.Player.ringColor = CopyTable(defaultsTable.Player.ringColor) end
	if TRP3_UF_DB.Player.ringColorCustom == nil then TRP3_UF_DB.Player.ringColorCustom = defaultsTable.Player.ringColorCustom end
	if TRP3_UF_DB.Target.ringColor == nil then TRP3_UF_DB.Target.ringColor = CopyTable(defaultsTable.Target.ringColor) end
	if TRP3_UF_DB.Target.ringColorCustom == nil then TRP3_UF_DB.Target.ringColorCustom = defaultsTable.Target.ringColorCustom end

	if TRP3_UF_DB.Player.frameTextureEnabled == nil then TRP3_UF_DB.Player.frameTextureEnabled = defaultsTable.Player.frameTextureEnabled end
	if TRP3_UF_DB.Player.frameTextureColor == nil then TRP3_UF_DB.Player.frameTextureColor = CopyTable(defaultsTable.Player.frameTextureColor) end
	if TRP3_UF_DB.Player.frameTextureCustom == nil then TRP3_UF_DB.Player.frameTextureCustom = defaultsTable.Player.frameTextureCustom end
	if TRP3_UF_DB.Player.frameTextureClass == nil then TRP3_UF_DB.Player.frameTextureClass = defaultsTable.Player.frameTextureClass end
	if TRP3_UF_DB.Player.frameTextureTRP == nil then TRP3_UF_DB.Player.frameTextureTRP = defaultsTable.Player.frameTextureTRP end
	if TRP3_UF_DB.Target.frameTextureEnabled == nil then TRP3_UF_DB.Target.frameTextureEnabled = defaultsTable.Target.frameTextureEnabled end
	if TRP3_UF_DB.Target.frameTextureColor == nil then TRP3_UF_DB.Target.frameTextureColor = CopyTable(defaultsTable.Target.frameTextureColor) end
	if TRP3_UF_DB.Target.frameTextureCustom == nil then TRP3_UF_DB.Target.frameTextureCustom = defaultsTable.Target.frameTextureCustom end
	if TRP3_UF_DB.Target.frameTextureClass == nil then TRP3_UF_DB.Target.frameTextureClass = defaultsTable.Target.frameTextureClass end
	if TRP3_UF_DB.Target.frameTextureTRP == nil then TRP3_UF_DB.Target.frameTextureTRP = defaultsTable.Target.frameTextureTRP end
	if TRP3_UF_DB.ProfileBorders == nil then TRP3_UF_DB.ProfileBorders = {} end
	
	if TRP3_UF_DB.Setting.profileSpecificBorder == nil then TRP3_UF_DB.Setting.profileSpecificBorder = defaultsTable.Setting.profileSpecificBorder end

	if TRP3_UF_DB.Player.showStatus == nil then TRP3_UF_DB.Player.showStatus = defaultsTable.Player.showStatus end
	if TRP3_UF_DB.Target.showStatus == nil then TRP3_UF_DB.Target.showStatus = defaultsTable.Target.showStatus end

	TRP3_UnitFrames.updateSVs()

	if TRP3_UnitFrames.InitializeSettingsUI then
		TRP3_UnitFrames.InitializeSettingsUI()
	end

	if TRP3_UnitFrames.CheckSettings then
		TRP3_UnitFrames.CheckSettings()
	end

	TRP3_UnitFrames.SetColors()

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
		if unitID == TRP3_API.globals.player_id or unitID == nil then
			if trpPlayer.SetAsPortrait then
				trpPlayer.SetAsPortrait();
			end
			if TRP3_UnitFrames.CheckSettings then
				TRP3_UnitFrames.CheckSettings();
			end
		end
	end)

	TRP3_UnitFrames.trpPlayer:RegisterEvent("PLAYER_FLAGS_CHANGED")
	TRP3_UnitFrames.trpPlayer:SetScript("OnEvent", function(_, event, unit)
		if event == "PLAYER_FLAGS_CHANGED" then
			local trpPlayer = TRP3_UnitFrames.trpPlayer
			local trpTarget = TRP3_UnitFrames.trpTarget
			if unit == "player" and trpPlayer.UpdateStatusIcon then
				trpPlayer.UpdateStatusIcon();
			elseif unit == "target" and trpTarget.UpdateStatusIcon then
				trpTarget.UpdateStatusIcon();
			end
		end
	end)
end

local totalRP3_UnitFrames = {
	["name"] = "Total RP 3: Unit Frames",
	["description"] = "Modifies the target and player frames to have some additional profile info.",
	["version"] = 4.001, -- Your version number
	["id"] = "trp3_unitframes", -- Your module ID
	["onStart"] = onStart, -- Your starting function
	["minVersion"] = 131, -- Whatever TRP3 minimum build you require, 131 is 11.0.0
};

TRP3_API.module.registerModule(totalRP3_UnitFrames);