local firebaseDynamicLinks = require "plugin.firebaseDynamicLinks"
local json = require "json"
local widget = require "widget"
firebaseDynamicLinks.init()

local longLink =""

local background = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
background.alpha = .95
background:setFillColor(.5,0,0)

local title = display.newText( "Firebase Dynamic Links", display.contentCenterX, display.contentCenterY-180 , native.systemFont, 18 )
title:setFillColor( 0 )

local createLink = widget.newButton( {
    label = "Create Link",
    id = "createLink",
    onRelease = function ( )
        longLink = firebaseDynamicLinks.buildUrl({domain="e2rfu.app.goo.gl", iOSBundleID="com.mycompany.App", iOSCustomScheme="firebaseTest",iOSAppStoreID="284882215",iOSFallbackURL="https://facebook.com", androidPackageName="com.mycompany.App",androidFallbackURL="https://google.com", analyticsMedium="test medium", analyticsSource="test app", analyticsCampaign="test campagin", analyticsTerm="term" })
        print(longLink)
    end
} )
createLink.x, createLink.y = display.contentCenterX, display.contentCenterY-20
createLink:setFillColor( 0 )

local shortenLink = widget.newButton( {
    label = "Shorten Link",
    id = "shortenLink",
    onRelease = function ( )
      firebaseDynamicLinks.shortenURL(longLink,function(e)
        if e.isError == false then
          print(e.url)
        end
      end)
    end
} )
shortenLink.x, shortenLink.y = display.contentCenterX, display.contentCenterY+20
shortenLink:setFillColor( 0 )


Runtime:addEventListener("firebaseDynamicLinks", function(e)
  print(json.encode(e))
end)
