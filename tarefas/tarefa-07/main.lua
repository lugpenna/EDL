-- O jogo: Uma bola é lançada aleatóriamente e o  objetivo é fazer com que a bola não ultrapasse a barra. Cada vez que a barra toca na bola, o seu score aumenta. Existem níveis de dificuldade no jogo, onde a velocidade da bola aumenta progressivamente e a largura da barra diminui progressivamente. Progressivamente também são criadas bombas que não podem colidir com a bola.
-- Níveis: Baby Level (Score: 0 até 5), Easy Level (Score: 5 até 10), Medium Level (Score: 10 até 15), Hard Level (Score: 15 até 20), Insane Level (Score: 25 até 30), God Level (Score: Maior que 30)

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
-- Tarefa 07
-- Criando array com bombas com escopo global
bombas = {}

-- Tarefa 07
-- Função que cria bombas
function criaBomba()
    bomba = {
        x = math.random(10,470),
        y = math.random(100,130),
        width = 5,
        height = 5,
    }
    table.insert(bombas, bomba)
end

-- Tarefa 07
-- Função que remove bombas
function removeBombas()
    for i = #bombas, 1, -1 do
        table.remove(bombas,i)
    end
end
	
 
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
		
		-- Tarefa 07
		-- Quando a bola colide com a bomba, o jogo acaba
		for k,bomba in pairs(bombas) do
        			if bomba.x < bola.x + bola.width and
				   bola.x < bomba.x + bomba.width and 
				   bomba.y < bola.y + bola.height and
				   bola.y < bomba.y + bomba.height
				   then
					state = "gameover"
				end
            	end
		
		if bola.y > barra.y - bola.height then
			score = score + 1
			if score < 10 then
				barra.width  = barra.width - 0.7
				bola.speed = bola.speed + 2
			elseif score < 15 then
				barra.width  = barra.width - 0.8				
				bola.speed = bola.speed + 2.1
			elseif score < 20 then
				barra.width  = barra.width - 0.9			
				bola.speed = bola.speed + 2.15
			elseif score < 25 then
				barra.width  = barra.width - 0.95				
				bola.speed = bola.speed + 2.20
			elseif score < 30 then
				barra.width  = barra.width - 0.97				
				bola.speed = bola.speed + 2.25
			end
			-- Tarefa 07
			-- Tempo de vida da bomba está associado ao score do jogador
			if score == 3  then
				criaBomba()
			elseif score == 5  then
				removeBombas()				
				criaBomba()
				criaBomba()
			elseif score == 10  then
				removeBombas()				
				criaBomba()
				criaBomba()				
			elseif score == 15 then
				removeBombas()
				criaBomba()
				criaBomba()
			elseif score == 18 then
				removeBombas()
				criaBomba()
				criaBomba()
			elseif score == 20 then
				removeBombas()
				criaBomba()
				criaBomba()
				criaBomba()
			elseif score == 22 then
				removeBombas()
				criaBomba()
				criaBomba()
				criaBomba()
			elseif score == 25 then
				removeBombas()
				criaBomba()
				criaBomba()
				criaBomba()
				criaBomba()
			elseif score == 27 then
				removeBombas()
				criaBomba()
				criaBomba()
				criaBomba()
				criaBomba()
			elseif score > 30 then
				removeBombas()
				criaBomba()
				criaBomba()
				criaBomba()
				criaBomba()
				criaBomba()
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
	
		for k,bomba in pairs(bombas) do
        		love.graphics.setColor(0, 0, 255)
			love.graphics.rectangle("fill", bomba.x, bomba.y, bomba.width, bomba.height)
    		end		
		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.printf("Score: "..score,0,0,640,'left')
		if score < 5 then
			love.graphics.setColor(255, 0, 0, 255)
			love.graphics.printf("BABY LEVEL", 0, 450, 640, "center")
		elseif score < 10 then
			love.graphics.setColor(255, 0, 0, 255)
			love.graphics.printf("EASY LEVEL", 0, 450, 640, "center")
		elseif score < 15 then
			love.graphics.setColor(255, 0, 0, 255)
			love.graphics.printf("MEDIUM LEVEL", 0, 450, 640, "center")
		elseif score < 20 then
			love.graphics.setColor(255, 0, 0, 255)
			love.graphics.printf("HARD LEVEL", 0, 450, 640, "center")
		elseif score < 25 then
			love.graphics.setColor(255, 0, 0, 255)
			love.graphics.printf("INSANE LEVEL", 0, 450, 640, "center")
		elseif score >= 30 then
			love.graphics.setColor(255, 0, 0, 255)
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

