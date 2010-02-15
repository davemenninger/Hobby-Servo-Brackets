
<servo_bracket_modules.scad>


module servo_bracket_foot()
{

	servo_bracket();

	//toes and heel
	//======
	difference(){
		union(){
			//toe
			translate( [ (B+C+10)*0.8, -20, -thickness ] ){
				rotate( 20, [0,0,1] ){
					cylinder( h=thickness, r=15 );
					translate( [ -5, 0, 0 ] ){
						cube( size=[ 10, 30, thickness ] );
					}
				}
			}
			//toe
			translate( [ (B+C+10)*0.2, -20, -thickness ] ){
				rotate( -20, [0,0,1] ){
					cylinder( h=thickness, r=15 );
					translate( [ -5, 0, 0 ] ){
						cube( size=[ 10, 30, thickness ] );
					}
				}
			}
			//heel
			translate( [ (B+C+10)*0.5, H*2, -thickness ] ){
				rotate( 180, [0,0,1] ){
					cylinder( h=thickness, r=15 );
					translate( [ -5, 0, 0 ] ){
						cube( size=[ 10, 30, thickness ] );
					}
				}
			}
		}
		rotate( 90, [1,0,0]){
			mountpoint( B, 1, -H/2 );
			mountpoint( (B+C+10)-B, 1, -H/2 );
		}
	}
}

servo_bracket_foot();

