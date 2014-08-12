require "Cocos2d"
require "Cocos2dConstants"

local RealGameScene = class("RealGameScene",function()
    return cc.Scene:create()
end)

function RealGameScene.create()
    local scene = RealGameScene.new()
    scene:addChild(scene:createLayerBack())
    return scene
end

function RealGameScene:ctor()
    self.visibleSize = cc.Director:getInstance():getVisibleSize()
    self.origin = cc.Director:getInstance():getVisibleOrigin()
    self.schedulerID = nil
end

function RealGameScene:playBgMusic()
    local bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("background.mp3") 
    cc.SimpleAudioEngine:getInstance():playMusic(bgMusicPath, true)
    local effectPath = cc.FileUtils:getInstance():fullPathForFilename("effect1.wav")
    cc.SimpleAudioEngine:getInstance():preloadEffect(effectPath)
end

-- create background
function RealGameScene:createLayerBack()
    local layerBack = cc.Layer:create()
    -- add in background
    local bg = cc.Sprite:create("realbg.jpg")
    --bg:setPosition(self.origin.x + self.visibleSize.width / 2 + 80, self.origin.y + self.visibleSize.height / 2)
    bg:setPosition(self.origin.x + self.visibleSize.width / 2, self.origin.y + self.visibleSize.height / 2)
    layerBack:addChild(bg)

    return layerBack
end

return RealGameScene