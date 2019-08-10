--[[ ZS 2.4 lightning system by Berdan Can Yetkiner ]]--
local play = parse
local t = timer

addhook("startround","round")
function round()
play("sv_sound zombie_swarm2.4/3dmstart.wav")
end;round()
		
function thunder()
		play("sv_sound env/thunder.wav")
		timer(500,"parse",'sv_daylighttime 185')
		timer(500,"parse",'flashplayer 0 40')
		timer(1500,"parse",'sv_daylighttime 21')
end

t(15000,"thunder","",0)
		
function sound()
play("sv_sound zombie_swarm2.4/ambience.ogg")
timer(17000,"sound")
end
sound()
