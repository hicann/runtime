# 0_simple_queue

## Overview

This sample demonstrates basic TDT Queue capabilities, covering QueueAttr configuration, attribute reading, and Queue creation and destruction flow.

## Product Support

| Product | Supported |
| --- | --- |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Feature Description

- Create QueueAttr and set name and depth.
- Read name and depth configuration from QueueAttr.
- Create Queue, and complete resource destruction at sample end.


## Build and Run

For environment installation details and running instructions, see [README](../../../README_en.md) in the example directory.

Run steps:

```bash
# Replace ${install_root} with actual CANN installation root directory, default installation at /usr/local/Ascend
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# Build and run
bash run.sh
```

## CANN RUNTIME API

Key features and interfaces in this sample:

- Initialization
  Call `aclInit` interface to initialize AscendCL configuration.
  Call `aclFinalize` interface to deinitialize AscendCL.
- Device Management
  Call `aclrtSetDevice` interface to specify Device for computation.
  Call `aclrtResetDeviceForce` interface to forcibly reset current Device and reclaim Device resources.
- Queue Attribute Configuration
  Call `acltdtCreateQueueAttr` interface to create Queue attribute object.
  Call `acltdtSetQueueAttr` interface to set Queue name and depth.
  Call `acltdtGetQueueAttr` interface to read name and depth configuration from Queue attributes.
  Call `acltdtDestroyQueueAttr` interface to destroy Queue attribute object.
- Queue Management
  Call `acltdtCreateQueue` and `acltdtDestroyQueue` interfaces to create and destroy Queue.

## Sample Output

```text
[INFO]  QueueAttr name=simple_queue, depth=4
[INFO]  Created queue id=...
[INFO]  Run the simple_queue sample successfully.
```

## Known Issues

None.
