# Failure to Call aclrtSetDevice

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-16T09:54:04.332Z pushedAt=2026-10-22T07:48:13.435Z -->

## Symptoms

**Symptom 1: An error code about an invalid device ID is returned when the aclrtSetDevice API is called**

The **aclrtSetDevice** API fails to be called, and **ACL_ERROR_RT_INVALID_DEVICEID** (error code 107001) is returned, indicating that the device ID is invalid.

Example of the error log:

```text
aclrtSetDevice failed, ret = 107001, deviceId=5
```

**Symptom 2: The aclrtSetDevice API fails to be called and the driver is not loaded correctly**

When the NPU driver is not installed or not loaded correctly, the **aclrtSetDevice API** also fails to be called and may return **ACL_ERROR_RT_INVALID_DEVICEID** (error code 107001).

Example of the error log:

```text
aclrtSetDevice failed, ret = 107001, deviceId=0
[ERROR] RUNTIME: Failed to get phy dev id by logic dev id, driver may not be loaded
```

## Possible Causes

1. **Device ID out of range**: The specified device ID exceeds the number of devices actually available in the system.
2. **Driver not loaded correctly**: The NPU driver is not installed or not loaded correctly into the system.

## Handling

### Cause 1: Device ID Out of Range

**Solution**:

- Query the number of available devices: call **aclrtGetDeviceCount** to obtain the total number of devices in the system.
- Use a valid device ID: Device IDs start from 0 and range from `[0, deviceCount - 1]`.

Example code:

```c
uint32_t deviceCount = 0;
aclError ret = aclrtGetDeviceCount(&deviceCount);
if (ret == ACL_SUCCESS) {
    // Device ID range: 0 to deviceCount - 1
    int32_t deviceId = 0;  // Use a valid device ID
    ret = aclrtSetDevice(deviceId);
}
```

### Cause 2: Driver Not Loaded Correctly

**Solution**:

- Check the driver installation: confirm that the CANN driver is installed correctly.
- Check the driver status: use system commands to check whether the driver is loaded.
- Reinstall the driver: If the driver is not loaded, reinstall it by referring to the Ascend Community documentation.

Command example:

```bash
# Check the driver version.
cat /usr/local/Ascend/version.info

# Check the driver loading status.
lsmod | grep ascend
```

## Related Issues

None
