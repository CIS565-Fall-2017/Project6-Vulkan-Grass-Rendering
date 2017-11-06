#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare fragment shader inputs

layout(location = 0) in vec3 fs_nor;

layout(location = 0) out vec4 outColor;

void main() {
    float lambertTerm = abs(dot(fs_nor, normalize(vec3(0.5, 0.5, 0.5))));
    outColor = vec4(0.0, 1.0, 0.0, 1.0) * lambertTerm;
}
