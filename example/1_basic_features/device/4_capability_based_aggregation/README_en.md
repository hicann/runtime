# 4_capability_based_aggregation

## Description

This sample demonstrates how a data aggregation workload can adapt to different hardware configurations during startup. It selects one physical Device, validates a physical ID to user-visible ID to physical ID round trip, and uses the Vector Core count to choose the kernel parallelism. It then queries signed 32-bit atomic-add support between the Device and Host. When supported, the kernel atomically aggregates eight counters directly into mapped Host memory. Otherwise, the kernel writes per-block results in Device memory and the Host performs the final reduction. Both paths compare all results from 1024 records against a CPU reference.

The logical Device ID parameters in `aclrtGetLogicDevIdByPhyDevId` and `aclrtGetPhyDevIdByLogicDevId` actually represent user Device IDs. This sample follows the documented effective semantics.

## Product Support

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training/inference products | Yes |
| Atlas A2 training/inference products | Yes |


## Build and Run

1. Change to the sample directory.

```bash
cd ${git_clone_path}/example/1_basic_features/device/4_capability_based_aggregation
```

2. Configure the environment.

```bash
source ${install_root}/set_env.sh
source ${git_clone_path}/example/set_sample_env.sh
```

3. Build and run the sample. With no argument, it selects the physical Device mapped from user Device 0. You can also provide a physical Device ID visible to the current process.

```bash
bash run.sh [physical_device_id]
```

## CANN Runtime APIs

- Initialization: `aclInit`, `aclFinalize`
- Device discovery and selection: `aclrtGetDeviceCount`, `aclrtGetLogicDevIdByPhyDevId`, `aclrtGetPhyDevIdByLogicDevId`, `aclrtSetDevice`, `aclrtResetDeviceForce`
- Hardware and atomic capability queries: `aclGetDeviceCapability`, `aclrtDeviceGetHostAtomicCapabilities`
- Memory and execution: `aclrtMalloc`, `aclrtMallocHost`, `aclrtHostRegisterV2`, `aclrtHostGetDevicePointer`, `aclrtMemcpy`, `aclrtCreateStream`, `aclrtSynchronizeStream`

## Example Output

The following output shows the fallback path when signed 32-bit Host/Device atomic add is unavailable. Hardware values, Device IDs, and capability masks depend on the environment.

```text
[INFO]: Current compile soc version is ...
...
[INFO]  Start to run capability_based_aggregation sample.
[INFO]  ID round-trip: physical=... -> legacy logic (user)=0 -> physical=...
[INFO]  Vector Cores=..., aggregation blocks=8
[INFO]  Host/Device DMA_ADD capabilities=0x0, required int32 mask=0x21
[INFO]  Selected path: Device partials + Host sum
[INFO]  Category 0: actual=-15, expected=-15
...
[INFO]  Category 7: actual=-120, expected=-120
[INFO]  Verified 8 categories across 1024 records.
[INFO]  Run the capability_based_aggregation sample successfully.
```
