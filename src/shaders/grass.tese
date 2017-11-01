#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 v0_i[];
layout(location = 1) in vec4 v1_i[];
layout(location = 2) in vec4 v2_i[];
layout(location = 3) in vec4 up_i[];

layout(location = 0) out vec4 v0_o;
layout(location = 1) out vec4 v1_o;
layout(location = 2) out vec4 v2_o;
layout(location = 3) out vec4 up_o;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
}
