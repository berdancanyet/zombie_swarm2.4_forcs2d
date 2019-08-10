local exec = parse
local dfl = dofile

dfl("sys/lua/zswarm2.4/config.lua")
dfl("sys/lua/zswarm2.4/lightning_sys.lua")
dfl("sys/lua/zswarm2.4/main_func.lua")

extra = {}
extra.dmg = {}
zombiei = {}

function _hit(id,source,wpn,hp)
if (player(source,"team")==2) and (player(id,"team")==1) then
exec("sv_soundpos \"zombie_swarm2.4/zombie_pain"..math.random(1,2)..".wav\" "..player(id,"x").." "..player(id,"y").."")
elseif (player(source,"team")==1) and (player(id,"team")==2) then
exec("sv_soundpos \"zombie_swarm2.4/human_pain"..math.random(1,2)..".wav\" "..player(id,"x").." "..player(id,"y").."")
end
if player(id,"team") == 1 then
    if extra.dmg[id] > 0 then
        extra.dmg[id] = extra.dmg[id] - hp
		exec('hudtxt2 '..id..' 1 "©255255255Extra Health: '..extra.dmg[id]..' " 20 430')
        return 1
end
	if extra.dmg[id] <= 0 then
		extra.dmg[id] = 0
		exec('hudtxt2 '..id..' 1 " " 20 430') end;end;end

function _spawn(id)
   if zombiei[id] then
      freeimage(zombiei[id])
      zombiei[id] = nil
   end
   if player(id,"team") == 1 then
      zombiei[id] = image("gfx/zombie_swarm2.4/zombie.png",2,0,200+id)
	  setmaxhealth(id,250)
	  sethealth(id,250)
	  speed(id,5)
	  exec("setweapon "..id.." 78")
	  strip(id,2)
	  strip(id,50)
	  get_item(id,59)
	  extra.dmg[id] = 250
	  		exec('hudtxt2 '..id..' 1 "©255255255Extra Health: '..extra.dmg[id]..' " 20 430')
      return "78,84"
   else
   	  setmaxhealth(id,100)
	  sethealth(id,100)
   end
end

function _start()
   for _, i in pairs(player(0,"tableliving")) do
       if zombiei[i] then
          freeimage(zombiei[i])
          zombiei[i] = nil
       end
       if player(i,"team") == 1 then
          zombiei[i] = image("gfx/zombie_swarm2.4/zombie.png",2,0,200+i)
       end
   end
end

function _ondisconnect(id)
   if zombiei[id] then
      freeimage(zombiei[id])
      zombiei[id] = nil
   end
   end

teamc = false

function _endround(a)
	if a == 4 or a == 5 then return end
	teamc = true
	for _,i in pairs(player(0,"table")) do
        if player(i,"team") ~= 0 then
            exec("make"..(player(i,"team")==1 and "ct" or "t").." "..i)
        end
    end
	teamc = false
end

function _team(id)
	if player(id,"team") > 0 then
		if not teamc then return 1 end
	end
end

function _say(id,message)
if message==".bm" or message==".BM" or message=="BM" or message=="bm" then
if player(id,"team")==2 then
menu(id,"Buy Menu for Humans,M3 Shotgun|4000$,XM1014 Shotgun|4500$,P90|6000$,M4A1|7000$,AK47|7000$,M249|10k$,Flare|1500$")
return 1;
end
if player(id,"team")==1 then
menu(id,"Buy Menu for Zombies,Gut|2000$")
return 1;
end
end
end
 
function _hmenu(id,baslik,buton)
if baslik=="Buy Menu for Humans" then
if buton==1 then
if player(id,"money")>=4000 then
		buy(id,4000,10,"M3")
	else error(id)
end 
end
if buton==2 then
if player(id,"money")>=4500 then
		buy(id,4500,11,"XM1014")
	else error(id)
end 
end
if buton==3 then
if player(id,"money")>=6000 then
		buy(id,6000,22,"P90")
	else error(id)
end 
end
if buton==4 then
if player(id,"money")>=7000 then
		buy(id,7000,32,"M4A1")
	else error(id)
end 
end
if buton==5 then
if player(id,"money")>=7000 then
		buy(id,7000,30,"AK47")
	else error(id)
end 
end
if buton==6 then
if player(id,"money")>=10000 then
		buy(id,10000,40,"M249")
	else error(id)
end 
end
if buton==7 then
if player(id,"money")>=1500 then
		buy(id,1500,54,"Flare")
	else error(id)
end 
end
end
end
 
function _zmenu(id,baslik,buton)
if baslik=="Buy Menu for Zombies" then
if buton==1 then
if player(id,"money")>=2000 then
		buy(id,2000,86,"Gut")
	else error(id)
end 
end
end
end

--Callback Functions--
function get_item(id,iid) 
    local x, y = player(id,"tilex"), player(id,"tiley")
    exec("setpos "..id.." 0 0")
    exec("spawnitem "..iid.." "..x.." "..y)
    exec("setpos "..id.." ".. x*32+16 .." ".. y*32+16)
end

function buy(id,mon,eq,nm) --int, int, int, string
	exec("sv_soundpos \"items/pickup.wav\" "..player(id,"x").." "..player(id,"y").."")
	exec("equip "..id.." "..eq) 
	exec("setweapon "..id.." "..eq)
	exec("setmoney "..id.." "..player(id,"money")-mon)
	msg2(id,"You have bought a "..nm.." for "..mon.."$@C")
end

function error(id)
id = tonumber(id)
msg2(id,"You don't have enough money to buy this!@C")
end

addhook("team","_team");
addhook("spawn","_spawn");
addhook("startround","_start");
addhook("hit","_hit");
addhook("endround","_endround");
addhook("say","_say");
addhook("menu","_hmenu");
addhook("menu","_zmenu");
addhook("leave","_ondisconnect");
