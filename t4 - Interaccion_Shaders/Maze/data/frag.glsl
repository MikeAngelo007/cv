#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform sampler2D normalMap;

varying vec4 vertColor;
varying vec3 ecNormal;
varying vec3 lightDir;
varying vec4 vertTexCoord;

void main() {

  vec4 normalMapValue = 2.0 * texture(normalMap, vertTexCoord.st, -1.0) - 1.0;
  vec3 unitNormal = normalize(normalMapValue.rgb);

  vec3 direction = normalize(lightDir);
  //vec3 normal = normalize(ecNormal);
  float nDotl = dot(unitNormal,direction);
  float brightness = max(nDotl,0.0);
  //float intensity = max(0.0, dot(direction, unitNormal));
  vec4 tintColor = vec4(brightness, brightness, brightness, 1) * vertColor;




  gl_FragColor = texture2D(texture, vertTexCoord.st) * tintColor;
}