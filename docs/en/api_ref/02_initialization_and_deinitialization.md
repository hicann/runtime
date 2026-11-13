# 2. Initialization and Deinitialization

<!-- md-trans-meta sourceCommit=be113e8125a2a8c7ff54fc96bb9a5e053217e879 translatedAt=2026-11-06T11:14:18.126Z pushedAt=2026-11-09T07:19:27.364Z nl=2 -->

This chapter describes the initialization and deinitialization APIs of CANN Runtime, including initialization and deinitialization of the ACL environment and related callback registration.

- [`aclError aclInit(const char *configPath)`](#aclInit): Initialization function.
- [`aclError aclFinalize()`](#aclFinalize): Deinitialization function, used for releasing the resources used by ACL APIs within the process.
- [`aclError aclFinalizeReference(uint64_t *refCount)`](#aclFinalizeReference): Deinitialization function, used for releasing the resources used by ACL APIs within the process.
- [`aclError aclInitCallbackRegister(aclRegisterCallbackType type, aclInitCallbackFunc cbFunc, void *userData)`](#aclInitCallbackRegister): Registers an initialization callback function.
- [`aclError aclInitCallbackUnRegister(aclRegisterCallbackType type, aclInitCallbackFunc cbFunc)`](#aclInitCallbackUnRegister): If the callback function does not need to be triggered, call this API to unregister the callback function.
- [`aclError aclFinalizeCallbackRegister(aclRegisterCallbackType type, aclFinalizeCallbackFunc cbFunc, void *userData)`](#aclFinalizeCallbackRegister): Registers a deinitialization callback function.
- [`aclError aclFinalizeCallbackUnRegister(aclRegisterCallbackType type, aclFinalizeCallbackFunc cbFunc)`](#aclFinalizeCallbackUnRegister): If the callback function does not need to be triggered, call this API to unregister the callback function.

<a class="method_anchor" id="aclInit"></a>

## aclInit

```c
aclError aclInit(const char *configPath)
```

### Applicable Products

<!-- npu="950" id3235 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3235 -->
<!-- npu="A3" id3236 -->
- Atlas A3 products: Supported
<!-- end id3236 -->
<!-- npu="910b" id3237 -->
- Atlas A2 products: Supported
<!-- end id3237 -->
<!-- npu="310b" id3238 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3238 -->
<!-- npu="310p" id3239 -->
- Atlas inference products: Supported
<!-- end id3239 -->
<!-- npu="910" id3240 -->
- Atlas training products: Supported
<!-- end id3240 -->
<!-- @ref: runtime/res/docs/zh/api_ref/02_initialization_and_deinitialization_res.md#id1 -->

### Description

Initialization function.

When developing applications using ACL APIs, you must call the aclInit API first. Otherwise, subsequent internal system resource initialization may fail, which in turn causes other service exceptions.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| configPath | Input | Pointer to the path (including the file name) of the configuration file. The configuration file content is in JSON format (the nesting level of "{" in the JSON file is at most 10, and the nesting level of "[" is at most 10).<br>During initialization, this configuration file can be used to enable Dump, configure Profiling collected information, and other functions. For details, see the descriptions in the configuration examples of each function below. If the default configuration meets your requirements and no modification is needed, you can pass NULL to the aclInit API, or configure the configuration file as an empty JSON string (that is, the configuration file contains only {}). |

### Return Values

Returns 0 on success and other values on failure. See [aclError](25-01_aclError.md#aclError).

### Constraints

<!-- npu="950,A3,910b,910,310p,310b" id1 -->
- A process supports calling the aclInit API multiple times for initialization, but must call the aclFinalize or aclFinalizeReference API for deinitialization. The following scenarios are supported:
    - Each time the aclInit API is called, the configuration must remain consistent. Otherwise, only the configuration of the first call takes effect, and subsequent calls to the aclInit API may cause errors or invalid configuration.
    - For compatibility with earlier versions, calling the aclInit API repeatedly returns the ACL\_ERROR\_REPEAT\_INITIALIZE error code. You can ignore this error and continue processing services.
    - If the aclInit and aclFinalize APIs are called to implement initialization and deinitialization respectively, repeated initialization and deinitialization are supported. In terms of timing, only sequential calls are supported. The API call sequence is as follows:

        ```text
        aclInit-->service processing-->aclFinalize-->aclInit-->service processing-->aclFinalize
        ```

        In this scenario, if the aclInit API is called multiple times before deinitialization, you only need to call the aclFinalize API once to directly clear the reference count of the aclInit API to zero.

    - If the aclInit and aclFinalizeReference APIs are called to implement initialization and deinitialization respectively, the aclInit and aclFinalizeReference APIs must be called in pairs.

        Because the aclFinalizeReference API internally involves the implementation of reference counting, each call to the aclInit API increments the reference count by one, and each call to the aclFinalizeReference API decrements the reference count by one. Only when the reference count decreases to 0 is deinitialization actually performed.

        Repeated initialization and deinitialization are supported. In terms of timing, both sequential calls and concurrent calls are supported. The API call sequence is as follows:

        - The sequential call sequence diagram is as follows:

            ![](figures/sequential_invoking_diagram.png)

        - The concurrent call sequence diagram is as follows:

            ![](figures/concurrent_invoking_diagram.png)
 <!-- end id1 -->

<!-- @ref: runtime/res/docs/zh/api_ref/02_initialization_and_deinitialization_res.md#id8 -->

### Model Dump Configuration and Single Operator Dump Configuration

The exported data of **model dump configuration** (used to export the input and output data of each operator layer in a model) and **single-operator dump configuration** (used to export the input and output data of a single operator) is used for comparison with a specified model or operator to locate precision issues. For the specific comparison method, see [Precision Debugging Tool User Guide](https://www.hiascend.com/document/detail/en/CANNCommunityEdition/920/devaids/ModelAccuracyAnalyzer/atlasaccuracy_16_0001.html). **The dump configurations are disabled by default.**

To enable the dump configuration through this API, configure the path for saving the dump data through the dump\_path parameter.

The following is an example of the model dump configuration:

```json
{
    "dump":{
        "dump_list":[
            {    "model_name":"ResNet-101"
            },
            {
                "model_name":"ResNet-50",
                "layer":[
                      "conv1conv1_relu",
                      "res2a_branch2ares2a_branch2a_relu",
                      "res2a_branch1",
                      "pool1"
                ]
            }
        ],
        "dump_path":"/home/output",
                "dump_mode":"output",
        "dump_op_switch":"off",
                "dump_data":"tensor"
    }
}
```

In the single operator call scenario, the following is an example of the dump configuration:

```json
{
    "dump":{
        "dump_path":"/home/output",
        "dump_list":[{}],
    "dump_op_switch":"on",
        "dump_data":"tensor"
    }
}
```

### Abnormal Operator Dump Configuration

**Abnormal operator Dump configuration** is used to export the input and output data, workspace information, and tiling information of abnormal operators. The exported data is used to analyze AI Core Error issues. **This Dump configuration is disabled by default.**

<!-- npu="950,A3,910b,910,310p,310b" id4 -->
For information collection and definitions related to AI Core Error issues, see [*Troubleshooting*](https://gitcode.com/cann/docs/blob/9.2.0/docs/en/troubleshooting/ai_core_error_description.md).
<!-- end id4 -->

Enable the abnormal operator Dump function by configuring the dump\_scene parameter value. The following example in the configuration file shows how to enable lightweight exception dump:

```json
{
    "dump":{
        "dump_path":"output",
        "dump_scene":"aic_err_brief_dump"
    }
}
```

The detailed configuration description and constraints are as follows:

- The dump\_scene parameter supports the following values:
    - aic\_err\_brief\_dump: indicates lightweight exception dump, which is used to export the input and output data and workspace data of the AI Core error operator.
    - aic\_err\_norm\_dump: indicates standard exception dump. In addition to the data exported by lightweight exception dump, it also exports shape, data type, format, and attribute information.
    <!-- npu="A3,910b" id5 -->
    - aic\_err\_detail\_dump: in addition to the data exported by lightweight exception dump, it also exports the internal storage, registers, and call stack information of the AI Core.

        When this option is configured, note the following:

        - This option is supported only on the following models, and requires driver 25.0.RC1 or later:

            Atlas A3 products

            Atlas A2 products

            You can click [Link](https://www.hiascend.com/hardware/firmware-drivers/commercial), download the Ascend HDK 25.0.RC1 or later driver installation package on the "Firmware & Driver" page, and install or upgrade it by referring to the documentation of the corresponding version.

        - During the export of dump files, the AI Core where the problematic operator resides is paused, which may affect the normal execution of other service processes on the device. After the dump files are exported, the AI Core automatically resumes. Therefore, in scenarios where multiple host-side user service processes specify the same device, using the aic\_err\_detail\_dump option is not recommended.
        - After the dump files are exported, the host-side user service process is forcibly terminated. Errors reported during the forced termination should not be used as input for AI Core problem analysis.
        - After the aic\_err\_detail\_dump option is configured, if dump files are generated but are not \*.core files, it indicates that the function corresponding to aic\_err\_detail\_dump is not enabled successfully, and the system automatically switches to dumping according to the aic\_err\_brief\_dump option.
    <!-- end id5 -->

    - lite\_exception: indicates lightweight exception dump. For compatibility with earlier versions, its effect is equivalent to aic\_err\_brief\_dump.

- dump\_path is an optional parameter that specifies the storage path for the exported dump files.

    The priority of the dump file storage path is as follows: the NPU\_COLLECT\_PATH environment variable \> ASCEND\_WORK\_PATH the environment variable \> dump\_path in the configuration file \> the current execution directory of the application. For a detailed description of the environment variables, see [*Environment Variable Reference*](https://gitcode.com/cann/docs/blob/9.2.0/docs/en/env-vars/intro.md).

<!-- npu="950,A3,910b,910,310p,310b" id6 -->
- To view the exported dump file content, see the "Fault Locating Tool \> msaicerr Tool Usage Guide \> Parsing Dump Files" chapter in [*Troubleshooting*](https://gitcode.com/cann/docs/blob/9.2.0/docs/en/troubleshooting/troubleshooting_intro.md).

    <!-- npu="A3,910b" id7 -->
    If dump\_scene is set to aic\_err\_detail\_dump, use the msDebug tool to view the content of the exported dump files. For details, see [Operator Development Tool User Guide](https://www.hiascend.com/document/detail/en/CANNCommunityEdition/920/devaids/optool/docs/en/quick_start/msdebug_quick_start.md).
    <!-- end id7 -->
<!-- end id6 -->

- Abnormal operator dump configuration cannot be enabled together with model dump configuration or single operator dump configuration.

### Overflow Operator Dump Configuration

**Overflow Operator Dump Configuration** is used to export the input and output data of overflow operators in a model. The exported data is used to analyze the cause of overflow and locate model accuracy issues. **This dump configuration is disabled by default.**

Set the dump\_debug parameter to on to enable the overflow operator configuration. The sample content in the configuration file is as follows:

```json
{
    "dump":{
        "dump_path":"output",
        "dump_debug":"on"
    }
}
```

The detailed configuration description and constraints are as follows:

- If dump\_debug is not configured or dump\_debug is set to off, the overflow operator configuration is not enabled.
- If the overflow operator configuration is enabled, dump\_path must be configured, which specifies the storage path for exporting dump files.

    After obtaining the exported data files, parse the files by referring to [Precision Debugging Tool User Guide](https://www.hiascend.com/document/detail/en/CANNCommunityEdition/920/devaids/ModelAccuracyAnalyzer/atlasaccuracy_16_0001.html).

    dump\_path supports configuring an absolute path or a relative path:

    - An absolute path starts with "/", for example: /home.
    - A relative path starts directly with a directory name, for example: output.

- The Overflow Operator Dump configuration cannot be enabled together with the model Dump configuration or the single operator Dump configuration; otherwise, an error is returned.
- Only overflow data of AI Core operators is supported for collection.

### Operator Dump Watch Mode Configuration

**Operator Dump Watch Mode Configuration** is used to enable the observation mode for the output data of specified operators. After locating the precision issue of some operators and ruling out the computation problem of the operators themselves, if you suspect that the precision issue is caused by other operators overwriting the memory, you can enable Dump Watch mode. **Dump Watch mode is disabled by default.**

Set the dump\_scene parameter to watcher to enable Operator Dump Watch mode. The sample content in the configuration file is as follows. The configuration takes effect as follows: (1) After operator A and operator B are executed, the output of operator C and operator D is dumped. (2) After operator C and operator D are executed, the output of operator C and operator D is also dumped. Compare the dump files of operator C and operator D in (1) and (2) to check whether operator A and operator B overwrite the output memory of operator C and operator D.

```json
{
    "dump":{
        "dump_list":[
            {
                "layer":["A", "B"],
                "watcher_nodes":["C", "D"]
            }
        ],
        "dump_path":"/home/",
        "dump_mode":"output",
        "dump_level":"op",
        "dump_scene":"watcher"
    }
}
```

The detailed configuration description and constraints are as follows:

- If Operator Dump Watch mode is enabled, Overflow Operator Dump (configured by the dump\_debug parameter) or single-operator model Dump (configured by the dump\_op\_switch parameter) cannot be enabled at the same time. Otherwise, an error is reported. This mode does not take effect in the single-operator API Dump scenario.

- In dump_list, the layer parameter specifies the names of operators whose memory may overwrite that of other operators, and the watcher_nodes parameter specifies the names of operators whose output memory may be overwritten by other operators, resulting in accuracy issues.
    - If layer is not specified, after all operators that support Dump in the model are executed, the output of the operators configured in watcher\_nodes is dumped.
    - The operators configured in layer and watcher\_nodes must be operators in a static graph or static subgraph. Otherwise, the configuration does not take effect.
    - If the operator names configured in layer and watcher\_nodes are the same, or if the operators configured in layer are collective communication operators (operator types start with Hcom, for example, HcomAllReduce), only the dump files of the operators configured in watcher\_nodes are exported.
    - For fused operators, the operator names configured in watcher\_nodes must be the names after fusion. If the names before fusion are configured, no dump file is exported.
    - Configuring model\_name in dump\_list is not supported yet.

- When operator Dump Watch mode is enabled, dump\_path must be configured to specify the storage path for exporting dump files.

    The dump files collected here cannot be viewed directly with a text tool. To view the content of a dump file, first convert the dump file to a numpy format file, and then view the numpy-format file through Python. For detailed conversion steps, see [Precision Debugging Tool User Guide](https://www.hiascend.com/document/detail/en/CANNCommunityEdition/920/devaids/ModelAccuracyAnalyzer/atlasaccuracy_16_0001.html).

    dump\_path supports configuring an absolute path or a relative path:

    - An absolute path starts with "/", for example, /home.
    - A relative path starts directly with a directory name, for example, output.

- The dump\_mode parameter controls which part of the data of the operator configured in watcher\_nodes is exported. Currently, only output is supported.

- Set the dump data level through dump_level. The values are as follows. Under the default configuration, there are many dump data files, for example, some dump files starting with aclnn. If users have requirements on dump performance or have limited memory resources, they can set this parameter to the op level to improve dump performance and reduce the number of dump data files.

    - op: Dumps data at the operator level. An operator is a representation of computation logic (such as addition, subtraction, multiplication, and division).
    - kernel: Dumps data at the kernel level.
    - all: Default value. Data at both the op and kernel levels is dumped. A kernel is the implementation that actually performs computation and processing for the operation logic, and it needs to be allocated to a specific compute device to complete the computation.

    <!-- npu="950,A3,910b,310p,310b" id8 -->

### Configuration for Dumping Operator Kernel Debugging Information

**The configuration for dumping operator kernel debugging information** is used to export the debugging information of Ascend C operator kernels, facilitating operator issue troubleshooting. **This dump configuration is disabled by default.**

Only the following models support this configuration:

<!-- npu="950" id9 -->
Ascend 950PR&950DT products
<!-- end id9 -->

<!-- npu="A3" id10 -->
Atlas A3 products
<!-- end id10 -->

<!-- npu="910b" id11 -->
Atlas A2 products
<!-- end id11 -->

<!-- npu="310b" id12 -->
Atlas 200I/500 A2 inference products
<!-- end id12 -->

<!-- npu="310p" id13 -->
Atlas inference products
<!-- end id13 -->

Configure the dump\_kernel\_data parameter to enable the operator kernel debugging information dump function. The following is an example in the configuration file:

```json
{
    "dump":{
        "dump_kernel_data":"printf,assert",
        "dump_path":"/home/"
    }
}
```

The detailed configuration description and constraints are as follows:

- dump\_kernel\_data: specifies the type of exported data. Multiple types can be configured, separated by commas (,). If this field is not configured but the model dump configuration or single-operator dump configuration is enabled, debugging information is exported as all by default.

    The following types are currently supported:

    - all: exports the output data of all the following debugging types.
    - printf: exports the output data debugged through AscendC::printf.
    - tensor: exports the output data debugged through AscendC::DumpTensor.
    - assert: exports the output data debugged through assert/ascendc\_assert.
    - timestamp: exports the output data debugged through AscendC::PrintTimeStamp.

- dump\_path: When the operator kernel debugging information dump function is enabled, dump\_path must be configured. It specifies the storage path of the exported Dump files, and supports both absolute and relative paths.

    The priority of the Dump file storage path is as follows: the ASCEND\_DUMP\_PATH environment variable \> the ASCEND\_WORK\_PATH environment variable \> the dump\_path in the configuration file. For a detailed description of the environment variables, see [*Environment Variable Reference*](https://gitcode.com/cann/docs/blob/9.2.0/docs/en/env-vars/intro.md).

    The content of the exported Dump files cannot be viewed directly with a text tool. To view it, use the show\_kernel\_debug\_data tool to parse the debugging information into a readable format. For instructions on using the tool, see [*Ascend C Operator Development Guide*](https://gitcode.com/cann/asc-devkit/blob/9.2.0/docs/en/guide/index.md).
    <!-- end id8 -->

### Profiling Information Collection Configuration

**Profiling information collection configuration**: For the configuration example, description, and constraints, see [Performance Tuning Tool User Guide](https://gitcode.com/cann/docs/blob/9.2.0/docs/en/profiling/profiling_menu.md). **Profiling information collection configuration is disabled by default.**

It is recommended that dump information and profiling collected information not be configured at the same time. Otherwise, the dump operation affects system performance, causing the performance data metrics collected by profiling to be inaccurate.

### Operator Cache Information Aging Configuration

**Operator cache information aging configuration**: When a single operator is executed in single-operator model mode (except for single operators executed through the aclopUpdateParams API), to save memory and balance call performance, you can configure the maximum length of the "operator type - single-operator model" mapping queue through the max\_opqueue\_num parameter. If the length reaches the maximum, the mapping information that has not been used for a long time and the single-operator models in the cache are deleted first, and then the latest mapping information and the corresponding single-operator models are loaded. If the maximum length of the mapping queue is not configured, the **default maximum length is 20000**.

Single-operator model execution refers to executing an operator based on graph IR. First, compile the operator (for example, use the ATC tool to compile the single-operator description file defined by Ascend IR into an operator OM model file), then call an acl API to load the operator model (for example, the aclopSetModelDir API), and finally call an acl API to execute the operator (for example, the aclopExecuteV2 API).

Configure the maximum length of the "operator type - single-operator model" mapping queue through the max\_opqueue\_num parameter to implement operator cache information aging. The example content in the configuration file is as follows:

```json
{
        "max_opqueue_num": "10000"
}
```

The related configuration description and constraints are as follows:

- For statically loaded operators (referring to the \*.om files compiled from single operators, for example, the aclopSetModelDir API), the aging configuration is invalid, and aging is not performed on the operator information of this part.
- For online-compiled operators (referring to operators compiled directly by calling acl APIs, for example, aclopCompile and aclopCompileAndExecuteV2), the API internally loads the single-operator model according to the input parameters, and the aging configuration is valid.

    If a user calls the aclopCompile API to compile an operator and the aclopExecuteV2 API to execute the operator, the operator must be executed in a timely manner after compilation. Otherwise, when the operator is executed, the operator information may have already been aged out and needs to be recompiled. It is recommended to call the aclopCompileAndExecuteV2 API to compile and execute the operator.

- The API internally maintains separate mapping queues for static-shape and dynamic-shape operators, and the maximum length of both is the max\_opqueue\_num parameter value.
- The max\_opqueue\_num parameter value is the sum of the number of single-operator models of statically loaded operators and the number of single-operator models of online-compiled operators. Therefore, the max\_opqueue\_num parameter value should be greater than the number of single-operator models of statically loaded operators available in the current process. Otherwise, the information of online-compiled operators cannot be aged out.

### Error Information Reporting Mode Configuration

**The error information reporting mode configuration** controls whether the [aclGetRecentErrMsg](13_exception_handling.md#aclGetRecentErrMsg) API obtains error information at the process level or thread level. **By default, error information is obtained at the thread level.**

err\_msg\_mode Value range of the parameter: 0 is the default value, indicating that error information is obtained at the thread level; 1 indicates that error information is obtained at the process level.

The following is an example of the content in the configuration file:

```json
{
        "err_msg_mode": "1"
}
```

<!-- npu="950,A3,910b,910,310p,310b" id15 -->
### Default Device Configuration Example

**Default Device Configuration** (used to configure the default compute device). If a device is also specified through the [aclrtSetDevice](04_device_management.md#aclrtSetDevice) API, the aclrtSetDevice API takes higher priority. After the user enables the default device function, if a context needs to be explicitly created, the [aclrtSetDevice](04_device_management.md#aclrtSetDevice) API must be called; otherwise, service exceptions may occur.

default\_device Set the Device ID in the parameter. The Device ID can be set to 0 or a positive decimal integer. After the user calls the [aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount) API to obtain the number of available devices, the value range of this Device ID is:\[0, \( the number of available devices -1\)\].

The example content in the configuration file is as follows:

```json
{
    "defaultDevice":{
        "default_device":"0"
    }
}
```
<!-- end id15 -->

<!-- npu="950,A3,910b,310b" id16 -->
### AI Core Stack Space Size Configuration Example

**AI Core stack space size configuration** controls the stack space size allocated to each AI Core during kernel execution in a process. **The default value is 32KB.**

<!-- npu="950" id17 -->
Ascend 950PR&950DT products support this configuration. When compiling AI Core operators, there is no need to enable the O0 switch.
<!-- end id17 -->

<!-- npu="A3,910b" id18 -->
Atlas A3 products and Atlas A2 products support this configuration. However, when compiling AI Core operators, the configured AI Core stack space size takes effect only when the O0 switch is enabled.
<!-- end id18 -->

<!-- npu="310b" id19 -->
Atlas 200I/500 A2 inference products support this configuration. However, when compiling AI Core operators, the configured AI Core stack space size takes effect only when the O0 switch is enabled.
<!-- end id19 -->

aicore\_stack\_size Set the stack space size at the parameter. The unit is byte, and the value must meet the following requirements:

- aicore\_stack\_size must be an integer multiple of 16K. If the passed aicore\_stack\_size is not an integer multiple of 16K, it is rounded up to ensure that it is an integer multiple of 16K.
- aicore\_stack\_size The minimum value is 32KB. If the passed aicore\_stack\_size is less than 32KB, the default configuration of 32KB is used.
- The maximum values of aicore\_stack\_size for each product are as follows:

    <!-- npu="950" id20 -->
    On Ascend 950PR&950DT products, the maximum value of aicore\_stack\_size is 128KB.
    <!-- end id20 -->

    <!-- npu="A3,910b" id21 -->
    On Atlas A3 products and Atlas A2 products, aicore\_stack\_size the maximum value is 192 KB.
    <!-- end id21 -->

    <!-- npu="310b" id22 -->
    On Atlas 200I/500 A2 inference products, aicore\_stack\_size the maximum value is 7680 KB.
    <!-- end id22 -->

The following is an example of the content in the configuration file:

```json
{
    "StackSize":{
        "aicore_stack_size":32768
    }
}
```
<!-- end id16 -->

<!-- npu="950" id23 -->
### SIMT Operator Stack Space Size Configuration Example

**SIMT (Single Instruction Multiple Thread) stack space size configuration** controls the stack space size of SIMT operators in each thread and the divergence stack space size of SIMT operators, in bytes.

<!-- npu="950" id24 -->
This configuration is supported only by Ascend 950PR&950DT products.
<!-- end id24 -->

simt\_stack\_size sets the stack space size of each thread for SIMT operators, in bytes. The default value is 1152 bytes.

simt\_divergence\_stack\_size sets the divergence stack space size of SIMT operators, in bytes. The default value is 1024 bytes.

The values of simt\_stack\_size and simt\_divergence\_stack\_size must be multiples of 128. If a value that is not a multiple of 128 is passed in, the API internally rounds it up to the nearest multiple of 128.

The following is an example of the content in the configuration file:

```json
{
  "StackSize": {
    "simt_stack_size": 1024,
    "simt_divergence_stack_size": 512
  }
}
```
<!-- end id23 -->

<!-- npu="950" id25 -->
### SIMT Printf Debug Space Size Configuration

The SIMT (Single Instruction Multiple Thread) Printf debug space size configuration controls the space size that a SIMT operator can use for Printf output, in bytes.

<!-- npu="950" id26 -->
Only Ascend 950PR&950DT products support this configuration.
<!-- end id26 -->

simt\_printf\_fifo\_size Set the SIMT operator Printf debug space size in the parameter, in bytes. The value must be a multiple of 8. If the value passed in is not a multiple of 8, the API internally rounds it up to the nearest multiple of 8.

simt\_printf\_fifo\_size The default value is 2 MB, the minimum value is 1 MB, and the maximum value is 64 MB.

The following is an example of the content in the configuration file:

```json
{
  "simt_printf_fifo_size": 1048576
}
```
<!-- end id25 -->

<!-- npu="950,A3,910b" id27 -->
### SIMD Printf Debug Space Size Configuration Example

The SIMD (Single Instruction Multiple Data) Printf debug space size configuration controls the space size, in bytes, that SIMD operators on each core can use for Printf output. Only the following models support this configuration:

<!-- npu="950,A3,910b" id28 -->
Only Ascend 950PR&950DT products, Atlas A3 products, and Atlas A2 products support this configuration.
<!-- end id28 -->

simd\_printf\_fifo\_size\_per\_core In the parameter, set the SIMD operator Printf debug space size, in bytes. The value must be a multiple of 8. If the value passed in is not a multiple of 8, the API internally rounds it up to the nearest multiple of 8.

simd\_printf\_fifo\_size\_per\_core The default value is 32 KB, the minimum value is 1 KB, and the maximum value is 64 MB.

The following is an example in the configuration file:

```json
{
  "simd_printf_fifo_size_per_core": 1048576
}
```
<!-- end id27 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclFinalize"></a>

## aclFinalize

```c
aclError aclFinalize()
```

### Applicable Products

<!-- npu="950" id666 -->
- Ascend 950PR&950DT products: Supported
<!-- end id666 -->
<!-- npu="A3" id667 -->
- Atlas A3 products: Supported
<!-- end id667 -->
<!-- npu="910b" id668 -->
- Atlas A2 products: Supported
<!-- end id668 -->
<!-- npu="310b" id669 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id669 -->
<!-- npu="310p" id670 -->
- Atlas inference products: Supported
<!-- end id670 -->
<!-- npu="910" id671 -->
- Atlas training products: Supported
<!-- end id671 -->
<!-- @ref: runtime/res/docs/zh/api_ref/02_initialization_and_deinitialization_res.md#id2 -->

### Description

Deinitialization function used to release the resources used by the acl APIs within the process.

<!-- npu="950,A3,910b,910,310p,310b" id29 -->
For scenarios where device service logs are reported back to the host, this API adds a 2000 ms delay by default (the actual maximum delay can reach 2000 ms) to ensure that ERROR-level and EVENT-level logs are completely reported back and prevent loss. You can set the ASCEND\_LOG\_DEVICE\_FLUSH\_TIMEOUT environment variable to 0 (command example: export ASCEND\_LOG\_DEVICE\_FLUSH\_TIMEOUT=0) to cancel this default delay. For a detailed description of the ASCEND\_LOG\_DEVICE\_FLUSH\_TIMEOUT environment variable, see ASCEND\_LOG\_DEVICE\_FLUSH\_TIMEOUT in [Environment Variable Reference](../env_vars/ASCEND_LOG_DEVICE_FLUSH_TIMEOUT.md).
<!-- end id29 -->

### Parameters

None

### Return Values

Returns 0 on success and other values on failure. See [aclError](25-01_aclError.md#aclError).

### Constraints

Before the application process exits, ensure that aclFinalize or [aclFinalizeReference](#aclFinalizeReference) has been called to complete deinitialization. Otherwise, exceptions may occur, for example, an error is reported when the application process exits.

It is not recommended to call aclFinalize or [aclFinalizeReference](#aclFinalizeReference) in a destructor. Otherwise, the process may exit abnormally when it exits because the destruction order of singletons is unknown.

<br>
<br>
<br>

<a class="method_anchor" id="aclFinalizeReference"></a>

## aclFinalizeReference

```c
aclError aclFinalizeReference(uint64_t *refCount)
```

### Applicable Products

<!-- npu="950" id3207 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3207 -->
<!-- npu="A3" id3208 -->
- Atlas A3 products: Supported
<!-- end id3208 -->
<!-- npu="910b" id3209 -->
- Atlas A2 products: Supported
<!-- end id3209 -->
<!-- npu="310b" id3210 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3210 -->
<!-- npu="310p" id3211 -->
- Atlas inference products: Supported
<!-- end id3211 -->
<!-- npu="910" id3212 -->
- Atlas training products: Supported
<!-- end id3212 -->
<!-- @ref: runtime/res/docs/zh/api_ref/02_initialization_and_deinitialization_res.md#id3 -->

### Description

Deinitialization function, used to release the resources used by the acl APIs within the process.

The aclFinalizeReference API internally involves reference counting. Each time the aclInit API is called, the reference count is incremented by one; each time the aclFinalizeReference API is called, the reference count is decremented by one. Only when the reference count reaches 0 is deinitialization actually performed. The difference between the [aclFinalize](#aclFinalize) API and this API is that calling the aclFinalize API clears the count to zero and performs deinitialization directly.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| refCount | Input & output | Returns the reference count after `aclFinalizeReference` is called.<br>If the reference count does not need to be obtained, `nullptr` can be passed here. |

### Return Values

Returns 0 on success and other values on failure. See [aclError](25-01_aclError.md#aclError).

### Constraints

Before the application process exits, ensure that [aclFinalize](#aclFinalize) or aclFinalizeReference has been called to complete deinitialization. Otherwise, exceptions may occur, for example, an error is reported when the application process exits.

It is not recommended to call [aclFinalize](#aclFinalize) or aclFinalizeReference in a destructor. Otherwise, the process may exit abnormally when it exits because the destruction order of singletons is unknown.

<br>
<br>
<br>

<a class="method_anchor" id="aclInitCallbackRegister"></a>

## aclInitCallbackRegister

```c
aclError aclInitCallbackRegister(aclRegisterCallbackType type, aclInitCallbackFunc cbFunc, void *userData)
```

### Applicable Products

<!-- npu="950" id988 -->
- Ascend 950PR&950DT products: Supported
<!-- end id988 -->
<!-- npu="A3" id989 -->
- Atlas A3 products: Supported
<!-- end id989 -->
<!-- npu="910b" id990 -->
- Atlas A2 products: Supported
<!-- end id990 -->
<!-- npu="310b" id991 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id991 -->
<!-- npu="310p" id992 -->
- Atlas inference products: Supported
<!-- end id992 -->
<!-- npu="910" id993 -->
- Atlas training products: Supported
<!-- end id993 -->
<!-- @ref: runtime/res/docs/zh/api_ref/02_initialization_and_deinitialization_res.md#id4 -->

### Description

Registers an initialization callback function.

If this API is called before [aclInit](#aclInit), the callback function is triggered during initialization. If this API is called after [aclInit](#aclInit), the callback function is triggered immediately upon registration.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| type | Input | Registration type, distinguished by function. See [aclRegisterCallbackType](25-02_Enumerations.md#aclRegisterCallbackType). |
| cbFunc | Input | Initialization callback function.<br>The function prototype of the callback function is as follows:<br>typedef [aclError](25-01_aclError.md#aclError) (*aclInitCallbackFunc)(const char*configStr, size_t len, void *userData);<br>configStr is consistent with the JSON file content in the aclInit API; len indicates the length of the JSON file content, in bytes. |
| userData | Input | Pointer to the user data to be passed to the callback function. |

### Return Values

Returns 0 on success and other values on failure. See [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclInitCallbackUnRegister"></a>

## aclInitCallbackUnRegister

```c
aclError aclInitCallbackUnRegister(aclRegisterCallbackType type, aclInitCallbackFunc cbFunc)
```

### Applicable Products

<!-- npu="950" id2444 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2444 -->
<!-- npu="A3" id2445 -->
- Atlas A3 products: Supported
<!-- end id2445 -->
<!-- npu="910b" id2446 -->
- Atlas A2 products: Supported
<!-- end id2446 -->
<!-- npu="310b" id2447 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2447 -->
<!-- npu="310p" id2448 -->
- Atlas inference products: Supported
<!-- end id2448 -->
<!-- npu="910" id2449 -->
- Atlas training products: Supported
<!-- end id2449 -->
<!-- @ref: runtime/res/docs/zh/api_ref/02_initialization_and_deinitialization_res.md#id5 -->

### Description

If callback function invocation does not need to be triggered, call this API to unregister the callback function.

### Parameters

| Parameter Name | Input/Output | Description |
| --- | :---: | --- |
| type | Input | Registration type, distinguished by function. See [aclRegisterCallbackType](25-02_Enumerations.md#aclRegisterCallbackType). |
| cbFunc | Input | Initialization callback function.<br>The function prototype of the callback function is as follows:<br>typedef [aclError](25-01_aclError.md#aclError) (*aclInitCallbackFunc)(const char*configStr, size_t len, void *userData); |

### Return Values

Returns 0 on success and other values on failure. See [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclFinalizeCallbackRegister"></a>

## aclFinalizeCallbackRegister

```c
aclError aclFinalizeCallbackRegister(aclRegisterCallbackType type, aclFinalizeCallbackFunc cbFunc, void *userData)
```

### Applicable Products

<!-- npu="950" id2332 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2332 -->
<!-- npu="A3" id2333 -->
- Atlas A3 products: Supported
<!-- end id2333 -->
<!-- npu="910b" id2334 -->
- Atlas A2 products: Supported
<!-- end id2334 -->
<!-- npu="310b" id2335 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2335 -->
<!-- npu="310p" id2336 -->
- Atlas inference products: Supported
<!-- end id2336 -->
<!-- npu="910" id2337 -->
- Atlas training products: Supported
<!-- end id2337 -->
<!-- @ref: runtime/res/docs/zh/api_ref/02_initialization_and_deinitialization_res.md#id6 -->

### Description

Registers a deinitialization callback function.

Call this API before [aclFinalize](#aclFinalize) to trigger the callback function during deinitialization.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| type | Input | Registration type, distinguished by function. See [aclRegisterCallbackType](25-02_Enumerations.md#aclRegisterCallbackType). |
| cbFunc | Input | Deinitialization callback function.<br>The callback function is defined as follows:<br>typedef [aclError](25-01_aclError.md#aclError) (*aclFinalizeCallbackFunc)(void*userData); |
| userData | Input | Pointer to the user data to be passed to the callback function. |

### Return Values

Returns 0 on success and other values on failure. See [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclFinalizeCallbackUnRegister"></a>

## aclFinalizeCallbackUnRegister

```c
aclError aclFinalizeCallbackUnRegister(aclRegisterCallbackType type, aclFinalizeCallbackFunc cbFunc)
```

### Applicable Products

<!-- npu="950" id155 -->
- Ascend 950PR&950DT products: Supported
<!-- end id155 -->
<!-- npu="A3" id156 -->
- Atlas A3 products: Supported
<!-- end id156 -->
<!-- npu="910b" id157 -->
- Atlas A2 products: Supported
<!-- end id157 -->
<!-- npu="310b" id158 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id158 -->
<!-- npu="310p" id159 -->
- Atlas inference products: Supported
<!-- end id159 -->
<!-- npu="910" id160 -->
- Atlas training products: Supported
<!-- end id160 -->
<!-- @ref: runtime/res/docs/zh/api_ref/02_initialization_and_deinitialization_res.md#id7 -->

### Description

If the callback function does not need to be triggered, call this API to unregister the callback function.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| type | Input | Registration type, distinguished by function. See [aclRegisterCallbackType](25-02_Enumerations.md#aclRegisterCallbackType). |
| cbFunc | Input | Deinitialization callback function.<br>The callback function is defined as follows:<br>typedef [aclError](25-01_aclError.md#aclError) (*aclFinalizeCallbackFunc)(void*userData); |

### Return Values

Returns 0 on success and other values on failure. See [aclError](25-01_aclError.md#aclError).
