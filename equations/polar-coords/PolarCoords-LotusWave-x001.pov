////////// POLAR COORDINATES : PARTICLE MATRICES CONFIG ////////////
// This is a general use configuration setup for rendering 2D polar coordinates equations
// Available functions official : http://www.povray.org/documentation/3.7.0/r3_3.html#r3_3_1_5_4
// Available functions unofficial : http://www.f-lohmueller.de/pov_tut/calc/math_600e.htm

///// CONFIG /////
global_settings {max_trace_level 1}

///// INCLUDES /////
#include "../../includes/functions.inc"

///// CAMERA /////
camera {
	orthographic 		// Available options : perspective, orthographic
	right x * 1			// Aspect Ratio
	angle 90			// Lens
	location <0, 0, -10>
	direction <0, 0,  2.25>
	look_at <0,0,0>
}

///// GLOBAL VARS /////
#declare cc = 3;


//////////////////// LOTUS MATRIX ////////////////////
////////// POLAR COORDS : CONFIG //////////
#declare i = 0;							// Current Iteration
#declare c = pow( 2, 5 );				// Numer of times to circle
#declare n = pow( 2, 16 ); 				// Number of Particles
#while( i < n )
	#declare i = i+1;
	#declare theta = ( i / n ) * c * pi * 2;
	#declare thetaDegrees = theta * (180/pi);
	#declare seq = ( i / n );
	
	#declare Diameter = 4/100; //(150 - 50 * sin(theta*4 - pi/2));				// Sphere Diameter


	///// LOTUS /////
	// This is a basic equasion for rendering lotus patterns
	#declare li = 	2;		// Initial Radius
	#declare lp = 	8; 		// Petals
	#declare lm = 	1;		// Multiplier
	#declare lo = 	2;		// In/Out Curve Ratio
	#declare lc = 	2;		// Curvature
	#declare lg = 	3; 		// Inward Gravity
	#declare lr = 	0;		// Rotation
	#declare Lotus = li +lm*(((abs(cos(theta*(lp/2)+lr/2))*lo)-(abs(cos(theta*(lp/2)+pi/2+lr/2)))*lg)/(2+abs(cos(theta*(lp/2)*2+pi/2+lr))*lc));

	
	///// RADIUS /////
	// TODO : Create a model whereby the radius jumps up by floor method, number of particles / number of circles
	// To create a more consistant lack of jump at the first level
	#declare pulse = floor( seq * c - 0.0000001) / c;
	#declare frame = sin( pulse * pi );
	#declare shape1 =  cc + Lotus + sin( theta* pow( 2, 8 ) + pi/2 ) ;
	#declare Radius = 0 + shape1 ;

	///// TRANSLATION /////
	#declare xTranslate = Radius;
	#declare yTranslate = 0;
	#declare zTranslate = 0;

	///// ROTATION /////
	#declare xRotate = 0;
	#declare yRotate = 0;
	#declare zRotate = thetaDegrees;

	///// PARTICLE /////
	sphere {
		0, Diameter
		translate < xTranslate,  yTranslate,  zTranslate >
		rotate < xRotate, yRotate, zRotate >
		texture{
			pigment{
				color <1,1,1>
			}
		}
		finish{
			ambient rgb <1,1,1>
		}
	}

#end
