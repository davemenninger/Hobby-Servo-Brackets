
<servo_bracket_modules.scad>

module toe(){

	cylinder( h=thickness, r=10 );
	translate( [ -2.5, 0, 0 ] ){
		cube( size=[ 5, 30, thickness ] );
	}

}

module servo_bracket_foot(){

	difference(){
		union(){
			//standard bracket
			servo_bracket();

			//toe
			translate( [ (B+C+10)*0.8, -12, -thickness ] ){
				rotate( 20, [0,0,1] ){
					toe();
				}
			}

			//toe
			translate( [ (B+C+10)*0.2, -12, -thickness ] ){
				rotate( -20, [0,0,1] ){
					toe();
				}
			}

			//heel
			translate( [ (B+C+10)*0.5, H*2.2, -thickness ] ){
				rotate( 180, [0,0,1] ){
					toe();
				}
			}

		}
	}

}

servo_bracket_foot();

