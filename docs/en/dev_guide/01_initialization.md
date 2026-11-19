# Initialization

<!-- md-trans-meta sourceCommit=f27ca703aef442726cc28a36cb0f8ecff75fe506 translatedAt=2026-11-11T06:19:16.592Z pushedAt=2026-11-16T02:25:25.373Z nl=2 -->

**CANN Runtime** provides the **aclInit** and **aclrtSetDevice** APIs, which are called when an application starts. Combined with a JSON configuration file, they implement the following features:

- **Environment initialization**: Sets the environment parameters required for CANN Runtime, ensuring that all runtime resources and configuration items are loaded correctly.
- **Device resource configuration**: Initializes hardware-related resources (such as Ascend processors and accelerator cards) and allocates the resources, so that subsequent computation tasks can be executed on the appropriate devices.
- **Log configuration**: Initializes logging to ensure that the system running status can be checked and debugged in real time.
- **Resource management initialization**: Prepares resources for subsequent features such as memory management, task scheduling, and memory allocation.

The following is a code example of initialization and specifying a computation device. It cannot be directly copied, compiled, and run, and is for reference only.

<!-- npu="950,A3,910b,910,310p,310b" id1 -->
For the complete sample code, see [Link](https://gitcode.com/cann/runtime/tree/master/example/1_basic_features/device/0_device_normal).
<!-- end id1 -->

```c
// Initialization
int32_t deviceId = 0;
aclInit(nullptr); // The JSON configuration path is nullptr, indicating default initialization.
aclrtSetDevice(deviceId);

// Other aclrt runtime APIs can be called only after SetDevice is called.
......

// Deinitialization
aclrtResetDeviceForce(deviceId);
aclFinalize();
```

If the **aclrtSetDevice** API is not explicitly called, you can specify the default device in the JSON file of the **aclInit** API, for example:

```c
{
    "defaultDevice":{
        "default_device":"0"
    }
}
```

After the default device feature is enabled in the **aclInit** API, the sample code for initialization is as follows. It cannot be directly copied, compiled, and run, and is for reference only. For details about the default device configuration, see the [aclInit API](../api_ref/02_initialization_and_deinitialization.md#default-device-configuration-example).

```c
// Initialization
int32_t deviceId = 0;
aclInit(nullptr);

// After DefaultDevice is enabled, you can directly call runtime APIs without explicitly calling aclrtSetDevice.
// The API implicitly calls aclrtSetDevice based on the device specified in the JSON configuration file.
aclrtMalloc(&devPtr, size, 0);

......

// Deinitialization
aclrtResetDeviceForce(deviceId);
aclFinalize();
```

In addition to the default device feature, you can also configure features such as performance data collection, model input/output data export, and overflow operator dump through the JSON file of the **aclInit** API, without modifying the code binary. For related configuration examples and usage instructions, see the description in the **aclInit** API.
