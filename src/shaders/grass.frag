#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 inPos;
layout(location = 1) in vec3 inNor;
layout(location = 2) in vec2 inUv;

layout(location = 0) out vec4 outColor;

void main() {
  // TODO: Compute fragment color
  vec4 colTop = vec4(0.4, 0.4, 0.2, 1.0);
  vec4 colBot = vec4(0.35, 0.35, 0.1, 1.0);
  vec4 col = mix(colBot, colTop, inUv.y);
  
  vec3 lightDir = normalize(vec3(1.0, 1.0, -1.0));
  vec4 ambient = vec4(0.1, 0.1, 0.05, 1.0);
  //outColor = vec4(inNor, 1.0);
  outColor = clamp(ambient + col * clamp(abs(dot(inNor, lightDir)), 0.0, 1.0), 0.0, 1.0);
}
