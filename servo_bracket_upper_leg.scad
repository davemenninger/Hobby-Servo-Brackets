
<servo_bracket_modules.scad>


module servo_bracket_upper_leg(){

	difference(){
		union(){
			//C bracket connects to lower leg
			translate( [0, 0, 0 ] ){
				rotate( -90, [0,1,0] ){
					servo_bracket_C();
				}
			}

			//C bracket connects to hip
			translate( [ thickness, 0, B*2 ] ){
				rotate( 90, [0,1,0] ){
					servo_bracket_C();
				}
			}
		}
	}

}

servo_bracket_upper_leg();