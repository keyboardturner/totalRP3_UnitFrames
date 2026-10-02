local addonName, TRP3_UnitFrames = ...;
local L = TRP3_UnitFrames.L;

local trpTarget = TRP3_UnitFrames.trpTarget;
local trpPlayer = TRP3_UnitFrames.trpPlayer;
local TargetName = TargetFrame.TargetFrameContent.TargetFrameContentMain.Name;
local ReputationColor = TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor;

local targetStatus = CreateFrame("Frame", nil, TargetFrame)
targetStatus:SetSize(22, 22)
targetStatus:SetPoint("CENTER", TargetFrame.TargetFrameContainer.Portrait, "TOP", 0, -15)
targetStatus:SetFrameStrata("MEDIUM")
targetStatus.Tex = targetStatus:CreateTexture(nil, "OVERLAY", nil, 7)
targetStatus.Tex:SetAllPoints()
targetStatus:Hide()
trpTarget.status = targetStatus

function trpTarget.UpdateStatusIcon()
	TRP3_UnitFrames.UpdateStatusIcon("target", trpTarget.status, TRP3_UF_DB and TRP3_UF_DB.Target.showStatus);
end

function trpTarget.SetColor()
	trpTarget.UpdateInfo();
end

function trpTarget.UpdateInfo()
	if TargetName then
		--local textR, textG, textB, textA = 1, 0.896, 0, 1;
		if TRP3_UF_DB.Target.nameWidth then
			TargetName:SetWidth(TRP3_UF_DB.Target.nameWidth);
		end

		local isTargetPlayer = not issecretvalue(UnitGUID("target")) and UnitIsPlayer("target");

		if isTargetPlayer then
			if TRP3_UF_DB.Setting.FullNameTarget and TRP3_UF_DB.Setting.UseTRPName then
				TargetName:SetText(TRP3_API.r.name("target"));
			elseif not TRP3_UF_DB.Setting.FullNameTarget and TRP3_UF_DB.Setting.UseTRPName and not issecretvalue(UnitGUID("target")) then
				local firstName = AddOn_TotalRP3.Player.CreateFromGUID(UnitGUID("target")):GetFirstName();
				if not issecretvalue(UnitGUID("target")) and firstName then
					TargetName:SetText(firstName);
				else
					TargetName:SetText(UnitName("target"));
				end
			else
				TargetName:SetText(UnitName("target"));
			end
		end

		local textR, textG, textB, textA = TRP3_UnitFrames.ResolveColorPriority("target", TRP3_UF_DB.Target.colorTextPriority, {
			customEnabled = TRP3_UF_DB.Target.colorTextCustom or (not isTargetPlayer and TRP3_UF_DB.Setting.NPCs),
			customColor = TRP3_UF_DB.Target.colorText,
			classEnabled = TRP3_UF_DB.Target.colorTextClass and isTargetPlayer,
			trpEnabled = (TRP3_UF_DB.Target.colorTextTRP ~= false) and isTargetPlayer,
			defaultColor = { r = 1, g = 0.896, b = 0, a = 1 },
		});

		local backR, backG, backB, backA = TRP3_UnitFrames.ResolveColorPriority("target", TRP3_UF_DB.Target.colorBackPriority, {
			customEnabled = TRP3_UF_DB.Target.colorBackCustom or (not isTargetPlayer and TRP3_UF_DB.Setting.NPCs),
			customColor = TRP3_UF_DB.Target.colorBack,
			classEnabled = TRP3_UF_DB.Target.colorBackClass and isTargetPlayer,
			trpEnabled = (TRP3_UF_DB.Target.colorBackTRP ~= false) and isTargetPlayer,
			defaultColor = { r = 0, g = 0, b = 1, a = 1 },
		});

		ReputationColor:SetVertexColor(backR, backG, backB, backA);

		TRP3_UnitFrames.ApplyTextColor(TargetName, TargetFrame.bbfName, textR, textG, textB, textA);

		local frameTex = TargetFrame.TargetFrameContainer.FrameTexture
		if frameTex then
			if TRP3_UF_DB.Target.frameTextureEnabled then
				frameTex:SetDesaturated(true);
				local r, g, b, a = TRP3_UnitFrames.ResolveColorPriority("target", TRP3_UF_DB.Target.frameTexturePriority, {
					customEnabled = TRP3_UF_DB.Target.frameTextureCustom,
					customColor = TRP3_UF_DB.Target.frameTextureColor,
					classEnabled = TRP3_UF_DB.Target.frameTextureClass and isTargetPlayer,
					trpEnabled = TRP3_UF_DB.Target.frameTextureTRP and isTargetPlayer,
					defaultColor = { r = 1, g = 1, b = 1, a = 1 },
				});
				frameTex:SetVertexColor(r, g, b, a);
			else
				frameTex:SetDesaturated(false);
				frameTex:SetVertexColor(1, 1, 1, 1);
			end
		end
	end

	trpTarget.UpdateStatusIcon()
