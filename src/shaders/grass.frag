#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 frag_normal;
layout(location = 1) in vec3 frag_position;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    
	vec3 color = vec3(1.f/256.f, 166.f/256.f, 17.f/256.f);
	vec3 light_position = vec3(5.0, 5.0, 5.0);
	float light_distance = distance(light_position, frag_position);
	vec3 L = (light_position - frag_position) / light_distance;
	float lambert = max(dot(L, frag_normal.xyz), 0.0);
	vec3 ambient = vec3(0.025);

	vec3 fragColor = color * lambert;
	fragColor += color * ambient;
	outColor = vec4(fragColor, 1.0);
}
