#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs

layout(location = 0) in vec2 teseDimensions[];
layout(location = 1) in vec3 teseV2Pos[];
layout(location = 2) in vec3 teseOrientation[];

layout(location = 0) out float colorHeight[];

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade

	vec3 orientation = teseOrientation[0];
	vec3 vAxis = teseV2Pos[0] - vec3(gl_in[0].gl_Position);
	vec3 uAxis = normalize(cross(vAxis, orientation)) * teseDimensions[0].x;

	gl_Position = camera.proj * camera.view * (gl_in[0].gl_Position + (1.0 - u) * vec4(uAxis, 0.0) + v * vec4(vAxis, 0.0));
	colorHeight[0] = v * 0.5 + 0.25;
}
