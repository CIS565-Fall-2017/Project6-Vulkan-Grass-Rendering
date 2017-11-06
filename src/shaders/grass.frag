#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

// Input from tess. eval
layout (location = 0) in vec4 te_position;
layout (location = 1) in vec4 te_normal;
layout (location = 2) in vec2 te_uv;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color

	// Lambert
	// vec3 lightPosition = vec3(0.0, 10.0, 0.0);
	// float lambertTerm = clamp( dot( te_normal.xyz, normalize(lightPosition - te_position.xyz) ), 0.0, 1.0 );

	vec4 ambientLight = vec4(0.75);
	vec4 albedo = vec4(0.13, 0.56, 0.13, 1.0);
    outColor = ambientLight * albedo;
}
