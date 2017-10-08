-- O jogo: Uma bola é lançada aleatóriamente e o  objetivo é fazer com que a bola não ultrapasse a barra. Cada vez que a barra toca na bola, o seu score aumenta. Existem níveis de dificuldade no jogo, onde a velocidade da bola aumenta progressivamente e a largura da barra diminui progressivamente.
-- Níveis: Baby Level (Score: 0 até 10), Easy Level (Score: 10 até 25), Medium Level (Score: 25 até 50), Hard Level (Score: 50 até 75), Insane Level (Score: 75 até 100), God Level (Score: Maior que 100)

local barra = {
	width = 150,
	height = 20,
	speed = 310,
	x = love.graphics.getWidth() / 2 -200/2, 
	y = love.graphics.getHeight() - 100 - 25/2
}

local bola = {
	width = 13,
	height = 15,
	speed = 270,
	x = love.graphics.getWidth() / 2 - 25/2,
	y = love.graphics.getHeight() / 2 - 600/2 ,
	direcao = {
		x = 0,
		y = 1
	}
}


function love.load()
   	love.window.setMode(640, 480)
	state = "menu"	
end



function love.keypressed (key)
    if state == "menu" then
        if key == "space" then
        	start()
	elseif key == "escape" then
		love.event.quit()
        end

    elseif state == "gameover" then
	if key == "space" then
		love.event.quit( "restart" )		
    	elseif key == "escape" then
       		love.event.quit()
  	end
  
    elseif state == "playing" then
	if key == "escape" then            
		love.event.quit()
	end       
    end
end	


function start ()
    score = 0
    state = "playing"
    bola.direcao.x = love.math.random(0.15, 0.35) * 2 - 1 
    barra.y = love.graphics.getHeight() - 100 - 25/2	
end



function love.update(dt)
	
	if state == "playing" then
		
		local direcao = 0
		if love.keyboard.isDown("d") then
			direcao = 1
		end
	
		if love.keyboard.isDown("a") then
			direcao = -1
		end

		barra.x = barra.x + (dt * barra.speed) * direcao
		
		bola.x = bola.x + (dt * bola.speed) * bola.direcao.x
		bola.y = bola.y + (dt * bola.speed) * bola.direcao.y
		
		if bola.x < 0 then
			bola.x = 0
			bola.direcao.x = bola.direcao.x * -1
		elseif bola.x > love.graphics.getWidth() - bola.width then
			bola.x = love.graphics.getWidth() - bola.width			
			bola.direcao.x = bola.direcao.x * -1	
		end
		
		
		
		if bola.y < 0 then
			bola.y = 0			
			bola.direcao.y = bola.direcao.y * -1
		elseif bola.y > love.graphics.getHeight() - bola.height then
			bola.y = love.graphics.getHeight() - bola.height
			bola.direcao.y = bola.direcao.y * -1
		end 
	
		if bola.y > barra.y - bola.height then
			score = score + 1
			if score < 10 then
				barra.width  = barra.width - 0.8
				bola.speed = bola.speed + 2
			elseif score < 25 then
				barra.width  = barra.width - 0.9				
				bola.speed = bola.speed + 2.15
			elseif score < 50 then
				barra.width  = barra.width - 0.92			
				bola.speed = bola.speed + 2.2
			elseif score < 75 then
				barra.width  = barra.width - 0.95				
				bola.speed = bola.speed + 2.25
			elseif score < 100 then
				barra.width  = barra.width - 0.97				
				bola.speed = bola.speed + 2.3
			end				
			if bola.x < barra.x + barra.width and bola.x > barra.x then
				bola.y = barra.y - bola.height
				bola.direcao.y = bola.direcao.y * -1
				
				
			else				
				state = "gameover"
								
			end	
		end
	
	end
end

function love.draw()
	if state == "menu" then
       		love.graphics.setColor(0,0,255)
        	love.graphics.setFont(love.graphics.newFont(50))
      		love.graphics.printf("Ultimate Pong Game 1.0",0,0,640,'center')
      		love.graphics.setColor(255,255,255)
        	love.graphics.setFont(love.graphics.newFont(25))
        	love.graphics.printf("Espaço para comecar\nEsc para sair",150,100,640,'left')
		love.graphics.printf("\n\nUtilize as teclas 'A' e 'D' para mover a barra" ,50,100,640,'left')

	elseif state == "playing" then 
		love.graphics.setColor(0, 255, 0, 255)
		love.graphics.rectangle("fill", barra.x, barra.y, barra.width, barra.height)
		
		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.rectangle("fill", bola.x, bola.y, bola.width, bola.height)

		love.graphics.printf("Score: "..score,0,0,640,'left')
		if score < 10 then
			love.graphics.printf("BABY LEVEL", 0, 450, 640, "center")
		elseif score < 25 then
			love.graphics.printf("EASY LEVEL", 0, 450, 640, "center")
		elseif score < 50 then
			love.graphics.printf("MEDIUM LEVEL", 0, 450, 640, "center")
		elseif score < 75 then
			love.graphics.printf("HARD LEVEL", 0, 450, 640, "center")
		elseif score < 100 then
			love.graphics.printf("INSANE LEVEL", 0, 450, 640, "center")
		elseif score >= 100 then
			love.graphics.printf("GOD LEVEL", 0, 450, 640, "center")
		end
	elseif state == "gameover" then
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.printf("GAME OVER!", 0, 240, 640, "center")
		love.graphics.printf("Score: "..score-1,0,0,640,'left')
		love.graphics.printf("\nEspaço retorna ao menu", 0, 240, 640, "center")
		love.graphics.printf("\n\nEsc para sair", 0, 240, 640, "center")
	end
end 


