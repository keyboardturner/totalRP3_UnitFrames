--CHAT_MSG_ADDON
--PLAYER_TARGET_CHANGED
--UNIT_TARGET -- probably not this one
--TRP3_GlanceBarSlot1
--TargetFrame

--TRP3_API.loc.TF_OPEN_CHARACTER -- "show character page" tooltip
--TRP3_API.loc.CL_OPEN_PROFILE -- "Open profile"
--TRP3_API.loc.UNIT_POPUPS_OPEN_PROFILE -- "Open Profile"
--TRP3_API.loc.BINDING_NAME_TRP3_OPEN_TARGET_PROFILE -- "Open target profile"


--TargetFrame.TargetFrameContent.TargetFrameContentContextual

local trpTarget, trpPlayer
trpTarget = CreateFrame("Frame")
trpPlayer = CreateFrame("Frame")

function trpPlayer.fadeout()
	UIFrameFadeOut(trpPlayer.button, .5, trpPlayer.button:GetAlpha(), 0)
	print(trpPlayer.button:GetAlpha())
end
function trpPlayer.hide()
	trpPlayer.button:Hide()
end

function trpPlayer.fadein()
	UIFrameFadeIn(trpPlayer.button, .5, trpPlayer.button:GetAlpha(), 1)
end
function trpPlayer.show()
	trpPlayer.button:Show()
end

function trpTarget.nameChecker()
	if AddOn_TotalRP3.Player.CreateFromUnit("player"):GetProfileID() ~= nil then
		local player1 = AddOn_TotalRP3.Player.CreateFromUnit("player")
		local icon = player1:GetCustomIcon()
		--trpTarget.button:SetNormalTexture("Interface/icons/" .. icon)
		SetPortraitToTexture(trpPlayer.button.tex, "Interface/icons/" .. icon)
		trpPlayer.button:Show()
	else
		trpPlayer.button:Hide()
	end
	if UnitIsPlayer("target") == true and AddOn_TotalRP3.Player.CreateFromUnit("target"):GetProfileID() ~= nil then
		local textColorQ = AddOn_TotalRP3.Player.CreateFromUnit("target"):GetCustomColorForDisplay()
		if textColorQ ~= nil then
			textColorStuff = textColorQ:GenerateHexColor()
		else
			textColorStuff = "FFFFD100"
		end
		TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(1,1,1)
		TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetText("|c" .. textColorStuff .. TRP3_API.r.name("target") .. "|r")
		PlayerName:SetText(TRP3_API.r.name("player"))
		local player = AddOn_TotalRP3.Player.CreateFromUnit("target")
		local icon = player:GetCustomIcon()
		if icon == nil then
			icon = "inv_inscription_scroll"
		end
		--trpTarget.button:SetNormalTexture("Interface/icons/" .. icon)
		SetPortraitToTexture(trpTarget.button.tex, "Interface/icons/" .. icon)
		trpTarget.button:Show()
	else
		trpTarget.button:Hide()
	end
end

