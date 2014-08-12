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
    local function button_click1_Begin()
        return true
    end
    
    local function button_click1_End()
        cc.Director:sharedDirector():endToLua()
    end
    
    --function2
    local function button_click2_Begin()
        return true
    end
    
    local function button_click2_End()
        print("enter normal")
    end
    
    --create button
    local menuItem1 = cc.MenuItemImage:create("button1.png", "button3.png")
    menuItem1:setPosition(self.origin.x + self.visibleSize.width / 2, self.origin.y + self.visibleSize.height / 2 - 160)
    --menuItem1:registerScriptHandler(button_click1)
    local menubutton1 = cc.Menu:createWithItem(menuItem1)
    menubutton1:setPosition(0,0)
    menubutton1:setVisible(true)
    layerBack:addChild(menubutton1)
    
    local listener1 = cc.EventListenerTouchOneByOne:create()
    listener1:registerScriptHandler(button_click1_Begin,cc.Handler.EVENT_TOUCH_BEGAN )
    listener1:registerScriptHandler(button_click1_End,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layerBack:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener1, menubutton1)
    
    local menuItem2 = cc.MenuItemImage:create("button2.png", "button3.png")
    menuItem2:setPosition(self.origin.x + self.visibleSize.width / 2, self.origin.y + self.visibleSize.height / 2 - 280)
    --menuItem2:registerScriptHandler(button_click2)
    local menubutton2 = cc.Menu:createWithItem(menuItem2)
    menubutton2:setPosition(0,0)
    menubutton2:setVisible(true)
    layerBack:addChild(menubutton2)
    
    local listener2 = cc.EventListenerTouchOneByOne:create()
    listener2:registerScriptHandler(button_click2_Begin,cc.Handler.EVENT_TOUCH_BEGAN )
    listener2:registerScriptHandler(button_click2_End,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layerBack:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener2, menubutton2)
    
    return layerBack
end



return GameScene
