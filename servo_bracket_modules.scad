//standard hobby servo dimensions - don't change
A = 19.82;
B = 13.47;
C = 33.79;
D = 10.17;
E = 9.66;
F = 30.22;
G = 11.68;
H = 26.67;
J = 52.84;

//thickness of the bracket parts
thickness = 4;

module pinhole( x, y, z ){
	translate([x,y,z]){
		rotate(90,[1,0,0]){
			cylinder(h=thickness+2,r=1);
		}
	}
}

module pivothole( x, y, z ){
	translate([x,y,z]){
		rotate(90,[1,0,0]){
			cylinder(h=thickness+2,r=2);
		}
	}
}

module mountpoint( x, y, z ){
		//one pivot hole in the center
		pivothole( x, y, z );

		//four mount holes
		pinhole( x+(B/2), y, z );
		pinhole( x-(B/2), y, z );
		pinhole( x, y, z-(B/2) );
		pinhole( x, y, z+(B/2) );
}

module servo_bracket()
{
	//front plate
	//======
	difference(){
		cube( size=[ B+C+10, thickness, A+thickness ] );
		translate( [ ((B+C+10)-(E+F))/2, -1, 0] ){
			cube( size=[ E+F, thickness+2, A+5 ] );
		}

		translate( [ 0, thickness+1, 0] ){
			//four mounting holes
			pivothole( 5, 0, (A-D)/2 );
			pivothole( 5, 0, ((A-D)/2)+D );
			pivothole( B+C+5, 0, (A-D)/2 );
			pivothole( B+C+5, 0, ((A-D)/2)+D );
		}
	}

	//supports
	//======
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
	//======
	difference(){
		translate( [0, H+thickness, 0] ){
			cube( size=[ B+C+10, thickness, A+thickness ] );
		}

		//pivot holes behind servo
		mountpoint( B+5, H+(thickness*2)+1, A/2 );
		mountpoint( (B+C+10)-(B+5), H+(thickness*2)+1, A/2 );
	}

	//base
	//======
	difference(){
		union(){
			translate( [ 0, 0, -thickness ] ){
				cube( size=[ B+C+10, H+(thickness*2), thickness ] );
			}
		}
		union(){
			rotate( 90, [1,0,0]){
				mountpoint( B+5, 1, -(H/2)-thickness );
				mountpoint( (B+C+10)-(B+5), 1, -(H/2)-thickness );
			}
		}
	}
}


module servo_bracket_C()
{
	//front plate
	//======
	difference(){
		union(){
			translate( [ B, thickness, A*1.5 ] ){
				rotate( 90, [ 1, 0, 0 ] ){
					cylinder( h=thickness, r=B );
				}
			}
			cube( size=[ B*2, thickness, A*1.5 ] );
		}

		mountpoint( B, thickness+1, A*1.5 );
	}

	//back plate
	//======
	difference(){
		union(){
			translate( [ B, H+G+(thickness*2), A*1.5 ] ){
				rotate( 90, [ 1, 0, 0 ] ){
					cylinder( h=thickness, r=B );
				}
			}
			translate( [ 0, H+G+thickness, 0 ] ){
				cube( size=[ B*2, thickness, A*1.5 ] );
			}
		}

		//mount point behind servo
		mountpoint( B, H+G+(thickness*2)+1, A*1.5 );
	}

	//base
	//======
	difference(){
		translate( [ 0, 0, -thickness ] ){
			cube( size=[ B*2, H+G+(thickness*2), thickness ] );
		}
		rotate( 90, [ 1, 0, 0 ] ){
			mountpoint( B, 1, -(H+G+(thickness*2))/2 );
		}
	}
}



//servo_bracket();

//servo_bracket_C();

