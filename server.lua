dofile("sys/lua/zswarm2.4/zs_config.cfg")
dofile("sys/lua/zswarm2.4/zs_lightning.lua")
dofile("sys/lua/zswarm2.4/zs_main_functions.lua")

function konumfarki(fx,fy,tx,ty)
return math.sqrt((fx-tx)^2+(fy-ty)^2)
end

function Sound3(dosya,x,y,tiled)
	for _, id in ipairs(player(0,"tableliving")) do
		if konumfarki(x,y,player(id,"x"),player(id,"y")) < tiled then
			parse('sv_sound2 '..id..' '..dosya)
		end
	end
end

extra = {}
extra.dmg = {}

addhook("hit","pain")
function pain(id,source,wpn,hp)
if (player(source,"team")==2) and (player(id,"team")==1) then
Sound3("zombie_swarm2.4/zombie_pain"..math.random(1,2)..".wav",player(id,"x"),player(id,"y"),256)
elseif (player(source,"team")==1) and (player(id,"team")==2) then
Sound3("zombie_swarm2.4/human_pain"..math.random(1,2)..".wav",player(id,"x"),player(id,"y"),256)
end
if player(id,"team") == 1 then
    if extra.dmg[id] > 0 then
        extra.dmg[id] = extra.dmg[id] - hp
		parse('hudtxt2 '..id..' 1 "©255255255Extra Health: '..extra.dmg[id]..' " 20 430')
        return 1
end
	if extra.dmg[id] <= 0 then
		extra.dmg[id] = 0
		parse('hudtxt2 '..id..' 1 " " 20 430')
end
end
end

zombiei = {}

addhook("spawn","model")
function model(id)
   if zombiei[id] then
      freeimage(zombiei[id])
      zombiei[id] = nil
   end
   if player(id,"team") == 1 then
      zombiei[id] = image("gfx/zombie_swarm2.4/zombie.png",2,0,200+id)
	  setmaxhealth(id,250)
	  sethealth(id,250)
	  speed(id,5)
	  parse("setweapon "..id.." 78")
	  strip(id,2)
	  strip(id,50)
	  get_item(id,59)
	  extra.dmg[id] = 250 -- EXTRA CAN BURADA <<
	  		parse('hudtxt2 '..id..' 1 "©255255255Extra Health: '..extra.dmg[id]..' " 20 430')
      return "78,84"
   else
   	  setmaxhealth(id,100)
	  sethealth(id,100)
   end
end

function get_item(id,iid)
    local x, y = player(id,"tilex"), player(id,"tiley")
    parse("setpos "..id.." 0 0")
    parse("spawnitem "..iid.." "..x.." "..y)
    parse("setpos "..id.." ".. x*32+16 .." ".. y*32+16)
end

addhook("startround","_star")
function _star()
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

addhook("leave","resetmodel")
function resetmodel(id)
   if zombiei[id] then
      freeimage(zombiei[id])
      zombiei[id] = nil
   end
   end

addhook("die","zdie")
function zdie(id)
if player(id,"team")==1 then
	parse('hudtxt2 '..id..' 1 " " 20 430')
end
end

teamc = false

addhook("endround","_endround")
function _endround(a)
	if a == 4 or a == 5 then return end
	teamc = true
	for _,i in pairs(player(0,"table")) do
        if player(i,"team") ~= 0 then
            parse("make"..(player(i,"team")==1 and "ct" or "t").." "..i)
        end
    end
	teamc = false
end

addhook("team","_team")
function _team(id)
	if player(id,"team") > 0 then
		if not teamc then return 1 end
	end
end

addhook("say","custombuy")
function custombuy(id,message)
if player(id,"team")==2 and message==".bm" or message==".BM" then
menu(id,"Buy Menu,M3 Shotgun|4000$,XM1014 Shotgun|4500$,P90|6000$,M4A1|7000$,AK47|7000$,M249|10k$,Flare|1500$")
return 1
end
if player(id,"team")==1 and message==".bm" or message==".BM" then
menu(id,"Buy Menu for Zombies,Gut|2000$")
return 1
end
end

addhook("menu","custombuymenu") 
function custombuymenu(id,baslik,buton)
if baslik=="Buy Menu" then
if buton==1 then
if player(id,"money")>=4000 then
		buy(id,4000,10,"M3")
	else msg2(id,"You haven't got enough money!@C")
end 
end
if buton==2 then
if player(id,"money")>=4500 then
		buy(id,4500,11,"XM1014")
	else msg2(id,"You haven't got enough money!@C")
end 
end
if buton==3 then
if player(id,"money")>=6000 then
		buy(id,6000,22,"P90")
	else msg2(id,"You haven't got enough money!@C")
end 
end
if buton==4 then
if player(id,"money")>=7000 then
		buy(id,7000,32,"M4A1")
	else msg2(id,"You haven't got enough money!@C")
end 
end
if buton==5 then
if player(id,"money")>=7000 then
		buy(id,7000,30,"AK47")
	else msg2(id,"You haven't got enough money!@C")
end 
end
if buton==6 then
if player(id,"money")>=10000 then
		buy(id,10000,40,"M249")
	else msg2(id,"You haven't got enough money!@C")
end 
end
if buton==7 then
if player(id,"money")>=1500 then
		buy(id,1500,54,"Flare")
	else msg2(id,"You haven't got enough money!@C")
end 
end
end
end

addhook("menu","custombuymenuz") 
function custombuymenuz(id,baslik,buton)
if baslik=="Buy Menu for Zombies" then
if buton==1 then
if player(id,"money")>=2000 then
		buy(id,2000,86,"Gut")
	else msg2(id,"You haven't got enough money!@C")
end 
end
end
end

function buy(id,mon,eq,nm)
	Sound3("items/pickup.wav",player(id,"x"),player(id,"y"),64)
	parse("equip "..id.." "..eq) 
	parse("setweapon "..id.." "..eq)
	parse("setmoney "..id.." "..player(id,"money")-mon)
	msg2(id,"You have bought a "..nm.." for "..mon.."$@C")
end