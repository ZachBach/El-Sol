uniform float time;
uniform float progress;
uniform sampler2D texture1;
uniform vec4 resolution;
uniform samplerCube uPerlin;
varying vec2 vUv;
varying vec3 vPosition;

float PI=3.141592653589793238;

varying vec3 vLayer0;
varying vec3 vLayer1;
varying vec3 vLayer2;
// float supersun(vec3 n){
	
// }

void main(){
	gl_FragColor=textureCube(uPerlin,vPosition);
	gl_FragColor=vec4(vLayer0,1.);
	// gl_FragColor=vec4(vUv,1.,1.);
	// gl_FragColor=vec4(1.,0.,1.,1.);
}