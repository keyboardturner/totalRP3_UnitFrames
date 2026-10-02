local addonName, TRP3_UnitFrames = ...;
local L = TRP3_UnitFrames.L;

local trpPlayer = TRP3_UnitFrames.trpPlayer;

local PlayerRepFrame = CreateFrame("Frame", nil, PlayerFrame)
PlayerRepFrame:SetPoint("TOPRIGHT", PlayerFrame, "TOPRIGHT", -22, -26)
PlayerRepFrame:SetWidth(135)
PlayerRepFrame:SetHeight(18)
PlayerRepFrame.tex = PlayerRepFrame:CreateTexture("PlayerFrameReputationColor", "BACKGROUND", nil, 0)
PlayerRepFrame.tex:SetAllPoints(PlayerRepFrame)
PlayerRepFrame.tex:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Type")
PlayerRepFrame.tex:SetTexCoord(1, 0, 0, 1)
PlayerRepFrame.tex:SetVertexColor(0,0,0,1)

local playerStatus = CreateFrame("Frame", nil, PlayerFrame)
playerStatus:SetSize(22, 22)
playerStatus:SetPoint("CENTER", PlayerFrame.PlayerFrameContainer.PlayerPortrait, "TOP", 0, -15)
playerStatus:SetFrameStrata("MEDIUM")
playerStatus.Tex = playerStatus:CreateTexture(nil, "OVERLAY", nil, 7)
playerStatus.Tex:SetAllPoints()
playerStatus:Hide()
trpPlayer.status = playerStatus

function trpPlayer.UpdateStatusIcon()
	TRP3_UnitFrames.UpdateStatusIcon("player", trpPlayer.status, TRP3_UF_DB and TRP3_UF_DB.Player.showStatus);
end

