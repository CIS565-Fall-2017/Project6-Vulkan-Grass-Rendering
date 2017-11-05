#version 450
#extension GL_ARB_separate_shader_objects : enable

// TESS. EVAL = CONFIGURE VERTICES' WORLD POSITIONS
// https://www.khronos.org/opengl/wiki/Tessellation_Evaluation_Shader

// This layout qualifier controls how Tessellator generates verts 
// primitive mode, vertex spacing, and ordering 
// http://prideout.net/blog/?p=48 
layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs

// Input from tess. control
layout (location = 0) in vec4 tc_v1[];
layout (location = 1) in vec4 tc_v2[];
layout (location = 2) in vec4 tc_up[];

// Output from tess. eval to frag shader
layout (location = 0) out vec4 te_position;
layout (location = 1) out vec3 te_normal;
layout (location = 2) out vec2 te_uv;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	
	// TESTING

	float x = gl_in[0].gl_Position.x + u * tc_v2[0].w;
	float y = gl_in[0].gl_Position.y + v * tc_v1[0].w;
	float z = gl_in[0].gl_Position.z + gl_in[0].gl_Position.z;

	te_position = vec4(x, y, z, 1.0);
	te_normal = vec3(0.0, 1.0, 0.0);
	te_uv = vec2(u, v);

	gl_Position = camera.proj * camera.view * te_position;
}