end

function trpTarget.nameChecker()
	trpTarget.UpdateInfo()
	trpPlayer.UpdateInfo()

	if UnitIsPlayer("target") and not issecretvalue(UnitGUID("target")) and AddOn_TotalRP3.Player.CreateFromUnit("target"):GetProfileID() then
		trpTarget.SetColor()

		local player = AddOn_TotalRP3.Player.CreateFromUnit("target")
		local icon = player:GetCustomIcon() or "inv_inscription_scroll"

		if trpTarget.button and trpTarget.button.tex then
			trpTarget.button.tex:SetTexture("Interface/icons/" .. icon)
			trpTarget.button.tex:SetTexCoord(0, 1, 0, 1)
			if not trpTarget.button.tex.TrpMask then
				trpTarget.button.tex.TrpMask = trpTarget.button:CreateMaskTexture()
				trpTarget.button.tex.TrpMask:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
				trpTarget.button.tex.TrpMask:SetAllPoints(trpTarget.button.tex)
				trpTarget.button.tex:AddMaskTexture(trpTarget.button.tex.TrpMask)
			end
		end

		if TRP3_UF_DB.Target.relativePoint == "CENTER" then
			if trpTarget.button then
				if trpTarget.fadeGroupShow then trpTarget.fadeGroupShow:Stop() end
				if trpTarget.fadeGroupHide then trpTarget.fadeGroupHide:Stop() end
				trpTarget.button:Hide()
			end
			if trpTarget.portraitClick then
				trpTarget.portraitClick:Show()
			end
			TargetFrame.TargetFrameContainer.Portrait:SetTexture("Interface/icons/" .. icon)
			TargetFrame.TargetFrameContainer.Portrait:SetTexCoord(0, 1, 0, 1)
		else
			if not InCombatLockdown() and TRP3_UF_DB.Target.show then
				if trpTarget.button then
					if trpTarget.fadeGroupShow then trpTarget.fadeGroupShow:Stop() end
					if trpTarget.fadeGroupHide then trpTarget.fadeGroupHide:Stop() end
					trpTarget.button:Show()
				end
			end
			if trpTarget.portraitClick then
				trpTarget.portraitClick:Hide()
			end
			SetPortraitTexture(TargetFrame.TargetFrameContainer.Portrait, "target")
		end

		if trpPlayer.SetAsPortrait then
			trpPlayer.SetAsPortrait()
		end
	else
		if trpTarget.button then
			if trpTarget.fadeGroupShow then trpTarget.fadeGroupShow:Stop() end
			if trpTarget.fadeGroupHide then trpTarget.fadeGroupHide:Stop() end
			trpTarget.button:Hide()
		end
		if trpTarget.portraitClick then
			trpTarget.portraitClick:Hide()
		end
		SetPortraitTexture(TargetFrame.TargetFrameContainer.Portrait, "target")
	end
end