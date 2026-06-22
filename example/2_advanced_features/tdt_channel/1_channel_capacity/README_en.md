# 1_channel_capacity

## Overview

This sample demonstrates TDT Channel with capacity limit, focusing on capacity query, cleanup, and stop operations, as well as slice information and Tensor type query.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Feature Description

- Create a Channel with capacity 2 to meet minimum capacity limit required by interface documentation.
- Send first Dataset and query channel size.
- Continue sending Dataset in non-blocking mode, observe return result when capacity is limited; if second send succeeds, continue third send until capacity pressure is triggered.
- Call SliceInfo, TensorType, and DatasetName query interfaces for supplementary check.
- Complete Channel cleanup, stop, and destruction.

## Note

When current Runtime does not enable queue-style TDT Channel capability, relevant dependencies are not ready, or underlying queue initialization/creation fails, `acltdtCreateChannelWithCapacity` may return `nullptr`. The sample records this situation as a warning, skips capacity-limited demonstration flow, and exits normally after cleanup.

## Build and Run

For environment installation details and running details, see [README](../../../README_en.md) in the example directory.

Run steps:

```bash
# Replace ${install_root} with CANN installation root directory, default installation at /usr/local/Ascend
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# Build and run
bash run.sh
```

## CANN RUNTIME API

Key features and interfaces in this sample:
- Initialization
    - Call aclInit interface to initialize AscendCL configuration.
    - Call aclFinalize interface to deinitialize AscendCL.
- Device Management
    - Call aclrtSetDevice interface to specify Device for computation.
    - Call aclrtResetDeviceForce interface to forcibly reset current computation Device and reclaim Device resources.
- Capacity-limited Channel Creation
    - Call acltdtCreateChannelWithCapacity interface to create Channel with capacity limit, and set capacity to minimum value 2 allowed by documentation.
    - Call acltdtCreateDataItem, acltdtCreateDataset, and acltdtAddDataItem interfaces to construct Dataset.
- Tensor Send and Capacity Query
    - Call acltdtSendTensor interface to send first Dataset, and call acltdtQueryChannelSize interface to query Channel current size.
    - Continue calling acltdtSendTensor interface in non-blocking mode, observe when capacity-limited return result is triggered in current environment.
- Additional Information Query
    - Call acltdtGetDataItem and acltdtGetDatasetSize interfaces to read DataItem in Dataset.
    - Call acltdtGetSliceInfoFromItem, acltdtGetTensorTypeFromItem, and acltdtGetDatasetName interfaces to view Slice information, Tensor type, and Dataset name.
- Channel Cleanup and Resource Release
    - Call acltdtCleanChannel, acltdtStopChannel, and acltdtDestroyChannel interfaces to cleanup, stop, and destroy Channel.
    - Call acltdtDestroyDataItem and acltdtDestroyDataset interfaces to release Dataset resources.

## Known Issues

None.