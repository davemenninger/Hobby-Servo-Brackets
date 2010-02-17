
<servo_bracket_modules.scad>


module servo_bracket_lower_leg_right(){

	difference(){
		union(){
			//standard bracket
			servo_bracket();

			//C bracket connects to ankle below
			translate( [ B+C+10, (-H/2)+thickness, A+thickness ] ){
				rotate( 90, [0,1,0] ){
					servo_bracket_C();
				}
			}
		}
	}

}

module servo_bracket_lower_leg_left(){

	difference(){
		union(){
			//standard bracket
			servo_bracket();

			//C bracket connects to ankle below
			translate( [ 0, (-H/2)+thickness, -thickness ] ){
				rotate( -90, [0,1,0] ){
					servo_bracket_C();
				}
			}
		}
	}

}


//servo_bracket_lower_leg_right();

servo_bracket_lower_leg_left();