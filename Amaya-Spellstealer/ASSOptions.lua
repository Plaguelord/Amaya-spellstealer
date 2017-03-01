--======================================================================================================================
--==                                                                                                                  ==
--== 	Decription:	Utility library for frame creation, options loading and population                                ==
--== 	Author= @Amaya                                                                                                ==
--==                                                                                                                  ==
--======================================================================================================================

addonVersion = GetAddOnMetadata("Amaya-Spellstealer", "Version")
addonName = GetAddOnMetadata("Amaya-Spellstealer", "Title")

function startOptions()
    loadProperties()
    createFrames()
    populateProperties()
end

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
--++                                                                                                                ++--
--++                                          Frame utility functions                                               ++--
--++                                                                                                                ++--
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function createFrames()
    createMainFrame()
    createClassFrames()
end

function createMainFrame()
    assOptionsPanel = CreateFrame("FRAME", "assOptionsPanel", InterfaceOptionsFrame)
    assOptionsPanel.name = " " .. addonName
    assOptionsPanel.okay = function(self) optionsSave(); end;
    assOptionsPanel.cancel = function(self) optionsDiscard(); end;
    assOptionsPanel:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)
    InterfaceOptions_AddCategory(assOptionsPanel)

    mybutton = CreateFrame("Button", "mybutton", assOptionsPanel, "UIPanelButtonTemplate")
    mybutton:SetPoint("CENTER", 0, 0)
    mybutton:SetWidth(80)
    mybutton:SetHeight(22)
end

function createClassFrames()
    addWarriorFrame()
    addHunterFrame()
    addPriestFrame()
    addShamanFrame()
    addWarlockFrame()
end

function addWarriorFrame()
    warriorASSOptions = CreateFrame("FRAME", "warriorASSOptions");
    warriorASSOptions.name = "Warrior Auras";
    warriorASSOptions.parent = assOptionsPanel;
    warriorASSOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)
    InterfaceOptions_AddCategory(warriorASSOptions);
end

function addHunterFrame()
    hunterASSOptions = CreateFrame("FRAME", "hunterASSOptions");
    hunterASSOptions.name = "Hunter Auras";
    hunterASSOptions.parent = assOptionsPanel;
    hunterASSOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)
    InterfaceOptions_AddCategory(hunterASSOptions);
end

function addPriestFrame()
    priestASSOptions = CreateFrame("FRAME", "priestASSOptions");
    priestASSOptions.name = "Priest Auras";
    priestASSOptions.parent = assOptionsPanel;
    priestASSOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)
    InterfaceOptions_AddCategory(priestASSOptions);
end

function addShamanFrame()
    shamanASSOptions = CreateFrame("FRAME", "shamanASSOptions");
    shamanASSOptions.name = "Shaman Auras";
    shamanASSOptions.parent = assOptionsPanel;
    shamanASSOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)
    InterfaceOptions_AddCategory(shamanASSOptions);
end

function addWarlockFrame()
    warlockASSOptions = CreateFrame("FRAME", "warlockASSOptions");
    warlockASSOptions.name = "Warlock Auras";
    warlockASSOptions.parent = assOptionsPanel;
    warlockASSOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)
    InterfaceOptions_AddCategory(warlockASSOptions);
end

function updateFrame()
end


--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
--++                                                                                                                ++--
--++                                        Button action functions                                                 ++--
--++                                                                                                                ++--
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function optionsSave()
    xpcall(function()
        showMessage("Should update & save ASS options")
    end,
        geterrorhandler())
end

function optionsDiscard()
    xpcall(function()
        showMessage("Should discard ASS unsaved options")
    end,
        geterrorhandler())
end

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
--++                                                                                                                ++--
--++                                     Properties utility functions                                               ++--
--++                                                                                                                ++--
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function loadProperties()
end

function populateProperties()
end

function updateProperties()
end