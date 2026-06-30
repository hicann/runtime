# Sample Usage Guide

The example directory provides a series of Runtime interface samples, including Device management, Stream management, Event management, memory management, Kernel execution, and more. These samples are for developer reference to help developers quickly get started and master Runtime key features.

## Directory Overview

- [0_quickstart](0_quickstart/README_en.md): Quick start samples, using `aclnnAdd` vector addition as the entry point to demonstrate initialization configuration, Device/Stream creation, Tensor and DataBuffer management, workspace allocation, operator execution, synchronization waiting, and resource release processes.
- [1_basic_features](1_basic_features/README_en.md): Basic feature samples, including device management (single-thread and multi-thread), memory management (memory copy, inter-process memory sharing, virtual memory management), Stream management (single-stream task dispatch, multi-stream task dispatch), and more.
- [2_advanced_features](2_advanced_features/README_en.md): Advanced feature samples, including operator Kernel loading and execution, ACL Graph, Reduce and random number generation built-in system task execution, Host-side callback function dispatch, and more.
- [3_memory_advanced](3_memory_advanced/README_en.md): Advanced memory management samples, including custom memory allocator, Host memory registration, unified addressing, Stream memory operations, Stream ordered memory allocation, and more.
- [4_reliability](4_reliability/README_en.md): Reliability samples, including overflow detection, error recovery, and more.
- [5_performance](5_performance/README_en.md): Performance analysis and precision debugging samples.
- [6_scenarios](6_scenarios/README_en.md): Scenario-based samples, for typical scenarios such as training pipelines, multi-device inference, and fault-tolerant execution.

## Product Support Table Notes

The product support table in each sample README lists only products that have been verified for the sample or whose support status has been explicitly declared. Ascend 950PR/Ascend 950DT are newly added products, and some historical samples have not yet completed verification on these products. A product not listed in a table does not mean that it is unsupported. If a product is explicitly unsupported, the sample README marks it with `×` in the table and adds notes when needed.

## Environment Preparation

Before compiling and running samples, obtain and install the firmware, driver, and CANN software packages. For detailed steps, refer to the [CANN Software Installation Guide](https://www.hiascend.com/cann/download).

If you have custom modifications to the source code in the src directory of this repository, after installing the CANN software, you also need to compile the source code and deploy it to the environment. For specific operations, refer to [README](../README_en.md).

## Running Samples

1. Download the sample code and upload it to the environment where CANN software is installed. Switch to the sample directory.
```bash
# This example uses the basic memory sample
cd ${git_clone_path}/example/1_basic_features/memory/0_h2h_memory_copy
```

2. Set environment variables.
```bash
# Replace ${install_root} with the CANN installation root directory. The default installation is in the `/usr/local/Ascend` directory.
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann
```

3. Run the following command to execute the sample.
```bash
# Note that some test cases have different run commands. Refer to the compile and run commands in the README.md file in each test case directory.
bash run.sh
```

## Sample Code Description

All samples demonstrate typical usage patterns of CANN Runtime API.

- Sample code is for learning and interface understanding.
- To highlight core processes, some examples simplify engineering handling.
- Before using in production environments, please add complete error handling, resource management, and boundary checking.

## Device Reset API Usage Convention

Single-process samples on one host usually use `aclrtResetDeviceForce` to clean up Device resources occupied by the current sample. Multi-process IPC samples on one host use `aclrtResetDevice` to release Device resources owned by the current process, avoiding forced reset effects on other processes on the same host.
