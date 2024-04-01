    p = love.physics
    g = love.graphics
    k = love.keyboard

    function love.load()
        
        backgroundfade = 0

        textblink = 255

        fadein = false

        scene = 1

        width, height = g.getDimensions()

        ScaleX, ScaleY = width/3840, height/2160




        love.mouse.setVisible(false) -- make default mouse invisible

        cursor = love.graphics.newImage("Sprites/Cursor.png") -- load in a custom mouse image

        
        
        
        SplashScreenFontSize = love.graphics.newFont(32)
        GameScreenFontSize = love.graphics.newFont(40)



        textlimit = width -- ideally needs to be bigger than or equal to screen resoultion (pixels on the width axis)

        

        InviteFriendGameScreen = {
            {},
            {},
            {},
            {},
            {},
            {}
        }
        
        InviteFriendGameScreen[3].SX = width/24

        InviteFriendGameScreen[3].SY = height/48

        InviteFriendGameScreenHeight =  height - height/4 - height/20

        InviteFriendGameScreen[1].X, InviteFriendGameScreen[1].Y = width/4 - (InviteFriendGameScreen[3].SX)/2, InviteFriendGameScreenHeight
        
        InviteFriendGameScreen[2].X, InviteFriendGameScreen[2].Y =  (width - width/4) - (InviteFriendGameScreen[3].SX)/2 , InviteFriendGameScreenHeight

        InviteFriendGameScreen[4].X, InviteFriendGameScreen[4].Y = width/4 - (InviteFriendGameScreen[3].SY)/2, InviteFriendGameScreenHeight - (InviteFriendGameScreen[3].SY/4) - (InviteFriendGameScreen[3].SY) --(height - height/4) - (InviteFriendGameScreen[3].SX)/2 + InviteFriendGameScreenHeight

        InviteFriendGameScreen[5].X, InviteFriendGameScreen[5].Y = (width - width/4) - (InviteFriendGameScreen[3].SY)/2, InviteFriendGameScreenHeight - (InviteFriendGameScreen[3].SY/4) - (InviteFriendGameScreen[3].SY)


        ellipse = {
            {},
            {},
            {}
        }

        ellipseRatio = 200

        ellipseHeight = height - height/7

        ellipse[1].X = width/4
        ellipse[1].Y = ellipseHeight
        
        ellipse[2].X = width/2
        ellipse[2].Y = ellipseHeight

        ellipse[3].X = width - ellipse[1].X
        ellipse[3].Y = ellipseHeight


        SelectButtonsCord = {
            {},
            {},
            {}
        }

        SelectButtonsCordY = height/2
        SelectButtonsCordX = width/16 - textlimit/2 -- dont touch texlimit/2
        
        SelectButtonsCord[1].Y = SelectButtonsCordY - height/10
        SelectButtonsCord[2].Y = SelectButtonsCordY
        SelectButtonsCord[3].Y = SelectButtonsCordY  + height/10

        SelectButtonsText = {
            "Map",
            "Mode",
            "Fill"
        }


    -- Sets Mouse Icon
        backgrounds = {
            g.newImage('Images/TitleScreen.jpg'),
            g.newImage('Images/Draft.png'),
            g.newImage('Images/Black.png')
        }

        scenes = {  
        function()    -- SplashScreen
            love.graphics.setColor(1, 1, 1, backgroundfade)
            g.draw(backgrounds[scene], 0, 0, 0, ScaleX, ScaleY)
            if backgroundfade < 1 then
                backgroundfade = backgroundfade + .005
            end
            if backgroundfade >= 1 then
                g.setFont(SplashScreenFontSize)
                g.printf({{255/255, 255/255, 255/255, textblink/255}, "PRESS ENTER TO START"}, width/2 - textlimit/2 , height - height/20, textlimit, "center") -- 1:2 ratio, it is what it is textlimit
                if fadein then
                    textblink = textblink + 1
                    if textblink == 255 or textblink > 255 then
                        fadein = false
                    end
                elseif fadein == false then
                    textblink = textblink - 1
                    if textblink == 0 or textblink < 0 then
                        fadein = true
                    end
                end
            end
        end,
        function() -- GameScreen
            love.graphics.setColor(1, 1, 1)

            g.draw(backgrounds[scene], 0, 0, 0, ScaleX, ScaleY)

            love.graphics.setColor(1, 1, 1)

            -- These are the circles for the player sprite to stand on
            for i = 1, 3, 1 do 
                love.graphics.ellipse("line", ellipse[i].X, ellipse[i].Y, ellipseRatio, ellipseRatio*.25)           
            end


            ---
            love.graphics.setColor(1, 1, 1)
                -- horizontal part

            for i = 1, 2, 1 do 
                love.graphics.rectangle("fill", InviteFriendGameScreen[i].X, InviteFriendGameScreen[i].Y, InviteFriendGameScreen[3].SX, InviteFriendGameScreen[3].SY)
            end
                --- vetical part (kys)
            for i = 4, 5, 1 do
                love.graphics.rectangle("fill", InviteFriendGameScreen[i].X, InviteFriendGameScreen[i].Y, InviteFriendGameScreen[3].SY, InviteFriendGameScreen[3].SX)
            end


            g.setFont(GameScreenFontSize)
            
            for i = 1, 3, 1 do
                g.printf({{255/255, 255/255, 255/255, 255/255},  SelectButtonsText[i]}, SelectButtonsCordX, SelectButtonsCord[i].Y, textlimit, "center")
            end
        end
            }
        function SceneSwtichers()
            function love.keypressed(key, scancode, isrepeat)
                print(key)
                if key == "escape" then
                    love.event.quit()
                end
                if key == "return" then
                    if scene == 1 then
                        scene = 2
                    end
                end
                if 0 < tonumber(key) and tonumber(key) < 10 then
                    scene = tonumber(key)
                end
            end
            function love.mousepressed(x, y, button, istouch)
                if scene ~= 1 and button ~= 1 then return end
                    scene = 2
            end
        end


        function CustomMouse()
            love.graphics.setColor(1, 1, 1)
            local x, y = love.mouse.getPosition() -- get the position of the mouse
            love.graphics.draw(cursor, x, y) -- draw the custom mouse image
        end

    end

    function love.update(dt)
        SceneSwtichers()
    end



    function love.draw()
        scenes[scene]()
        CustomMouse()
    end