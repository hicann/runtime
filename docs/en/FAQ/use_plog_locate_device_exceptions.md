# How to Locate Device-Side Exceptions Using Plog Logs

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-16T10:07:02.311Z pushedAt=2026-10-23T07:10:41.110Z -->

## Symptoms

**Symptom 1: Operator execution fails, but the error cause and location cannot be identified**

An exception occurs when a Runtime application executes a task on the device side. The host side returns an error code, but the specific error cause and location cannot be identified.

Example of the error log:

```text
[ERROR] RUNTIME(2082291,python3):2024-07-04-14:14:25.036.721 [stars_engine.cc:1321]2082291 ProcLogicCqReport:[INIT][DEFAULT]Task run failed, device_id=0, stream_id=2, task_id=1, sqe_type=0(ffts), errType=0x1(task exception), sqSwStatus=0
[ERROR] RUNTIME(2082291,python3):2024-07-04-14:14:25.050.365 [davinic_kernel_task.cc:1219]2082291 PreCheckTaskErr:[INIT][DEFAULT]Kernel task happen error, retCode=0x31, [vector core exception].
[ERROR] RUNTIME(2082291,python3):2024-07-04-14:14:25.050.941 [davinic_kernel_task.cc:1143]2082291 PrintErrorInfoForDavinciTask:[INIT][DEFAULT]Aicore kernel execute failed, device_id=0, stream_id=2, report_stream_id=2, task_id=1, flip_num=0, fault kernel_name=Add_ee98c6628030785f610b924ab1557b31_high_performance_210000000
```

**Symptom 2: Abnormal task exit or out-of-bounds memory access on the device side**

A task on the device side exits abnormally, the out-of-bounds memory access occurs, or kernel execution times out.

**Symptom 3: In-depth analysis through plog logs is required**

Conventional error codes are insufficient to locate the issue, and the detailed information about the device-side exception must be obtained through plog logs.

## Possible Causes

1. **Device-side hardware exception**: including the vector core exception, cube core exception, and memory access exception.

2. **Kernel code error**: The operator kernel code contains logic errors, such as out-of-bounds array access, null pointer dereference, and incorrect data types.

3. **Memory issue**: including the device memory out-of-bounds access, address alignment error, and uninitialized memory access.

4. **Resource limitation**: including task timeout, insufficient hardware resources, and task queue overflow.

## Handling

### Step 1: Locating the Failed Task and Kernel

Extract key information from the plog log to locate the failed task.

```bash
# Search for the failed task information.
grep "Task run failed" plog.log

# Output example:
# [ERROR] Task run failed, device_id=0, stream_id=2, task_id=1,
#         sqe_type=0(ffts), errType=0x1(task exception), sqSwStatus=0
#
# Interpretation:
# - device_id=0: The device ID is 0.
# - stream_id=2: The stream ID is 2.
# - task_id=1: The task ID is 1.
# - errType=0x1: Task exception
```

```bash
# Search for the failed kernel name.
grep "fault kernel_name" plog.log

# Output example:
# fault kernel_name=Add_ee98c6628030785f610b924ab1557b31_high_performance_210000000
#
# Interpretation:
# - The kernel name is Add_ee98c6628030785f610b924ab1557b31.
# - The suffix _high_performance indicates the high-performance mode.
# - 210000000 is the tiling key.
```

### Step 2: Analyzing the Error Code and Type

Extract the error code and type from the plog log.

```bash
# Search for the error code.
grep "retCode" plog.log

```

```bash
# Search for the error type.
grep "errType" plog.log

# Common error types:
# task exception
# task timeout
```

### Step 3: Analyzing Device-Side Exception Details

Extract detailed information about the device-side exception from the plog log.

```bash
# Search for the device-side exception information.
grep "The error from device" plog.log

# Output example:
# The error from device(chipId:3, dieId:0), serial number is 20,
# there is an aivec error exception, core id is 4, error code = 0,
#
# Interpretation:
# - chipId:3, dieId:0: Chip and die number
# - aivec error exception: AI vector core exception
```

### Step 4: Performing Comprehensive Analysis and Problem Locating

Locate the problem by combining the preceding information.

```bash
# Complete error locating process:
echo "=== Device-side exception locating analysis ==="

echo -e "\n[1] Failed task locating:"
grep "Task run failed" plog.log | tail -1

echo -e "\n[2] Failed kernel locating:"
grep "fault kernel_name" plog.log | tail -1

echo -e "\n[3] Error code analysis:"
grep "retCode\|Kernel task happen error" plog.log | tail -1

echo -e "\n[4] Device exception details:"
grep "The error from device" plog.log | tail -1

echo -e "\n[5] Extended error information:"
grep "The extend info" plog.log | tail -1

echo -e "\n[6] Kernel parameter information:"
grep "AIC_INFO" plog.log | tail -3

echo -e "\n=== Analysis completed ==="
```

**Typical problem diagnosis examples**:

**Scenario 1: out-of-bounds address access**

```text
Error features:
- aivec error exception

Diagnosis steps:
1. Check whether array access in the kernel code is out of bounds.
2. Check whether the allocated memory size is sufficient.
3. Check whether the tiling parameter calculation is correct.
```

**Scenario 2: memory alignment error**

```text
Error features:
- Data transfer failure

Diagnostic steps:
1. Check whether the memory address meets the alignment requirement (64-byte alignment is usually required).
2. Check whether the data structure definition is correct.
3. Verify the alignment parameter of the memory allocation API.
```

**Scenario 3: task timeout**

```text
Error features:
- task timeout
- The task execution time is too long

Diagnostic steps:
1. Check whether the kernel has an infinite loop.
2. Check whether the task computation volume is excessive.
3. Check whether hardware resources are sufficient.
```

### Step 5: Enabling Detailed Logs

If the default log information is insufficient, you can enable a more detailed log level:

```bash
# Set the log level (using an environment variable).
export ASCEND_GLOBAL_LOG_LEVEL=0  # DEBUG level, outputs the most detailed logs
export ASCEND_LOG_PRINT_TO_STDOUT=1  # Output to standard output

# Or set it in the code.
aclError error = aclInit(nullptr);
// Runtime automatically reads the log level configuration.

# Run the program.
./your_program 2>&1 | tee detailed_plog.log
```

**Log level description**:

- 0: DEBUG - Detailed debug log
- 1: INFO - General information log (default)
- 2: WARNING - Error and warning log
- 3: ERROR - Error log only

## Related Issues

None
