-- ZS 2.4 Main Functions
--[[Do not edit these functions.]]--
local exec = parse
local m2 = msg2

function _drop(id)
	if player(id,"team") == 1 then 
		return 1;
	end
end

function _walkover(id,iid,type)
	if player(id,"team")==2 and (type==59) or (type==84) then 
		return 1;
	elseif player(id,"team")==1 and (type~=59) then 
		return 1;
	end
end

--[[addhook("collect","nocollect")
function nocollect(id,iid,type)
if player(id,"team")==1 and (type~=59) then
exec("strip "..id.." "..type)
end
end ]]--

function _die(id)
	if player(id,"team")==1 then 
		exec('hudtxt2 '..id..' 1 " " 20 430') 
		return 1;
	end
end

function _flash(id)
	if player(id,"team")==1 then 
		m2(id,"Humans can notice you easier, if you use flashlight!@C")
	end
end

function _buy(id)
	return 1;
end

--Callback Functions--
function equip(id,weapon)
	exec("equip "..id.." "..weapon) 
end

function strip(id,weapon)
	exec("strip "..id.." "..weapon) 
end

function setmaxhealth(id,maxhealth)
	exec("setmaxhealth "..id.." "..maxhealth) 
end

function sethealth(id,health)
	exec("sethealth "..id.." "..health) 
end

function speed(id,amount)
	exec("speedmod "..id.." "..amount) 
end
	
addhook("drop","_drop");
addhook("walkover","_walkover");
addhook("die","_die");
addhook("flashlight","_flash");
addhook("buy","_buy");
