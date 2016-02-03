selectedVersion = 1
limitedInfectionMode = false
specificInfectionNumber = 0

--Handles all keyboard controls
function checkKeyboardInput(key)
	--If key is a number, set the selectedVersion to that value
	if limitedInfectionMode then
		--Cancel limitedInfectionMode
		if key == "escape" then
			limitedInfectionMode = false
		end

		--Get number input
		if tonumber(key) then
			if specificInfectionNumber == 0 then
				if key == 0 then
					specificInfectionNumber = 0
				else
					specificInfectionNumber = tonumber(key)
				end
			else
				specificInfectionNumber = tonumber(specificInfectionNumber..key)
			end

			--Execute limitedInfection
		elseif key == "return" or key == "enter" then
			limitedInfectionMode = false
			limitedInfection(specificInfectionNumber, selectedVersion)
		end

	else
		--End Program
		if key == "escape" then
			love.event.quit()
		end

		--Change selected Version
		if tonumber(key) then
			selectedVersion = tonumber(key)
		end

		if key == "r" then
			userNodes = createNodes()
		end

		if key == "return" or key == "enter" then
			limitedInfectionMode = true
			specificInfectionNumber = 0
		end

		if key == "s" then
			UserNode.scrambleNodes(userNodes)
		end
	end
end

--Handles mouse clicks
function mouseInput()
	--If first mouse click
	if lm.isDown(1) and firstClick then
		firstClick = false
		for k,node in pairs(userNodes) do
			local x, y = lm.getPosition()
			--Checks if the mouse clicked over a node
			if node:handleClick(x, y, selectedVersion, 1) then 
				break --Break if hit one node so don't hist overlapping nodes
			end
		end
		
	elseif not lm.isDown(1) then
		firstClick = true
	end
end