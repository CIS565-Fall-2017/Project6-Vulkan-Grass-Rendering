
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};
layout(location = 0) in vec4 v0;
layout(location = 1) in vec4 v1;
layout(location = 2) in vec4 v2;
layout(location = 3) in vec4 up;

layout(location = 0) out vec4 v1_out;
layout(location = 1) out vec4 v2_out;
layout(location = 2) out vec4 up_out;
layout(location = 3) out vec4 bladeBit_out; //bitangent of the blade
// TODO: Declare vertex shader inputs and outputs

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs

	//v0.w holds orientation, v1.w holds height, v2.w holds width, and up.w holds the stiffness coefficient

	v1_out=vec4((model * vec4(v1.xyz, 1.0)).xyz, v1.w);
	v2_out=vec4((model * vec4(v2.xyz, 1.0)).xyz, v2.w);
	//up_out=vec4(normalize(up.xyz),up.w);
	up_out=vec4(normalize(up.xyz),0.0);

	vec3 ref=vec3(sin(v0.w),0,cos(v0.w)); //For cross product
 	vec3 FaceDir = normalize(cross(up_out.xyz, ref));

	bladeBit_out.xyz = normalize(cross(FaceDir, up_out.xyz));
	//gl_Position (v0.xyz,1.0f);

	gl_Position =model*vec4(v0.xyz,1.0);

}
