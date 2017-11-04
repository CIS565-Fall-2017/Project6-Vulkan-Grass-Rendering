#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
//layout(location = 0) patch in vec4 tese_v1;
layout(location = 0) patch in vec4 inV0;
layout(location = 1) patch in vec4 inV1;
layout(location = 2) patch in vec4 inV2;
layout(location = 3) patch in vec4 inUp;

layout(location = 0) out vec4 outPos;
layout(location = 1) out vec3 outNor;
layout(location = 2) out vec2 outUv;

void main() {
  float u = gl_TessCoord.x;
  float v = gl_TessCoord.y;
  outUv = vec2(u, v);

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
  vec3 a = mix(inV0.xyz, inV1.xyz, v);
  vec3 b = mix(inV1.xyz, inV2.xyz, v);
  vec3 c = mix(a, b, v);

  //vec3 faceDir = normalize(cross(up.xyz, vec3(sin(v0.w), 0, cos(v0.w)));
  //vec3 biTan = normalize(cross(faceDir, up.xyz));
  vec3 tangent = normalize(b - a);
  vec3 biTangent = vec3(sin(inV0.w), 0.0, cos(inV0.w));
  float w = inV2.w;
  vec3 c0 = c - w * biTangent;
  vec3 c1 = c + w * biTangent;
  outNor = normalize(cross(tangent, biTangent));

  float t = u - u*v*v; // quad shape
  vec3 p = mix(c0, c1, t);
  outPos = camera.proj * camera.view * vec4(p, 1.0);
  gl_Position = outPos;
}
