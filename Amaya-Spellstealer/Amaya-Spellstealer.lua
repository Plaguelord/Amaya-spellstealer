--======================================================================================================================
--==                                                                                                                  ==
--== 	                                      Amaya's Spellsteal v1.0.0                                               ==
--==                                                                                                                  ==
--== 	Decription:	Creates a small frame, prioritized by must steal, followed by normal stealable spells from your   ==
--== 	current target, orderd by remaining time.                                                                     ==
--== 	Author= @Amaya_PvP                                                                                            ==
--==                                                                                                                  ==
--======================================================================================================================

local _, playerClass = UnitClass("player")
addonVersion = GetAddOnMetadata("Amaya-Spellstealer", "Version")
addonName = GetAddOnMetadata("Amaya-Spellstealer", "Title")

function startUp(self)
    self:RegisterEvent("PLAYER_TARGET_CHANGED")
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:RegisterEvent("UNIT_AURA")
    self:RegisterEvent("PLAYER_DEAD")
    self:RegisterEvent("UNIT_TARGET")

    SLASH_SS1 = "/ass" -- From Amaya's SpellStealer :P
    SlashCmdList["SS"] = slashCommand
end

function onShow()
    return nill
end

function onUpdate(self, elapsed)
    return nil
end

function onEvent(self, event, ...)
    return nil
end

function slashCommand(msg, editbox, showAddonHeader)

    if (showAddonHeader == nil or showAddonHeader == "" or showAddonHeader == true) then
        addonSpam()
    end

    if (msg == nil or msg == "") then
        showMessage("Please insert a valid option!")
        slashCommand("?", editbox, false)
    elseif (string.lower(msg) == "ui") then
        loadUI()
    elseif (string.lower(msg) == "test") then
        showTest()
    elseif (string.lower(msg) == "lock") then
        lockUI()
    elseif (string.lower(msg) == "unlock") then
        unlockUI()
    elseif (string.lower(msg) == "?") then
        showMessage(" -= Valid options =-")
        showMessage(" • ui: Show ASS interface options")
        showMessage(" • test: Show ASS sample interface (for positioning)")
        showMessage(" • lock: Lock ASS frame at the current position")
        showMessage(" • unlock: Unlock ASS frame")
        showMessage(" • ?: Help")
        showMessage("")
    else
        showMessage("Invalid option [" .. msg .. "], please enter a valid option!")
        slashCommand("?", editbox, false)
    end
end

function handleCmd(msg, editbox)
    if (msg == "test") then
        if (debug == true) then
            debug = false
            DEFAULT_CHAT_FRAME:AddMessage("SpellStealer: Disabling test frame.")
            SSFrameUpdate()
        else
            debug = true
            SSFrameUpdate()
            DEFAULT_CHAT_FRAME:AddMessage("SpellStealer: Showing test frame.")
        end
    elseif (msg == "announce") then
        if (SSAnnounce == true) then
            DEFAULT_CHAT_FRAME:AddMessage("SpellStealer: Announcing to raid/party disabled.")
            SSAnnounce = false
            if (not SSFrametitle) then
                SSFrameCreate()
                SSFrameUpdate()
            end
            SSFrametitle:SetText("Spell Stealer")
        else
            DEFAULT_CHAT_FRAME:AddMessage("SpellStealer: Announcing to raid/party enabled.")
            SSAnnounce = true
            if (not SSFrametitle) then
                SSFrameCreate()
                SSFrameUpdate()
            end
            SSFrametitle:SetText("Spell Stealer (Announce mode)")
        end
    elseif (msg == "lock") then
        if (SSFrame.Locked == true) then
            SSFrame.Locked = false
            DEFAULT_CHAT_FRAME:AddMessage("SpellStealer: Frame is now unlocked. Frame with auto lock if you reload UI or restart game.")
        else
            SSFrame.Locked = true
            DEFAULT_CHAT_FRAME:AddMessage("SpellStealer: Frame is now locked.")
        end
    elseif (msg == "growup") then
        if (SSGrowup == true) then
            SSGrowup = false
            DEFAULT_CHAT_FRAME:AddMessage("SpellStealer: Frame will now grow down (normal).")
            SSFrameList:ClearAllPoints()
            SSFrameList:SetPoint("TOPLEFT", 0, -21)
            SSFrameUpdate()

        else
            SSGrowup = true
            DEFAULT_CHAT_FRAME:AddMessage("SpellSteaker: Frame will now grow up (reverse).")
            SSFrameList:ClearAllPoints()
            SSFrameList:SetPoint("BOTTOMLEFT", 0, 21)
            SSFrameUpdate()
        end
    else
        DEFAULT_CHAT_FRAME:AddMessage("SpellStealer: The following commands are recognized. \n\r\"test\" -- Shows spellstealer frame with fake buffs for positioning.\n\r\"announce\" -- Toggles on/off announcing spells stolen to raid/party. Detects which you are in and announces accordingly.\r\n\"lock\" --Toggles on/off the frame locking. (Defaults to locked)\r\n\"growup\" -- Toggles the frame growing down (default) or up (reversed)")
    end
