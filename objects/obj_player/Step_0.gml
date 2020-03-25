isGround = place_meeting(x, y + 1, obj_ground);
isWallLeft = place_meeting(x - 1, y, obj_ground);
isWallRight = place_meeting(x + 1, y + 1, obj_ground);

if(isGround){
	timerToJump = jumpTolerance;
}else{
	if(timerToJump > 0){
		timerToJump--;
	}
}

if(isWallLeft || isWallRight){
	if(isWallRight){
		lastWallTouched = 0;
	}else{
		lastWallTouched = 1;
	}
	
	timerToWallJump = limitWallJumping;
}else{
	if(timerToWallJump > 0){
		timerToWallJump--;
	}
}

var left, right, up, down, jump, move_h, jumpHeight, dash;
left = keyboard_check(ord("A"));
right = keyboard_check(ord("D"));
up = keyboard_check(ord("W"));
down = keyboard_check(ord("S"));
jump = keyboard_check_pressed(ord("K"));
jumpHeight =keyboard_check_released(ord("K"));
dash = keyboard_check_pressed(ord("L"));

move_h = (right - left) * max_velh;
if(isGround){
	acel = acel_ground;
}else{
	acel = acel_air;
}

switch(state){
	case states.stopped:
		velh = 0;
		velv = 0;
		
		if((isGround || timerToJump) && jump){
			velv = -max_velv;
			
			xscale = .5;
			yscale = 1.5;
		}
		
		if(!isGround && (isWallLeft || isWallRight)){
			if(velv > 0){
				velv = lerp(velv, slideWall, acel);
			}else{
				velv += grav;
			}
			
			if(isWallRight && jump){
				velv = -max_velv;
				velh = -max_velh;
				xscale = .5;
				yscale = 1.5
			}else if(isWallLeft && jump){
				velv = -max_velv;
				velh = max_velh;
				xscale = .5;
				yscale = 1.5
			}
		}else if(!isGround){
			velv += grav;
		}
		
		if(abs(velh) > 0 || abs(velv) > 0 || left || right || jump){
			state = states.moving;
		}		
		
		if(dash){
			if(up && right){
				dashDir = 45;
			}else if(up && left){
				dashDir = 135;
			}else if(down && right){
				dashDir = 315;
			}else if(down && left){
				dashDir = 225;
			}else if(up){
				dashDir = 90;
			}else if(down){
				dashDir = 270;
			}else if(right){
				dashDir = 0;
			}else if(left){
				dashDir = 180;
			}
			//dashdir = point_direction(0, 0, (right - left), (down - up));
			
			state = states.dash;
		}
		break;
	case states.moving:			
	
		if(isGround && down){
			xscale = 1.5;
			yscale = .5;
		}
	
		velh = lerp(velh, move_h, acel);		
		
		if(abs(velh) > max_velh - .5 && isGround){
			for(var i = 0; i < irandom_range(0, 1); i++){
				var xx = random_range(x - sprite_width/2, x + sprite_width/2);
		
				instance_create_layer(xx, y, layer, obj_dust);
			}
		}
			
		if(!isGround && (isWallLeft || isWallRight || timerToWallJump)){
			if(velv > 0){
				velv = lerp(velv, slideWall, acel);
				
				for(var i = 0; i < irandom_range(0, 1); i++){					
					var isWallsliding = isWallRight - isWallLeft;
					var xx = x + isWallsliding * sprite_width/2;
					var yy = y - sprite_height/2;
					instance_create_layer(xx, yy, layer, obj_dust);
				}
				
			}else{
				velv += grav;
			}
			
			if(!lastWallTouched && jump){
				velv = -max_velv;
				velh = -max_velh;
				xscale = .5;
				yscale = 1.5;
				
				for(var i = 0; i < irandom_range(0, 1); i++){										
					var xx = x + sprite_width/2;
					var yy = y - sprite_height/2;
					instance_create_layer(xx, yy, layer, obj_dust);
				}
			}else if(lastWallTouched && jump){
				velv = -max_velv;
				velh = max_velh;
				xscale = .5;
				yscale = 1.5;
				
				for(var i = 0; i < irandom_range(0, 1); i++){										
					var xx = x - sprite_width/2;
					var yy = y + sprite_height/2;
					instance_create_layer(xx, yy, layer, obj_dust);
				}
			}
		}else if(!isGround){
			velv += grav;
		}
		
		
		if((isGround || timerToJump) && jump){
			velv = -max_velv;
			
			xscale = .5;
			yscale = 1.5;
			
			for(var i = 0; i < irandom_range(2, 5); i++){
				var xx = random_range(x - sprite_width, x + sprite_width);
		
				instance_create_layer(xx, y, layer, obj_dust);
			}
		}
		
		if(jump){
			timerFall = limitBuffer;
		}
		
		if(timerFall > 0){
			jumpBuffer = true;
		}else{
			jumpBuffer = false;
		}
		
		if(jumpBuffer){
			if((isGround || timerToJump) && jump){
				velv = -max_velv;
			
				xscale = .5;
				yscale = 1.5;
				
				timerToJump = 0;
				timerFall = 0;
				
				for(var i = 0; i < irandom_range(2, 5); i++){
					var xx = random_range(x - sprite_width, x + sprite_width);
		
					instance_create_layer(xx, y, layer, obj_dust);
				}
			}
			
			timerFall--;
		}		
		
		if(jumpHeight && velv < 0){
			velv *= .4;
		}
		
		if(dash){
			
			if(up && right){
				dashDir = 45;
			}else if(up && left){
				dashDir = 135;
			}else if(down && right){
				dashDir = 315;
			}else if(down && left){
				dashDir = 225;
			}else if(up){
				dashDir = 90;
			}else if(down){
				dashDir = 270;
			}else if(right){
				dashDir = 0;
			}else if(left){
				dashDir = 180;
			}			
						
			state = states.dash;
		}		
		
		velv = clamp(velv, -max_velv, max_velv);
		break;
	case states.dash:
		dashDuration--;
		image_blend = c_red;
		
		var trail = instance_create_layer(x, y, layer, obj_dashTrail);
		trail.xscale = xscale;
		trail.yscale = yscale;
		
		velh = lengthdir_x(dashVel, dashDir);
		velv = lengthdir_y(dashVel, dashDir);
		
		if(dashDir == 90 || dashDir == 270){
			yscale = 1.5;
			xscale = .5
		}else{
			yscale = .5;
			xscale = 1.5
		}
		
		if(dashDuration <= 0){
			state = states.moving;
			dashDuration = room_speed / 4;
			image_blend = c_white;
			
			velh = (max_velh * sign(velh) * .5);
			velv = (max_velv * sign(velv) * .5);
			
		}
		break;
}

xscale = lerp(xscale, 1, .15);
yscale = lerp(yscale, 1, .15);