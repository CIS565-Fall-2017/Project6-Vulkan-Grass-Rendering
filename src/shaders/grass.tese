#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) patch in vec4 tese_v1;
layout(location = 1) patch in vec4 tese_v2;
layout(location = 2) patch in vec4 tese_up;
layout(location = 3) patch in vec4 tese_widthDir;

layout(location = 0) out vec4 Position;
layout(location = 1) out vec3 Normal;
layout(location = 2) out vec3 WindDirection;
layout(location = 3) out vec2 UV;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade

	mat4 viewProj = camera.proj * camera.view;
		
	vec3 Current_V0 = gl_in[0].gl_Position.xyz + v*(tese_v1.xyz -  gl_in[0].gl_Position.xyz);
	vec3 Current_V1 = tese_v1.xyz + v*(tese_v2.xyz - tese_v1.xyz);
	vec3 Current_V2 = Current_V0 + v*(Current_V1 - Current_V0);

	vec3 Bi_tangent = tese_widthDir.xyz; 	
	vec3 Width_Whole = Bi_tangent * tese_v2.w * 0.5;

	Normal = normalize(cross(Bi_tangent, normalize(Current_V1 - Current_V0)));
	UV = vec2(u, v);

	float t = u + 0.5*v -u*v;
    Position.xyz = (1.0 - t)*(Current_V2 - Width_Whole) + t*(Current_V2 + Width_Whole);
	Position = viewProj * vec4(Position.xyz, 1.0);

    gl_Position = Position;
	WindDirection = tese_widthDir.xyz;

}
