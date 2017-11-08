#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

layout(location = 0) in vec3 nor;
layout(location = 1) in vec3 world_pos;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec3 col = vec3(0.15, 0.8, 0.1);
    vec3 light = vec3(0.0, 15.0, 5.0);

    vec3 L = normalize(light - world_pos);

    //outColor = vec4(1.0);
    outColor = vec4(col * clamp(dot(nor.xyz, L), 0.0, 1.0) + col * 0.15, 0);
    //outColor = vec4(nor,1);
}
