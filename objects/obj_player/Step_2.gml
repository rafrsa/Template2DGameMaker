if(place_meeting(x + velh, y, obj_ground)){
	while(!place_meeting(x + sign(velh), y, obj_ground)){
		x += sign(velh);
	}
	velh = 0;
}
x += velh;

if(place_meeting(x, y + velv, obj_ground)){
	while(!place_meeting(x, y + sign(velv), obj_ground)){
		y += sign(velv);
	}
	velv = 0;
}
y += velv;