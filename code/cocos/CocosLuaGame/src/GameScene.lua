require "Cocos2d"
require "Cocos2dConstants"

local GameScene = class("GameScene",function()
    return cc.Scene:create()
end)

function GameScene.create()
    local scene = GameScene.new()
    scene:addChild(scene:createLayerBack())
    return scene
end

function GameScene:ctor()
    self.visibleSize = cc.Director:getInstance():getVisibleSize()
    self.origin = cc.Director:getInstance():getVisibleOrigin()
    self.schedulerID = nil
end

function GameScene:playBgMusic()
    local bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("background.mp3") 
    cc.SimpleAudioEngine:getInstance():playMusic(bgMusicPath, true)
    local effectPath = cc.FileUtils:getInstance():fullPathForFilename("effect1.wav")
    cc.SimpleAudioEngine:getInstance():preloadEffect(effectPath)
end

-- create background
function GameScene:createLayerBack()
    local layerBack = cc.Layer:create()
    -- add in background
    local bg = cc.Sprite:create("background.jpg")
    --bg:setPosition(self.origin.x + self.visibleSize.width / 2 + 80, self.origin.y + self.visibleSize.height / 2)
    bg:setPosition(self.origin.x + self.visibleSize.width / 2, self.origin.y + self.visibleSize.height / 2)
    layerBack:addChild(bg)
    
    --function1
    --local function button_click1_Begin()
        --return true
    --end
    
    local function button_click1()
        cc.Director:sharedDirector():endToLua()
    end
    
    --function2
    --local function button_click2_Begin()
        --return true
    --end
    
    local function button_click2()
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
        print("enter normal")
    end
    
    
    --local menuItem2 = cc.MenuItemImage:create("button2.png", "button3.png")
    --menuItem2:setPosition(self.origin.x + self.visibleSize.width / 2, self.origin.y + self.visibleSize.height / 2 - 280)
    --menuItem2:registerScriptHandler(button_click2)
    --local menubutton2 = cc.Menu:createWithItem(menuItem2)
    --menubutton2:setPosition(0,0)
    --menubutton2:setVisible(true)
    --layerBack:addChild(menubutton2)
    
    --local listener2 = cc.EventListenerTouchOneByOne:create()
    --listener2:registerScriptHandler(button_click2_Begin,cc.Handler.EVENT_TOUCH_BEGAN )
    --listener2:registerScriptHandler(button_click2_End,cc.Handler.EVENT_TOUCH_ENDED )
    --local eventDispatcher = layerBack:getEventDispatcher()
    --eventDispatcher:addEventListenerWithSceneGraphPriority(listener2, menubutton2)
    
    
    local button1 = ccui.Button:create()
    button1:setTouchEnabled(true)
    button1:setPressedActionEnabled(true)
    button1:loadTextures("button1.png", "button3.png", "")
    button1:setPosition(cc.p(self.origin.x + self.visibleSize.width / 2, self.origin.y + self.visibleSize.height / 2 - 160))
    button1:addTouchEventListener(button_click1)        
    layerBack:addChild(button1)

    local button2 = ccui.Button:create()
    button2:setTouchEnabled(true)
    button2:setPressedActionEnabled(true)
    button2:loadTextures("button2.png", "button3.png", "")
    button2:setPosition(cc.p(self.origin.x + self.visibleSize.width / 2, self.origin.y + self.visibleSize.height / 2 - 280))
    button2:addTouchEventListener(button_click2)        
    layerBack:addChild(button2)
    
    return layerBack
end



return GameScene
