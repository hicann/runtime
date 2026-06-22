# 0_simple_channel

## Overview

This sample demonstrates TDT Channel basic data transmission, covering Channel, Dataset, and DataItem creation, send, receive, and data verification flow.

## Product Support

Key interfaces in this sample have the following support status on different products:

| Product | Supported |
| --- | --- |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

To experience TDT Channel on current products, see [1_channel_capacity](../1_channel_capacity/README_en.md).

## Feature Description

- Create a TDT Channel and construct DataItem corresponding to floating-point Tensor.
- Use Dataset to wrap single Tensor and send through Channel.
- Receive Dataset in the same process, and read dimension, data type, data address, and first element value.
- Query Channel current size, and complete stop, cleanup, and destruction.

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
- Channel and Dataset Creation
    - Call acltdtCreateChannelWithCapacity interface to create TDT Channel.
    - Call acltdtCreateDataItem interface to construct DataItem based on Tensor data.
    - Call acltdtCreateDataset and acltdtAddDataItem interfaces to wrap Dataset.
- Tensor Send/Receive and Information Query
    - Call acltdtSendTensor and acltdtReceiveTensor interfaces to complete Dataset send and receive.
    - Call acltdtGetDatasetSize and acltdtGetDataItem interfaces to read DataItem in Dataset.
    - Call acltdtGetDataAddrFromItem, acltdtGetDataSizeFromItem, acltdtGetDataTypeFromItem, acltdtGetTensorTypeFromItem, acltdtGetDimNumFromItem, and acltdtGetDimsFromItem interfaces to view Tensor data, data type, and dimension information.
- Channel Status and Resource Release
    - Call acltdtQueryChannelSize interface to query Channel current size.
    - Call acltdtStopChannel, acltdtCleanChannel, and acltdtDestroyChannel interfaces to stop, cleanup, and destroy Channel.
    - Call acltdtDestroyDataItem and acltdtDestroyDataset interfaces to release Dataset resources.

## Known Issues

None.