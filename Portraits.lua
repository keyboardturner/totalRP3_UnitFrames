local addonName, TRP3_UnitFrames = ...;
local L = TRP3_UnitFrames.L;

local trpTarget = TRP3_UnitFrames.trpTarget;
local trpPlayer = TRP3_UnitFrames.trpPlayer;

local borderStyles = {
	["rare"] = {
		texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\uiunitframeboss2x",
		coords = {0.314453125, 0.001953125, 0.322265625, 0.630859375},
		size = {x = 80, y = 79},
		offset = {x = 8, y = -10},
	},
	["rare-elite"] = {
		texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\uiunitframeboss2x",
		coords = {0.77734375, 0.390625, 0.001953125, 0.318359375},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -10},
	},
	["elite"] = {
		texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\uiunitframeboss2x",
		coords = {0.3125, 0.001953125, 0.634765625, 0.947265625},
		size = {x = 80, y = 79},
		offset = {x = 8, y = -10},
	},
	["boss"] = {
		texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\uiunitframeboss2x",
		coords = {0.388671875, 0.001953125, 0.001953125, 0.318359375},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -10},
	},

	-- LGBTQ+
	["agender"] = {
		texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_agender",
		coords = {.051, .437, .215, .845},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -10},
	},
	["asexual"] = {
		texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_asexual",
		coords = {.051, .437, .215, .845},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -10},
	},
	["aroace"] = {
		texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_aroace",
		coords = {.051, .437, .215, .845},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -10},
	},
	["bisexual"] = {
		texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_BiS",
		coords = {.051, .437, .215, .845},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -10},
	},
	["enby"] = {
		texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_enby",
		coords = {.051, .437, .215, .845},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -10},
	},
	["gaym"] = {
		texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_gayM",
		coords = {.051, .437, .215, .845},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -10},
	},
	["genderfluid"] = {
		texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_genderfluid",
		coords = {.051, .437, .215, .845},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -10},
	},
	["genderqueer"] = {
		texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_genderqueer",
		coords = {.051, .437, .215, .845},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -10},
	},
	["lesbian"] = {
		texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_lesbian",
		coords = {.051, .437, .215, .845},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -10},
	},
	["transgender"] = {
		texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_trans",
		coords = {.051, .437, .215, .845},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -10},
	},
	["pansexual"] = {
		texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_pansexual",
		coords = {.051, .437, .215, .845},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -10},
	},
	["rainbow"] = {
		texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_rainbow",
		coords = {.051, .437, .215, .845},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -10},
	},
	["rainbowphilly"] = {
		texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_philly",
		coords = {.051, .437, .215, .845},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -10},
	},
	["rainbowgilbaker"] = {
		texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_gilbertbaker",
		coords = {.051, .437, .215, .845},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -10},
	},
	["rainbowprogress"] = {
		texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_progress",
		coords = {.051, .437, .215, .845},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -10},
	},

	--Narcissus
	["NarciHexagonBorder"] = {
		texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder.tga",
		coords = {-0.26, 0.93, 0, 1},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -8},
	},
	["NarciHexagonBorder-Artifact"] = {
		texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Artifact.tga",
		coords = {-0.26, 0.93, 0, 1},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -8},
	},
	["NarciHexagonBorder-Azerite"] = {
		texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Azerite.tga",
		coords = {-0.26, 0.93, 0, 1},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -8},
	},
	["NarciHexagonBorder-Black"] = {
		texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Black.tga",
		coords = {-0.26, 0.93, 0, 1},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -8},
	},
	["NarciHexagonBorder-BlackDragon"] = {
		texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-BlackDragon.tga",
		coords = {-0.26, 0.93, 0, 1},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -8},
	},
	["NarciHexagonBorder-Epic"] = {
		texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Epic.tga",
		coords = {-0.26, 0.93, 0, 1},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -8},
	},
	["NarciHexagonBorder-Heart"] = {
		texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Heart.tga",
		coords = {-0.26, 0.93, 0, 1},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -8},
	},
	["NarciHexagonBorder-Heirloom"] = {
		texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Heirloom.tga",
		coords = {-0.26, 0.93, 0, 1},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -8},
	},
	["NarciHexagonBorder-Legendary"] = {
		texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Legendary.tga",
		coords = {-0.26, 0.93, 0, 1},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -8},
	},
	["NarciHexagonBorder-NZoth"] = {
		texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-NZoth.tga",
		coords = {-0.26, 0.93, 0, 1},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -8},
	},
	["NarciHexagonBorder-Rare"] = {
		texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Rare.tga",
		coords = {-0.26, 0.93, 0, 1},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -8},
	},
	["NarciHexagonBorder-Special"] = {
		texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Special.tga",
		coords = {-0.26, 0.93, 0, 1},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -8},
	},
	["NarciHexagonBorder-Uncommon"] = {
		texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Uncommon.tga",
		coords = {-0.26, 0.93, 0, 1},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -8},
	},
	["NarciHexagonBorder-Void"] = {
		texture = "Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Void.tga",
		coords = {-0.26, 0.93, 0, 1},
		size = {x = 99, y = 81},
		offset = {x = -10, y = -8},
	},

};


TRP3_UnitFrames.BorderStyles = borderStyles;

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
	if TRP3_UF_DB.Player.show == true then
		trpPlayer:Show()
		if trpPlayer.button then trpPlayer.button:Show() end
	else
		trpPlayer:Hide()
		if trpPlayer.button then trpPlayer.button:Hide() end
	end
end

function trpPlayer.SetAsPortrait()
	if TRP3_UF_DB.Border.show ~= true then
		PlayerDragonFrame:Hide()
		return
	end

	local styleData = borderStyles[TRP3_UF_DB.Border.style]
	if not styleData then
		PlayerDragonFrame:Hide()
		return
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

	if TRP3_UF_DB.Border.colorBorderCustom == true then
		PlayerDragonFrame.tex:SetVertexColor(ColorMixin.GetRGBA(TRP3_UF_DB.Border.color))
	else
		PlayerDragonFrame.tex:SetVertexColor(1, 1, 1, 1)
	end

	PlayerDragonFrame:Show()
end