end


function HideSSMonitorToggle() -- Spellsteal Monitor Toggle
    local stealMonitorChecked = MageNugOptionsFrame_CheckButton2:GetChecked();
    if (stealMonitorChecked == true) then
        MageNuggets.ssMonitorToggle = false;
    else
        MageNuggets.ssMonitorToggle = true;
    end
end

function ShowConfigFrames() --Shows frames for 120 seconds
    previewMnFrames = true;
    if (MageNuggets.ssMonitorToggle == true) then
        spellStealTog = 120;
        MNSpellSteal_Frame:Show();
        MNSpellStealFocus_Frame:Show();
    end
    mirrorImageTime = 120;
    MageNugMI_Frame:Show();
    MageNugNova_Frame:Show();
    MageNugIgnite_Frame:Show();
    polyTimer = 120
    MageNugPolyFrameText:SetText("|cffFFFFFF" .. "Polymorph")
    MageNugPolyFrame:Show();
    mageImpProgMonTime = 120;
    MageNugBFProcFrameText:SetText("|cffFFFFFF" .. "BRAIN FREEZE!")
    MageNugBFProcFrame:Show();
    MageNugProcFrameText:SetText("|cffFF0000" .. "HOT STREAK!");
    MageNugProcFrame:Show();
    MageNugProcHUFrameText:SetText("|cffFFCC00" .. "HEATING UP!");
    MageNugProcHUFrame:Show();
    MageNugMBProcFrameText:SetText("|cffFF33FF" .. "ARCANE MISSILES!")
    MageNugMBProcFrame:Show();
    MageNugFoFProcFrameText:SetText("|cffFFFFFF" .. "Fingers Of Frost")
    MageNugFoFProcFrame:Show();
    cauterizeTime = 120;
    MageNugCauterize_Frame:Show();
    abProgMonTime = 120;
    MageNugAB_Frame:Show();
    clearcastTime = 120;
    MageNugCauterizeFrame:Show();
end

function HideConfigFrames()
    previewMnFrames = false;
    MageNugCauterize_Frame:Hide();
    MNSpellSteal_Frame:Hide();
    MNSpellStealFocus_Frame:Hide();
    MageNugMI_Frame:Hide();
    MageNugPolyFrame:Hide();
    MageNugIgnite_Frame:Hide();
    MageNugBFProcFrame:Hide();
    MageNugProcFrame:Hide();
    MageNugProcHUFrame:Hide();
    MageNugMBProcFrame:Hide();
    MageNugFoFProcFrame:Hide();
    MageNugAB_Frame:Hide();
    MageNugCauterizeFrame:Hide();
    MageNugNova_Frame:Hide();
end

function LockFramesToggle()
    local flChecked = MageNugOption2Frame_LockFramesCheckButton:GetChecked();
    if (flChecked == true) then
        MageNuggets.lockFrames = true;
    else
        MageNuggets.lockFrames = false;
    end
end

function MNRecallFrames()
    MNSpellStealFocus_Frame:SetClampedToScreen(true);
    MageNugIgnite_Frame:SetClampedToScreen(true);
    MageNugCauterize_Frame:SetClampedToScreen(true);
    MageNugAB_Frame:SetClampedToScreen(true);
    MNabCast_Frame:SetClampedToScreen(true);
    MageNugProcFrame:SetClampedToScreen(true);
    MageNugPolyFrame:SetClampedToScreen(true);
    MageNugBFProcFrame:SetClampedToScreen(true);
    MageNugMBProcFrame:SetClampedToScreen(true);
    MageNugFoFProcFrame:SetClampedToScreen(true);
    MNSpellSteal_Frame:SetClampedToScreen(true);
    MageNugMI_Frame:SetClampedToScreen(true);
    MageNugMoonkin_Frame:SetClampedToScreen(true);
    MNmoonFire_Frame:SetClampedToScreen(true);
    MNinsectSwarm_Frame:SetClampedToScreen(true);
    MNstarSurge_Frame:SetClampedToScreen(true);
