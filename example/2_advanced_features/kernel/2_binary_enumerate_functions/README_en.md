# aclrtBinaryEnumerateFunctions Sample

This sample compiles `add_custom`, `sub_custom`, and `mul_custom` into one standalone
operator binary. It uses `aclrtBinaryEnumerateFunctions` to obtain the Kernel function
handles, queries their names with `aclrtGetFunctionName`, launches all three Kernels,
and prints the first output element from each Kernel.

`aclrtBinaryLoadFromFile` loads and parses the file on the Host. The first
`aclrtBinaryEnumerateFunctions` call copies the associated operator binary to the Device
of the current Context. With `x=1.0` and `y=2.0`, the three Kernels produce `3.0`,
`-1.0`, and `2.0`, respectively.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

The Device Kernels are defined in `kernel/custom.cpp`.

## Environment

The Runtime installation defaults to `/home/developer/Ascend/cann`. The AscendC
compiler is also required. A Runtime-only installation might not contain
`ascendc.cmake`.

`run.sh` detects the CANN environment automatically: it prefers the preset
`ASCEND_INSTALL_PATH` / `ASCEND_HOME_PATH`, otherwise it locates and sources
`set_env.sh` from common install paths via `example/common/resolve_cann_env.sh`.

When `SOC_VERSION` and `ASCENDC_CMAKE_DIR` are not set, `run.sh` sources
`example/set_sample_env.sh` to detect them automatically (`SOC_VERSION` is queried
from the device), so no manual configuration is required.

Alternatively, configure it manually:

```bash
export ASCEND_INSTALL_PATH=/home/developer/Ascend/cann
export SOC_VERSION=Ascend910B1
```

## Build and Run

```bash
cd ${git_clone_path}/example/2_advanced_features/kernel/2_binary_enumerate_functions
bash run.sh
```

Expected output:

```text
[INFO] Enumerating functions in the Kernel binary.
[INFO] aclrtBinaryEnumerateFunctions succeeded.
[INFO] function[0]: name=add_custom, handle=...
[INFO] function[1]: name=mul_custom, handle=...
[INFO] function[2]: name=sub_custom, handle=...
[INFO] add_custom result: 3.0
[INFO] mul_custom result: 2.0
[INFO] sub_custom result: -1.0
```
