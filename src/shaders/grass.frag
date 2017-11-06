#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

layout(location = 0) in vec4 Position;
layout(location = 1) in vec3 Normal;
layout(location = 2) in vec3 WindDirection;
layout(location = 3) in vec2 UV;
layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	vec3 Light = normalize(vec3(-1.0, 5.0, -3.0));
	vec3 Green_UP = vec3(0.3,0.7,0.3);
	vec3 Green_Down = vec3(0.1,0.2,0.1);
	vec3 FinalColor = mix(Green_Down, Green_UP, UV.y);
    outColor = vec4(FinalColor*clamp(dot(Normal, Light), 0.1, 1.0), 1.0);
}
