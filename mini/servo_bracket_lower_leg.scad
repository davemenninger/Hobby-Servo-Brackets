
<servo_bracket_modules.scad>


module servo_bracket_lower_leg_right(){

	difference(){
		union(){
			//standard bracket
			servo_bracket();

			//C bracket connects to ankle below
			translate( [ B+C+10+(thickness*0.9),-(H+thickness*2)/2, E*2-thickness ] ){
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
			translate( [ -thickness*0.9, -(H+thickness*2)/2, -thickness ] ){
				rotate( -90, [0,1,0] ){
					servo_bracket_C();
				}
			}
		}
	}

}


//servo_bracket_lower_leg_right();

servo_bracket_lower_leg_left();