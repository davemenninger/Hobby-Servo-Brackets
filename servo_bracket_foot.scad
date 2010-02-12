
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
			cube( size=[ E+F, thickness+2, A ] );
		}

		translate( [ 0, thickness+1, 0] ){
			//four mounting holes
			pivothole( 5, 0, (A-D)/2 );
			pivothole( 5, 0, ((A-D)/2)+D );
			pivothole( B+C+5, 0, (A-D)/2 );
			pivothole( B+C+5, 0, ((A-D)/2)+D );
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
		mountpoint( B, H+(thickness*2)+1, A/2 );
		mountpoint( (B+C+10)-B, H+(thickness*2)+1, A/2 );
	}

	//base
	//sanity check ball
	//translate( [ B+C, 0, 0] ){
	//	sphere(r=1);
	//}
	difference(){
		translate( [ 0, -15, -thickness ] ){
			cube( size=[ B+C+10, H+(thickness*2)+30, thickness ] );
		}
		rotate( 90, [1,0,0]){
			mountpoint( B, 1, -thickness-1 );
			mountpoint( (B+C+10)-B, 1, -thickness-1 );
		}
	}
}

servo_bracket();

