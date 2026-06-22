# 1_queue_route

## Overview

This sample demonstrates TDT Queue route object creation, binding, query, and unbinding flow.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Feature Description

- Create two independent Queues as route source and destination.
- Create Route and RouteList and bind to runtime.
- Query route by source queue and destination queue using QueryInfo.
- Read route source, destination, and status fields.
- Complete route unbinding and resource release.

## Build and Run

For environment installation details and running details, see [README](../../../README_en.md) in the example directory.

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
    - Call aclInit interface to initialize AscendCL configuration.
    - Call aclFinalize interface to deinitialize AscendCL.
- Device Management
    - Call aclrtSetDevice interface to specify Device for computation.
    - Call aclrtResetDeviceForce interface to forcibly reset current Device and reclaim Device resources.
- Queue Creation and Attribute Configuration
    - Call acltdtCreateQueueAttr interface to create Queue attribute object.
    - Call acltdtSetQueueAttr interface to set Queue name and depth.
    - Call acltdtCreateQueue interface to create source Queue and destination Queue.
    - Call acltdtDestroyQueueAttr interface to destroy Queue attribute object.
- Route Creation and Binding
    - Call acltdtCreateQueueRoute interface to create route object.
    - Call acltdtCreateQueueRouteList and acltdtAddQueueRoute interfaces to assemble route list.
    - Call acltdtBindQueueRoutes interface to bind route relationship to runtime.
- Route Query and Parameter Retrieval
    - Call acltdtCreateQueueRouteQueryInfo and acltdtSetQueueRouteQueryInfo interfaces to construct query conditions.
    - Call acltdtQueryQueueRoutes interface to query matching route list.
    - Call acltdtGetQueueRouteNum, acltdtGetQueueRoute, and acltdtGetQueueRouteParam interfaces to read route count and route parameters.
- Route Unbinding and Resource Release
    - Call acltdtUnbindQueueRoutes interface to unbind route.
    - Call acltdtDestroyQueueRouteList, acltdtDestroyQueueRouteQueryInfo, and acltdtDestroyQueueRoute interfaces to release route-related objects.
    - Call acltdtDestroyQueue interface to destroy source Queue and destination Queue.

## Known Issues

None.