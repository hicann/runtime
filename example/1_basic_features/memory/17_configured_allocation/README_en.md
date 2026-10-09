# 17_configured_allocation

## Description

This sample stages data using transfer buffers tagged by application module on a single device. It transfers 1024 deterministic 32-bit integers along Host → configured Device buffer → cache-capable Device buffer → Host. The Host and staging Device allocations use application module ID 33 to help identify application memory during diagnostics.

The sample selects copy directions from queried memory locations and checks that both Device buffers are ordinary Device memory before transferring data. Synchronized releases wait for asynchronous tasks before reclaiming the input and cached buffers. Every returned element is verified, and the success marker is printed only after verification and all cleanup operations succeed. The current version does not require manual CPU/NPU cache-coherency maintenance.

## Product Support

| Product | Supported |
| --- | :---: |
| Atlas A2 series products | √ |
| Atlas A3 series products | √ |
| Ascend 950PR/Ascend 950DT | √ |

## Compile and Run

See [Sample Usage Guide](../../../README_en.md), change to this sample directory, and run `bash run.sh`. Install a CANN package that provides the interfaces listed below. This sample uses Device 0.

## CANN RUNTIME API

The key features and interfaces used in this sample are:

- Initialization
    - `aclInit` initializes the runtime configuration.
    - `aclFinalize` finalizes the runtime.
- Device management
    - `aclrtSetDevice` selects the device used for transfers.
    - `aclrtResetDeviceForce` forcibly resets the current device and reclaims resources.
- Stream management
    - `aclrtCreateStream` creates the asynchronous transfer stream.
    - `aclrtSynchronizeStream` waits for remaining tasks before cleanup.
    - `aclrtDestroyStreamForce` forcibly destroys the stream.
- Configured memory allocation
    - `aclrtMallocHostWithCfg` allocates pinned Host memory tagged with the application module ID.
    - `aclrtMallocWithCfg` allocates staging Device memory tagged with the application module ID, using normal pages.
    - `aclrtMallocCached` allocates cache-capable Device relay memory.
- Memory identification and data transfer
    - `aclrtCheckMemType` checks whether both Device addresses match `ACL_RT_MEM_TYPE_DEV`; transfers proceed only when the returned match result is 1.
    - `aclrtPointerGetAttributes` queries memory location, Device ID, and page size to select copy directions and reject memory belonging to another device.
    - `aclrtMemcpyAsync` performs asynchronous Host-to-Device, Device-to-Device, and Device-to-Host transfers.
- Synchronized release
    - `aclrtFreeHostWithDevSync` waits for the upload before releasing the input Host allocation and releases the output Host allocation during cleanup.
    - `aclrtFreeWithDevSync` waits for the download before releasing the cached Device allocation and releases the configured Device allocation during cleanup.

## Sample Output

A successful run reports the memory-type check, copy directions selected from memory attributes, synchronized releases, and verification of all 1024 elements. Page sizes depend on the environment.

```text
Configuring CMake...
...
Building...
...
[INFO]  Configured Host and staging buffers: 4096 bytes, application module ID 33
[INFO]  Verified both Device buffers match ACL_RT_MEM_TYPE_DEV
[INFO]  Selected Host -> Device from pointer attributes (source page ..., destination page ...)
[INFO]  Released Host input after implicit Device synchronization
[INFO]  Selected Device -> Device from pointer attributes (source page ..., destination page ...)
[INFO]  Selected Device -> Host from pointer attributes (source page ..., destination page ...)
[INFO]  Released cached Device buffer after implicit Device synchronization
[INFO]  Verified 1024 elements after Host -> configured Device -> cached Device -> Host
[INFO]  [SUCCESS] Configured allocation sample completed successfully
```
