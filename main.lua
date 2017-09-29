-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- remove status bar
display.setStatusBar(display.HiddenStatusBar)

--get physics
local physics = require("physics")
physics.start()

--variables
local score = 0
local redBall
local blackBall
local music = audio.loadSound("sounds/game-music.wav")
local bumpSound = audio.loadSound("sounds/bump-efx.wav")

--skyline
local sky = display.newImageRect("image/blue-sky1.jpeg",1084,640)

--for background music
local soundOptions =
{
    --channel = 1,
    --loops = -1,
    duration = 20000,
    --fadein = 5000,
    --onComplete = callbackListener
}
audio.play(music,soundOptions)

--for score display
local options = {
   text = "Score: "..score,
   x = 390,
   y = 300,
   fontSize = 30,
   width = 200,
   height = 0,
   align = "right"
}
 
local playerScore = display.newText( options )
playerScore:setFillColor( 0, 0, 1 )

--rock
local rock = display.newImageRect("image/rock.png",150,150)
rock.x = display.contentCenterX
rock.y = display.contentCenterY + 80
physics.addBody(rock,"static")
rock.gravityScale=-0.1


--player
local bun = display.newImageRect("image/bunny.png",50,30)
bun.x = 240
bun.y = display.contentCenterY
physics.addBody(bun,"dynamic",{density=0.2})
bun.gravityScale=0.3


-- Make player jump
function bun:touch(event)
	if(event.phase == "began") then
		bun:setLinearVelocity( 0, -90 )
        score = score + 1
        playerScore.text = "Score: "..score

	end
end
bun:addEventListener("touch",bun)


--birds
local eagle = display.newImageRect("image/eagle2.png",100,100)
eagle.x = 270
eagle.y = 0
physics.addBody(eagle,"static")
transition.to(eagle, {x=display.contentCenterX,y=display.contentCenterY,time=100000})

--projectile balls
function redBallFun()
  redBall = display.newCircle(500,160,10)
  redBall:setFillColor(1,0,0)
  physics.addBody(redBall,"dynamic",{density=0.2,bounce=0.2})
   transition.to( redBall, { x=0, y=display.contentCenterY - 12, iterations=0,time=5000 } )
end
redBallFun()

function blackBallFun()
  local blackBall = display.newCircle( 0, 160, 10 )
  blackBall:setFillColor( 0,0,0 )
  transition.to( blackBall, { x=500, y=display.contentCenterY,iterations=0,time=7000 } )
end
--blackBallFun()

--[[collisions
local function onLocalCollision( self, event )
 
    if ( event.phase == "began" ) then
        --audio.play(bumpSound)
    elseif ( event.phase == "ended" ) then
        --audio.stop()
    end
end
--0bjects involved in collision
bun.collision = onLocalCollision
bun:addEventListener( "collision" )
 
redBall.collision = onLocalCollision
redBall:addEventListener( "collision" )
--blade functions
function rightBladeFun()
   local rightBlade = display.newImageRect("image/right-blade.png",30,20)
   rightBlade.x = 500
   rightBlade.y = display.contentCenterY - 12
   rightBlade:rotate(-12)
   physics.addBody(rightBlade,"dynamic")
   transition.to( rightBlade, { x=0, y=display.contentCenterY - 7, iterations=0,time=5000 } )
end
rightBladeFun()

function leftBladeFun()
  local leftBlade = display.newImageRect("image/left-blade.png",30,20)
  leftBlade.x = 0
  leftBlade.y = display.contentCenterY - 12
  leftBlade:rotate(-12)
  physics.addBody(leftBlade,"dynamic")
  transition.to( leftBlade, { x=500, y=display.contentCenterY - 7,iterations=0,time=7000 } )
end
leftBladeFun()--]]