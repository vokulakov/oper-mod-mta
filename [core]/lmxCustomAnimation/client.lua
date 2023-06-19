local animationManagerWindow = nil
local replaceAnimationLabel, playAnimationLabel = nil, nil
local restoreDefaultsButton, stopAnimationButton = nil, nil
local replaceAnimationGridList, playAnimationGridList = nil, nil

local isShowingAnimationBlocksInPlayGridList = true
local currentBlockNameSelected = nil

local isLocalPlayerAnimating = false

local function PopulatePlayAnimationGridListWithBlocks ()
    isShowingAnimationBlocksInPlayGridList = true
    currentBlockNameSelected = nil

    guiGridListClear ( playAnimationGridList )

    -- Add IFP blocks to the play animation gridlist
    for customAnimationBlockIndex, customAnimationBlock in ipairs ( globalLoadedIfps ) do 
        local rowIndex = guiGridListAddRow ( playAnimationGridList, " + "..customAnimationBlock.friendlyName )
        guiGridListSetItemData ( playAnimationGridList, rowIndex, 1, customAnimationBlockIndex )
    end
end

local function PopulatePlayAnimationGridListWithCustomBlockAnimations ( ifpIndex )
    isShowingAnimationBlocksInPlayGridList = false
    currentBlockNameSelected = globalLoadedIfps [ifpIndex].blockName

    guiGridListClear ( playAnimationGridList )
    guiGridListAddRow ( playAnimationGridList, ".." )

    -- Add IFP blocks to the play animation gridlist
    for _, customAnimationName in ipairs ( globalLoadedIfps [ifpIndex].animations ) do 
        local rowIndex = guiGridListAddRow ( playAnimationGridList, "  "..customAnimationName )
        guiGridListSetItemData ( playAnimationGridList, rowIndex, 1, customAnimationName )
    end
end

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        triggerServerEvent ( "onCustomAnimationSyncRequest", resourceRoot, localPlayer )

        outputChatBox ("Press 'X' to toggle Animation Manager", 255, 255, 255)

        showCursor ( true )

        animationManagerWindow = guiCreateWindow(118, 116, 558, 371, "Animation Manager", false)
        guiWindowSetSizable(animationManagerWindow, false)

        replaceAnimationLabel = guiCreateLabel(12, 26, 245, 19, "Replace Animations With", false, animationManagerWindow)
        guiSetFont(replaceAnimationLabel, "default-bold-small")
        guiLabelSetHorizontalAlign(replaceAnimationLabel, "center", false)

        replaceAnimationGridList = guiCreateGridList(12, 49, 245, 255, false, animationManagerWindow)
        guiGridListAddColumn(replaceAnimationGridList, "Animation Blocks", 0.9)
        
        restoreDefaultsButton = guiCreateButton(49, 314, 174, 41, "Restore Defaults", false, animationManagerWindow)
        playAnimationLabel = guiCreateLabel(294, 26, 245, 19, "Play Animation", false, animationManagerWindow)
        guiSetFont(playAnimationLabel, "default-bold-small")
        guiLabelSetHorizontalAlign(playAnimationLabel, "center", false)
        
        stopAnimationButton = guiCreateButton(329, 314, 174, 41, "Stop Animation", false, animationManagerWindow)
        playAnimationGridList = guiCreateGridList(294, 49, 245, 255, false, animationManagerWindow)
        guiGridListAddColumn(playAnimationGridList, "Animation Blocks", 0.9)

        -- load IFP files and add them to the play animation gridlist
        for customAnimationBlockIndex, customAnimationBlock in ipairs ( globalLoadedIfps ) do 
            local ifp = engineLoadIFP ( customAnimationBlock.path, customAnimationBlock.blockName )
            if not ifp then
                outputChatBox ("Failed to load '"..customAnimationBlock.path.."'")
            end
        end

        -- now add replaceable ifps to the other grid list
        for _, ifpIndex in ipairs ( globalReplaceableIfpsIndices ) do 
            local customAnimationBlock = globalLoadedIfps [ ifpIndex ]
            local rowIndex = guiGridListAddRow ( replaceAnimationGridList, customAnimationBlock.friendlyName )
            guiGridListSetItemData ( replaceAnimationGridList, rowIndex, 1, ifpIndex )
        end

        PopulatePlayAnimationGridListWithBlocks ()
    end
) 

local function ReplacePedBlockAnimations ( player, ifpIndex )
    local customIfpBlockName = globalLoadedIfps [ ifpIndex ].blockName
    for _, animationName in pairs ( globalPedAnimationBlock.animations ) do 
        -- make sure that we don't replace a partial animation
        if not globalPedAnimationBlock.partialAnimations [ animationName ] then 
            engineReplaceAnimation ( player, "ped", animationName, customIfpBlockName, animationName )
        end
    end
end 

