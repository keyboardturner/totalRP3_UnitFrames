local addonName, TRP3_UnitFrames = ...;
local L = TRP3_UnitFrames.L;

local trpTarget = TRP3_UnitFrames.trpTarget;
local trpPlayer = TRP3_UnitFrames.trpPlayer;

trpTarget.portraitClick = CreateFrame("Button")
trpTarget.portraitClick:SetParent(TargetFrame)
trpTarget.portraitClick:SetAllPoints(TargetFrame.TargetFrameContainer.Portrait)
trpTarget.portraitClick:SetFrameLevel(trpTarget.portraitClick:GetParent():GetFrameLevel() + 5)
trpTarget.portraitClick:Hide()

trpTarget.portraitClick:SetScript("OnEnter", function()
	GameTooltip_SetDefaultAnchor(GameTooltip, trpTarget)
	GameTooltip:ClearAllPoints()
	GameTooltip:AddLine(TRP3_API.loc.BINDING_NAME_TRP3_OPEN_TARGET_PROFILE, 1, 1, 1, 1)
	GameTooltip:SetPoint("BOTTOMLEFT", trpTarget.portraitClick, "TOPRIGHT", 0, 0)
	GameTooltip:Show()
end)
trpTarget.portraitClick:SetScript("OnLeave", function() GameTooltip:Hide() end)
trpTarget.portraitClick:SetScript("OnMouseDown", function()
	TargetFrame.TargetFrameContainer.Portrait:SetTexCoord(-0.02, 1.02, -0.02, 1.02)
end)
trpTarget.portraitClick:SetScript("OnMouseUp", function()
	TRP3_API.slash.openProfile("target")
	TargetFrame.TargetFrameContainer.Portrait:SetTexCoord(0, 1, 0, 1)
end)

local TarWidth = TargetFrame.TargetFrameContainer.Portrait:GetWidth()
local TarHeight = TargetFrame.TargetFrameContainer.Portrait:GetHeight()
trpTarget.button = CreateFrame("Button")
trpTarget.button:SetPoint("CENTER", TargetFrame.TargetFrameContainer.Portrait, "BOTTOMLEFT", TarWidth/12, TarHeight/12)
trpTarget.button:SetParent(TargetFrame)
trpTarget.button:SetSize(14.3, 14.3)
trpTarget.button:SetScale(TRP3_UF_DB and TRP3_UF_DB.Target.scale or 1.5)
trpTarget.button:SetFrameLevel(trpTarget.button:GetParent():GetFrameLevel() + 5)
trpTarget.button:Hide()

trpTarget.button.tex = trpTarget.button:CreateTexture(nil, "ARTWORK", nil, 0)
trpTarget.button.tex:SetAllPoints(trpTarget.button)
trpTarget.button.tex:SetTexCoord(.08, .92, .08, .92)

trpTarget.button.ring = trpTarget.button:CreateTexture(nil, "ARTWORK", nil, 1)
trpTarget.button.ring:SetPoint("CENTER", trpTarget.button.tex, "CENTER", .8, -.8)
trpTarget.button.ring:SetSize(20, 20)
trpTarget.button.ring:SetAtlas("bag-border")

trpTarget.button:SetScript("OnEnter", function()
	GameTooltip_SetDefaultAnchor(GameTooltip, trpTarget)
	GameTooltip:ClearAllPoints()
	GameTooltip:AddLine(TRP3_API.loc.BINDING_NAME_TRP3_OPEN_TARGET_PROFILE, 1, 1, 1, 1)
	GameTooltip:SetPoint("BOTTOMLEFT", trpTarget.button, "TOPRIGHT", 0, 0)
	GameTooltip:Show()
end)
trpTarget.button:SetScript("OnLeave", function() GameTooltip:Hide() end)
trpTarget.button:SetScript("OnMouseDown", function() trpTarget.button.tex:SetTexCoord(0, 1, 0, 1) end)
trpTarget.button:SetScript("OnMouseUp", function()
	TRP3_API.slash.openProfile("target")
	trpTarget.button.tex:SetTexCoord(.08, .92, .08, .92)
end)

function trpTarget.SetPos()
	if TRP3_UF_DB.Target.relativePoint == "CENTER" then
		if trpTarget.nameChecker then
			trpTarget.nameChecker()
		end
		return
	end

	SetPortraitTexture(TargetFrame.TargetFrameContainer.Portrait, "target")

	local xPos, yPos = 0, 0
	local pos = TRP3_UF_DB.Target.position
	
	if TRP3_UF_DB.Target.relativePoint == "TOPLEFT" then
		yPos, xPos = -5 * pos, 5 * pos
	elseif TRP3_UF_DB.Target.relativePoint == "BOTTOMLEFT" then
		yPos, xPos = 5 * pos, 5 * pos
	elseif TRP3_UF_DB.Target.relativePoint == "TOPRIGHT" then
		yPos, xPos = -5 * pos, -5 * pos
	elseif TRP3_UF_DB.Target.relativePoint == "BOTTOMRIGHT" then
		yPos, xPos = 5 * pos, -5 * pos
	end
	
	trpTarget.button:ClearAllPoints()
	trpTarget.button:SetPoint("CENTER", TargetFrame.TargetFrameContainer.Portrait, TRP3_UF_DB.Target.relativePoint, xPos, yPos)

	if trpTarget.nameChecker then
		trpTarget.nameChecker()
	end
