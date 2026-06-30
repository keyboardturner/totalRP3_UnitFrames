local addonName, TRP3_UnitFrames = ...;
local L = TRP3_UnitFrames.L;
local trpPlayer = TRP3_UnitFrames.trpPlayer;

TRP3_UnitFrames.BackplateThemes = {
	{
		ThemeName = L["DeathKnight"],
		Data = {
			{
				id = "swordrunes",
				name = L["BPStyle_SwordRunes"],
				texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\playerframe_DK2x2.png",
				coords = {-0.435, 1.365, -0.4, 1.1},
			},
			{
				id = "swordplain",
				name = L["BPStyle_SwordPlain"],
				texture = "Interface\\AddOns\\totalRP3_UnitFrames\\tex\\playerframe_DKx2.png",
				coords = {-.445, 1.375, -.43, 1.17},
			},
		},
	},
};

TRP3_UnitFrames.BackplateStyles = {};
for _, theme in ipairs(TRP3_UnitFrames.BackplateThemes) do
	if theme.Data then
		for _, styleData in ipairs(theme.Data) do
			TRP3_UnitFrames.BackplateStyles[styleData.id] = styleData;
		end
	end
end

local PlayerBackplateFrame = CreateFrame("Frame", nil, PlayerFrame);
PlayerBackplateFrame:SetPoint("CENTER", PlayerFrame, "CENTER", 0, 0);
PlayerBackplateFrame:SetSize(PlayerFrame:GetWidth()*2, PlayerFrame:GetHeight()*2);
PlayerBackplateFrame.tex = PlayerBackplateFrame:CreateTexture(nil, "ARTWORK", nil, 0);
PlayerBackplateFrame.tex:SetAllPoints(PlayerBackplateFrame);
PlayerBackplateFrame.tex:SetVertexColor(1, 1, 1);

TRP3_UnitFrames.PlayerBackplateFrame = PlayerBackplateFrame;

function trpPlayer.SetBackplate()
	local config = TRP3_UnitFrames.GetBackplateConfig();

	if config.show then
		PlayerBackplateFrame:Show();
		local styleData = TRP3_UnitFrames.BackplateStyles[config.style];
		if styleData then
			PlayerBackplateFrame.tex:SetTexture(styleData.texture);
			if styleData.coords then
				PlayerBackplateFrame.tex:SetTexCoord(unpack(styleData.coords)); 
			end
		end
	else
		PlayerBackplateFrame:Hide();
	end
end
