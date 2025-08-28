#define GLFW_INCLUDE_VULKAN
#include <glfw/glfw3.h>

#include <vulkan/vulkan.h>

int main() {
    // Initialize GLFW
    if (!glfwInit())
        return -1;

    // Create a window
    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
    GLFWwindow* window = glfwCreateWindow(800, 600, "Vulkan & GLFW Hello World", nullptr, nullptr);
    if (!window) {
        glfwTerminate();
        return -1;
    }

    // Create an instance of Vulkan
    VkInstance instance;
    {
        VkApplicationInfo appInfo = {};
        appInfo.sType = VK_STRUCTURE_TYPE_APPLICATION_INFO;
        appInfo.pApplicationName = "Hello, World!";
        appInfo.applicationVersion = VK_MAKE_VERSION(1, 0, 0);
        appInfo.pEngineName = "No Engine";
        appInfo.engineVersion = VK_MAKE_VERSION(1, 0, 0);
        appInfo.apiVersion = VK_API_VERSION_1_2;

        VkInstanceCreateInfo createInfo = {};
        createInfo.sType = VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO;
        createInfo.pApplicationInfo = &appInfo;

        uint32_t enableExtensionCount = 0;
        const char** enabledExtensions = nullptr;
        if (glfwGetRequiredInstanceExtensions(&enableExtensionCount, enabledExtensions) != GLFW_TRUE)
            return -1;

        createInfo.enabledExtensionCount = enableExtensionCount;
        createInfo.ppEnabledExtensionNames = enabledExtensions;

        VkPhysicalDevice physicalDevice;
        if (vkEnumeratePhysicalDevices(instance, &physicalDevice, nullptr) != VK_SUCCESS)
            return -1;

        if (vkGetPhysicalDeviceProperties(physicalDevice, &appInfo.deviceInfo) == VK_SUCCESS) {
            createInfo.enabledLayerCount = 0; // No validation layers for this example
        } else {
            printf("Failed to get device properties\n");
            return -1;
        }

        VkResult result = vkCreateInstance(&createInfo, nullptr, &instance);
        if (result != VK_SUCCESS) {
            printf("Failed to create Vulkan instance: %d\n", result);
            return -1;
        }
    }

    // Present the window and handle input
    glfwMakeContextCurrent(window);

    // Main loop
    while (!glfwWindowShouldClose(window)) {
        glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    // Cleanup
    vkDestroyInstance(instance, nullptr);
    glfwDestroyWindow(window);
    glfwTerminate();

    return 0;
}