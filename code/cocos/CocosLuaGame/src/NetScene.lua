require "Cocos2d"
require "Cocos2dConstants"

local NetScene = class("NetScene",function()
    return cc.Scene:create()
end)

function NetScene.create()
    local scene = NetScene.new()
    scene:addChild(scene:createLayerBack())
    return scene
end

function NetScene:ctor()
    self.visibleSize = cc.Director:getInstance():getVisibleSize()
    self.origin = cc.Director:getInstance():getVisibleOrigin()
    self.schedulerID = nil
end

function NetScene:playBgMusic()
    local bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("background.mp3") 
    cc.SimpleAudioEngine:getInstance():playMusic(bgMusicPath, true)
    local effectPath = cc.FileUtils:getInstance():fullPathForFilename("effect1.wav")
    cc.SimpleAudioEngine:getInstance():preloadEffect(effectPath)
end

-- create background
function NetScene:createLayerBack()

    local function gameStart()
        --create scene 
        local scene = require("RealGameScene")
        local gameScene = scene.create()
        --scene.newScene()
        gameScene:playBgMusic()

        if cc.Director:getInstance():getRunningScene() then
            cc.Director:getInstance():replaceScene(gameScene)
        else
            cc.Director:getInstance():runWithScene(gameScene)
        end
    end
    
    local layerBack = cc.Layer:create()
    -- add in background
    local bg = cc.Sprite:create("netbg.png")
    bg:setPosition(self.origin.x + self.visibleSize.width / 2, self.origin.y + self.visibleSize.height / 2)
    layerBack:addChild(bg)

    local netButton = ccui.Button:create()
    netButton:setTouchEnabled(true)
    netButton:setPressedActionEnabled(true)
    netButton:loadTextures("netbutton.png", "netbutton.png", "")
    netButton:setPosition(cc.p(self.origin.x + self.visibleSize.width / 2, self.origin.y + self.visibleSize.height / 2 - 160))
    netButton:addTouchEventListener(gameStart)        
    layerBack:addChild(netButton)
    
    return layerBack
end

return NetScene