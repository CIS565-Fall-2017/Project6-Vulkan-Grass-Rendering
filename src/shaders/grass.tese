#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs

//layout (location = 0) out vec4 col;

layout (location = 0) in vec4[] v0;
layout (location = 1) in vec4[] v1;
layout (location = 2) in vec4[] v2;
layout (location = 3) in vec4[] v3;

layout (location = 0) out vec3 nor;
layout (location = 1) out vec3 world_pos;

void main() {
  float u = gl_TessCoord.x;
  float v = gl_TessCoord.y;

  // TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
  vec3 pos = v0[0].xyz;
  vec3 p1 = v1[0].xyz;
  vec3 p2 = v2[0].xyz;
  vec3 up = v3[0].xyz;
  float orientation = v0[0].w;
  float height = v1[0].w;
  float width = v2[0].w;
  vec3 t1 = cross(up, vec3(sin(orientation), 0, cos(orientation)));

  vec3 a = pos + v * (p1 - pos);
  vec3 b = p1 + v * (p2 - p1);
  vec3 c = a + v * (b - a);
  vec3 c0 = c - width * t1;
  vec3 c1 = c + width * t1;
  vec3 t0 = normalize(b - a);
  nor = normalize(cross(t0, t1));

  float t = u + 0.5 * v - u * v;
  vec3 n_pos = t * c0 + (1 - t) * c1;
  world_pos = n_pos;
  gl_Position = camera.proj * camera.view * vec4(n_pos, 1);
  //nor = p2;
  //nor = t0;
  //nor = c/10;
}
