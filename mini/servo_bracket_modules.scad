//standard hobby servo dimensions - measured by hand
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

//mini hobby servo dimensions
A = 12.7;
B = 8.5;
C = 28.6 - B;
D = 0;
E = 6;
F = 24 - E;
G = 10.6;
H = 15.6;
J = 32.1;
K = G;
M = 23.4;
X = 3;

//thickness of the bracket parts
thickness = 3.5;

module pinhole( x, y, z ){
	translate([x,y,z]){
		rotate(90,[1,0,0]){
			cylinder(h=thickness+2,r=1, $fn=10);
		}
	}
}

module pivothole( x, y, z ){

	translate([x,y,z]){
		rotate(90,[1,0,0]){
			cylinder(h=thickness+2,r=2, $fn=80);
		}
	}
}

module mountpoint( x, y, z ){
		//one pivot hole in the center
		pivothole( x, y, z );

		//four mount holes
		/*
		pinhole_distance = 4.5;
		pinhole( x+pinhole_distance, y, z );
		pinhole( x-pinhole_distance, y, z );
		pinhole( x, y, z+pinhole_distance );
		pinhole( x, y, z-pinhole_distance );
		*/
}

module servo_bracket()
{

//cleaning up the messy variable names a little
extra_length = 10;
bracket_length = B + C + extra_length;

bracket_depth = H;

bracket_height = A;

servo_hole_length = E + F;

	//front plate
	//======
	difference(){
		cube( size=[ bracket_length, thickness, bracket_height + thickness ] );

		//hole that the servo fits into
		translate( [ ( bracket_length - servo_hole_length )/2, -thickness/2, 0 ] ){
			cube( size=[ servo_hole_length, thickness*2,  bracket_height ] );
		}

		translate( [ 0, thickness+1, 0] ){
			//two mounting holes
			pivothole( 5.4, 0, bracket_height/2 );
			pivothole( bracket_length-5.4, 0, bracket_height/2 );
		}
	}


	//back plate
	//======
	difference(){
		translate( [0, bracket_depth + thickness, 0] ){
			cube( size=[ bracket_length, thickness, bracket_height + thickness ] );
		}

		//pivot holes behind servo
		translate( [ 0, 0, 0 ] ){
			mountpoint( B+5, bracket_depth + thickness*3, bracket_height/2 );
			mountpoint( (bracket_length)-(B+5), bracket_depth + thickness*3,  bracket_height/2 );
		}
	}

	//base
	//======
	difference(){
		union(){
			translate( [ 0, 0, -thickness ] ){
				cube( size=[ bracket_length, bracket_depth + (thickness*2), thickness ] );
			}
		}

		//make a hole in the base
		translate( [ ( bracket_length - servo_hole_length )/2, bracket_depth + thickness, -thickness*2] ){
			rotate( 90, [1,0,0]){
				cube( size=[ servo_hole_length, thickness*2, bracket_height + thickness ] );
			}
		}

	}

	//top
	//======
	difference(){
		union(){
			translate( [ 0, 0, bracket_height ] ){
				cube( size=[ bracket_length, bracket_depth + (thickness*2), thickness ] );
			}
		}

		//make a hole in the top
		translate( [ ( bracket_length - servo_hole_length )/2, bracket_depth + thickness, bracket_height - thickness] ){
			rotate( 90, [1,0,0]){
				cube( size=[ servo_hole_length, thickness*2, bracket_height + thickness ] );
			}
		}
	}
}


module servo_bracket_C()
{

//length of the bracket (fudge takes into account extra room for horns, washers, etc)
fudge=3;
bracket_length = H+G+X+(thickness*2)+(thickness*2)+fudge;

//heigh of the bracket
bracket_height = A*1.5;

//width of the bracket
//bracket_width = B*2;  //thicker bracket
bracket_width = E*2;  //thinner bracket

	//front plate
	//======
	difference(){
		union(){
			translate( [ bracket_width/2, thickness, bracket_height ] ){
				rotate( 90, [ 1, 0, 0 ] ){
					cylinder( h=thickness, r=bracket_width/2, $fn=80 );
				}
			}
			cube( size=[ bracket_width, thickness, bracket_height ] );
		}

		mountpoint( bracket_width/2, thickness+1, bracket_height );
	}

	//back plate
	//======
	difference(){
		union(){
			translate( [ bracket_width/2, bracket_length, bracket_height ] ){
				rotate( 90, [ 1, 0, 0 ] ){
					cylinder( h=thickness, r=bracket_width/2, $fn=80 );
				}
			}
			translate( [ 0, bracket_length-thickness, 0 ] ){
				cube( size=[ bracket_width, thickness, bracket_height ] );
			}
		}

		//mount point behind servo
		mountpoint( bracket_width/2, bracket_length+1, bracket_height );
	}

	//base
	//======
	difference(){
		translate( [ 0, 0, -thickness ] ){
			cube( size=[ bracket_width, bracket_length, thickness ] );
		}
		/*
		rotate( 90, [ 1, 0, 0 ] ){
			mountpoint( bracket_width/2, 1, -bracket_length/2 );
		}
		*/
	}

}


module mockup(){
	servo_bracket();

	
	translate( [ -thickness, -thickness*3, E*2 ] ){
		rotate( 90, [0,1,0] ){
			servo_bracket_C();
		}
	}
	
}

//mockup();

//servo_bracket();