end

trpPlayer.portraitClick = CreateFrame("Button")
trpPlayer.portraitClick:SetParent(PlayerFrame)
trpPlayer.portraitClick:SetAllPoints(PlayerFrame.PlayerFrameContainer.PlayerPortrait)
trpPlayer.portraitClick:SetFrameLevel(trpPlayer.portraitClick:GetParent():GetFrameLevel() + 5)
trpPlayer.portraitClick:Hide()

trpPlayer.portraitClick:SetScript("OnEnter", function()
	GameTooltip_SetDefaultAnchor(GameTooltip, trpPlayer)
	GameTooltip:ClearAllPoints()
	GameTooltip:AddLine(TRP3_API.loc.TF_OPEN_CHARACTER, 1, 1, 1, 1)
	GameTooltip:SetPoint("BOTTOMLEFT", trpPlayer.portraitClick, "TOPRIGHT", 0, 0)
	GameTooltip:Show()
end)
trpPlayer.portraitClick:SetScript("OnLeave", function() GameTooltip:Hide() end)
trpPlayer.portraitClick:SetScript("OnMouseDown", function()
	PlayerFrame.PlayerFrameContainer.PlayerPortrait:SetTexCoord(-0.02, 1.02, -0.02, 1.02)
end)
trpPlayer.portraitClick:SetScript("OnMouseUp", function()
	TRP3_API.slash.openProfile("player")
	PlayerFrame.PlayerFrameContainer.PlayerPortrait:SetTexCoord(0, 1, 0, 1)
end)

local PlayWidth = PlayerFrame.PlayerFrameContainer.PlayerPortrait:GetWidth()
local PlayHeight = PlayerFrame.PlayerFrameContainer.PlayerPortrait:GetHeight()
trpPlayer.button = CreateFrame("Button")
trpPlayer.button:SetPoint("CENTER", PlayerFrame.PlayerFrameContainer.PlayerPortrait, "BOTTOMRIGHT", -PlayWidth/12, PlayHeight/12)
trpPlayer.button:SetParent(PlayerFrame)
trpPlayer.button:SetSize(14.3, 14.3)
trpPlayer.button:SetScale(TRP3_UF_DB and TRP3_UF_DB.Player.scale or 1.5)
trpPlayer.button:SetFrameLevel(trpPlayer.button:GetParent():GetFrameLevel() + 5)

trpPlayer.button.tex = trpPlayer.button:CreateTexture(nil, "ARTWORK", nil, 0)
trpPlayer.button.tex:SetAllPoints(trpPlayer.button)
trpPlayer.button.tex:SetTexCoord(.08, .92, .08, .92)

trpPlayer.button.ring = trpPlayer.button:CreateTexture(nil, "ARTWORK", nil, 1)
trpPlayer.button.ring:SetPoint("CENTER", trpPlayer.button.tex, "CENTER", .8, -.8)
trpPlayer.button.ring:SetSize(20, 20)
trpPlayer.button.ring:SetAtlas("bag-border")

trpPlayer.button:SetScript("OnEnter", function()
	GameTooltip_SetDefaultAnchor(GameTooltip, trpPlayer)
	GameTooltip:ClearAllPoints()
	GameTooltip:AddLine(TRP3_API.loc.TF_OPEN_CHARACTER, 1, 1, 1, 1)
	GameTooltip:SetPoint("BOTTOMLEFT", trpPlayer.button, "TOPRIGHT", 0, 0)
	GameTooltip:Show()
end)
trpPlayer.button:SetScript("OnLeave", function() GameTooltip:Hide() end)
trpPlayer.button:SetScript("OnMouseDown", function() trpPlayer.button.tex:SetTexCoord(0, 1, 0, 1) end)
trpPlayer.button:SetScript("OnMouseUp", function()
	TRP3_API.slash.openProfile("player")
	trpPlayer.button.tex:SetTexCoord(.08, .92, .08, .92)
end)

function trpPlayer.SetPos()
	if TRP3_UF_DB.Player.relativePoint == "CENTER" then
		if trpPlayer.UpdateInfo then
			trpPlayer.UpdateInfo()
		end
		return
	end

	SetPortraitTexture(PlayerFrame.PlayerFrameContainer.PlayerPortrait, "player")

	local xPos, yPos = 0, 0
	local pos = TRP3_UF_DB.Player.position
	
	if TRP3_UF_DB.Player.relativePoint == "TOPLEFT" then
		yPos, xPos = -5 * pos, 5 * pos
	elseif TRP3_UF_DB.Player.relativePoint == "BOTTOMLEFT" then
		yPos, xPos = 5 * pos, 5 * pos
	elseif TRP3_UF_DB.Player.relativePoint == "TOPRIGHT" then
		yPos, xPos = -5 * pos, -5 * pos
	elseif TRP3_UF_DB.Player.relativePoint == "BOTTOMRIGHT" then
		yPos, xPos = 5 * pos, -5 * pos
	end
	
	trpPlayer.button:ClearAllPoints()
	trpPlayer.button:SetPoint("CENTER", PlayerFrame.PlayerFrameContainer.PlayerPortrait, TRP3_UF_DB.Player.relativePoint, xPos, yPos)

	if trpPlayer.UpdateInfo then
		trpPlayer.UpdateInfo()
	end
