# aclrtBinaryGetFunctionCount Sample

This sample demonstrates how to use the `aclrtBinaryGetFunctionCount` interface to query the number of kernel functions in an operator binary file, and then perform a complete workflow including function lookup, information query, kernel launch, and result verification.

The sample compiles three AscendC kernel functions (`add_custom`, `sub_custom`, and `mul_custom`) into a single standalone operator binary, and executes the following steps:

1. **Query function count**: Call `aclrtBinaryGetFunctionCount` to get the total number of kernel functions in the binary.
2. **Get function handles by name**: With known kernel function names, call `aclrtBinaryGetFunction` to obtain the corresponding function handle for each.
3. **Query function information**: Call `aclrtGetFunctionName` to get function names, and `aclrtGetFunctionAddr` to get the Device code addresses.
4. **Prepare input data**: Allocate Host and Device memory, and copy FP16 input data to Device.
5. **Launch and verify**: Call `aclrtLaunchKernelWithHostArgs` to launch each kernel, synchronize, copy results back to Host, and verify correctness.

## Directory

```text
3_binary_get_function_count/
├── CMakeLists.txt
├── kernel/
│   └── custom.cpp
├── main.cpp
├── README.md
├── README_en.md
└── run.sh
```

The three Device Kernels are defined in `kernel/custom.cpp`.

## Environment

The Runtime installation defaults to `/home/developer/Ascend/cann`. The AscendC compiler is also required. A Runtime-only installation might not contain `ascendc.cmake`.

From the Runtime repository, the environment can be detected with:

```bash
source /home/developer/Ascend/cann/set_env.sh
source /mnt/workspace/runtime/example/set_sample_env.sh
```

Alternatively, configure it manually:

```bash
export ASCEND_HOME_PATH=/home/developer/Ascend/cann
export SOC_VERSION=Ascend910B1
```

Replace `SOC_VERSION` with the actual device model.

## Build and Run

```bash
cd /mnt/workspace/runtime/example/2_advanced_features/kernel/3_binary_get_function_count
bash run.sh
```

Expected output:

```text
[STEP 1] Querying the number of kernel functions in the binary
[INFO] aclrtBinaryGetFunctionCount returned 3 functions
[STEP 2] Getting function handles by name
[STEP 3] Querying function names and addresses
[INFO] function[0]: name=add_custom, handle=..., aic=..., aiv=...
[INFO] function[1]: name=sub_custom, handle=..., aic=..., aiv=...
[INFO] function[2]: name=mul_custom, handle=..., aic=..., aiv=...
[STEP 4] Preparing input data
[STEP 5] Launching kernels and verifying results
[INFO] add_custom result verified
[INFO] sub_custom result verified
[INFO] mul_custom result verified
[SUCCESS] aclrtBinaryGetFunctionCount sample passed
```

## Key Interfaces

- `aclrtBinaryLoadFromFile`: Loads and parses an operator binary file from disk, outputting a binHandle.
- `aclrtBinaryGetFunctionCount`: Gets the total number of kernel functions in the binary.
- `aclrtBinaryGetFunction`: Gets a kernel function handle by its name.
- `aclrtGetFunctionName`: Gets the kernel function name from a function handle.
- `aclrtGetFunctionAddr`: Gets the Device-side kernel code address from a function handle.
- `aclrtLaunchKernelWithHostArgs`: Launches a kernel with Host-side arguments that are automatically copied to Device.
- `aclrtBinaryUnLoad`: Unloads the operator binary file and releases associated resources.
