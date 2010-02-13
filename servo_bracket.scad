
module servo_bracket()
{

A = 19.82;
B = 13.47;
C = 33.79;
D = 10.17;
E = 9.66;
F = 30.22;
G = 11.68;
H = 26.67;
J = 52.84;

thickness = 4;

module pinhole( x, y, z ){
	translate([x,y,z]){
		rotate(90,[1,0,0]){
			cylinder(h=thickness+2,r=2);
		}
	}
}

	//zero ball
	//sphere(r=1);

	//front plate
	//sanity check ball
	//translate( [ 0, 0, A ] ){
	//	sphere(r=1);
	//}
	difference(){
		cube( size=[ B+C+10, thickness, A+thickness ] );
		translate( [ ((B+C+10)-(E+F))/2, -1, 0] ){
			cube( size=[ E+F, thickness+2, A+5 ] );
		}

		translate( [ 0, thickness+1, 0] ){
			//four mounting holes
			pinhole( 5, 0, (A-D)/2 );
			pinhole( 5, 0, ((A-D)/2)+D );
			pinhole( B+C+5, 0, (A-D)/2 );
			pinhole( B+C+5, 0, ((A-D)/2)+D );
		}
	}

	//supports
	difference(){
		union(){
			translate( [ 0, -3, 5 ] ){
				rotate( -45, [1,0,0] ){
					cube( size=[ thickness/2 , H/1.5, A/2 ] );
				}
			}
			translate( [ (B+C+10)-(thickness/2), -3, 5 ] ){
				rotate( -45, [1,0,0] ){
					cube( size=[ thickness/2 , H/1.5, A/2 ] );
				}
			}
			translate( [ 0, H-1, -7 ] ){
				rotate( 45, [1,0,0] ){
					cube( size=[ thickness/2 , H/1.5, A/2 ] );
				}
			}
			translate( [ (B+C+10)-(thickness/2), H-1, -7 ] ){
				rotate( 45, [1,0,0] ){
					cube( size=[ thickness/2 , H/1.5, A/2 ] );
				}
			}
		}
		union(){
			translate( [ 0, 0, -thickness*2 ] ){
				cube( size=[ B+C+10, H+(thickness*2), thickness ] );
			}
			translate( [ 0, -thickness, 0 ] ){
				cube( size=[ B+C+10, thickness, A+thickness ] );
			}
			translate( [ 0, H+thickness*2, 0 ] ){
				cube( size=[ B+C+10, thickness, A+thickness ] );
			}
		}
	}

	//back plate
	//sanity check ball
	//translate( [ 0, H, 0] ){
	//	sphere(r=1);
	//}
	difference(){
		translate( [0, H+thickness, 0] ){
			cube( size=[ B+C+10, thickness, A+thickness ] );
		}

		//pivot holes behind servo
		pinhole( B+5, H+(thickness*2)+1, A/2 );
		pinhole( (B+C+10)-(B+5), H+(thickness*2)+1, A/2 );
	}

	//base
	translate( [ 0, 0, -thickness ] ){
		cube( size=[ B+C+10, H+(thickness*2), thickness ] );
	}
}

servo_bracket();

