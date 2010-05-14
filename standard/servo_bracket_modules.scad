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

//guesses
K=5.8;
M=40;
X=3.5;

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
		pinhole_distance = 7.5;
		pinhole( x+pinhole_distance, y, z );
		pinhole( x-pinhole_distance, y, z );
		pinhole( x, y, z+pinhole_distance );
		pinhole( x, y, z-pinhole_distance );
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

//length of the bracket
fudge=5;
bracket_length = H+G+X+(thickness*2)+fudge;

//heigh of the bracket
bracket_height = A*1.5;

	//front plate
	//======
	difference(){
		union(){
			translate( [ B, thickness, bracket_height ] ){
				rotate( 90, [ 1, 0, 0 ] ){
					cylinder( h=thickness, r=B );
				}
			}
			cube( size=[ B*2, thickness, bracket_height ] );
		}

		mountpoint( B, thickness+1, bracket_height );
	}

	//back plate
	//======
	difference(){
		union(){
			translate( [ B, bracket_length, bracket_height ] ){
				rotate( 90, [ 1, 0, 0 ] ){
					cylinder( h=thickness, r=B );
				}
			}
			translate( [ 0, bracket_length-thickness, 0 ] ){
				cube( size=[ B*2, thickness, bracket_height ] );
			}
		}

		//mount point behind servo
		mountpoint( B, bracket_length+1, bracket_height );
	}

	//base
	//======
	difference(){
		translate( [ 0, 0, -thickness ] ){
			cube( size=[ B*2, bracket_length, thickness ] );
		}
		rotate( 90, [ 1, 0, 0 ] ){
			mountpoint( B, 1, -bracket_length/2 );
		}
	}
}


module mockup(){
	servo_bracket();

	translate( [ -B*0.8, -thickness*3.9, B*1.75 ] ){
		rotate( 90, [0,1,0] ){
			servo_bracket_C();
		}
	}
}

//mockup();
