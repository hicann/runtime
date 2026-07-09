# 18. Dump配置

本章节描述 CANN Runtime 的 Dump 配置接口，用于算子数据 Dump 的初始化、配置及回调注册。

- [`aclError aclmdlInitDump()`](#aclmdlInitDump)：Dump初始化。
- [`aclError aclmdlSetDump(const char *dumpCfgPath)`](#aclmdlSetDump)：设置Dump参数。
- [`aclError acldumpRegCallback(int32_t (* const messageCallback)(const acldumpChunk *, int32_t len), int32_t flag)`](#acldumpRegCallback)：Dump数据回调函数注册接口。
- [`void acldumpUnregCallback()`](#acldumpUnregCallback)：Dump数据回调函数取消注册接口。
- [`const char* acldumpGetPath(acldumpType dumpType)`](#acldumpGetPath)：获取Dump数据存放路径，以便用户将自定维测数据保存到该路径下。
- [`aclError aclmdlFinalizeDump()`](#aclmdlFinalizeDump)：Dump去初始化。
- [`aclError aclopStartDumpArgs(uint32_t dumpType, const char *path)`](#aclopStartDumpArgs)：调用本接口开启算子信息统计功能，并需与[aclopStopDumpArgs](#aclopStopDumpArgs)接口配合使用，将算子信息文件输出到path参数指定的目录，一个shape对应一个算子信息文件，文件中包含算子类型、算子属性、算子输入&输出的format/数据类型/shape等信息。
- [`aclError aclopStopDumpArgs(uint32_t dumpType)`](#aclopStopDumpArgs)：调用本接口关闭算子信息统计功能，并需与[aclopStartDumpArgs](#aclopStartDumpArgs)接口配合使用，将算子信息文件输出到path参数指定的目录，一个shape对应一个算子信息文件，文件中包含算子类型、算子属性、算子输入&输出的format/数据类型/shape等信息。

<a id="aclmdlInitDump"></a>

## aclmdlInitDump

```c
aclError aclmdlInitDump()
```

### 产品支持情况

<!-- npu="950" id2108 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2108 -->
<!-- npu="A3" id2109 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2109 -->
<!-- npu="910b" id2110 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2110 -->
<!-- npu="310b" id2111 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2111 -->
<!-- npu="310p" id2112 -->
- Atlas 推理系列产品：支持
<!-- end id2112 -->
<!-- npu="910" id2113 -->
- Atlas 训练系列产品：支持
<!-- end id2113 -->
<!-- npu="IPV350" id2114 -->
- IPV350：不支持
<!-- end id2114 -->
<!-- @ref: runtime/res/docs/zh/api_ref/18_dump_configuration_res.md#id1 -->

### 功能说明

Dump初始化。

本接口需与其它接口配合使用实现以下功能：

- **Dump数据落盘到文件**

    [aclmdlInitDump](#aclmdlInitDump)接口、[aclmdlSetDump](#aclmdlSetDump)接口、[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口配合使用，用于将Dump数据记录到文件中。一个进程内，可以根据需求多次调用这些接口，基于不同的Dump配置信息，获取Dump数据。场景举例如下：

    - 执行两个不同的模型，需要设置不同的Dump配置信息，接口调用顺序：[aclInit](02_initialization_and_deinitialization.md#aclInit)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[aclmdlSetDump](#aclmdlSetDump)接口--\>模型1加载--\>模型1执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型1卸载--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[aclmdlSetDump](#aclmdlSetDump)接口--\>模型2加载--\>模型2执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型2卸载--\>执行其它任务--\>[aclFinalize](02_initialization_and_deinitialization.md#aclFinalize)接口
    - 同一个模型执行两次，第一次需要Dump，第二次无需Dump，接口调用顺序：[aclInit](02_initialization_and_deinitialization.md#aclInit)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[aclmdlSetDump](#aclmdlSetDump)接口--\>模型加载--\>模型执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型卸载--\>模型加载--\>模型执行--\>执行其它任务--\>[aclFinalize](02_initialization_and_deinitialization.md#aclFinalize)接口

- **Dump数据不落盘到文件，直接通过回调函数获取**

    [aclmdlInitDump](#aclmdlInitDump)接口、[acldumpRegCallback](#acldumpRegCallback)接口（通过该接口注册的回调函数需由用户自行实现，回调函数实现逻辑中包括获取Dump数据及数据长度）、[acldumpUnregCallback](#acldumpUnregCallback)接口、[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口配合使用，用于通过回调函数获取Dump数据。场景举例如下：

    - 执行一个模型，通过回调获取Dump数据：

        [aclInit](02_initialization_and_deinitialization.md#aclInit)接口--\>[acldumpRegCallback](#acldumpRegCallback)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>模型加载--\>模型执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>[acldumpUnregCallback](#acldumpUnregCallback)接口--\>模型卸载--\>[aclFinalize](02_initialization_and_deinitialization.md#aclFinalize)接口

    - 执行两个不同的模型，通过回调获取Dump数据，该场景下，只要不调用[acldumpUnregCallback](#acldumpUnregCallback)接口取消注册回调函数，则可通过回调函数获取两个模型的Dump数据：

        [aclInit](02_initialization_and_deinitialization.md#aclInit)接口--\>[acldumpRegCallback](#acldumpRegCallback)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>模型1加载--\>模型1执行--\>--\>模型2加载--\>模型2执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型卸载--\>[acldumpUnregCallback](#acldumpUnregCallback)接口--\>[aclFinalize](02_initialization_and_deinitialization.md#aclFinalize)接口

### 参数说明

无

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 对于模型Dump配置、单算子Dump配置、溢出算子Dump配置，如果已经通过[aclInit](02_initialization_and_deinitialization.md#aclInit)接口配置了dump信息，则调用aclmdlInitDump接口时会返回失败。
- 必须在调用[aclInit](02_initialization_and_deinitialization.md#aclInit)接口之后、模型加载接口之前调用aclmdlInitDump接口。

### 参考资源

当前还提供了[aclInit](02_initialization_and_deinitialization.md#aclInit)接口，在初始化阶段，通过\*.json文件传入Dump配置信息，运行应用后获取Dump数据的方式。该种方式，一个进程内，只能调用一次[aclInit](02_initialization_and_deinitialization.md#aclInit)接口，如果要修改Dump配置信息，需修改\*.json文件中的配置。

<br>
<br>
<br>

<a id="aclmdlSetDump"></a>

## aclmdlSetDump

```c
aclError aclmdlSetDump(const char *dumpCfgPath)
```

### 产品支持情况

<!-- npu="950" id554 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id554 -->
<!-- npu="A3" id555 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id555 -->
<!-- npu="910b" id556 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id556 -->
<!-- npu="310b" id557 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id557 -->
<!-- npu="310p" id558 -->
- Atlas 推理系列产品：支持
<!-- end id558 -->
<!-- npu="910" id559 -->
- Atlas 训练系列产品：支持
<!-- end id559 -->
<!-- npu="IPV350" id560 -->
- IPV350：不支持
<!-- end id560 -->
<!-- @ref: runtime/res/docs/zh/api_ref/18_dump_configuration_res.md#id2 -->

### 功能说明

设置Dump参数。

[aclmdlInitDump](#aclmdlInitDump)接口、[aclmdlSetDump](#aclmdlSetDump)接口、[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口配合使用，用于将Dump数据记录到文件中。一个进程内，可以根据需求多次调用这些接口，基于不同的Dump配置信息，获取Dump数据。场景举例如下：

- 执行两个不同的模型，需要设置不同的Dump配置信息，接口调用顺序：[aclInit](02_initialization_and_deinitialization.md#aclInit)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[aclmdlSetDump](#aclmdlSetDump)接口--\>模型1加载--\>模型1执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型1卸载--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[aclmdlSetDump](#aclmdlSetDump)接口--\>模型2加载--\>模型2执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型2卸载--\>执行其它任务--\>[aclFinalize](02_initialization_and_deinitialization.md#aclFinalize)接口
- 同一个模型执行两次，第一次需要Dump，第二次无需Dump，接口调用顺序：[aclInit](02_initialization_and_deinitialization.md#aclInit)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[aclmdlSetDump](#aclmdlSetDump)接口--\>模型加载--\>模型执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型卸载--\>模型加载--\>模型执行--\>执行其它任务--\>[aclFinalize](02_initialization_and_deinitialization.md#aclFinalize)接口

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dumpCfgPath | 输入 | 配置文件路径的指针，包含文件名。配置文件格式为json格式。<br>可通过该配置文件配置开启或配置各类Dump信息，详细描述请参见下文各功能配置示例中的描述。如果算子输入或输出中包含用户的敏感信息，则存在信息泄露风险。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 只有在调用本接口开启Dump之后加载模型，配置的Dump信息有效。在调用本接口之前已经加载的模型不受影响，除非用户在调用本接口后重新加载该模型。

    例如以下接口调用顺序中，加载的模型1不受影响，配置的Dump信息仅对加载的模型2有效：

    [aclmdlInitDump](#aclmdlInitDump)接口--\>模型1加载--\>aclmdlSetDump接口--\>模型2加载--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口

- 多次调用本接口对同一个模型配置了Dump信息，系统内处理时会采用覆盖策略。

    例如以下接口调用顺序中，第二次调用本接口配置的Dump信息会覆盖第一次配置的Dump信息：

    [aclmdlInitDump](#aclmdlInitDump)接口--\>aclmdlSetDump接口--\>aclmdlSetDump接口--\>模型1加载--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口

### 模型Dump配置、单算子Dump配置

**模型Dump配置**（用于导出模型中每一层算子输入和输出数据）、**单算子Dump配置**（用于导出单个算子的输入和输出数据），导出的数据用于与指定模型或算子进行比对，定位精度问题，具体比对方法请参见[《精度调试工具用户指南》](https://hiascend.com/document/redirect/CannCommunityToolAccucacy)。**默认不启用该Dump配置。**

通过本接口启用Dump配置，需通过dump\_path参数配置保存Dump数据的路径。

模型Dump配置示例如下：

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

单算子调用场景下，Dump配置示例如下：

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

### 配置文件示例（异常算子Dump配置）

**异常算子Dump配置**（用于导出异常算子的输入输出数据、workspace信息、Tiling信息），导出的数据用于分析AI Core Error问题。默认不启用该Dump配置

通过配置dump\_scene参数值开启异常算子Dump功能，配置文件中的示例内容如下，表示开启轻量化的exception dump：

```json
{
    "dump":{
        "dump_path":"output",
        "dump_scene":"aic_err_brief_dump"
    }
}
```

详细配置说明及约束如下：

- dump\_scene参数支持如下取值：
    - aic\_err\_brief\_dump：表示轻量化exception dump，用于导出AI Core错误算子的输入&输出、workspace数据。
    - aic\_err\_norm\_dump：表示普通exception dump，在轻量化exception dump基础上，还会导出Shape、Data Type、Format以及属性信息。
    <!-- npu="A3,910b" id1 -->
    - aic\_err\_detail\_dump：在轻量化exception dump基础上，还会导出AI Core的内部存储、寄存器以及调用栈信息。

        配置该选项时，有以下注意事项：

        - 该选项仅支持以下型号，且需配套25.0.RC1或更高版本的驱动才可以使用：

            Atlas A2 训练系列产品/Atlas A2 推理系列产品

            Atlas A3 训练系列产品/Atlas A3 推理系列产品

            您可以单击[Link](https://www.hiascend.com/hardware/firmware-drivers/commercial)，在“固件与驱动”页面下载Ascend HDK  25.0.RC1或更高版本的驱动安装包，并参考相应版本的文档进行安装、升级。
    <!-- end id1 -->

        -   若设置aic\_err\_detail\_dump选项，则需在[aclrtSetDevice](04_device_management.md#aclrtSetDevice)接口之前调用本接口，且通过[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口无法实现Dump去初始化。
        -   导出dump文件过程中，会暂停问题算子所在的AI Core，因此可能会影响Device上其它业务进程的正常执行，导出dump文件后，会自行恢复AI Core。
        -   导出dump文件后，会强制退出Host侧用户业务进程，强制退出过程中的报错可不作为AI Core问题分析的输入。
        -   如果多个Host侧用户业务进程指定同一个Device、且都配置了aic\_err\_detail\_dump选项，则先执行的进程按aic\_err\_detail\_dump选项导出dump文件，后执行的进程按照aic\_err\_brief\_dump选项导出dump文件。

    - lite\_exception：表示轻量化exception dump，为了兼容旧版本，效果等同于aic\_err\_brief\_dump。

- dump\_path是可选参数，表示导出dump文件的存储路径。

    dump文件存储路径的优先级如下：NPU\_COLLECT\_PATH环境变量 \> ASCEND\_WORK\_PATH环境变量 \> 配置文件中的dump\_path \> 应用程序的当前执行目录

    环境变量的详细描述请参见[《环境变量参考》](https://hiascend.com/document/redirect/CannCommunityEnvRef)。

<!-- npu="950,A3,910b,910,310p,310b" id2 -->
- 若需查看导出的dump文件内容，请参见[《故障处理》](https://hiascend.com/document/redirect/CannCommunitytrouble)中的“故障定位工具 \> msaicerr工具使用指导 \> 解析Dump文件”章节。

    <!-- npu="A3,910b" id3 -->
    若将dump\_scene参数设置为aic\_err\_detail\_dump时，需使用msDebug工具查看导出的dump文件内容，详细方法请参见[《算子开发工具用户指南》](https://hiascend.com/document/redirect/CannCommunityopdev)。
    <!-- end id3 -->
<!-- end id2 -->

- 异常算子Dump配置，不能与模型Dump配置或单算子Dump配置同时开启。

### 溢出算子Dump配置

**溢出算子Dump配置**，用于导出模型中溢出算子的输入和输出数据。导出的数据用于分析溢出原因，定位模型精度的问题。**默认不启用该Dump配置。**

将dump\_debug参数设置为on表示开启溢出算子配置，配置文件中的示例内容如下：

```json
{
    "dump":{
        "dump_path":"output",
        "dump_debug":"on"
    }
}
```

详细配置说明及约束如下：

- 不配置dump\_debug或将dump\_debug配置为off表示不开启溢出算子配置。
- 若开启溢出算子配置，则dump\_path必须配置，表示导出dump文件的存储路径。

    获取导出的数据文件后，文件的解析请参见[《精度调试工具用户指南》](https://hiascend.com/document/redirect/CannCommunityToolAccucacy)。

    dump\_path支持配置绝对路径或相对路径：

    - 绝对路径配置以“/“开头，例如：/home。
    - 相对路径配置直接以目录名开始，例如：output。

- 溢出算子Dump配置，不能与模型Dump配置或单算子Dump配置同时开启，否则会返回报错。
- 仅支持采集AI Core算子的溢出数据。

### 算子Dump Watch模式配置

**算子Dump Watch模式配置**，用于开启指定算子输出数据的观察模式。在定位部分算子精度问题且已排除算子本身的计算问题后，若怀疑被其它算子踩踏内存导致精度问题，可开启Dump Watch模式。**默认不开启Dump Watch模式。**

将dump\_scene参数设置为watcher，开启算子Dump Watch模式，配置文件中的示例内容如下，配置效果为：（1）当执行完A算子、B算子时，会把C算子和D算子的输出Dump出来；（2）当执行完C算子、D算子时，也会把C算子和D算子的输出Dump出来。将（1）、（2）中的C算子、D算子的Dump文件进行比较，用于排查A算子、B算子是否会踩踏C算子、D算子的输出内存。

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

详细配置说明及约束如下：

- 若开启算子Dump Watch模式，则不支持同时开启溢出算子Dump（配置dump\_debug参数）或开启单算子模型Dump（配置dump\_op\_switch参数），否则报错。该模式在单算子API Dump场景下不生效。
- 在dump\_list中，通过layer参数配置可能踩踏其它算子内存的算子名称，通过watcher\_nodes参数配置可能被其它算子踩踏输出内存导致精度有问题的算子名称。
    - 若不指定layer，则模型内所有支持Dump的算子在执行后，都会将watcher\_nodes中配置的算子的输出Dump出来。
    - layer和watcher\_nodes处配置的算子都必须是静态图、静态子图中的算子，否则不生效。
    - 若layer和watcher\_nodes处配置的算子名称相同，或者layer处配置的是集合通信类算子（算子类型以Hcom开头，例如HcomAllReduce），则只导出watcher\_nodes中所配置算子的dump文件。
    - 对于融合算子，watcher\_nodes处配置的算子名称必须是融合后的算子名称，若配置融合前的算子名称，则不导出dump文件。
    - dump\_list内暂不支持配置model\_name。

- 开启算子Dump Watch模式，则dump\_path必须配置，表示导出dump文件的存储路径。

    此处收集的dump文件无法通过文本工具直接查看其内容，若需查看dump文件内容，先将dump文件转换为numpy格式文件后，再通过Python查看numpy格式文件，详细转换步骤请参见[《精度调试工具用户指南》](https://hiascend.com/document/redirect/CannCommunityToolAccucacy)。

    dump\_path支持配置绝对路径或相对路径：

    - 绝对路径配置以“/“开头，例如：/home。
    - 相对路径配置直接以目录名开始，例如：output。

- 通过dump\_mode参数控制导出watcher\_nodes中所配置算子的哪部分数据，当前仅支持配置为output。

<!-- npu="950,A3,910b,310p,310b" id4 -->
### 算子Kernel调测信息Dump配置

**算子Kernel调测信息Dump配置**，用于导出Ascend C算子Kernel的调测信息，便于定位算子问题。**默认不启用该Dump配置。**

仅如下型号支持该配置：
<!-- npu="950" id5 -->
- Ascend 950PR/Ascend 950DT
<!-- end id5 -->
<!-- npu="A3" id6 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品
<!-- end id6 -->
<!-- npu="910b" id7 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品
<!-- end id7 -->
<!-- npu="310b" id8 -->
- Atlas 200I/500 A2 推理产品
<!-- end id8 -->
<!-- npu="310p" id9 -->
- Atlas 推理系列产品
<!-- end id9 -->

配置dump\_kernel\_data参数开启算子Kernel调测信息Dump功能，配置文件中的示例如下：

```json
{
    "dump":{
        "dump_kernel_data":"printf,assert",
        "dump_path":"/home/"
    }
}
```

详细配置说明及约束如下：

- dump\_kernel\_data：指定导出数据的类型，支持配置多个类型，用英文逗号隔开。如果未配置该字段，但启用了模型Dump配置、单算子Dump配置，则默认按all导出调测信息。

    当前支持如下类型：

    - all：导出以下所有类型调测的输出数据。
    - printf：导出通过AscendC::printf调测的输出数据。
    - tensor：导出通过AscendC::DumpTensor调测的输出数据。
    - assert：导出通过assert/ascendc\_assert调测的输出数据。
    - timestamp：导出通过AscendC::PrintTimeStamp调测的输出数据。

- dump\_path：启用算子Kernel调测信息Dump功能时，dump\_path必须配置，表示导出Dump文件的存储路径，支持配置绝对路径或相对路径。

    Dump文件存储路径的优先级如下：ASCEND\_DUMP\_PATH环境变量 \> ASCEND\_WORK\_PATH环境变量 \> 配置文件中的dump\_path，环境变量的详细描述请参见[《环境变量参考》](https://hiascend.com/document/redirect/CannCommunityEnvRef)。

    导出的Dump文件无法通过文本工具直接查看其内容，若需查看，需使用show\_kernel\_debug\_data工具将调测信息解析为可读格式，工具使用指导请参见[《Ascend C算子开发指南》](https://hiascend.com/document/redirect/CannCommunityOpdevAscendC)。
<!-- end id4 -->

### 参考资源

当前还提供了[aclInit](02_initialization_and_deinitialization.md#aclInit)接口，在初始化阶段，通过\*.json文件传入Dump配置信息，运行应用后获取Dump数据的方式。该种方式，一个进程内，只能调用一次[aclInit](02_initialization_and_deinitialization.md#aclInit)接口，如果要修改Dump配置信息，需修改\*.json文件中的配置。

<br>
<br>
<br>

<a id="acldumpRegCallback"></a>

## acldumpRegCallback

```c
aclError acldumpRegCallback(int32_t (* const messageCallback)(const acldumpChunk *, int32_t len), int32_t flag)
```

### 产品支持情况

<!-- npu="950" id1541 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1541 -->
<!-- npu="A3" id1542 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1542 -->
<!-- npu="910b" id1543 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1543 -->
<!-- npu="310b" id1544 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1544 -->
<!-- npu="310p" id1545 -->
- Atlas 推理系列产品：支持
<!-- end id1545 -->
<!-- npu="910" id1546 -->
- Atlas 训练系列产品：支持
<!-- end id1546 -->
<!-- npu="IPV350" id1547 -->
- IPV350：不支持
<!-- end id1547 -->
<!-- @ref: runtime/res/docs/zh/api_ref/18_dump_configuration_res.md#id3 -->

### 功能说明

Dump数据回调函数注册接口。

[aclmdlInitDump](#aclmdlInitDump)接口、[acldumpRegCallback](#acldumpRegCallback)接口（通过该接口注册的回调函数需由用户自行实现，回调函数实现逻辑中包括获取Dump数据及数据长度）、[acldumpUnregCallback](#acldumpUnregCallback)接口、[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口配合使用，用于通过回调函数获取Dump数据。**场景举例如下：**

- **执行一个模型，通过回调获取Dump数据：**

    支持以下两种方式：

    - 在aclInit接口处**不启用**模型Dump配置、单算子Dump配置

        [aclInit](02_initialization_and_deinitialization.md#aclInit)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[acldumpRegCallback](#acldumpRegCallback)接口--\>模型加载--\>模型执行--\>[acldumpUnregCallback](#acldumpUnregCallback)接口--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型卸载--\>[aclFinalize](02_initialization_and_deinitialization.md#aclFinalize)接口

    - 在aclInit接口处**启用**模型Dump配置、单算子Dump配置，在aclInit接口处启用Dump配置时需配置落盘路径，但如果调用了[acldumpRegCallback](#acldumpRegCallback)接口，则落盘不生效，以回调函数获取的Dump数据为准

        [aclInit](02_initialization_and_deinitialization.md#aclInit)接口--\>[acldumpRegCallback](#acldumpRegCallback)接口--\>模型加载--\>模型执行--\>[acldumpUnregCallback](#acldumpUnregCallback)接口--\>模型卸载--\>[aclFinalize](02_initialization_and_deinitialization.md#aclFinalize)接口

- **执行两个不同的模型，通过回调获取Dump数据**，该场景下，只要不调用[acldumpUnregCallback](#acldumpUnregCallback)接口取消注册回调函数，则可通过回调函数获取两个模型的Dump数据：

    [aclInit](02_initialization_and_deinitialization.md#aclInit)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[acldumpRegCallback](#acldumpRegCallback)接口--\>模型1加载--\>模型1执行--\>--\>模型2加载--\>模型2执行--\>[acldumpUnregCallback](#acldumpUnregCallback)接口--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型卸载--\>[aclFinalize](02_initialization_and_deinitialization.md#aclFinalize)接口

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| messageCallback | 输入 | 回调函数指针，用于接收回调数据的回调。 |
| flag | 输入 | 在调用回调接口后是否还落盘dump数据，当前仅支持0，表示不落盘。 |

<br>
在messageCallback回调函数中：

- acldumpChunk结构体的定义如下，在实现messageCallback回调函数时可以获取acldumpChunk结构体中的dataBuf、bufLen等参数值，用于获取Dump数据及其数据长度：

  ```c
  typedef struct acldumpChunk  {
    char       fileName[ACL_DUMP_MAX_FILE_PATH_LENGTH];   // 待落盘的Dump数据文件名，ACL_DUMP_MAX_FILE_PATH_LENGTH表示文件名最大长度，当前为4096
    uint32_t   bufLen;       // dataBuf数据长度，单位Byte
    uint32_t   isLastChunk;  // 标识Dump数据是否为最后一个分片，0表示不是最后一个分片，1表示最后一个分片
    int64_t    offset;       // Dump数据文件内容的偏移，其中-1表示文件追加内容
    int32_t    flag;         // 预留Dump数据标识，当前数据无标识
    uint8_t    dataBuf[0];   // Dump数据的内存地址
  } acldumpChunk;
  ```

- len：表示acldumpChunk结构体的长度，单位Byte。

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acldumpUnregCallback"></a>

## acldumpUnregCallback

```c
void acldumpUnregCallback()
```

### 产品支持情况

<!-- npu="950" id435 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id435 -->
<!-- npu="A3" id436 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id436 -->
<!-- npu="910b" id437 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id437 -->
<!-- npu="310b" id438 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id438 -->
<!-- npu="310p" id439 -->
- Atlas 推理系列产品：支持
<!-- end id439 -->
<!-- npu="910" id440 -->
- Atlas 训练系列产品：支持
<!-- end id440 -->
<!-- npu="IPV350" id441 -->
- IPV350：不支持
<!-- end id441 -->
<!-- @ref: runtime/res/docs/zh/api_ref/18_dump_configuration_res.md#id4 -->

### 功能说明

Dump数据回调函数取消注册接口。acldumpUnregCallback需要和acldumpRegCallback配合使用，且必须在acldumpRegCallback调用后才有效。

[aclmdlInitDump](#aclmdlInitDump)接口、[acldumpRegCallback](#acldumpRegCallback)接口（通过该接口注册的回调函数需由用户自行实现，回调函数实现逻辑中包括获取Dump数据及数据长度）、[acldumpUnregCallback](#acldumpUnregCallback)接口、[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口配合使用，用于通过回调函数获取Dump数据。场景举例如下：

- 执行一个模型，通过回调获取Dump数据：

    [aclInit](02_initialization_and_deinitialization.md#aclInit)接口--\>[acldumpRegCallback](#acldumpRegCallback)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>模型加载--\>模型执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>[acldumpUnregCallback](#acldumpUnregCallback)接口--\>模型卸载--\>[aclFinalize](02_initialization_and_deinitialization.md#aclFinalize)接口

- 执行两个不同的模型，通过回调获取Dump数据，该场景下，只要不调用[acldumpUnregCallback](#acldumpUnregCallback)接口取消注册回调函数，则可通过回调函数获取两个模型的Dump数据：

    [aclInit](02_initialization_and_deinitialization.md#aclInit)接口--\>[acldumpRegCallback](#acldumpRegCallback)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>模型1加载--\>模型1执行--\>--\>模型2加载--\>模型2执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型卸载--\>[acldumpUnregCallback](#acldumpUnregCallback)接口--\>[aclFinalize](02_initialization_and_deinitialization.md#aclFinalize)接口

### 参数说明

无

### 返回值说明

无

<br>
<br>
<br>

<a id="acldumpGetPath"></a>

## acldumpGetPath

```c
const char* acldumpGetPath(acldumpType dumpType)
```

### 产品支持情况

<!-- npu="950" id2850 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2850 -->
<!-- npu="A3" id2851 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2851 -->
<!-- npu="910b" id2852 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2852 -->
<!-- npu="310b" id2853 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2853 -->
<!-- npu="310p" id2854 -->
- Atlas 推理系列产品：不支持
<!-- end id2854 -->
<!-- npu="910" id2855 -->
- Atlas 训练系列产品：不支持
<!-- end id2855 -->
<!-- npu="IPV350" id2856 -->
- IPV350：不支持
<!-- end id2856 -->
<!-- @ref: runtime/res/docs/zh/api_ref/18_dump_configuration_res.md#id5 -->

### 功能说明

获取Dump数据存放路径，以便用户将自定维测数据保存到该路径下。

在调用本接口前，需通过[aclmdlInitDump](#aclmdlInitDump)接口初始化Dump功能、通过[aclmdlSetDump](#aclmdlSetDump)接口配置Dump信息，或者直接通过[aclInit](02_initialization_and_deinitialization.md#aclInit)接口配置Dump信息。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dumpType | 输入 | Dump类型。类型定义请参见[acldumpType](25-02_Enumerations.md#acldumpType)。 |

### 返回值说明

返回Dump数据的路径。如果返回空指针，则表示未查询到Dump路径。

<br>
<br>
<br>

<a id="aclmdlFinalizeDump"></a>

## aclmdlFinalizeDump

```c
aclError aclmdlFinalizeDump()
```

### 产品支持情况

<!-- npu="950" id1856 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1856 -->
<!-- npu="A3" id1857 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1857 -->
<!-- npu="910b" id1858 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1858 -->
<!-- npu="310b" id1859 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1859 -->
<!-- npu="310p" id1860 -->
- Atlas 推理系列产品：支持
<!-- end id1860 -->
<!-- npu="910" id1861 -->
- Atlas 训练系列产品：支持
<!-- end id1861 -->
<!-- npu="IPV350" id1862 -->
- IPV350：不支持
<!-- end id1862 -->
<!-- @ref: runtime/res/docs/zh/api_ref/18_dump_configuration_res.md#id6 -->

### 功能说明

Dump去初始化。

本接口需与其它接口配合使用实现以下功能：

- **Dump数据落盘到文件**

    [aclmdlInitDump](#aclmdlInitDump)接口、[aclmdlSetDump](#aclmdlSetDump)接口、[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口配合使用，用于将Dump数据记录到文件中。一个进程内，可以根据需求多次调用这些接口，基于不同的Dump配置信息，获取Dump数据。场景举例如下：

    - 执行两个不同的模型，需要设置不同的Dump配置信息，接口调用顺序：[aclInit](02_initialization_and_deinitialization.md#aclInit)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[aclmdlSetDump](#aclmdlSetDump)接口--\>模型1加载--\>模型1执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型1卸载--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[aclmdlSetDump](#aclmdlSetDump)接口--\>模型2加载--\>模型2执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型2卸载--\>执行其它任务--\>[aclFinalize](02_initialization_and_deinitialization.md#aclFinalize)接口
    - 同一个模型执行两次，第一次需要Dump，第二次无需Dump，接口调用顺序：[aclInit](02_initialization_and_deinitialization.md#aclInit)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[aclmdlSetDump](#aclmdlSetDump)接口--\>模型加载--\>模型执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型卸载--\>模型加载--\>模型执行--\>执行其它任务--\>[aclFinalize](02_initialization_and_deinitialization.md#aclFinalize)接口

- **Dump数据不落盘到文件，直接通过回调函数获取**

    [aclmdlInitDump](#aclmdlInitDump)接口、[acldumpRegCallback](#acldumpRegCallback)接口（通过该接口注册的回调函数需由用户自行实现，回调函数实现逻辑中包括获取Dump数据及数据长度）、[acldumpUnregCallback](#acldumpUnregCallback)接口、[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口配合使用，用于通过回调函数获取Dump数据。场景举例如下：

    - 执行一个模型，通过回调获取Dump数据：

        [aclInit](02_initialization_and_deinitialization.md#aclInit)接口--\>[acldumpRegCallback](#acldumpRegCallback)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>模型加载--\>模型执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>[acldumpUnregCallback](#acldumpUnregCallback)接口--\>模型卸载--\>[aclFinalize](02_initialization_and_deinitialization.md#aclFinalize)接口

    - 执行两个不同的模型，通过回调获取Dump数据，该场景下，只要不调用[acldumpUnregCallback](#acldumpUnregCallback)接口取消注册回调函数，则可通过回调函数获取两个模型的Dump数据：

        [aclInit](02_initialization_and_deinitialization.md#aclInit)接口--\>[acldumpRegCallback](#acldumpRegCallback)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>模型1加载--\>模型1执行--\>--\>模型2加载--\>模型2执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型卸载--\>[acldumpUnregCallback](#acldumpUnregCallback)接口--\>[aclFinalize](02_initialization_and_deinitialization.md#aclFinalize)接口

### 参数说明

无

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 参考资源

当前还提供了[aclInit](02_initialization_and_deinitialization.md#aclInit)接口，在初始化阶段，通过\*.json文件传入Dump配置信息，运行应用后获取Dump数据的方式。该种方式，一个进程内，只能调用一次[aclInit](02_initialization_and_deinitialization.md#aclInit)接口，如果要修改Dump配置信息，需修改\*.json文件中的配置。

<br>
<br>
<br>

<a id="aclopStartDumpArgs"></a>

## aclopStartDumpArgs

```c
aclError aclopStartDumpArgs(uint32_t dumpType, const char *path)
```

### 产品支持情况

<!-- npu="950" id3396 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3396 -->
<!-- npu="A3" id3397 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3397 -->
<!-- npu="910b" id3398 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3398 -->
<!-- npu="310b" id3399 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id3399 -->
<!-- npu="310p" id3400 -->
- Atlas 推理系列产品：不支持
<!-- end id3400 -->
<!-- npu="910" id3401 -->
- Atlas 训练系列产品：支持
<!-- end id3401 -->
<!-- npu="IPV350" id3402 -->
- IPV350：不支持
<!-- end id3402 -->
<!-- @ref: runtime/res/docs/zh/api_ref/18_dump_configuration_res.md#id7 -->

### 功能说明

调用本接口开启算子信息统计功能，并需与[aclopStopDumpArgs](#aclopStopDumpArgs)接口配合使用，将算子信息文件输出到path参数指定的目录，一个shape对应一个算子信息文件，文件中包含算子类型、算子属性、算子输入&输出的format/数据类型/shape等信息。

**使用场景：**例如要统计某个模型执行涉及哪些算子，可在模型执行之前调用aclopStartDumpArgs接口，在模型执行之后调用aclopStopDumpArgs接口，接口调用成功后，在path参数指定的目录下生成每个算子shape的算子信息文件。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dumpType | 输入 | 指定dump信息的类型。<br>当前仅支持ACL_OP_DUMP_OP_AICORE_ARGS，表示统计所有算子信息。<br>#define ACL_OP_DUMP_OP_AICORE_ARGS 0x00000001U |
| path | 输入 | 指定dump文件的保存路径，支持绝对路径或相对路径（指相对应用可执行文件所在的目录），但用户需确保路径存在或者该路径可以被创建。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="950,A3,910b,910" id10 -->
### 约束说明

仅支持在单算子API执行（例如，接口名前缀为aclnn的接口）场景下使用本接口，否则无法生成dump文件。
<!-- end id10 -->

<br>
<br>
<br>

<a id="aclopStopDumpArgs"></a>

## aclopStopDumpArgs

```c
aclError aclopStopDumpArgs(uint32_t dumpType)
```

### 产品支持情况

<!-- npu="950" id1590 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1590 -->
<!-- npu="A3" id1591 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1591 -->
<!-- npu="910b" id1592 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1592 -->
<!-- npu="310b" id1593 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1593 -->
<!-- npu="310p" id1594 -->
- Atlas 推理系列产品：不支持
<!-- end id1594 -->
<!-- npu="910" id1595 -->
- Atlas 训练系列产品：支持
<!-- end id1595 -->
<!-- npu="IPV350" id1596 -->
- IPV350：不支持
<!-- end id1596 -->
<!-- @ref: runtime/res/docs/zh/api_ref/18_dump_configuration_res.md#id8 -->

### 功能说明

调用本接口关闭算子信息统计功能，并需与[aclopStartDumpArgs](#aclopStartDumpArgs)接口配合使用，将算子信息文件输出到path参数指定的目录，一个shape对应一个算子信息文件，文件中包含算子类型、算子属性、算子输入&输出的format/数据类型/shape等信息。

**使用场景：**例如要统计某个模型执行涉及哪些算子，可在模型执行之前调用aclopStartDumpArgs接口，在模型执行之后调用aclopStopDumpArgs接口，接口调用成功后，在path参数指定的目录下生成每个算子shape的算子信息文件。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dumpType | 输入 | 指定dump信息的类型。<br>当前仅支持ACL_OP_DUMP_OP_AICORE_ARGS，表示统计所有算子信息。<br>#define ACL_OP_DUMP_OP_AICORE_ARGS 0x00000001U |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="950,A3,910b,910" id11 -->
### 约束说明

仅支持在单算子API执行（例如，接口名前缀为aclnn的接口）场景下使用本接口，否则无法生成dump文件。
<!-- end id11 -->