local function onStart()
	trpTarget:RegisterEvent("CHAT_MSG_ADDON")
	trpTarget:RegisterEvent("PLAYER_TARGET_CHANGED")
	trpTarget:RegisterEvent("UNIT_TARGET")

	trpTarget.button = CreateFrame("Button")
	trpTarget.button:SetPoint("CENTER", TargetFrame, "BOTTOMRIGHT", -48, 18)
	trpTarget.button:SetSize(14.3,14.3)
	trpTarget.button.tex = trpTarget.button:CreateTexture(nil, "ARTWORK", nil, 0)
	trpTarget.button.tex:SetAllPoints(trpTarget.button)
	trpTarget.button.tex:SetTexCoord(.08, .92, .08, .92)
	SetPortraitToTexture(trpTarget.button.tex)

	trpTarget.button:SetScript("OnMouseDown", function()
		trpTarget.button.tex:SetTexCoord(0, 1, 0, 1)
	end)
	trpTarget.button:SetScript("OnMouseUp", function()
		TRP3_API.slash.openProfile("target")
		trpTarget.button.tex:SetTexCoord(.08, .92, .08, .92)
	end)

	trpTarget.button.ring = trpTarget.button:CreateTexture(nil, "ARTWORK", nil, 1)
	trpTarget.button.ring:SetPoint("CENTER", trpTarget.button.tex, "CENTER", .8, -.8)
	trpTarget.button.ring:SetSize(20,20)
	trpTarget.button.ring:SetAtlas("bag-border")
	--trpTarget.button.ring:SetAtlas("communities-ring-gold")
	trpTarget.button:Hide()
	--PlayerName
	--C_ClassColor.GetClassColor(UnitClass("target")):GenerateHexColor() -- generates default class color

	trpPlayer:RegisterEvent("CHAT_MSG_ADDON")
	trpPlayer:RegisterEvent("PLAYER_TARGET_CHANGED")
	trpPlayer:RegisterEvent("UNIT_TARGET")
	trpPlayer:RegisterEvent("PLAYER_REGEN_DISABLED")
	trpPlayer:RegisterEvent("PLAYER_REGEN_ENABLED")


	trpPlayer.button = CreateFrame("Button")
	trpPlayer.button:SetPoint("CENTER", PlayerFrame, "BOTTOMLEFT", 48, 18)
	trpPlayer.button:SetSize(14.3,14.3)
	trpPlayer.button.tex = trpPlayer.button:CreateTexture(nil, "ARTWORK", nil, 0)
	trpPlayer.button.tex:SetAllPoints(trpPlayer.button)
	trpPlayer.button.tex:SetTexCoord(.08, .92, .08, .92)
	SetPortraitToTexture(trpPlayer.button.tex)

	trpPlayer.button:SetScript("OnMouseDown", function()
		trpPlayer.button.tex:SetTexCoord(0, 1, 0, 1)
	end)
	trpPlayer.button:SetScript("OnMouseUp", function()
		TRP3_API.slash.openProfile("player")
		trpPlayer.button.tex:SetTexCoord(.08, .92, .08, .92)
	end)

	trpPlayer.button.ring = trpPlayer.button:CreateTexture(nil, "ARTWORK", nil, 1)
	trpPlayer.button.ring:SetPoint("CENTER", trpPlayer.button.tex, "CENTER", .8, -.8)
	trpPlayer.button.ring:SetSize(20,20)
	trpPlayer.button.ring:SetAtlas("bag-border")
	--trpPlayer.button.ring:SetAtlas("communities-ring-gold")
	
	trpPlayer:SetScript("OnEvent", function(self, event)
		--print("firing function")
		if event == "PLAYER_REGEN_DISABLED" then
			print("entering combat")
			trpPlayer.fadeout()
			C_Timer.After(.5, trpPlayer.hide)
		elseif event == "PLAYER_REGEN_ENABLED" then
			print("exiting combat")
			trpPlayer.fadein()
			C_Timer.After(.5, trpPlayer.show)
		end
	end);

	trpTarget:SetScript("OnEvent", trpTarget.nameChecker)
	trpTarget.button:SetScript("OnEnter", function()
		GameTooltip_SetDefaultAnchor(GameTooltip, trpTarget)
		GameTooltip:ClearAllPoints()
		GameTooltip:AddLine(TRP3_API.loc.BINDING_NAME_TRP3_OPEN_TARGET_PROFILE, 1, 1, 1, 1);
		GameTooltip:SetPoint("BOTTOMLEFT", trpTarget.button, "TOPRIGHT", 0, 0);
		GameTooltip:Show()
	end)
	trpTarget.button:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)
	
	trpPlayer.button:SetScript("OnEnter", function()
		GameTooltip_SetDefaultAnchor(GameTooltip, trpPlayer)
		GameTooltip:ClearAllPoints()
		GameTooltip:AddLine(TRP3_API.loc.TF_OPEN_CHARACTER, 1, 1, 1, 1);
		GameTooltip:SetPoint("BOTTOMLEFT", trpPlayer.button, "TOPRIGHT", 0, 0);
		GameTooltip:Show()
	end)
	trpPlayer.button:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)
end


local totalRP3_Target = {
    ["name"] = "Total RP 3: Target",
    ["description"] = "Modifies the target frame to have some additional profile info.",
    ["version"] = 0.1, -- Your version number
    ["id"] = "trp3_target", -- Your module ID
    ["onStart"] = onStart, -- Your starting function
    ["minVersion"] = 108, -- Whatever TRP3 minimum build you require, 108 is the current one
};

TRP3_API.module.registerModule(totalRP3_Target);