function TimedUpdate()
	if(assassin_on == true) then
		ASNupdate();
	end

end 

RegisterTimedEvent("TimedUpdate",30*1000,0);