end

function MageNugSSMonitorSize() -- SS Slider
    local tempInt = MageNugOptionsFrame_Slider2:GetValue()

    if not MageNugOptionsFrame_Slider2._onsetting then
        MageNugOptionsFrame_Slider2._onsetting = true
        MageNugOptionsFrame_Slider2:SetValue(MageNugOptionsFrame_Slider2:GetValue())
        tempInt = MageNugOptionsFrame_Slider2:GetValue()
        MageNugOptionsFrame_Slider2._onsetting = false
    else return
    end

    if (tempInt == 0) then
        MNSpellSteal_Frame:SetScale(0.7);
        MageNuggets.ssMonitorSize = 0;
    elseif (tempInt == 1) then
        MNSpellSteal_Frame:SetScale(0.8);
        MageNuggets.ssMonitorSize = 1;
    elseif (tempInt == 2) then
        MNSpellSteal_Frame:SetScale(0.9);
        MageNuggets.ssMonitorSize = 2;
    elseif (tempInt == 3) then
        MNSpellSteal_Frame:SetScale(1.0);
        MageNuggets.ssMonitorSize = 3;
    elseif (tempInt == 4) then
        MNSpellSteal_Frame:SetScale(1.1);
        MageNuggets.ssMonitorSize = 4;
    elseif (tempInt == 5) then
        MNSpellSteal_Frame:SetScale(1.2);
        MageNuggets.ssMonitorSize = 5;
    elseif (tempInt == 6) then
        MNSpellSteal_Frame:SetScale(1.3);
        MageNuggets.ssMonitorSize = 6;
    end
end

