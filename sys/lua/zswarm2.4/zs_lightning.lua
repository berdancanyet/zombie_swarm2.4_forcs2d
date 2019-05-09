## ZS 2.4 lightning system 

addhook("startround","round")
function round()
parse("sv_sound zombie_swarm2.4/3dmstart.wav")
end;round()
		
function thunder()
		parse("sv_sound env/thunder.wav")
		timer(500,"parse",'sv_daylighttime 185')
		timer(500,"parse",'flashplayer 0 40')
		timer(1500,"parse",'sv_daylighttime 21')
end

timer(15000,"thunder","",0)
		
function play()
parse("sv_sound zombie_swarm2.4/ambience.ogg")
timer(17000,"play")
end;play()