end

local function CreateFadeAnimations(frameTable)
	frameTable.fadeGroupShow = frameTable.button:CreateAnimationGroup()
	frameTable.fadeGroupHide = frameTable.button:CreateAnimationGroup()

	frameTable.fadeIn = frameTable.fadeGroupShow:CreateAnimation("Alpha")
	frameTable.fadeIn:SetDuration(.5)
	frameTable.fadeIn:SetFromAlpha(0)
	frameTable.fadeIn:SetToAlpha(1)

	frameTable.fadeOut = frameTable.fadeGroupHide:CreateAnimation("Alpha")
	frameTable.fadeOut:SetDuration(.5)
	frameTable.fadeOut:SetFromAlpha(1)
	frameTable.fadeOut:SetToAlpha(0)
	frameTable.fadeOut:SetScript("OnFinished", function() frameTable.button:Hide() end)

	frameTable.ShowFadingFrame = function()
		frameTable.button:Show()
		frameTable.fadeGroupShow:Play()
	end

	frameTable.HideFadingFrame = function()
		frameTable.fadeGroupHide:Play()
	end
end

CreateFadeAnimations(trpPlayer)
CreateFadeAnimations(trpTarget)

local function StatusTextureVisibility()
	if TRP3_UF_DB and TRP3_UF_DB.Border.status and IsResting() then
		PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Hide();
	else
		PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Show();
	end
end

trpPlayer:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_REGEN_DISABLED" then
		trpPlayer.HideFadingFrame()
	elseif event == "PLAYER_UPDATE_RESTING" then
		StatusTextureVisibility()
	elseif event == "PLAYER_REGEN_ENABLED" then
		if AddOn_TotalRP3.Player.CreateFromUnit("player"):GetProfileID() ~= nil
		and TRP3_UF_DB.Player.relativePoint ~= "CENTER" then
			trpPlayer.ShowFadingFrame()
		end
	elseif event == "PLAYER_LOGOUT" then
		SetPortraitTexture(TargetFrame.TargetFrameContainer.Portrait, "target")
		SetPortraitTexture(PlayerFrame.PlayerFrameContainer.PlayerPortrait, "player")
	elseif event == "PLAYER_ENTERING_WORLD" then
		if trpPlayer.UpdateInfo then
			trpPlayer.UpdateInfo()
		end
		StatusTextureVisibility()
	else
		if trpTarget.UpdateInfo then
			trpTarget.UpdateInfo()
		end
		if trpPlayer.UpdateInfo then
			trpPlayer.UpdateInfo()
		end
	end
end)

trpTarget:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_REGEN_DISABLED" then
		trpTarget.HideFadingFrame()
	elseif event == "PLAYER_REGEN_ENABLED" then
		if UnitIsPlayer("target")
		and AddOn_TotalRP3.Player.CreateFromUnit("target"):GetProfileID() ~= nil
		and TRP3_UF_DB.Target.relativePoint ~= "CENTER" then
			trpTarget.ShowFadingFrame()
		end
	else
		if trpTarget.nameChecker then
			trpTarget.nameChecker()
		end
	end
end)

trpPlayer:RegisterEvent("PLAYER_TARGET_CHANGED")
trpPlayer:RegisterEvent("UNIT_TARGET")
trpPlayer:RegisterEvent("PLAYER_REGEN_DISABLED")
trpPlayer:RegisterEvent("PLAYER_REGEN_ENABLED")
trpPlayer:RegisterEvent("PLAYER_LOGOUT")
trpPlayer:RegisterEvent("PLAYER_ENTERING_WORLD")
trpPlayer:RegisterEvent("UNIT_FACTION")
trpPlayer:RegisterEvent("GROUP_ROSTER_UPDATE")
trpPlayer:RegisterEvent("PLAYER_ROLES_ASSIGNED")
trpPlayer:RegisterEvent("GUILD_PARTY_STATE_UPDATED")
trpPlayer:RegisterEvent("UNIT_AREA_CHANGED")
trpPlayer:RegisterEvent("UNIT_PHASE")
trpPlayer:RegisterEvent("CLIENT_SCENE_OPENED")
trpPlayer:RegisterEvent("CLIENT_SCENE_CLOSED")
trpPlayer:RegisterEvent("ZONE_CHANGED")
trpPlayer:RegisterEvent("PLAYER_UPDATE_RESTING")

trpTarget:RegisterEvent("PLAYER_TARGET_CHANGED")
trpTarget:RegisterEvent("UNIT_TARGET")
trpTarget:RegisterEvent("PLAYER_REGEN_DISABLED")
trpTarget:RegisterEvent("PLAYER_REGEN_ENABLED")