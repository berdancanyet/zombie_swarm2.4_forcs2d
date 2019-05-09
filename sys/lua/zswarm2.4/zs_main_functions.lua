## ZS 2.4 Main Functions
--Do not edit these functions.--

addhook("drop","nodrop")
function nodrop(id)
if player(id,"team") == 1 then --for zombies
	return 1; --no drop
end
end

addhook("walkover","nowalkover")
function nowalkover(id,iid,type)
if player(id,"team")==2 and (type==59) or (type==84) then --for humans, no walkover for nightvision and gut
return 1;
elseif player(id,"team")==1 and (type~=59)then --for zombies
return 1; --no walkover for  nightvision
end
end

--[[addhook("collect","nocollect")
function nocollect(id,iid,type)
if player(id,"team")==1 and (type~=59) then
parse("strip "..id.." "..type)
end
end --]]

addhook("die","nodrop1")
function nodrop1(id)
if player(id,"team")==1 then -- for zombies
return 1; --no drop
end
end

addhook("flashlight","_flalert")
function _flalert(id)
if player(id,"team")==1 then
msg2(id,"Humans can notice you easier, if you use flashlight!@C")
end
end

addhook("buy","nobuy")
function nobuy(id)
return 1 --buymenu is disabled
end

function equip(id,weapon)
	parse("equip "..id.." "..weapon)
end

function strip(id,weapon)
	parse("strip "..id.." "..weapon)
end

function setmaxhealth(id,maxhealth)
	parse("setmaxhealth "..id.." "..maxhealth)
end

function sethealth(id,health)
	parse("sethealth "..id.." "..health)
end

function speed(id,amount)
	parse("speedmod "..id.." "..amount)
end