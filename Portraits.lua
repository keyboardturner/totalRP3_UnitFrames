local addonName, TRP3_UnitFrames = ...;
local L = TRP3_UnitFrames.L;

local trpTarget = TRP3_UnitFrames.trpTarget;
local trpPlayer = TRP3_UnitFrames.trpPlayer;

TRP3_UnitFrames.PortraitThemes = {
	[1] = {
		ThemeName = L["Dragons"],
		Data = {
			{
				id = "rare",
				name = ITEM_QUALITY3_DESC,
				texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\uiunitframeboss2x",
				coords = {0.314453125, 0.001953125, 0.322265625, 0.630859375},
				size = {x = 80, y = 79},
				offset = {x = 8, y = -10},
			},
			{
				id = "rare-elite",
				name = ITEM_QUALITY3_DESC .. " " .. ELITE,
				texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\uiunitframeboss2x",
				coords = {0.77734375, 0.390625, 0.001953125, 0.318359375},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -10},
			},
			{
				id = "elite",
				name = ELITE,
				texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\uiunitframeboss2x",
				coords = {0.3125, 0.001953125, 0.634765625, 0.947265625},
				size = {x = 80, y = 79},
				offset = {x = 8, y = -10},
			},
			{
				id = "boss",
				name = BOSS,
				texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\uiunitframeboss2x",
				coords = {0.388671875, 0.001953125, 0.001953125, 0.318359375},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -10},
			},
		},
	},
	[2] = {
		ThemeName = L["LGBQT+"],
		Data = {
			{
				id = "agender",
				name = L["Agender"],
				texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_agender",
				coords = {.051, .437, .215, .845},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -10},
			},
			{
				id = "asexual",
				name = L["Asexual"],
				texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_asexual",
				coords = {.051, .437, .215, .845},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -10},
			},
			{
				id = "aroace",
				name = L["Aromantic Asexual"],
				texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_aroace",
				coords = {.051, .437, .215, .845},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -10},
			},
			{
				id = "bisexual",
				name = L["Bisexual"],
				texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_BiS",
				coords = {.051, .437, .215, .845},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -10},
			},
			{
				id = "enby",
				name = L["Non-Binary"],
				texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_enby",
				coords = {.051, .437, .215, .845},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -10},
			},
			{
				id = "gaym",
				name = L["Gay Male"],
				texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_gayM",
				coords = {.051, .437, .215, .845},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -10},
			},
			{
				id = "genderfluid",
				name = L["Genderfluid"],
				texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_genderfluid",
				coords = {.051, .437, .215, .845},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -10},
			},
			{
				id = "genderqueer",
				name = L["Genderqueer"],
				texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_genderqueer",
				coords = {.051, .437, .215, .845},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -10},
			},
			{
				id = "lesbian",
				name = L["Lesbian"],
				texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_lesbian",
				coords = {.051, .437, .215, .845},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -10},
			},
			{
				id = "transgender",
				name = L["Transgender"],
				texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_trans",
				coords = {.051, .437, .215, .845},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -10},
			},
			{
				id = "pansexual",
				name = L["Pansexual"],
				texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_pansexual",
				coords = {.051, .437, .215, .845},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -10},
			},
			{
				id = "rainbow",
				name = L["Rainbow"],
				texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_rainbow",
				coords = {.051, .437, .215, .845},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -10},
			},
			{
				id = "rainbowphilly",
				name = L["RainbowPhilly"],
				texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_philly",
				coords = {.051, .437, .215, .845},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -10},
			},
			{
				id = "rainbowgilbaker",
				name = L["RainbowGilBaker"],
				texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_gilbertbaker",
				coords = {.051, .437, .215, .845},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -10},
			},
			{
				id = "rainbowprogress",
				name = L["RainbowProgress"],
				texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_progress",
				coords = {.051, .437, .215, .845},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -10},
			},
		},
	},
	[3] = C_AddOns.IsAddOnLoaded("Narcissus") and {
		ThemeName = L["Narcissus"],
		Data = {
			{
				id = "NarciHexagonBorder",
				name = "Default",
				texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder.tga",
				coords = {-0.26, 0.93, 0, 1},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -8},
			},
			{
				id = "PortraitBorder",
				name = "Portrait Border",
				texture = "Interface\\AddOns\\Narcissus\\Art\\Widgets\\Portrait\\PortraitBorder.tga",
				coords = {-.17, 0.48, 0, .55},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -8},
			},
			{
				id = "NarciHexagonBorder-Artifact",
				name = "Artifact",
				texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Artifact.tga",
				coords = {-0.26, 0.93, 0, 1},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -8},
			},
			{
				id = "NarciHexagonBorder-Azerite",
				name = "Azerite",
				texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Azerite.tga",
				coords = {-0.26, 0.93, 0, 1},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -8},
			},
			{
				id = "NarciHexagonBorder-Black",
				name = "Black",
				texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Black.tga",
				coords = {-0.26, 0.93, 0, 1},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -8},
			},
			{
				id = "NarciHexagonBorder-BlackDragon",
				name = "Black Dragon",
				texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-BlackDragon.tga",
				coords = {-0.26, 0.93, 0, 1},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -8},
			},
			{
				id = "NarciHexagonBorder-Epic",
				name = ITEM_QUALITY6_DESC,
				texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Epic.tga",
				coords = {-0.26, 0.93, 0, 1},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -8},
			},
			{
				id = "NarciHexagonBorder-Heart",
				name = "Heart",
				texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Heart.tga",
				coords = {-0.26, 0.93, 0, 1},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -8},
			},
			{
				id = "NarciHexagonBorder-Heirloom",
				name = "Heirloom",
				texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Heirloom.tga",
				coords = {-0.26, 0.93, 0, 1},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -8},
			},
			{
				id = "NarciHexagonBorder-Legendary",
				name = ITEM_QUALITY5_DESC,
				texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Legendary.tga",
				coords = {-0.26, 0.93, 0, 1},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -8},
			},
			{
				id = "NarciHexagonBorder-NZoth",
				name = "N'Zoth",
				texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-NZoth.tga",
				coords = {-0.26, 0.93, 0, 1},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -8},
			},
			{
				id = "NarciHexagonBorder-Rare",
				name = ITEM_QUALITY3_DESC,
				texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Rare.tga",
				coords = {-0.26, 0.93, 0, 1},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -8},
			},
			{
				id = "NarciHexagonBorder-Special",
				name = "Special",
				texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Special.tga",
				coords = {-0.26, 0.93, 0, 1},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -8},
			},
			{
				id = "NarciHexagonBorder-Uncommon",
				name = ITEM_QUALITY2_DESC,
				texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Uncommon.tga",
				coords = {-0.26, 0.93, 0, 1},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -8},
			},
			{
				id = "NarciHexagonBorder-Void",
				name = "Void",
				texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Void.tga",
				coords = {-0.26, 0.93, 0, 1},
				size = {x = 99, y = 81},
				offset = {x = -10, y = -8},
			},
		},
	} or { ThemeName = L["Narcissus"], ThemeDesc = L["NotDetected"], Data = nil },
}


