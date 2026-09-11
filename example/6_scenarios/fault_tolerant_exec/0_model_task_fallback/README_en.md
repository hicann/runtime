# 0_model_task_fallback

## Description

This sample is intended for developers who need a fallback policy when an input is unsuitable for optional post-processing. It first runs a complete path containing a main compute task and an optional post-processing task. It then inspects the model Streams and tasks, uniquely identifies both tasks by type, function handle, and sequence ID, switches the main task to backup input, and disables the optional task. The final checks prove that the main output came from the backup input and that the optional output retained its preset value.


## Product Support

| Product | Supported |
| --- | :---: |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Ascend 950PR/Ascend 950DT | Yes |

## Compile and Run

1. Download the sample code to the environment where CANN is installed, and switch to the sample directory.

```bash
cd ${git_clone_path}/example/6_scenarios/fault_tolerant_exec/0_model_task_fallback
```

2. Set the environment variables.

```bash
# Replace ${install_root} with the CANN installation root directory
source ${install_root}/set_env.sh
source ${git_clone_path}/example/set_sample_env.sh
```

3. Run the following command to compile and execute the sample.

```bash
bash run.sh
```

## CANN RUNTIME API

The key functionality points and their key interfaces involved in this sample are as follows:

- Initialization and Deinitialization
    - `aclInit`: Initializes ACL.
    - `aclrtSetDevice`: Selects Device 0 for the sample.
    - `aclrtResetDeviceForce`: Releases resources held by the sample on Device 0.
    - `aclFinalize`: Finalizes ACL.
- Device memory
    - `aclrtMalloc`: Allocates two input and two output Device buffers.
    - `aclrtMemcpy`: Writes input and output sentinel values and reads both path results back.
    - `aclrtFree`: Releases the Device buffers.
- Stream
    - `aclrtCreateStream`: Creates the Stream used to capture and execute the model.
    - `aclrtSynchronizeStreamWithTimeout`: Waits a bounded time for model execution.
    - `aclrtDestroyStream`: Destroys the Stream.
- Kernel
    - `aclrtBinaryLoadFromFile`: Loads the Kernel binary containing the main and optional tasks.
    - `aclrtBinaryGetFunction`: Obtains both Kernel function handles.
    - `aclrtLaunchKernelWithHostArgs`: Dispatches both captured tasks with tightly packed Host arguments.
    - `aclrtBinaryUnLoad`: Unloads the Kernel binary.
- Model capture and execution
    - `aclmdlRICaptureBegin`: Starts capturing both tasks.
    - `aclmdlRICaptureEnd`: Ends capture and obtains the model runtime instance.
    - `aclmdlRIExecuteAsync`: Executes the complete path or the updated fallback path.
    - `aclmdlRIDestroy`: Destroys the model runtime instance.
- Task selection and fallback update
    - `aclmdlRIGetStreams`: Obtains the model's single Stream for task lookup.
    - `aclmdlRIGetTasksByStream`: Obtains the tasks on that Stream.
    - `aclmdlRITaskGetType`: Filters compute tasks.
    - `aclmdlRITaskGetSeqId`: Verifies that the main task precedes the optional task.
    - `aclmdlRITaskGetParams`: Reads the Kernel function, argument layout, and block count for selection and update.
    - `aclmdlRITaskSetParams`: Switches the main task to the backup input.
    - `aclmdlRITaskDisable`: Disables the optional post-processing task.
    - `aclmdlRIUpdate`: Commits the task-parameter and disable-state updates.

## Sample Output

```text
[INFO]  Start to run 0_model_task_fallback sample.
[INFO]  Baseline path verified: main_first=11, optional_first=22.
[INFO]  Selected fallback tasks: main_seq=0, optional_seq=1.
[INFO]  Fallback path verified: main_first=31, optional_first=-1.
[INFO]  Run the 0_model_task_fallback sample successfully.
```
