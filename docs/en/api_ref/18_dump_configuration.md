# 18. Dump Configuration

<!-- md-trans-meta sourceCommit=be113e8125a2a8c7ff54fc96bb9a5e053217e879 translatedAt=2026-11-06T11:31:18.482Z pushedAt=2026-11-09T10:33:13.497Z nl=2 -->

This topic describes the dump configuration APIs of CANN Runtime, which are used to initialize, configure, and register callbacks for operator data dump.

- [`aclError aclmdlInitDump()`](#aclmdlInitDump): Initializes the dump.
- [`aclError aclmdlSetDump(const char *dumpCfgPath)`](#aclmdlSetDump): Sets the dump parameter.
- [`aclError acldumpRegCallback(int32_t (* const messageCallback)(const acldumpChunk *, int32_t), int32_t flag)`](#acldumpRegCallback): Registers the dump data callback.
- [`void acldumpUnregCallback()`](#acldumpUnregCallback): Unregisters the dump data callback.
- [`const char* acldumpGetPath(acldumpType dumpType)`](#acldumpGetPath): Obtains the storage path of dump data, so that users can save custom maintenance and test data to this path.
- [`aclError aclmdlFinalizeDump()`](#aclmdlFinalizeDump): Deinitializes the dump.
- [`aclError aclopStartDumpArgs(uint32_t dumpType, const char *path)`](#aclopStartDumpArgs): Enables operator information statistics. It must be used together with [aclopStopDumpArgs](#aclopStopDumpArgs) to output the operator information file to the directory specified by the **path** parameter. One shape corresponds to one operator information file, which contains the operator type, operator attributes, and the format/data type/shape of operator inputs and outputs.
- [`aclError aclopStopDumpArgs(uint32_t dumpType)`](#aclopStopDumpArgs): Disables operator information statistics. It must be used together with [aclopStartDumpArgs](#aclopStartDumpArgs) to output the operator information file to the directory specified by the **path** parameter. One shape corresponds to one operator information file, which contains the operator type, operator attributes, and the format/data type/shape of operator inputs and outputs.
- [`aclError acldumpGetExceptionInfoPath(char *path, size_t maxLen)`](#acldumpGetExceptionInfoPath): Obtains the storage path of the exception operator dump data, so that users can save custom maintenance and test data to this path. The exported data is used to analyze AI Core errors.
- [`aclError acldumpSaveExceptionInfo(const char *fileName, const char *userTag, const acldumpTensorInfo *tensors, size_t tensorCount)`](#acldumpSaveExceptionInfo): Saves custom exception operator tensor data to the storage path of the exception operator dump data. The exported data is used to analyze AI Core errors.

<a class="method_anchor" id="aclmdlInitDump"></a>

## aclmdlInitDump

```c
aclError aclmdlInitDump()
```

### Applicable Products

<!-- npu="950" id2108 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2108 -->
<!-- npu="A3" id2109 -->
- Atlas A3 products: Supported
<!-- end id2109 -->
<!-- npu="910b" id2110 -->
- Atlas A2 products: Supported
<!-- end id2110 -->
<!-- npu="310b" id2111 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2111 -->
<!-- npu="310p" id2112 -->
- Atlas inference products: Supported
<!-- end id2112 -->
<!-- npu="910" id2113 -->
- Atlas training products: Supported
<!-- end id2113 -->
<!-- @ref: runtime/res/docs/zh/api_ref/18_dump_configuration_res.md#id1 -->

### Description

Initializes the dump.

This API must be used together with other APIs to implement the following features:

- **Dump data written to a file**

    The [aclmdlInitDump](#aclmdlInitDump), [aclmdlSetDump](#aclmdlSetDump), and [aclmdlFinalizeDump](#aclmdlFinalizeDump) APIs are used together to record dump data to a file. Within a process, these APIs can be called multiple times as needed to obtain dump data based on different dump configuration information. Scenario examples are as follows:

    - To execute two different models with different dump configuration information, the API call sequence is as follows: [aclInit](02_initialization_and_deinitialization.md#aclInit) API --\> [aclmdlInitDump](#aclmdlInitDump) API --\>[aclmdlSetDump](#aclmdlSetDump) API --\> model 1 loading --\> model 1 execution --\> [aclmdlFinalizeDump](#aclmdlFinalizeDump) API --\> model 1 unloading --\> [aclmdlInitDump](#aclmdlInitDump) API --\> [aclmdlSetDump](#aclmdlSetDump) API --\> model 2 loading --\> model 2 execution --\> [aclmdlFinalizeDump](#aclmdlFinalizeDump) API --\> model 2 unloading --\> execution of other tasks --\> [aclFinalize](02_initialization_and_deinitialization.md#aclFinalize) API
    - To execute the same model twice, where dump is required for the first execution but not for the second, the API call sequence is as follows: [aclInit](02_initialization_and_deinitialization.md#aclInit) API --\> [aclmdlInitDump](#aclmdlInitDump) API --\> [aclmdlSetDump](#aclmdlSetDump) API --\> model loading --\> model execution --\> [aclmdlFinalizeDump](#aclmdlFinalizeDump) API --\> model unloading --\> model loading --\> model execution --\> execution of other tasks --\> [aclFinalize](02_initialization_and_deinitialization.md#aclFinalize) API

- **Dump data obtained directly through a callback function without being written to a file**

    The [aclmdlInitDump](#aclmdlInitDump), [acldumpRegCallback](#acldumpRegCallback) (the callback function registered through this API must be implemented by the user, and its implementation logic includes obtaining the dump data and data length), [acldumpUnregCallback](#acldumpUnregCallback), and [aclmdlFinalizeDump](#aclmdlFinalizeDump) APIs are used together to obtain dump data through a callback function. Scenario examples are as follows:

    - Execute a model and obtain dump data through the callback:

        [aclInit](02_initialization_and_deinitialization.md#aclInit) API --\> [acldumpRegCallback](#acldumpRegCallback) API --\> [aclmdlInitDump](#aclmdlInitDump) API --\> model loading --\> model execution --\> [aclmdlFinalizeDump](#aclmdlFinalizeDump) API --\> [acldumpUnregCallback](#acldumpUnregCallback) API --\> model unloading --\> [aclFinalize](02_initialization_and_deinitialization.md#aclFinalize) API

    - Execute two different models and obtain dump data through callbacks. In this scenario, as long as the [acldumpUnregCallback](#acldumpUnregCallback) API is not called to unregister the callback function, the dump data of both models can be obtained through the callback function:

        [aclInit](02_initialization_and_deinitialization.md#aclInit) API --\> [acldumpRegCallback](#acldumpRegCallback) API --\> [aclmdlInitDump](#aclmdlInitDump) API --\> model 1 loading --\> model 1 execution --\>--\> model 2 loading --\> model 2 execution --\> [aclmdlFinalizeDump](#aclmdlFinalizeDump) API --\> model unloading --\> [acldumpUnregCallback](#acldumpUnregCallback) API --\> [aclFinalize](02_initialization_and_deinitialization.md#aclFinalize) API

### Parameters

None

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- For model dump configuration, single-operator dump configuration, and overflow operator dump configuration, if dump information has been configured through the [aclInit](02_initialization_and_deinitialization.md#aclInit) API, calling the **aclmdlInitDump** API returns a failure message.
- The **aclmdlInitDump** API must be called after the [aclInit](02_initialization_and_deinitialization.md#aclInit) API and before the model loading API.

### Reference Resources

The [aclInit](02_initialization_and_deinitialization.md#aclInit) API is also provided. During the initialization phase, dump configuration information is passed in through the **\*.json** file, and dump data is obtained after the application runs. With this method, the [aclInit](02_initialization_and_deinitialization.md#aclInit) API can be called only once within a process. To modify the dump configuration information, modify the configuration in the **\*.json** file.

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlSetDump"></a>

## aclmdlSetDump

```c
aclError aclmdlSetDump(const char *dumpCfgPath)
```

### Applicable Products

<!-- npu="950" id554 -->
- Ascend 950PR&950DT products: Supported
<!-- end id554 -->
<!-- npu="A3" id555 -->
- Atlas A3 products: Supported
<!-- end id555 -->
<!-- npu="910b" id556 -->
- Atlas A2 products: Supported
<!-- end id556 -->
<!-- npu="310b" id557 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id557 -->
<!-- npu="310p" id558 -->
- Atlas inference products: Supported
<!-- end id558 -->
<!-- npu="910" id559 -->
- Atlas training products: Supported
<!-- end id559 -->
<!-- @ref: runtime/res/docs/zh/api_ref/18_dump_configuration_res.md#id2 -->

### Description

Sets the dump parameter.

The [aclmdlInitDump](#aclmdlInitDump), [aclmdlSetDump](#aclmdlSetDump), and [aclmdlFinalizeDump](#aclmdlFinalizeDump) APIs are used together to record dump data to files. Within a process, these APIs can be called multiple times as needed to obtain dump data based on different dump configuration information. Scenario examples are as follows:

- To execute two different models that require different dump configuration information, the API call sequence is: [aclInit](02_initialization_and_deinitialization.md#aclInit) API --\> [aclmdlInitDump](#aclmdlInitDump) API --\> [aclmdlSetDump](#aclmdlSetDump) API --\> model 1 loading --\> model 1 execution --\> [aclmdlFinalizeDump](#aclmdlFinalizeDump) API --\> model 1 unloading --\> [aclmdlInitDump](#aclmdlInitDump) API --\> [aclmdlSetDump](#aclmdlSetDump) API --\> model 2 loading --\> model 2 execution --\> [aclmdlFinalizeDump](#aclmdlFinalizeDump) API --\> model 2 unloading --\> execution of other tasks --\> [aclFinalize](02_initialization_and_deinitialization.md#aclFinalize) API
- To execute the same model twice, where dump is required for the first execution but not for the second, the API call sequence is: [aclInit](02_initialization_and_deinitialization.md#aclInit) API --\> [aclmdlInitDump](#aclmdlInitDump) API --\> [aclmdlSetDump](#aclmdlSetDump) API --\> model loading --\> model execution --\> [aclmdlFinalizeDump](#aclmdlFinalizeDump) API --\> model unloading --\> model loading --\> model execution --\> execution of other tasks --\> [aclFinalize](02_initialization_and_deinitialization.md#aclFinalize) API

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dumpCfgPath | Input | Pointer to the configuration file path, including the file name. The configuration file is in JSON format.<br>This configuration file can be used to enable or configure various types of dump information. For details, see the descriptions in the configuration examples of each function below. If the operator input or output contains sensitive user information, there is a risk of information leakage. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- The configured dump information takes effect only for models loaded after this API is called to enable dump. Models loaded before this API is called are not affected, unless the user reloads the models after calling this API.

    For example, in the following API call sequence, loaded model 1 is not affected, and the configured dump information takes effect only for loaded model 2:

    [aclmdlInitDump](#aclmdlInitDump) API --\> model 1 loading --\> **aclmdlSetDump** API --\> model 2 loading --\> [aclmdlFinalizeDump](#aclmdlFinalizeDump) API

- If this API is called multiple times to configure dump information for the same model, the system adopts an overwrite policy during processing.

    For example, in the following API call sequence, the dump information configured by the second call to this API overwrites the dump information configured by the first call:

    [aclmdlInitDump](#aclmdlInitDump) API --\> **aclmdlSetDump** API --\> **aclmdlSetDump** API --\> model 1 loading --\> [aclmdlFinalizeDump](#aclmdlFinalizeDump) API

### Model Dump Configuration and Single-Operator Dump Configuration

The exported data of **model dump configuration** (used to export the input and output data of each operator layer in a model) and **single-operator dump configuration** (used to export the input and output data of a single operator) is used for comparison with a specified model or operator to locate precision issues. For the specific comparison method, see [Precision Debugging Tool User Guide](https://www.hiascend.com/document/detail/en/CANNCommunityEdition/920/devaids/ModelAccuracyAnalyzer/atlasaccuracy_16_0001.html). **The dump configurations are disabled by default.**

To enable the dump configuration through this API, configure the path for saving dump data through the **dump\_path** parameter.

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

The following is an example of the single-operator dump configuration:

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

<a class="method_anchor" id="exception_dump_config"></a>

### Configuration File Example (Exception Operator Dump Configuration)

The exported data of **exception operator dump configuration** (used to export the input/output data, workspace information, and tiling information of exception operators) is used to analyze AI Core errors. This dump configuration is disabled by default.

Enable the exception operator dump feature by setting the **dump\_scene** parameter. The example content in the configuration file is as follows, indicating that lightweight exception dump is enabled:

```json
{
    "dump":{
        "dump_path":"output",
        "dump_scene":"aic_err_brief_dump"
    }
}
```

The detailed configuration description and constraints are as follows:

- The **dump\_scene** parameter supports the following values:
    - **aic\_err\_brief\_dump**: lightweight exception dump, used to export the input/output and workspace data of AI Core error operators.
    - **aic\_err\_norm\_dump**: normal exception dump. In addition to lightweight exception dump, it also exports **Shape**, **Data Type**, **Format**, and attribute information.
    <!-- npu="A3,910b" id1 -->
    - **aic\_err\_detail\_dump**: In addition to lightweight exception dump, it also exports the internal storage, register, and call stack information of AI Cores.

        When setting this option, note the following:

        - This option is supported only on the following models, and requires a driver of version 25.0.RC1 or later:

            Atlas A2 products

            Atlas A3 products

            You can click [Link](https://www.hiascend.com/hardware/firmware-drivers/commercial) to download the driver installation package of Ascend HDK  25.0.RC1 or later on the firmware and drivers page, and install or upgrade it by referring to the documentation of the corresponding version.
    <!-- end id1 -->

        -   If the **aic\_err\_detail\_dump** option is set, this API must be called before the [aclrtSetDevice](04_device_management.md#aclrtSetDevice) API, and dump deinitialization cannot be implemented through the [aclmdlFinalizeDump](#aclmdlFinalizeDump) API.
        -   During the export of dump files, the AI Core where the exception operator resides is paused, which may affect the normal execution of other service processes on the device. After the dump files are exported, the AI Core is automatically restored.
        -   After the dump files are exported, the user service process on the host side is forcibly exited. Errors reported during the forced exit may not be used as input for AI Core problem analysis.
        -   If multiple user service processes on the host side specify the same device and all set the **aic\_err\_detail\_dump** option, the process executed first exports dump files according to the **aic\_err\_detail\_dump** option, and the process executed later exports dump files according to the **aic\_err\_brief\_dump** option.

    - **lite\_exception**: lightweight exception dump. For compatibility with earlier versions, its effect is equivalent to **aic\_err\_brief\_dump**.

- **dump\_path** is an optional parameter that indicates the storage path for exported dump files.

    The priority of the dump file storage path is as follows: **NPU\_COLLECT\_PATH** environment variable \> **ASCEND\_WORK\_PATH** environment variable \> **dump\_path** in the configuration file \> the current execution directory of the application

    For details about the environment variables, see [Environment Variable Reference](https://gitcode.com/cann/docs/blob/9.2.0/docs/en/env-vars/intro.md).

<!-- npu="950,A3,910b,910,310p,310b" id2 -->
- To view the content of the exported dump files, see the "Fault Locating Tool \> msaicerr Tool Usage Guide \> Parsing Dump Files" section in [Troubleshooting](https://gitcode.com/cann/docs/blob/9.2.0/docs/en/troubleshooting/troubleshooting_intro.md).

    <!-- npu="A3,910b" id3 -->
    If the **dump\_scene** parameter is set to **aic\_err\_detail\_dump**, use the msDebug tool to view the content of the exported dump files. For details, see [Operator Development Tool User Guide](https://www.hiascend.com/document/detail/en/CANNCommunityEdition/920/devaids/optool/docs/en/quick_start/msdebug_quick_start.md).
    <!-- end id3 -->
<!-- end id2 -->

- Exception operator dump configuration cannot be enabled simultaneously with model dump configuration or single-operator dump configuration.

### Overflow Operator Dump Configuration

**Overflow operator dump configuration** is used to export the input and output data of overflow operators in a model. The exported data is used to analyze the cause of overflow and locate model precision issues. **This dump configuration is disabled by default.**

Set the **dump\_debug** parameter to **on** to enable the overflow operator configuration. The sample content in the configuration file is as follows:

```json
{
    "dump":{
        "dump_path":"output",
        "dump_debug":"on"
    }
}
```

The detailed configuration description and constraints are as follows:

- If **dump\_debug** is not set or **dump\_debug** is set to **off**, the overflow operator configuration is not enabled.
- If the overflow operator configuration is enabled, **dump\_path** must be set to specify the storage path of the exported dump files.

    After obtaining the exported data files, parse the files by referring to [Precision Debugging Tool User Guide](https://www.hiascend.com/document/detail/en/CANNCommunityEdition/920/devaids/ModelAccuracyAnalyzer/atlasaccuracy_16_0001.html).

    **dump\_path** supports an absolute path or a relative path:

    - An absolute path starts with **"/"**, for example, **/home**.
    - A relative path starts directly with a directory name, for example, **output**.

- Overflow operator dump configuration cannot be enabled simultaneously with model dump configuration or single-operator dump configuration; otherwise, an error is returned.
- Only overflow data of AI Core operators is supported for collection.

### Operator Dump Watch Mode Configuration

**Operator dump watch mode configuration** is used to enable the observation mode for the output data of specified operators. After locating the precision issue of some operators and ruling out the computation problem of the operators themselves, if you suspect that the precision issue is caused by other operators corrupting their memory, you can enable the dump watch mode. **The dump watch mode is disabled by default.**

Set the **dump\_scene** parameter to **watcher** to enable the operator dump watch mode. The sample content in the configuration file is as follows, and the configuration effect is: (1) After operator A and operator B are executed, the outputs of operator C and operator D are dumped. (2) After operator C and operator D are executed, the outputs of operator C and operator D are also dumped. Compare the dump files of operator C and operator D in (1) and (2) to check whether operator A and operator B corrupt the output memory of operator C and operator D.

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
        "dump_scene":"watcher"
    }
}
```

The detailed configuration description and constraints are as follows:

- If the operator dump watch mode is enabled, overflow operator dump configuration (set by the **dump\_debug** parameter) or single-operator model dump configuration (set by the **dump\_op\_switch** parameter) cannot be enabled at the same time; otherwise, an error is reported. This mode does not take effect in the single-operator API Dump scenario.
- In **dump\_list**, use the **layer** parameter to set the names of operators that may corrupt the memory of other operators, and use the **watcher\_nodes** parameter to set the names of operators whose output memory may be corrupted by other operators, causing precision issues.
    - If **layer** is not specified, after all dump-capable operators in the model are executed, the outputs of the operators configured in **watcher\_nodes** are dumped.
    - The operators configured in **layer** and **watcher\_nodes** must be operators in a static graph or static subgraph; otherwise, the configuration does not take effect.
    - If the operator names configured in **layer** and **watcher\_nodes** are the same, or if the operators configured in **layer** are collective communication operators (operator type starting with **Hcom**, for example, **HcomAllReduce**), only the dump files of the operators configured in **watcher\_nodes** are exported.
    - For fused operators, the operator names configured in **watcher\_nodes** must be the names after fusion. If the names before fusion are configured, no dump files are exported.
    - Configuration of **model\_name** is not supported in **dump\_list**.

- When the operator dump watch mode is enabled, **dump\_path** must be set to specify the storage path for exported dump files.

    The dump files collected here cannot be viewed directly with a text tool. To view the content of a dump file, first convert the dump file to a numpy format file, and then view the numpy-format file through Python. For detailed conversion steps, see [Precision Debugging Tool User Guide](https://www.hiascend.com/document/detail/en/CANNCommunityEdition/920/devaids/ModelAccuracyAnalyzer/atlasaccuracy_16_0001.html).

    **dump\_path** supports an absolute path or a relative path:

    - An absolute path starts with **"/"**, for example, **/home**.
    - A relative path starts directly with a directory name, for example, **output**.

- The **dump\_mode** parameter controls which part of the data of the operator configured in **watcher\_nodes** is exported. Currently, only output is supported.

<!-- npu="950,A3,910b,310p,310b" id4 -->
### Operator Kernel Debugging Information Dump Configuration

**Operator kernel debugging information dump configuration** is used to export the debugging information of the Ascend C operator kernel, facilitating operator issue locating. **This dump configuration is disabled by default.**

Only the following models support this configuration:
<!-- npu="950" id5 -->
- Ascend 950PR&950DT products
<!-- end id5 -->
<!-- npu="A3" id6 -->
- Atlas A3 products
<!-- end id6 -->
<!-- npu="910b" id7 -->
- Atlas A2 products
<!-- end id7 -->
<!-- npu="310b" id8 -->
- Atlas 200I/500 A2 inference products
<!-- end id8 -->
<!-- npu="310p" id9 -->
- Atlas inference products
<!-- end id9 -->

Set the **dump\_kernel\_data** parameter to enable the operator kernel debugging information dump feature. The following is an example in the configuration file:

```json
{
    "dump":{
        "dump_kernel_data":"printf,assert",
        "dump_path":"/home/"
    }
}
```

The detailed configuration description and constraints are as follows:

- **dump\_kernel\_data**: type of data to be exported. Multiple types can be configured, separated by English commas (,). If this field is not set but the model dump configuration or single-operator dump configuration is enabled, debugging information is exported as **all** by default.

    The following types are currently supported:

    - **all**: exports the output data of all the following types of debugging.
    - **printf**: exports the output data debugged through **AscendC::printf**.
    - **tensor**: exports the output data debugged through **AscendC::DumpTensor**.
    - **assert**: exports the output data debugged through **assert/ascendc\_assert**.
    - **timestamp**: exports the output data debugged through **AscendC::PrintTimeStamp**.

- **dump\_path**: When the operator kernel debugging information dump feature is enabled, **dump\_path** must be set. It specifies the storage path for exported dump files, supporting absolute or relative paths.

    The priority of the dump file storage path is as follows: **ASCEND\_DUMP\_PATH** environment variable \> **ASCEND\_WORK\_PATH** environment variable \> **dump\_path** in the configuration file. For details about environment variables, see [Environment Variable Reference](https://gitcode.com/cann/docs/blob/9.2.0/docs/en/env-vars/intro.md).

    The exported dump files cannot be viewed directly with a text tool. To view their content, use the **show\_kernel\_debug\_data** tool to parse the debugging information into a readable format. For tool usage instructions, see [Ascend C Operator Development Guide](https://gitcode.com/cann/asc-devkit/blob/9.2.0/docs/en/guide/index.md).
<!-- end id4 -->

### Reference Resources

Currently, the [aclInit](02_initialization_and_deinitialization.md#aclInit) API is also provided. During the initialization phase, dump configuration information is passed in through the **\*.json** file, and dump data is obtained after the application runs. In this mode, the [aclInit](02_initialization_and_deinitialization.md#aclInit) API can be called only once within a process. To modify the dump configuration information, you need to modify the configuration in the **\*.json** file.

<br>
<br>
<br>

<a class="method_anchor" id="acldumpRegCallback"></a>

## acldumpRegCallback

```c
aclError acldumpRegCallback(int32_t (* const messageCallback)(const acldumpChunk *, int32_t), int32_t flag)
```

### Applicable Products

<!-- npu="950" id1541 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1541 -->
<!-- npu="A3" id1542 -->
- Atlas A3 products: Supported
<!-- end id1542 -->
<!-- npu="910b" id1543 -->
- Atlas A2 products: Supported
<!-- end id1543 -->
<!-- npu="310b" id1544 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1544 -->
<!-- npu="310p" id1545 -->
- Atlas inference products: Supported
<!-- end id1545 -->
<!-- npu="910" id1546 -->
- Atlas training products: Supported
<!-- end id1546 -->
<!-- @ref: runtime/res/docs/zh/api_ref/18_dump_configuration_res.md#id3 -->

### Description

Registers a dump data callback function.

The [aclmdlInitDump](#aclmdlInitDump), [acldumpRegCallback](#acldumpRegCallback) (the callback function registered through this API must be implemented by the user, and its implementation logic includes obtaining the dump data and data length), [acldumpUnregCallback](#acldumpUnregCallback), and [aclmdlFinalizeDump](#aclmdlFinalizeDump) APIs are used together to obtain dump data through the callback function. **Scenario examples are as follows:**

- **Execute one model and obtain dump data through the callback:**

    The following two methods are supported:

    - **Do not enable** model dump configuration or single-operator dump configuration at the **aclInit** API.

        [aclInit](02_initialization_and_deinitialization.md#aclInit) API --\> [aclmdlInitDump](#aclmdlInitDump) API --\> [acldumpRegCallback](#acldumpRegCallback) API --\> model loading --\> model execution --\> [acldumpUnregCallback](#acldumpUnregCallback) API --\> [aclmdlFinalizeDump](#aclmdlFinalizeDump) API --\> model unloading --\> [aclFinalize](02_initialization_and_deinitialization.md#aclFinalize) API

    - **Enable** model dump configuration and single-operator dump configuration at the **aclInit** API. When dump configuration is enabled at the **aclInit** API, a dump-to-disk path must be set. However, if the [acldumpRegCallback](#acldumpRegCallback) API is called, dump-to-disk does not take effect, and the dump data obtained by the callback function prevails.

        [aclInit](02_initialization_and_deinitialization.md#aclInit) API --\> [acldumpRegCallback](#acldumpRegCallback) API --\> model loading --\> model execution --\> [acldumpUnregCallback](#acldumpUnregCallback) API --\> model unloading --\> [aclFinalize](02_initialization_and_deinitialization.md#aclFinalize) API

- **Execute two different models and obtain dump data through the callback**. In this scenario, as long as the [acldumpUnregCallback](#acldumpUnregCallback) API is not called to unregister the callback function, the dump data of both models can be obtained through the callback function:

    [aclInit](02_initialization_and_deinitialization.md#aclInit) API --\> [aclmdlInitDump](#aclmdlInitDump) API --\> [acldumpRegCallback](#acldumpRegCallback) API --\> model 1 loading --\> model 1 execution --\>--\> model 2 loading --\> model 2 execution --\> [acldumpUnregCallback](#acldumpUnregCallback) API --\> [aclmdlFinalizeDump](#aclmdlFinalizeDump) API --\> model unloading --\> [aclFinalize](02_initialization_and_deinitialization.md#aclFinalize) API

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| messageCallback | Input | Callback function pointer used to receive callback data. |
| flag | Input | Whether to dump data to the disk after the callback API is called. Currently only **0** is supported, indicating that data is not dumped to the disk. |

<br>
In the **messageCallback** callback function:

- The **acldumpChunk** struct is defined as follows. When implementing the **messageCallback** callback function, you can obtain the **dataBuf**, **bufLen**, and other parameter values in the **acldumpChunk** struct to obtain the dump data and its data length:

  ```c
  typedef struct acldumpChunk  {
    char       fileName[ACL_DUMP_MAX_FILE_PATH_LENGTH];   // Name of the dump data file to be written to the disk. ACL_DUMP_MAX_FILE_PATH_LENGTH indicates the maximum file name length, which is currently 4096.
    uint32_t   bufLen;       // Length of dataBuf, in bytes.
    uint32_t   isLastChunk;  // Whether the dump data is the last chunk. 0 indicates that it is not the last chunk, and 1 indicates that it is the last chunk.
    int64_t    offset;       // Offset of the dump data file content, where -1 indicates appending content to the file.
    int32_t    flag;         // Reserved dump data flag. Currently the data has no flag.
    uint8_t    dataBuf[0];   // Memory address of the dump data.
  } acldumpChunk;
  ```

- **len**: length of the **acldumpChunk** struct, in bytes.

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acldumpUnregCallback"></a>

## acldumpUnregCallback

```c
void acldumpUnregCallback()
```

### Applicable Products

<!-- npu="950" id435 -->
- Ascend 950PR&950DT products: Supported
<!-- end id435 -->
<!-- npu="A3" id436 -->
- Atlas A3 products: Supported
<!-- end id436 -->
<!-- npu="910b" id437 -->
- Atlas A2 products: Supported
<!-- end id437 -->
<!-- npu="310b" id438 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id438 -->
<!-- npu="310p" id439 -->
- Atlas inference products: Supported
<!-- end id439 -->
<!-- npu="910" id440 -->
- Atlas training products: Supported
<!-- end id440 -->
<!-- @ref: runtime/res/docs/zh/api_ref/18_dump_configuration_res.md#id4 -->

### Description

Unregisters the dump data callback function. **acldumpUnregCallback** must be used together with **acldumpRegCallback**, and it takes effect only after **acldumpRegCallback** is called.

The [aclmdlInitDump](#aclmdlInitDump), [acldumpRegCallback](#acldumpRegCallback) (the callback function registered through this API must be implemented by the user, and its implementation logic includes obtaining the dump data and data length), [acldumpUnregCallback](#acldumpUnregCallback), and [aclmdlFinalizeDump](#aclmdlFinalizeDump) APIs are used together to obtain dump data through the callback function. The following are scenario examples:

- Execute a model and obtain dump data through the callback:

    [aclInit](02_initialization_and_deinitialization.md#aclInit) API --\> [acldumpRegCallback](#acldumpRegCallback) API --\> [aclmdlInitDump](#aclmdlInitDump) API --\> model loading --\> model execution --\> [aclmdlFinalizeDump](#aclmdlFinalizeDump) API --\> [acldumpUnregCallback](#acldumpUnregCallback) API --\> model unloading --\> [aclFinalize](02_initialization_and_deinitialization.md#aclFinalize) API

- Execute two different models and obtain dump data through the callback. In this scenario, as long as the [acldumpUnregCallback](#acldumpUnregCallback) API is not called to unregister the callback function, the dump data of both models can be obtained through the callback function:

    [aclInit](02_initialization_and_deinitialization.md#aclInit) API --\> [acldumpRegCallback](#acldumpRegCallback) API --\> [aclmdlInitDump](#aclmdlInitDump) API --\> model 1 loading --\> model 1 execution --\>--\> model 2 loading --\> model 2 execution --\> [aclmdlFinalizeDump](#aclmdlFinalizeDump) API --\> model unloading --\> [acldumpUnregCallback](#acldumpUnregCallback) API --\> [aclFinalize](02_initialization_and_deinitialization.md#aclFinalize) API

### Parameters

None

### Return Values

None

<br>
<br>
<br>

<a class="method_anchor" id="acldumpGetPath"></a>

## acldumpGetPath

```c
const char* acldumpGetPath(acldumpType dumpType)
```

### Applicable Products

<!-- npu="950" id2850 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2850 -->
<!-- npu="A3" id2851 -->
- Atlas A3 products: Supported
<!-- end id2851 -->
<!-- npu="910b" id2852 -->
- Atlas A2 products: Supported
<!-- end id2852 -->
<!-- npu="310b" id2853 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2853 -->
<!-- npu="310p" id2854 -->
- Atlas inference products: Not supported
<!-- end id2854 -->
<!-- npu="910" id2855 -->
- Atlas training products: Not supported
<!-- end id2855 -->
<!-- @ref: runtime/res/docs/zh/api_ref/18_dump_configuration_res.md#id5 -->

### Description

Obtains the storage path of dump data so that users can save custom maintenance and test data to this path.

Before calling this API, initialize the dump feature through the [aclmdlInitDump](#aclmdlInitDump) API and configure dump information through the [aclmdlSetDump](#aclmdlSetDump) API, or directly configure dump information through the [aclInit](02_initialization_and_deinitialization.md#aclInit) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dumpType | Input | Dump type. For details about the type definition, see [acldumpType](25-02_Enumerations.md#acldumpType). |

### Return Values

Returns the path of the dump data. If a null pointer is returned, no dump path is found.

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlFinalizeDump"></a>

## aclmdlFinalizeDump

```c
aclError aclmdlFinalizeDump()
```

### Applicable Products

<!-- npu="950" id1856 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1856 -->
<!-- npu="A3" id1857 -->
- Atlas A3 products: Supported
<!-- end id1857 -->
<!-- npu="910b" id1858 -->
- Atlas A2 products: Supported
<!-- end id1858 -->
<!-- npu="310b" id1859 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1859 -->
<!-- npu="310p" id1860 -->
- Atlas inference products: Supported
<!-- end id1860 -->
<!-- npu="910" id1861 -->
- Atlas training products: Supported
<!-- end id1861 -->
<!-- @ref: runtime/res/docs/zh/api_ref/18_dump_configuration_res.md#id6 -->

### Description

Deinitializes the dump.

This API must be used together with other APIs to implement the following features:

- **Dump data written to files**

    The [aclmdlInitDump](#aclmdlInitDump), [aclmdlSetDump](#aclmdlSetDump), and [aclmdlFinalizeDump](#aclmdlFinalizeDump) APIs are used together to record dump data to files. Within a process, these APIs can be called multiple times as needed to obtain dump data based on different dump configuration information. Scenario examples are as follows:

    - To execute two different models that require different dump configuration information, the API call sequence is: [aclInit](02_initialization_and_deinitialization.md#aclInit) API --\> [aclmdlInitDump](#aclmdlInitDump) API --\> [aclmdlSetDump](#aclmdlSetDump) API --\> model 1 loading --\> model 1 execution --\> [aclmdlFinalizeDump](#aclmdlFinalizeDump) API --\> model 1 unloading --\> [aclmdlInitDump](#aclmdlInitDump) API --\> [aclmdlSetDump](#aclmdlSetDump) API --\> model 2 loading --\> model 2 execution --\> [aclmdlFinalizeDump](#aclmdlFinalizeDump) API --\> model 2 unloading --\> execution of other tasks --\> [aclFinalize](02_initialization_and_deinitialization.md#aclFinalize) API
    - To execute the same model twice, where dump is required for the first execution but not for the second, the API call sequence is: [aclInit](02_initialization_and_deinitialization.md#aclInit) API --\> [aclmdlInitDump](#aclmdlInitDump) API --\> [aclmdlSetDump](#aclmdlSetDump) API --\> model loading --\> model execution --\> [aclmdlFinalizeDump](#aclmdlFinalizeDump) API --\> model unloading --\> model loading --\> model execution --\> execution of other tasks --\>[aclFinalize](02_initialization_and_deinitialization.md#aclFinalize) API

- **Dump data obtained directly through a callback function without being written to a file**

    The [aclmdlInitDump](#aclmdlInitDump), [acldumpRegCallback](#acldumpRegCallback) (the callback function registered through this API must be implemented by the user, and its implementation logic includes obtaining the Dump data and data length), [acldumpUnregCallback](#acldumpUnregCallback), and [aclmdlFinalizeDump](#aclmdlFinalizeDump) APIs are used together to obtain Dump data through the callback function. Scenario examples are as follows:

    - Execute a model and obtain dump data through the callback:

        [aclInit](02_initialization_and_deinitialization.md#aclInit) API --\> [acldumpRegCallback](#acldumpRegCallback) API --\> [aclmdlInitDump](#aclmdlInitDump) API --\> model loading --\> model execution --\> [aclmdlFinalizeDump](#aclmdlFinalizeDump) API --\> [acldumpUnregCallback](#acldumpUnregCallback) API --\> model unloading --\> [aclFinalize](02_initialization_and_deinitialization.md#aclFinalize) API

    - Execute two different models and obtain dump data through the callback. In this scenario, as long as the [acldumpUnregCallback](#acldumpUnregCallback) API is not called to unregister the callback function, the dump data of both models can be obtained through the callback function:

        [aclInit](02_initialization_and_deinitialization.md#aclInit) API --\> [acldumpRegCallback](#acldumpRegCallback) API --\> [aclmdlInitDump](#aclmdlInitDump) API --\> model 1 loading --\> model 1 execution --\>--\> model 2 loading --\> model 2 execution --\> [aclmdlFinalizeDump](#aclmdlFinalizeDump) API --\> model unloading --\> [acldumpUnregCallback](#acldumpUnregCallback) API --\> [aclFinalize](02_initialization_and_deinitialization.md#aclFinalize) API

### Parameters

None

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Reference Resources

The [aclInit](02_initialization_and_deinitialization.md#aclInit) API is also provided. During the initialization phase, Dump configuration information is passed in through the **\*.json** file, and dump data is obtained after the application runs. With this method, the [aclInit](02_initialization_and_deinitialization.md#aclInit) API can be called only once within a process. To modify the dump configuration information, modify the configuration in the **\*.json** file.

<br>
<br>
<br>

<a class="method_anchor" id="aclopStartDumpArgs"></a>

## aclopStartDumpArgs

```c
aclError aclopStartDumpArgs(uint32_t dumpType, const char *path)
```

### Applicable Products

<!-- npu="950" id3396 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3396 -->
<!-- npu="A3" id3397 -->
- Atlas A3 products: Supported
<!-- end id3397 -->
<!-- npu="910b" id3398 -->
- Atlas A2 products: Supported
<!-- end id3398 -->
<!-- npu="310b" id3399 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3399 -->
<!-- npu="310p" id3400 -->
- Atlas inference products: Not supported
<!-- end id3400 -->
<!-- npu="910" id3401 -->
- Atlas training products: Supported
<!-- end id3401 -->
<!-- @ref: runtime/res/docs/zh/api_ref/18_dump_configuration_res.md#id7 -->

### Description

Enables operator information statistics, which must be used together with the [aclopStopDumpArgs](#aclopStopDumpArgs) API to output the operator information file to the directory specified by the **path** parameter. One shape corresponds to one operator information file, which contains the operator type, operator attributes, and the format/data type/shape of operator inputs and outputs.

**Usage scenario:** For example, to collect the operators involved in the execution of a model, call the **aclopStartDumpArgs** API before model execution and the **aclopStopDumpArgs** API after model execution. After the API calls succeed, an operator information file for each operator shape is generated in the directory specified by the **path** parameter.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dumpType | Input | Type of dump information.<br>Currently, only **ACL_OP_DUMP_OP_AICORE_ARGS** is supported, which indicates collecting all operator information.<br>#define ACL_OP_DUMP_OP_AICORE_ARGS 0x00000001U |
| path | Input | Directory for saving dump files. Both absolute paths and relative paths (relative to the directory where the application executable resides) are supported, but the user must ensure that the path exists or can be created. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="950,A3,910b,910" id10 -->
### Constraints

This API can be used only in single-operator API execution scenarios (for example, APIs whose names are prefixed with **aclnn**); otherwise, no dump file can be generated.
<!-- end id10 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclopStopDumpArgs"></a>

## aclopStopDumpArgs

```c
aclError aclopStopDumpArgs(uint32_t dumpType)
```

### Applicable Products

<!-- npu="950" id1590 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1590 -->
<!-- npu="A3" id1591 -->
- Atlas A3 products: Supported
<!-- end id1591 -->
<!-- npu="910b" id1592 -->
- Atlas A2 products: Supported
<!-- end id1592 -->
<!-- npu="310b" id1593 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1593 -->
<!-- npu="310p" id1594 -->
- Atlas inference products: Not supported
<!-- end id1594 -->
<!-- npu="910" id1595 -->
- Atlas training products: Supported
<!-- end id1595 -->
<!-- @ref: runtime/res/docs/zh/api_ref/18_dump_configuration_res.md#id8 -->

### Description

Disables operator information statistics, which must be used together with the [aclopStartDumpArgs](#aclopStartDumpArgs) API to output the operator information file to the directory specified by the **path** parameter. One shape corresponds to one operator information file, which contains the operator type, operator attributes, and the format/data type/shape of operator inputs and outputs.

**Usage scenario:** For example, to collect statistics on which operators are involved in the execution of a model, call the **aclopStartDumpArgs** API before model execution and the **aclopStopDumpArgs** API after model execution. After the API calls succeed, an operator information file for each operator shape is generated in the directory specified by the **path** parameter.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dumpType | Input | Type of dump information.<br>Currently, only **ACL_OP_DUMP_OP_AICORE_ARGS** is supported, which indicates collecting all operator information.<br>#define ACL_OP_DUMP_OP_AICORE_ARGS 0x00000001U |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="950,A3,910b,910" id11 -->
### Constraints

This API can be used only in the single-operator API execution scenario (for example, APIs whose names are prefixed with **aclnn**); otherwise, the dump file cannot be generated.
<!-- end id11 -->

<br>
<br>
<br>

<a class="method_anchor" id="acldumpGetExceptionInfoPath"></a>

## acldumpGetExceptionInfoPath

```c
aclError acldumpGetExceptionInfoPath(char *path, size_t maxLen)
```

### Applicable Products

<!-- npu="950" id9001 -->
- Ascend 950PR&950DT products: supported
<!-- end id9001 -->
<!-- npu="A3" id9002 -->
- Atlas A3 products: supported
<!-- end id9002 -->
<!-- npu="910b" id9003 -->
- Atlas A2 products: supported
<!-- end id9003 -->
<!-- npu="310b" id9004 -->
- Atlas 200I/500 A2 inference products: supported
<!-- end id9004 -->
<!-- npu="310p" id9005 -->
- Atlas inference products: supported
<!-- end id9005 -->
<!-- npu="910" id9006 -->
- Atlas training products: supported
<!-- end id9006 -->
<!-- @ref: runtime/res/docs/zh/api_ref/18_dump_configuration_res.md#id9 -->

### Description

Obtains the storage path of exception operator dump data so that users can save custom maintenance and test data to this path. The exported data is used to analyze AI Core errors. The output path format is `<dumpPath>/extra-info/data-dump/<deviceId>/`, where:

 - **dumpPath**: storage path configured when exception operator dump is enabled.
 - **deviceId**: ID of the device currently in use.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| path | Output | Character array used to receive the path. The memory space of this array is requested by the caller in advance and must be large enough to hold the path (4096 bytes recommended). |
| maxLen | Input | Memory size of the **path** parameter. |

### Return Values

Returns **0 (ACL_SUCCESS)** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- This API must be called after the exception operator dump feature is enabled. For detailed configuration, see [aclInit (Exception Operator Dump Configuration)](02_initialization_and_deinitialization.md#aclInit), [aclmdlSetDump (Exception Operator Dump Configuration)](#exception_dump_config), or the environment variable [ASCEND\_DUMP\_SCENE](https://gitcode.com/cann/docs/blob/9.2.0/docs/en/env-vars/ASCEND_DUMP_SCENE.md).

<br>
<br>
<br>

<a class="method_anchor" id="acldumpSaveExceptionInfo"></a>

## acldumpSaveExceptionInfo

```c
aclError acldumpSaveExceptionInfo(const char *fileName, const char *userTag, const acldumpTensorInfo *tensors, size_t tensorCount)
```

### Applicable Products

<!-- npu="950" id9008 -->
- Ascend 950PR&950DT products: Supported
<!-- end id9008 -->
<!-- npu="A3" id9009 -->
- Atlas A3 products: Supported
<!-- end id9009 -->
<!-- npu="910b" id9010 -->
- Atlas A2 products: Supported
<!-- end id9010 -->
<!-- npu="310b" id9011 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id9011 -->
<!-- npu="310p" id9012 -->
- Atlas inference products: Supported
<!-- end id9012 -->
<!-- npu="910" id9013 -->
- Atlas training products: Supported
<!-- end id9013 -->
<!-- @ref: runtime/res/docs/zh/api_ref/18_dump_configuration_res.md#id10 -->

### Description

Saves custom exception operator tensor data to the storage path of the exception operator dump data. The exported data is used to analyze AI Core errors.

The actual storage path format of the data file is `<dumpPath>/extra-info/data-dump/<deviceId>/<fileName>.custom.{timestamp}`, where:

 - **dumpPath**: storage path configured when exception operator dump is enabled.
 - **deviceId**: ID of the device currently in use.
 - **fileName**: file name.
 - **timestamp**: timestamp in milliseconds.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| fileName | Input | Target file name. It supports a relative path to the exception operator dump data storage path, and must not contain the ".." path segment. |
| userTag | Input | Custom maintenance and test data to be saved. This is an optional parameter. |
| tensors | Input | Array of tensors to be saved. The valid length of the array must not be less than **tensorCount**. For the tensor type definition, see [acldumpTensorInfo](25-04_Structs.md#acldumpTensorInfo). **acldumpTensorInfo.addrType** supports only **ACL_DUMP_ADDR_RAW**, and **acldumpTensorInfo.placement** supports only **ACL_DUMP_PLACEMENT_DEVICE**. |
| tensorCount | Input | Number of elements in the **tensors** array. The caller must ensure that it is consistent with the actual length of the array. |

### Return Values

Returns **0 (ACL_SUCCESS)** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- This API must be called after the exception operator dump feature is enabled. For detailed configuration, see [aclInit (Exception Operator Dump Configuration)](02_initialization_and_deinitialization.md#aclInit) or [aclmdlSetDump (Exception Operator Dump Configuration)](#exception_dump_config) or the environment variable [ASCEND\_DUMP\_SCENE](https://gitcode.com/cann/docs/blob/9.2.0/docs/en/env-vars/ASCEND_DUMP_SCENE.md).
