#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs

layout (location = 0) in vec4 v_in0;
layout (location = 1) in vec4 v_in1;
layout (location = 2) in vec4 v_in2;
layout (location = 3) in vec4 v_in3;

layout (location = 0) out vec4 v0;
layout (location = 1) out vec4 v1;
layout (location = 2) out vec4 v2;
layout (location = 3) out vec4 v3;

out gl_PerVertex {
  vec4 gl_Position;
};

void main() {
  gl_Position = v_in0;
  v0 = v_in0;
  v1 = v_in1;
  v2 = v_in2;
  v3 = v_in3;
}
