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
	local classR, classG, classB = C_ClassColor.GetClassColor(UnitClassBase("player")).r, C_ClassColor.GetClassColor(UnitClassBase("player")).g, C_ClassColor.GetClassColor(UnitClassBase("player")).b

	if PlayerName then
		if TRP3_UF_DB.Player.nameWidth then
			PlayerName:SetWidth(TRP3_UF_DB.Player.nameWidth);
		end

		if TRP3_UF_DB.Setting.FullNamePlayer and TRP3_UF_DB.Setting.UseTRPName and not issecretvalue(TRP3_API.r.name("player")) then
			PlayerName:SetText(TRP3_API.r.name("player"));
		elseif not TRP3_UF_DB.Setting.FullNamePlayer and TRP3_UF_DB.Setting.UseTRPName and ( not issecretvalue(UnitGUID("player")) and not issecretvalue(AddOn_TotalRP3.Player.CreateFromGUID(UnitGUID("player")):GetFirstName()) ) then
			PlayerName:SetText(AddOn_TotalRP3.Player.CreateFromGUID(UnitGUID("player")):GetFirstName());
		else
			PlayerName:SetText(UnitName("player"));
		end
		
		PlayerName:SetTextColor(1, 0.896, 0, 1)
		PlayerFrameReputationColor:SetVertexColor(0, 0, 0, 0)

		if TRP3_UF_DB.Player.colorTextClass then
			PlayerName:SetTextColor(classR, classG, classB);
		end
		
		local customColor = AddOn_TotalRP3.Player.CreateFromUnit("player"):GetCustomColorForDisplay()
		if not issecretvalue(customColor) and customColor then
			PlayerName:SetTextColor(customColor:GetRGB());
		end

		if TRP3_UF_DB.Player.colorTextCustom then
			PlayerName:SetTextColor(ColorMixin.GetRGBA(TRP3_UF_DB.Player.colorText));
		end
	end
	

	if TRP3_UF_DB.Player.colorBackClass then
		PlayerFrameReputationColor:SetVertexColor(classR, classG, classB, 1)
	end
	if TRP3_UF_DB.Player.colorBackCustom then
		PlayerFrameReputationColor:SetVertexColor(ColorMixin.GetRGBA(TRP3_UF_DB.Player.colorBack));
	end
	if not TRP3_UF_DB.Player.colorBackClass and not TRP3_UF_DB.Player.colorBackCustom then
		PlayerFrameReputationColor:SetVertexColor(0, 0, 0, 0);
	end

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
				local r, g, b, a = 1, 1, 1, 1;
				if TRP3_UF_DB.Player.frameTextureClass then
					r, g, b = classR, classG, classB;
					a = 1;
				end
				if TRP3_UF_DB.Player.frameTextureTRP then
					local customColor = AddOn_TotalRP3.Player.CreateFromUnit("player"):GetCustomColorForDisplay();
					if not issecretvalue(AddOn_TotalRP3.Player.CreateFromUnit("player")) and customColor then
						r, g, b = customColor:GetRGB();
						a = 1;
					end
				end
				if TRP3_UF_DB.Player.frameTextureCustom then
					r = TRP3_UF_DB.Player.frameTextureColor.r;
					g = TRP3_UF_DB.Player.frameTextureColor.g;
					b = TRP3_UF_DB.Player.frameTextureColor.b;
					a = TRP3_UF_DB.Player.frameTextureColor.a or 1;
				end
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