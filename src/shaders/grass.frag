#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare fragment shader inputs

layout(location = 0) in vec3 fs_nor;
layout (location = 1) in vec3 fs_posVC;

layout(location = 0) out vec4 outColor;

void main() {
    float lambertTerm = dot(faceforward(fs_nor, normalize(fs_posVC), fs_nor), normalize((camera.view * vec4(1.0, 3.0, 1.0, 0.0)).xyz));
    outColor = vec4(0.0, 1.0, 0.0, 1.0) * lambertTerm;
}
