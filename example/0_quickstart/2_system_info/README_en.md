# 2_system_info

## Description

This sample demonstrates Runtime basic system information query and common data type utility interfaces, suitable as a warm-up sample before device query-type samples.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Compile and Run

For environment installation details and general running steps, refer to [README](../../README_en.md) in the example directory.

## CANN RUNTIME API

The key functionality points and their key interfaces involved in this sample are as follows:

- Initialization
    - Call `aclInit` interface for initialization configuration.
    - Call `aclFinalize` interface for deinitialization.
- Version Information Query
    - Call `aclrtGetVersion` interface to query ACL Runtime API version number.
    - Call `aclsysGetVersionStr` and `aclsysGetVersionNum` interfaces to query CANN software package version information.
- Run Mode and Data Type Tools
    - Call `aclrtGetRunMode` interface to determine whether currently running in Host or Device mode.
    - Call `aclFloatToFloat16` and `aclFloat16ToFloat` interfaces to complete float16/float32 mutual conversion.
    - Call `aclDataTypeSize` interface to query byte size of common `aclDataType`.

## Sample Output

```text
[INFO]  ACL Runtime API version: 1.2.3
[INFO]  CANN package [runtime] version string: 8.x.x
[INFO]  CANN package [runtime] version number: 8000000
[INFO]  Current run mode: ACL_HOST
[INFO]  Float conversion: 1.625000 -> 0x3e80 -> 1.625000
[INFO]  Data type size: ACL_FLOAT=4, ACL_FLOAT16=2, ACL_INT64=8
```