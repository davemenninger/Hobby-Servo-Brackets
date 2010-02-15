
module servo_bracket_C()
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

rotate( 90, [0,1,0]){
	//zero ball
	//sphere(r=1);

	//front plate
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
	//sanity check ball
	//translate( [ 0, H+G, 0 ] ){
	//	sphere(r=1);
	//}
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
	difference(){
		translate( [ 0, 0, -thickness ] ){
			cube( size=[ B*2, H+G+(thickness*2), thickness ] );
		}
		rotate( 90, [ 1, 0, 0 ] ){
			mountpoint( B, 1, -(H+G+(thickness*2))/2 );
		}
	}
}
}

servo_bracket_C();
