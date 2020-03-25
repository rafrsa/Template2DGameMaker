var touchGround = place_meeting(x, y + 1, obj_ground);
	

if(touchGround && !isGround){
	xscale = 1.5;
	yscale = .5
	
	for(var i = 0; i < irandom_range(4, 10); i++){
		var xx = random_range(x - sprite_width, x + sprite_width);
		
		instance_create_layer(xx, y, layer, obj_dust);
	}
}

if(keyboard_check(vk_enter)){
	game_restart();
}