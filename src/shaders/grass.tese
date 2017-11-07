#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) patch in vec4 tesev0;
layout(location = 1) patch in vec4 tesev1;
layout(location = 2) patch in vec4 tesev2;
layout(location = 3) patch in vec4 teseup;

layout(location = 0) out vec3 bladeNormal;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	vec3 v0 = gl_in[0].gl_Position.xyz;
	vec3 v1 = tesev1.xyz;
	vec3 v2 = tesev2.xyz;
	float orientation = tesev0.w;
	float width = tesev2.w;

	//De-caltesjaul Interpolation
	vec3 a = v0 + v*(v1 - v0);
	vec3 b = v1 + v*(v2 - v1);
	vec3 c = a + v*(b-a);
	
	vec3 t1 = vec3(cos(orientation), 0, sin(orientation));
	//vec3 t1 = vec3(sin(orientation), 0, cos(orientation));
	vec3 c0 = c - width * t1;
	vec3 c1 = c + width * t1;
	vec3 t0 = normalize(b-a);
	vec3 n = cross(t0, t1);
	//Triangle Interpolation
	float t = u + 0.5f*v - u*v;
	//float t = u;
	vec3 p = (1-t)*c0 + t*c1;
	
	gl_Position = camera.proj * camera.view * vec4(p,1);
	bladeNormal = n;
}
