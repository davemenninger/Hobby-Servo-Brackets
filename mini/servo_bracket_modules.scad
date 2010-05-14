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

//mini hobby servo dimensions
A = 12.7;
B = 8.5;
C = 28.6 - B;
D = 0;
E = 6;
F = 22.9 - E;
G = 10.6;
H = 15.6;
J = 32.1;
K = G;
M = 23.4;
X = 3;

//thickness of the bracket parts
thickness = 3;

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
	//front plate
	//======
	difference(){
		cube( size=[ B+C+10, thickness, A+thickness ] );

		translate( [ ((B+C+10)-(E+F))/2, -1, 0] ){
			cube( size=[ E+F, thickness*2, A+thickness ] );
		}

		translate( [ 0, thickness+1, 0] ){
			//two mounting holes
			pivothole( B-5, 0, A/2 );
			pivothole( (B+C)+5, 0, A/2 );
		}
	}

	//supports
	//======
	support_length = sqrt( (pow(A+thickness,2))+(pow((H/2),2)) );
	support_width = sqrt( (pow(A,2))-(pow((support_length/2),2)) );

	difference(){
		union(){
			rotate( 30, [1,0,0] ){
				translate( [ 0, 1, -6 ] ){
					cube( size=[ thickness*0.75 , support_width, support_length ] );
				}
			}
			rotate( 30, [1,0,0] ){
				translate( [ 5.5, 1, -6 ] ){
					cube( size=[ thickness*0.75 , support_width, support_length ] );
				}
			}
			rotate( 30, [1,0,0] ){
				translate( [ (B+C+10)-thickness*0.75, 1, -6 ] ){
					cube( size=[ thickness*0.75 , support_width, support_length ] );
				}
			}
			rotate( 30, [1,0,0] ){
				translate( [ (B+C+10)-thickness*0.75-5.5, 1, -6 ] ){
					cube( size=[ thickness*0.75 , support_width, support_length ] );
				}
			}
			rotate( -30, [1,0,0] ){
				translate( [ 0, 9, 5 ] ){
					cube( size=[ thickness*0.75 , support_width, support_length ] );
				}
			}
			rotate( -30, [1,0,0] ){
				translate( [  (B+C+10)-thickness*0.75, 9, 5 ] ){
					cube( size=[ thickness*0.75 , support_width, support_length ] );
				}
			}
		}

		//big blocks to subtract off the corners sticking out
		union(){
			translate( [ 0, 0, -((thickness+2)*2+thickness) ] ){
				cube( size=[ B+C+10, H+(thickness*2), (thickness+2)*2 ] );
			}
			translate( [ 0, -(thickness+2), -thickness ] ){
				cube( size=[ B+C+10, thickness+2, A+thickness+thickness ] );
			}
			translate( [ 0, H+thickness*2, -thickness ] ){
				cube( size=[ B+C+10, thickness+thickness, A+thickness+thickness ] );
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
		//mountpoint( B+5, H+(thickness*2)+1, A/2 );
		//mountpoint( (B+C+10)-(B+5), H+(thickness*2)+1, A/2 );
	}

	//base
	//======
	difference(){
		union(){
			translate( [ 0, 0, -thickness ] ){
				cube( size=[ B+C+10, H+(thickness*2), thickness ] );
			}
		}
		/*
		union(){
			rotate( 90, [1,0,0]){
				mountpoint( B+5, 1, -(H/2)-thickness );
				mountpoint( (B+C+10)-(B+5), 1, -(H/2)-thickness );
			}
		}
		*/
	}
}


module servo_bracket_C()
{

//length of the bracket (fudge takes into account extra room for horns, washers, etc)
fudge=2;
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

