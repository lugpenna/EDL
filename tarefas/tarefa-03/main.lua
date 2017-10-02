
function love.load()
	boss = love.graphics.newImage("likeaboss.jpg")
	
	largura = boss:getWidth()
	altura = boss:getHeight()
end


function love.draw()
	    
	love.graphics.print("Hello World", 350, 50)
	love.graphics.print("Luiz Augusto", 350, 75)
	love.graphics.draw(boss, 250, 200, math.rad(0), largura/5000, altura/5000)
end 
