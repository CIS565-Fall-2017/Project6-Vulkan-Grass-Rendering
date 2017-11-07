#pragma once

#include "Device.h"
#include "SwapChain.h"
#include "Scene.h"
#include "Camera.h"

class Renderer {
public:
	Renderer() = delete;
	Renderer(Device* device, SwapChain* swapChain, Scene* scene, Camera* camera);
	~Renderer();

	void CreateCommandPools();

	void CreateRenderPass();

	void CreateCameraDescriptorSetLayout();
	void CreateModelDescriptorSetLayout();
	void CreateTimeDescriptorSetLayout();
	void CreateGrassDescriptorSetLayout();
	void CreateComputeDescriptorSetLayout();

	void CreateDescriptorPool();

	void CreateCameraDescriptorSet();
	void CreateModelDescriptorSets();
	void CreateGrassDescriptorSets();
	void CreateTimeDescriptorSet();
	void CreateComputeDescriptorSets();

	void CreateGraphicsPipeline();
	void CreateGrassPipeline();
	void CreateComputePipeline();

	void CreateFrameResources();
	void DestroyFrameResources();
	void RecreateFrameResources();

	void RecordCommandBuffers();
	void RecordComputeCommandBuffer();

	void Frame();

private:
	Device* device;
	VkDevice logicalDevice;
	SwapChain* swapChain;
	Scene* scene;
	Camera* camera;

	VkCommandPool graphicsCommandPool;
	VkCommandPool computeCommandPool;

	VkRenderPass renderPass;

	VkDescriptorSetLayout computeDescriptorSetLayout;
	VkDescriptorSetLayout cameraDescriptorSetLayout;
	VkDescriptorSetLayout modelDescriptorSetLayout;
	VkDescriptorSetLayout timeDescriptorSetLayout;
	VkDescriptorSetLayout grassDescriptorSetLayout;

	VkDescriptorPool descriptorPool;

	VkDescriptorSet cameraDescriptorSet;
	std::vector<VkDescriptorSet> modelDescriptorSets;
	std::vector<VkDescriptorSet> grassDescriptorSets;
	std::vector<VkDescriptorSet> computeDescriptorSets;
	VkDescriptorSet timeDescriptorSet;

	VkPipelineLayout graphicsPipelineLayout;
	VkPipelineLayout grassPipelineLayout;
	VkPipelineLayout computePipelineLayout;

	VkPipeline graphicsPipeline;
	VkPipeline grassPipeline;
	VkPipeline computePipeline;

	std::vector<VkImageView> imageViews;
	VkImage depthImage;
	VkDeviceMemory depthImageMemory;
	VkImageView depthImageView;
	std::vector<VkFramebuffer> framebuffers;

	std::vector<VkCommandBuffer> commandBuffers;
	VkCommandBuffer computeCommandBuffer;
};