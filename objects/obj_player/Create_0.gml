grav = .3;
acel_ground = .1;
acel_air = .07;
acel = acel_ground;

sidePlayer = 1;

velh = 0;
velv = 0;

max_velh = 6;
max_velv = 8;
dashVel = 10;

jumpTolerance = 6;
timerToJump = 0;

limitBuffer = 6;
timerFall = 0;
jumpBuffer = false;

limitWallJumping = 6;
timerToWallJump = 0;
lastWallTouched = 0;


dashDuration = room_speed / 4;
dashDir = 0;

isWallLeft = false;
isWallRight = false;
slideWall = 2;

isGround = false;

yscale = 1;
xscale = 1;

enum states{
	stopped,
	moving,
	dash
}

state = states.stopped;