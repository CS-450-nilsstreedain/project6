#version 120
uniform float uTime;
uniform float uAmp;
uniform float uSpeed;
uniform float uFreq;

varying vec2 vST; // texture coordinates
varying vec3 vN;  // surface normal vector
varying vec3 vL;  // vector from point to light
varying vec3 vE;  // vector from point to eye

const vec3 LIGHTPOS = vec3( 10., 10., 5. ); // light position
const float PI = 3.14159265;
const float TWOPI = 2.*PI;
const float LENGTH = 5.; // salmon length

void main( )
{
	vST = gl_MultiTexCoord0.st;
	vec3 vert = gl_Vertex.xyz;
	// which direction on the salmon will do the wriggling?
	// what multiplies time to get distance (wriggled)
	// what multiplies position to get how many wriggles we see?
    vert.x += uAmp * sin( TWOPI*( (uSpeed*uTime)+(uFreq*vert.z/LENGTH) ) );

	// setup for the per-fragment lighting:
	vec4 ECposition = gl_ModelViewMatrix * vec4( vert, 1. );
	vN = normalize( gl_NormalMatrix * gl_Normal ); // surface normal vector
	vL = LIGHTPOS - ECposition.xyz; // vector from the point to the light position
	vE = vec3( 0., 0., 0. ) - ECposition.xyz; // vector from the point to the eye position
	gl_Position = gl_ModelViewProjectionMatrix * vec4( vert, 1. );
}
