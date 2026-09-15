# 3_device_identity_mapping

## Description

This sample targets Device identification in container, virtualization, and scheduling systems. It enumerates user-visible Devices, queries each UUID, and verifies bidirectional mappings between user and logical Device IDs and between user and physical Device IDs. For a PCIe-connected Device, the sample also resolves the user Device ID from its PCI Bus ID and checks the round-trip. When a non-PCIe interconnect returns `ACL_ERROR_RT_FEATURE_NOT_SUPPORT`, the sample explicitly logs and skips PCI discovery; any other error still fails the sample.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Compile and Run

For environment installation details and general running steps, refer to [README](../../../README_en.md) in the example directory.

## CANN RUNTIME API

The key functionality points and their key interfaces involved in this sample are as follows:

- Initialization
    - Call `aclInit` to initialize ACL.
    - Call `aclFinalize` to deinitialize ACL.
- Device Enumeration
    - Call `aclrtGetDeviceCount` to obtain the number of user-visible Devices.
- Unique Device Identifier Query
    - Version requirements: CANN 9.2.0-beta.2 or later with Ascend HDK 25.5.5 or later.
    - Call `aclrtDeviceGetUuid` to obtain the Device UUID.
    - Call `aclrtDeviceGetPCIBusId` to obtain the Device PCI Bus ID. PCI discovery is explicitly skipped when a non-PCIe interconnect reports that the feature is unsupported.
    - Call `aclrtDeviceGetByPCIBusId` to resolve the user Device ID from the PCI Bus ID and verify it against the original ID.
- Device ID Mapping
    - Call `aclrtGetLogicDevIdByUserDevId` to map the user Device ID to a logical Device ID.
    - Call `aclrtGetUserDevIdByLogicDevId` to map the logical Device ID back to a user Device ID.
    - Call `aclrtGetPhyDevIdByUserDevId` to map the user Device ID to a physical Device ID.
    - Call `aclrtGetUserDevIdByPhyDevId` to map the physical Device ID back to a user Device ID.

## Sample Output

```text
[INFO]  Start to run device_identity_mapping sample.
[INFO]  Device ID mapping: user=0, logic=..., physical=...
[INFO]  UUID: ...
[WARN]  Skip PCI discovery for user Device 0: the current interconnect is not PCIe.
[INFO]  Device ID mapping: user=1, logic=..., physical=...
[INFO]  UUID: ...
[WARN]  Skip PCI discovery for user Device 1: the current interconnect is not PCIe.
[INFO]  Enumerated 2 user-visible Device(s); PCI discovery skipped for 2 Device(s).
[INFO]  Run the device_identity_mapping sample successfully.
```
