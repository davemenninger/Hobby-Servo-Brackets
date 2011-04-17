
include <servo_bracket_modules.scad>


module servo_bracket_lower_leg_right(){

	difference(){
		union(){
			//standard bracket
			servo_bracket();

			//C bracket connects to ankle below
			translate( [ 0, E*2, -(H+G+X)/2 ] ){
				rotate( 90, [1,0,0] ){
				rotate( -90, [0,1,0] ){
					servo_bracket_C();
				}
				}
			}
		}
	}

}

module servo_bracket_lower_leg_left(){

	mirror( [ 0, 1, 0 ] ){
		servo_bracket_lower_leg_right();
	}
}


servo_bracket_lower_leg_right();