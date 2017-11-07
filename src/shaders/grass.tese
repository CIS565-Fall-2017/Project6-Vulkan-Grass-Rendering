#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout (location = 0) in vec4 [] v0_in;
layout (location = 1) in vec4 [] v1_in;
layout (location = 2) in vec4 [] v2_in;
layout (location = 3) in vec4 [] v3_in;

layout (location = 0) out vec4 [] norm;
layout (location = 1) out vec4 [] world;


// TODO: Declare tessellation evaluation shader inputs and outputs

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade

	vec4 pos = gl_in[0].gl_Position;
	float h = v1_in[0].w;
	float w = v2_in[0].w;
	float dir =  v0_in[0].w;
	
	vec3 v0 = vec3(v0_in[0]);
	vec3 v1 = vec3(v1_in[0]);
	vec3 v2 = vec3(v2_in[0]);
	vec3 up = vec3(v3_in[0]);
	vec3 f = normalize(cross(up, vec3(sin(dir), 0.0, cos(dir))));

	float dir90 = dir - 1.57079632679;
	vec3 t1 = cross(up, vec3(sin(dir90), 0.0 , cos(dir90) ) );

	vec3 a = v0 + v * (v1 - v0);
	vec3 b = v1 + v * (v2 - v1);
	vec3 c = a + v * (b - a);
	vec3 c0 = c - w * t1;
	vec3 c1 = c + w * t1;
	vec3 t0 = normalize(b - a);
	vec3 n = normalize( cross(t0, t1) );

	
	float t = u + 0.5 * v - u * v;

	vec3 newP = (1 - t) * c0 + t * c1;

	vec4 newPos = vec4(newP, 1.0);

	gl_Position = camera.proj * camera.view * (newPos);
	norm[0] = vec4(n,1);
	world[0] = vec4(newP,1);

}
