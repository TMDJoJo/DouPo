UIWingInfoAll={}
local _wingId = nil
function UIWingInfoAll.init()
    local btn_close = ccui.Helper:seekNodeByName( UIWingInfoAll.Widget , "btn_close" )
    local btn_closed = ccui.Helper:seekNodeByName( UIWingInfoAll.Widget , "btn_closed" )
    local function onEvent( sender , eventType )
        if eventType == ccui.TouchEventType.ended then
            if sender == btn_close or sender == btn_closed then
                UIManager.popScene()
            end
        end
    end
    btn_close:setPressedActionEnabled( true )
    btn_close:addTouchEventListener( onEvent )
    btn_closed:setPressedActionEnabled( true )
    btn_closed:addTouchEventListener( onEvent )
end
function UIWingInfoAll.setup()
    local image_basecolour = ccui.Helper:seekNodeByName( UIWingInfoAll.Widget , "image_basecolour" )
    local actionName = DictWing[tostring(_wingId)].actionName
    local _starLevel = 3
    local _level = 0
    if actionName and actionName ~= "" then
        utils.addArmature( image_basecolour , 54 + _starLevel , actionName , image_basecolour:getContentSize().width / 2, image_basecolour:getContentSize().height / 2 + 30 , 1000 , 0.8 )
    else
        utils.addArmature( image_basecolour , 54 + _starLevel , "0".._starLevel..DictWing[tostring(_wingId)].sname , image_basecolour:getContentSize().width / 2, image_basecolour:getContentSize().height / 2 + 30 , 1000 , 0.8 )
    end
    local image_name = image_basecolour:getChildByName("image_name")
    image_name:getChildByName("text_name"):setString( DictWing[tostring(_wingId)].name )
    if _wingId < 5 then
        local image_quality = image_basecolour:getChildByName("image_quality")
        image_quality:loadTexture( "ui/wing_"..DictWing[ tostring( _wingId ) ].sname..".png" )
    end
    local image_down = image_basecolour:getChildByName("image_down")
    local text_name = ccui.Helper:seekNodeByName( image_down , "text_name")
    text_name:setString("三阶神羽")
    local image_wing_di = image_basecolour:getChildByName("image_wing_di")
    local _proValue = nil
    for key , value in pairs( DictWingAdvance ) do
        if value.wingId == _wingId and value.starNum == _starLevel then
            _proValue = utils.stringSplit( value.openFightPropIdList , ";" )
            break
        end
    end
    local temp , _allValue = nil , {}
    for key , value in pairs( DictWingStrengthen ) do
        if value.wingId == _wingId and value.level == _level then
            temp = utils.stringSplit( value.fightPropValueList , ";" )
            break
        end
    end
    for key , value in pairs( temp ) do
        local data = utils.stringSplit( value , "_" )
        _allValue[ data[1] ] = data[ 2 ]
    end
    local fightPropName = {}
        fightPropName["2"]={id=2,name="物       攻", oname = "物攻" , sname="wAttack",smallUiId=0,bigUiId=0,description=""}
        fightPropName["3"]={id=3,name="法       攻", oname = "法攻",sname="fAttack",smallUiId=0,bigUiId=0,description=""}
        fightPropName["8"]={id=8,name="物       防", oname = "增加物防",sname="wDefense",smallUiId=0,bigUiId=0,description=""}
        fightPropName["9"]={id=9,name="法       防", oname = "增加法防",sname="fDefense",smallUiId=0,bigUiId=0,description=""}
        fightPropName["17"]={id=17,name="雷属性伤害", oname = "雷系伤害",sname="leiDam",smallUiId=0,bigUiId=0,description=""}
        fightPropName["18"]={id=18,name="风属性伤害", oname = "风系伤害",sname="fengDam",smallUiId=0,bigUiId=0,description=""}
        fightPropName["19"]={id=19,name="光属性伤害", oname = "光系伤害",sname="guangDam",smallUiId=0,bigUiId=0,description=""}
        fightPropName["20"]={id=20,name="暗属性伤害", oname = "暗系伤害",sname="anDam",smallUiId=0,bigUiId=0,description=""}
    for i = 1 , 4 do
        image_wing_di:getChildByName("text_add"..i):setVisible( false )

        image_wing_di:getChildByName("text_name"..i):setString( fightPropName[tostring(_proValue[i])].name.."：" .. _allValue[ _proValue[i] ] )
    end
end
function UIWingInfoAll.free()
    _wingId = nil
end

function UIWingInfoAll.setId( id )
    _wingId = id
end