function MageNuggets_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > MN_UpdateInterval) then

        if (previewFrames == true) then
            previewFramesCounter = previewFramesCounter + 1;
            if (previewFramesCounter > 300) then
                previewFramesCounter = 0;
                previewFrames = false;
            end
        end

        --SpellSteal
        if (spellStealTog >= 1) then
            spellStealTog = spellStealTog - 1;
        else
            if (MageNuggets.ssMonitorToggle == true) then
                if (mnenglishClass == 'MAGE') then
                    local stealableBuffs, i = {}, 1;
                    local buffName, a1, a2, a3, a4, a5, expirationTime, _, isStealable = UnitAura("target", i, "HELPFUL");
                    while buffName do
                        if (isStealable == true) then
                            if (expirationTime ~= nil) then
                                sstimeleft = RoundZero(expirationTime - GetTime());
                                if (sstimeleft > 60) then
                                    sstimeleft = "+60";
                                end
                            end

                            stealableBuffs[#stealableBuffs + 1] = buffName .. "  " .. sstimeleft .. "s";
                        end
                        i = i + 1;
                        buffName, _, _, _, _, _, expirationTime, _, isStealable = UnitAura("target", i, "HELPFUL");
                    end
                    if (#stealableBuffs < 1) and (previewMnFrames == false) then
                        MNSpellSteal_Frame:Hide();
                    else
                        MNSpellSteal_Frame:Show();
                        stealableBuffs = table.concat(stealableBuffs, "\n");
                        MNSpellSteal_FrameBuffText:SetText("|cffFFFFFF" .. stealableBuffs);
                    end
                    local stealableBuffs2, i = {}, 1;
                    local buffName2, _, _, _, _, _, expirationTime2, _, isStealable2 = UnitAura("focus", i, "HELPFUL");
                    while buffName2 do
                        if (isStealable2 == true) then
                            if (expirationTime2 ~= nil) then
                                sstimeleft2 = RoundZero(expirationTime2 - GetTime());
                                if (sstimeleft2 > 60) then
                                    sstimeleft2 = "+60";
                                end
                            end
                            stealableBuffs2[#stealableBuffs2 + 1] = buffName2 .. "  " .. sstimeleft2 .. "s";
                        end
                        i = i + 1;
                        buffName2, _, _, _, _, _, expirationTime2, _, isStealable2 = UnitAura("focus", i, "HELPFUL");
                    end
                    if (#stealableBuffs2 < 1) and (previewMnFrames == false) then
                        MNSpellStealFocus_Frame:Hide();
                    else
                        MNSpellStealFocus_Frame:Show();
                        stealableBuffs2 = table.concat(stealableBuffs2, "\n");
                        MNSpellStealFocus_FrameBuffText:SetText("|cffFFFFFF" .. stealableBuffs2);
                    end
                elseif (mnenglishClass == 'SHAMAN') then
                    if (UnitCanAttack("player", "target")) then
                        local purgeableBuffs, i = {}, 1;
                        local buffName1, _, _, _, debuffType1, _, expirationTime1, _, _ = UnitAura("target", i, "HELPFUL");
                        while buffName1 do
                            if (debuffType1 == "Magic") then
                                purgeableBuffs[#purgeableBuffs + 1] = buffName1;
                            end
                            i = i + 1;
                            buffName1, _, _, _, debuffType1, _, expirationTime1, _, _ = UnitAura("target", i, "HELPFUL");
                        end
                        if (#purgeableBuffs < 1) then
                            MNSpellSteal_Frame:Hide();
                        else
                            MNSpellSteal_Frame:Show();
                            purgeableBuffs = table.concat(purgeableBuffs, "\n");
                            MNSpellSteal_FrameBuffText:SetText("|cffFFFFFF" .. purgeableBuffs);
                        end
                    else
                        MNSpellSteal_Frame:Hide();
                    end
                    local stealableBuffs2, i = {}, 1;
                    local buffName2, _, _, _, debuffTypep, _, expirationTime2, _, isStealable2 = UnitAura("focus", i, "HELPFUL");
                    while buffName2 do
                        if (debuffTypep == "Magic") then
                            if (expirationTime2 ~= nil) then
                                sstimeleft2 = RoundZero(expirationTime2 - GetTime());
                                if (sstimeleft2 > 60) then
                                    sstimeleft2 = "+60";
                                end
                            end
                            stealableBuffs2[#stealableBuffs2 + 1] = buffName2 .. "  " .. sstimeleft2 .. "s";
                        end
                        i = i + 1;
                        buffName2, _, _, _, debuffTypep, _, expirationTime2, _, isStealable2 = UnitAura("focus", i, "HELPFUL");
                    end
                    if (#stealableBuffs2 < 1) then
                        MNSpellStealFocus_Frame:Hide();
                    else
                        MNSpellStealFocus_Frame:Show();
                        stealableBuffs2 = table.concat(stealableBuffs2, "\n");
                        MNSpellStealFocus_FrameBuffText:SetText("|cffFFFFFF" .. stealableBuffs2);
                    end
                elseif (mnenglishClass == 'PRIEST') then
                    if (UnitCanAttack("player", "target")) then
                        local dispelBuffs, i = {}, 1;
                        local buffName2, _, _, _, debuffType2, _, expirationTime2, _, _ = UnitAura("target", i, "HELPFUL");
                        while buffName2 do
                            if (debuffType2 == "Magic") then
                                dispelBuffs[#dispelBuffs + 1] = buffName2;
                            end
                            i = i + 1;
                            buffName2, _, _, _, debuffType2, _, expirationTime2, _, _ = UnitAura("target", i, "HELPFUL");
                        end
                        if (#dispelBuffs < 1) then
                            MNSpellSteal_Frame:Hide();
                        else
                            MNSpellSteal_Frame:Show();
                            dispelBuffs = table.concat(dispelBuffs, "\n");
                            MNSpellSteal_FrameBuffText:SetText("|cffFFFFFF" .. dispelBuffs);
                        end
                    else
                        MNSpellSteal_Frame:Hide();
                    end
                end
            end
        end
        self.TimeSinceLastUpdate = 0;
    end
end

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
--++                                                                                                                ++--
--++                                              Utility functions                                                 ++--
--++                                                                                                                ++--
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--

function addonSpam()
    showMessage(addonName .. " " .. addonVersion .. "\r\n")
end

function showMessage(msg)
    DEFAULT_CHAT_FRAME:AddMessage(msg)
end

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
--++                                                                                                                ++--

--++                                                                                                                ++--
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--

function loadUI()
    showMessage("Should load GUI")
end

function showTest()
    showMessage("Should show ASS sample")
end

function lockUI()
    showMessage("Should lock ASS frame")
end

function unlockUI()
    showMessage("Should unlock ASS frame")
end