TRP3_UnitFrames.PortraitStyles = {};

for _, theme in ipairs(TRP3_UnitFrames.PortraitThemes) do
	if theme.Data then
		for _, styleData in ipairs(theme.Data) do
			TRP3_UnitFrames.PortraitStyles[styleData.id] = styleData;
		end
	end
end

local PlayerDragonFrame = CreateFrame("Frame", nil, PlayerFrame)
PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
PlayerDragonFrame:SetSize(99, 81)
PlayerDragonFrame.tex = PlayerDragonFrame:CreateTexture(nil, "ARTWORK", nil, 0)
PlayerDragonFrame.tex:SetAllPoints(PlayerDragonFrame)
PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\uiunitframeboss2x")
PlayerDragonFrame.tex:SetTexCoord(0.77734375, 0.390625, 0.001953125, 0.318359375)
PlayerDragonFrame.tex:SetVertexColor(1, 1, 1)
PlayerDragonFrame.mask = PlayerDragonFrame:CreateMaskTexture()
PlayerDragonFrame.mask:SetAllPoints(PlayerDragonFrame.tex)
PlayerDragonFrame.mask:SetTexture(nil)

TRP3_UnitFrames.PlayerDragonFrame = PlayerDragonFrame

function trpPlayer.SetVisible()
	if TRP3_UF_DB.Player.show then
		if trpPlayer.button then
			trpPlayer.button:Show();
		end
	else
		if trpPlayer.button then
			trpPlayer.button:Hide();
		end
	end
end

function trpTarget.SetVisible()
	if TRP3_UF_DB.Target.show then
		if trpTarget.button then
			trpTarget.button:Show();
		end
	else
		if trpTarget.button then
			trpTarget.button:Hide();
		end
	end
end

function trpPlayer.SetAsPortrait()
	local borderCfg = TRP3_UnitFrames.GetBorderConfig()

	if not borderCfg.show then
		PlayerDragonFrame:Hide();
		return;
	end

	local styleData = TRP3_UnitFrames.PortraitStyles[borderCfg.style]
	if not styleData then
		PlayerDragonFrame:Hide();
		return;
	end

	PlayerDragonFrame.tex:SetTexture(styleData.texture)
	PlayerDragonFrame.tex:SetTexCoord(unpack(styleData.coords))

	local w = styleData.size and styleData.size.x or 99
	local h = styleData.size and styleData.size.y or 81
	local ox = styleData.offset and styleData.offset.x or -10
	local oy = styleData.offset and styleData.offset.y or -10

	PlayerDragonFrame:SetSize(w, h)
	PlayerDragonFrame:ClearAllPoints()
	PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", ox, oy)

	PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)

	if borderCfg.color.custom then
		PlayerDragonFrame.tex:SetVertexColor(ColorMixin.GetRGBA(borderCfg.color));
	else
		PlayerDragonFrame.tex:SetVertexColor(1, 1, 1, 1);
	end

	PlayerDragonFrame:Show()
end
