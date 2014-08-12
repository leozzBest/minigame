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
    
    local function joinGame()

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
    netButton:setPosition(cc.p(self.origin.x + self.visibleSize.width / 2, self.origin.y + self.visibleSize.height / 2 - 260))
    netButton:addTouchEventListener(joinGame)        
    layerBack:addChild(netButton)
    
    local user1 = ccui.ImageView:create()
    user1:loadTexture("orange-rooboo.png")
    user1:setPosition(cc.p(200, 580))
    layerBack:addChild(user1)
    
    local user2 = ccui.ImageView:create()
    user2:loadTexture("green-rooboo.png")
    user2:setPosition(cc.p(400, 600))
    layerBack:addChild(user2)
    
    local user3 = ccui.ImageView:create()
    user3:loadTexture("purple-rooboo.png")
    user3:setPosition(cc.p(600, 570))
    layerBack:addChild(user3)
    
    return layerBack
end



return NetScene