function trpPlayer.UpdateInfo()
	if not (TRP3_API and TRP3_API.globals and TRP3_API.globals.player_realm_id) then return end;
	local playerClass = UnitClassBase("player");
	local playerGUID = UnitGUID("player");
	local playerNameString = UnitName("player");
	if issecretvalue(playerClass) or issecretvalue(playerGUID) or issecretvalue(playerNameString) then return end;
	if not playerClass or not playerGUID or not playerNameString or playerNameString == "" then return end;
	--local classR, classG, classB = C_ClassColor.GetClassColor(playerClass).r, C_ClassColor.GetClassColor(playerClass).g, C_ClassColor.GetClassColor(playerClass).b

	if PlayerName then
		if TRP3_UF_DB.Player.nameWidth then
			PlayerName:SetWidth(TRP3_UF_DB.Player.nameWidth);
		end

		local nameToSet = playerNameString;
		if TRP3_UF_DB.Setting.FullNamePlayer and TRP3_UF_DB.Setting.UseTRPName and TRP3_API and TRP3_API.globals and TRP3_API.globals.player_realm_id and TRP3_API.r.name("player") then
			nameToSet = TRP3_API.r.name("player");
		elseif not TRP3_UF_DB.Setting.FullNamePlayer and TRP3_UF_DB.Setting.UseTRPName and ( not issecretvalue(playerGUID) and AddOn_TotalRP3.Player.CreateFromGUID(playerGUID):GetFirstName() ) then
			nameToSet = AddOn_TotalRP3.Player.CreateFromGUID(playerGUID):GetFirstName();
		end

		TRP3_UnitFrames.SetText(PlayerName, PlayerFrame.bbfName, nameToSet);
		
		local textR, textG, textB, textA = TRP3_UnitFrames.ResolveColorPriority("player", TRP3_UF_DB.Player.colorTextPriority, {
			customEnabled = TRP3_UF_DB.Player.colorTextCustom,
			customColor = TRP3_UF_DB.Player.colorText,
			classEnabled = TRP3_UF_DB.Player.colorTextClass,
			trpEnabled = TRP3_UF_DB.Player.colorTextTRP ~= false,
			defaultColor = { r = 1, g = 0.896, b = 0, a = 1 },
		});

		TRP3_UnitFrames.ApplyTextColor(PlayerName, PlayerFrame.bbfName, textR, textG, textB, textA);
	end
	

	local backR, backG, backB, backA = TRP3_UnitFrames.ResolveColorPriority("player", TRP3_UF_DB.Player.colorBackPriority, {
		customEnabled = TRP3_UF_DB.Player.colorBackCustom,
		customColor = TRP3_UF_DB.Player.colorBack,
		classEnabled = TRP3_UF_DB.Player.colorBackClass,
		trpEnabled = TRP3_UF_DB.Player.colorBackTRP ~= false,
		defaultColor = { r = 0, g = 0, b = 0, a = 0 },
	});
	PlayerFrameReputationColor:SetVertexColor(backR, backG, backB, backA);

	local profileID = AddOn_TotalRP3.Player.CreateFromUnit("player"):GetProfileID();
	if not issecretvalue(AddOn_TotalRP3.Player.CreateFromUnit("player")) and profileID then
		local player1 = AddOn_TotalRP3.Player.CreateFromUnit("player")
		local icon = player1:GetCustomIcon() or "inv_inscription_scroll"

		if trpPlayer.button and trpPlayer.button.tex then
			trpPlayer.button.tex:SetTexture("Interface/icons/" .. icon)
			trpPlayer.button.tex:SetTexCoord(0, 1, 0, 1)
			if not trpPlayer.button.tex.TrpMask then
				trpPlayer.button.tex.TrpMask = trpPlayer.button:CreateMaskTexture();
				trpPlayer.button.tex.TrpMask:SetAtlas("UI-HUD-UnitFrame-Player-Portrait-Mask");
				trpPlayer.button.tex.TrpMask:SetAllPoints(trpPlayer.button.tex);
				trpPlayer.button.tex:AddMaskTexture(trpPlayer.button.tex.TrpMask);
			end
		end

		if TRP3_UF_DB.Player.relativePoint == "CENTER" then
			if trpPlayer.button then
				trpPlayer.button:Hide();
			end
			if trpPlayer.portraitClick then
				trpPlayer.portraitClick:Show();
			end
			PlayerFrame.PlayerFrameContainer.PlayerPortrait:SetTexture("Interface/icons/" .. icon);
			PlayerFrame.PlayerFrameContainer.PlayerPortrait:SetTexCoord(0, 1, 0, 1);
		else
			if not InCombatLockdown() then
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
			if trpPlayer.portraitClick then
				trpPlayer.portraitClick:Hide();
			end
			SetPortraitTexture(PlayerFrame.PlayerFrameContainer.PlayerPortrait, "player");
		end

		if trpPlayer.SetAsPortrait then
			trpPlayer.SetAsPortrait();
		end
		if trpPlayer.SetBackplate then
			trpPlayer.SetBackplate();
		end
	else
		if trpPlayer.button then
			trpPlayer.button:Hide();
		end
		if trpPlayer.portraitClick then
			trpPlayer.portraitClick:Hide();
		end
		SetPortraitTexture(PlayerFrame.PlayerFrameContainer.PlayerPortrait, "player");
	end

	local frameTex = PlayerFrame.PlayerFrameContainer.FrameTexture
	local altFrameTex = PlayerFrame.PlayerFrameContainer.AlternatePowerFrameTexture
	for _, tex in ipairs({ frameTex, altFrameTex }) do
		if tex then
			if TRP3_UF_DB.Player.frameTextureEnabled then
				tex:SetDesaturated(true);
				local r, g, b, a = TRP3_UnitFrames.ResolveColorPriority("player", TRP3_UF_DB.Player.frameTexturePriority, {
					customEnabled = TRP3_UF_DB.Player.frameTextureCustom,
					customColor = TRP3_UF_DB.Player.frameTextureColor,
					classEnabled = TRP3_UF_DB.Player.frameTextureClass,
					trpEnabled = TRP3_UF_DB.Player.frameTextureTRP,
					defaultColor = { r = 1, g = 1, b = 1, a = 1 },
				});
				tex:SetVertexColor(r, g, b, a);
			else
				tex:SetDesaturated(false);
				tex:SetVertexColor(1, 1, 1, 1);
			end
		end
	end

	trpPlayer.UpdateStatusIcon()
end

--this should cover the cases of resting a bit better than before, since it pulls from the actual blizz interface method
local function StatusTextureVisibility()
	if TRP3_UF_DB and TRP3_UF_DB.Border and TRP3_UF_DB.Border.status and IsResting() then
		PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Hide();
		--local PlayerRestLoop = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PlayerRestLoop;
		--PlayerRestLoop:Hide();
		--PlayerRestLoop.PlayerRestLoopAnim:Stop(); -- this is probably a bit overkill
	else
		PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Show();
	end
end

hooksecurefunc("PlayerFrame_UpdatePlayerRestLoop", function(state)
	if state then
		StatusTextureVisibility();
	end
end);