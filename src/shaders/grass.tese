#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 v0_tese[];
layout(location = 1) in vec4 v1_tese[];
layout(location = 2) in vec4 v2_tese[];
layout(location = 3) in vec4 v3_tese[];

layout(location = 0) out vec4 f_pos_screenSpace;
layout(location = 1) out vec4 f_pos_world;

void main() 
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	float x = v0_tese[0].x + u*v2_tese[0].w;
	float y = v0_tese[0].y + v*v1_tese[0].w;
	float z = v0_tese[0].z + v0_tese[0].z;
	vec3 pos = vec3(x,y,z);

	f_pos_world = vec4(pos, 1.0);
	f_pos_screenSpace = camera.proj * camera.view * f_pos_world;

	gl_Position = f_pos_screenSpace;
}