local function HandleReplacedAnimationGridListDoubleClick ()
    local replacedAnimGridSelectedRow, replacedAnimGridSelectedCol = guiGridListGetSelectedItem ( replaceAnimationGridList ); 
    if replacedAnimGridSelectedRow and replacedAnimGridSelectedRow ~= -1 then 
        local ifpFriendlyName = guiGridListGetItemText( replaceAnimationGridList, replacedAnimGridSelectedRow, replacedAnimGridSelectedCol ) 
        local ifpIndex = guiGridListGetItemData(replaceAnimationGridList, replacedAnimGridSelectedRow, replacedAnimGridSelectedCol )
        ReplacePedBlockAnimations ( localPlayer, ifpIndex )
        triggerServerEvent ( "onCustomAnimationReplace", resourceRoot, localPlayer, ifpIndex )
        outputChatBox ("Replaced 'ped' block animations with '"..ifpFriendlyName.."'", 255, 255, 255)
    end
end 

local function HandlePlayAnimationGridListDoubleClick ()
    local playAnimGridSelectedRow, playAnimGridSelectedCol = guiGridListGetSelectedItem ( playAnimationGridList ); 
    if playAnimGridSelectedRow and playAnimGridSelectedRow ~= -1 then 
        local itemText = guiGridListGetItemText( playAnimationGridList, playAnimGridSelectedRow, playAnimGridSelectedCol )
        if isShowingAnimationBlocksInPlayGridList then  
            local ifpIndex = guiGridListGetItemData(playAnimationGridList, playAnimGridSelectedRow, playAnimGridSelectedCol )
            PopulatePlayAnimationGridListWithCustomBlockAnimations ( ifpIndex )
        else
            if itemText == ".." then 
                PopulatePlayAnimationGridListWithBlocks ( )
            else
                local animationName = guiGridListGetItemData(playAnimationGridList, playAnimGridSelectedRow, playAnimGridSelectedCol )
                setPedAnimation ( localPlayer, currentBlockNameSelected, animationName )
                triggerServerEvent ( "onCustomAnimationSet", resourceRoot, localPlayer, currentBlockNameSelected, animationName )
                isLocalPlayerAnimating = true
            end
       end
    end 
end 

addEventHandler( "onClientGUIDoubleClick", resourceRoot,
    function ( button, state, absoluteX, absoluteY )
        if button == "left" and state == "up" then 
            if source == replaceAnimationGridList then 
                HandleReplacedAnimationGridListDoubleClick ( )
            elseif source == playAnimationGridList then 
                HandlePlayAnimationGridListDoubleClick ( )
            end 
        end
    end 
)

addEventHandler( "onClientGUIClick", resourceRoot,
    function ( button, state )
        if button == "left" and state == "up" then 
            if source == restoreDefaultsButton then 
                -- restore all replaced animations of "ped" block
                engineRestoreAnimation ( localPlayer, "ped" )
                triggerServerEvent ( "onCustomAnimationRestore", resourceRoot,  localPlayer, "ped" )
                outputChatBox ("Restored ped block animations", 255, 255, 255)
            elseif source == stopAnimationButton then 
                setPedAnimation ( localPlayer, false )
                triggerServerEvent ( "onCustomAnimationSet", resourceRoot, localPlayer, false, false )
            end 
        end
    end 
)
 
bindKey ( "X", "down", 
    function ( key, keyState )
        if ( keyState == "down" ) then
            local isAnimationMangerWindowVisible = guiGetVisible ( animationManagerWindow )
            guiSetVisible ( animationManagerWindow, not isAnimationMangerWindowVisible )
            showCursor ( not isAnimationMangerWindowVisible )
        end
    end
)

addEvent ("onClientCustomAnimationSyncRequest", true )
addEventHandler ("onClientCustomAnimationSyncRequest", root,
    function ( playerAnimations )
        for player, anims in pairs ( playerAnimations ) do 
            if isElement ( player ) then 
                if anims.current then 
                    setPedAnimation ( player, anims.current[1], anims.current[2] ) 
                end
                if anims.replacedPedBlock then 
                    ReplacePedBlockAnimations ( player, anims.replacedPedBlock )
                end
            end
        end 
    end 
)

addEvent ("onClientCustomAnimationSet", true )
addEventHandler ("onClientCustomAnimationSet", root,
    function ( blockName, animationName )
        if source == localPlayer then return end
        if blockName == false then 
            setPedAnimation ( source, false )
            return
        end 
        setPedAnimation ( source, blockName, animationName )
    end 
)

addEvent ("onClientCustomAnimationReplace", true )
addEventHandler ("onClientCustomAnimationReplace", root,
    function ( ifpIndex )
        if source == localPlayer then return end
        ReplacePedBlockAnimations ( source, ifpIndex )
    end 
)

addEvent ("onClientCustomAnimationRestore", true )
addEventHandler ("onClientCustomAnimationRestore", root,
    function ( blockName )
        if source == localPlayer then return end
        engineRestoreAnimation ( source, blockName )
    end 
)


setTimer ( 
    function ()
        if isLocalPlayerAnimating then 
            if not getPedAnimation (localPlayer) then
                isLocalPlayerAnimating = false
                triggerServerEvent ( "onCustomAnimationStop", resourceRoot, localPlayer )
            end
        end
    end, 100, 0
)