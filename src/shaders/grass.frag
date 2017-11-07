#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 world_pos;
layout(location = 1) in vec3 world_normal;
layout(location = 2) in vec2 tex_coords;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	vec3 upper_color = vec3(0.3,0.9,0.1);
	vec3 lower_color = vec3(0.0,0.4,0.1);

	vec3 yellow_upper_color = vec3(0.6,0.8,0.35);
	vec3 yellow_lower_color = vec3(0.6,0.55,0.23);

	vec3 lightDir = normalize(vec3(-1.0, 5.0, -3.0));

//basic diffuse(lambert)
	//float NoL = clamp(dot(world_normal, lightDir), 0.1, 1.0);

	//vec3 diffuse_color = mix(yellow_lower_color, yellow_upper_color, tex_coords.y);
	//vec3 colorLinear = diffuse_color * NoL;

//blinn-phong
	vec3 normal = normalize(world_normal);
	vec4 cameraPos = inverse(camera.view) * vec4(0,0,0,1);
	cameraPos /= cameraPos.w;
	float lambertian = max(dot(lightDir,normal), 0.0);
	float specular = 0.0;

	if(lambertian > 0.0) {
		vec3 viewDir = normalize((cameraPos - world_pos).xyz);
		vec3 halfDir = normalize(lightDir + viewDir);
		float specAngle = max(dot(halfDir, normal), 0.0);
		specular = pow(specAngle, 128);
	}

	vec3 specColor = vec3(0.9,0.9,0.9);
	vec3 diffuseColor = mix(lower_color, upper_color, tex_coords.y);
	float ambient = 0.15;
	vec3 colorLinear = (ambient +
						lambertian + specular) * diffuseColor;


	////Distance Culling
	//float min_distance = 0.1;
	//float far_distance = 100;

	////seperate into 10 buckets
	//the distance between each bucket is 10
	//vec4 view_v0 = camera.view * vec4(world_pos.xyz, 1.0f);
	//float horizontal_distance = abs(dot(view_v0.xyz, vec3(0,0,1)));

	//int bucket_level = 11;
	//if(horizontal_distance < far_distance){
	//	bucket_level = int(horizontal_distance) / 10;
	//}
	//outColor = vec4(vec3(float(bucket_level)/10.0f), 1.0f);
    outColor = vec4(colorLinear, 1.0);

    //outColor = vec4(1.0);
}
