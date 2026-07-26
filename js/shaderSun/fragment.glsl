uniform float time;
uniform vec4 resolution;
uniform samplerCube uPerlin;

varying vec2 vUv;
varying vec3 vPosition;
varying vec3 vLayer0;
varying vec3 vLayer1;
varying vec3 vLayer2;

float PI=3.141592653589793238;

// Map a scalar brightness onto a hot, blackbody-ish sun ramp:
// dark ember red -> orange -> yellow -> white as it climbs.
vec3 brightnessToColor(float b){
  b*=.25;
  return(vec3(b,b*b,b*b*b*b)/.25)*.6;
}

// Sample the animated perlin cubemap through the three rotating layers and
// average them. The layers spin on different axes, so the surface roils and
// never shows a static, repeating pattern.
float supersun(){
  float sum=0.;
  sum+=textureCube(uPerlin,vLayer0).r;
  sum+=textureCube(uPerlin,vLayer1).r;
  sum+=textureCube(uPerlin,vLayer2).r;
  sum*=.33;
  return sum;
}

void main(){
  float brightness=supersun();
  brightness=brightness*4.+1.;            // lift out of the dark + boost contrast

  vec3 col=brightnessToColor(brightness);

  // Fresnel corona: the sphere is centred at the origin, so the world normal is
  // just normalize(vPosition). Grazing angles (the limb) glow into an orange rim.
  vec3 normal=normalize(vPosition);
  vec3 eye=normalize(cameraPosition-vPosition);
  float fres=1.-max(dot(eye,normal),0.);
  fres=pow(fres,3.);
  col+=brightnessToColor(fres*4.)*vec3(1.,.55,.25);

  gl_FragColor=vec4(col,1.);
}
