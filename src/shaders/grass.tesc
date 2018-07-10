#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
// controly
layout(location = 0) in vec4 c_v1[];
layout(location = 1) in vec4 c_v2[];


// evaluate
layout(location = 0) out vec4 e_v1[];
layout(location = 1) out vec4 e_v2[];
layout(location = 2) out vec4 e_orthogonal[]; // direction for width of the blade


void main() {
	// Don't move the origin location of the patch
	vec4 p0 =  gl_in[gl_InvocationID].gl_Position; // original position of the patch
    gl_out[gl_InvocationID].gl_Position = p0;
	
	vec4 p1 = c_v1[gl_InvocationID];
	vec4 p2 = c_v2[gl_InvocationID];

	e_v1[gl_InvocationID] = p1;
	e_v2[gl_InvocationID] = p2;
	vec4 e_o = vec4(0);
	e_o.xyz = vec3(-sin(p1.w), 0, cos(p1.w)); // 90 deg from orientation

	e_o.w = p2.w; // width
	e_orthogonal[gl_InvocationID] = e_o;
	
	float viewDist = length((camera.view * vec4(p0.xyz, 1.0)).xyz);

	float segments = max(2.0, floor(6.0 * (1.0 - viewDist / 40.0)));

    gl_TessLevelInner[0] = 2; // u
    gl_TessLevelInner[1] = segments; // v

    gl_TessLevelOuter[0] = segments; // v
    gl_TessLevelOuter[1] = 2; // u
    gl_TessLevelOuter[2] = segments; // v
    gl_TessLevelOuter[3] = 2; // u
}
