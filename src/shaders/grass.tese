#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 teseIn_v1[];
layout(location = 1) in vec4 teseIn_v2[];
layout(location = 2) in vec4 teseIn_Up[];
layout(location = 3) in vec3 teseIn_Side[];

layout(location = 0) out vec3 pos;
layout(location = 1) out vec3 nor;


void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	vec3 v0 = gl_in[0].gl_Position.xyz;
	vec3 v1 = teseIn_v1[0].xyz;
	vec3 v2 = teseIn_v2[0].xyz;
	vec3 up = teseIn_Up[0].xyz;
	vec3 sideDir = teseIn_Side[0];

	float width = teseIn_Up[0].w;

	vec3 p0 = v0 + v*(v1-v0);
	vec3 p1 = v1 + v*(v2-v1);
	vec3 point = p0 + v * (p1-p0);
	vec3 pointLeft = point - width * sideDir;
	vec3 pointRight = point + width * sideDir;

	nor = cross(sideDir,up);

	float ratio = u + 0.5 * v - u * v;
	vec3 position = mix(pointLeft,pointRight,ratio);
	pos = position;

	gl_Position = camera.proj*camera.view*vec4(position,1.0);
}
