
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout (location = 0) in vec4 v0;
layout (location = 1) in vec4 v1;
layout (location = 2) in vec4 v2;
layout (location = 3) in vec4 up;

layout(location = 0) out vec4 tescIn_v1;
layout(location = 1) out vec4 tescIn_v2;
layout(location = 2) out vec3 tescIn_Up;
layout(location = 3) out vec3 tescIn_Face;//normalized 

out gl_PerVertex {
    vec4 gl_Position;
};


void main() {
	// TODO: Write gl_Position and any other shader outputs
    float direction = v0.w;
	float height = v1.w;
	float width = v2.w;

	vec3 groundPos = vec3(v0.xyz);

	tescIn_v1 = model * vec4(v1.xyz,1.0);
	tescIn_v2 = model * vec4(v2.xyz,1.0);
	tescIn_Up = vec3(model * vec4(up.xyz,0.0));

	float cosTheta = cos(direction);
	float sinTheta = sin(direction);

	float leftPointXDis = width*0.5*cosTheta;
	float leftPointZDis = width*0.5*sinTheta;

	vec3 leftPoint = groundPos + vec3(leftPointXDis,0.0,-leftPointZDis);

	vec3 groundDir = leftPoint - groundPos;

	vec3 face = cross(groundDir,tescIn_Up);
	tescIn_Face = normalize(face);

	gl_Position = model * vec4(v0.x,v0.y,v0.z,1.0);
}
