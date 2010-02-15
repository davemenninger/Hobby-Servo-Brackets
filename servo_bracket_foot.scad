
<servo_bracket_modules.scad>


module servo_bracket_foot()
{

module toe(){
	cylinder( h=thickness, r=15 );
	translate( [ -5, 0, 0 ] ){
		cube( size=[ 10, 30, thickness ] );
	}
}
					
	difference(){
		union(){
			//standard bracket
			servo_bracket();

			//toe
			translate( [ (B+C+10)*0.8, -20, -thickness ] ){
				rotate( 20, [0,0,1] ){
					toe();
				}
			}

			//toe
			translate( [ (B+C+10)*0.2, -20, -thickness ] ){
				rotate( -20, [0,0,1] ){
					toe();
				}
			}

			//heel
			translate( [ (B+C+10)*0.5, H*2, -thickness ] ){
				rotate( 180, [0,0,1] ){
					toe();
				}
			}

		}
	}
}

servo_bracket_foot();

