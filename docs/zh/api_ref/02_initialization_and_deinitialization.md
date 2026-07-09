# 2. 初始化与去初始化

本章节描述 CANN Runtime 的初始化与去初始化接口，包括 ACL 环境的初始化、反初始化及相关回调注册。

- [`aclError aclInit(const char *configPath)`](#aclInit)：初始化函数。
- [`aclError aclFinalize()`](#aclFinalize)：去初始化函数，用于释放进程内acl接口使用的相关资源。
- [`aclError aclFinalizeReference(uint64_t *refCount)`](#aclFinalizeReference)：去初始化函数，用于释放进程内acl接口使用的相关资源。
- [`aclError aclInitCallbackRegister(aclRegisterCallbackType type, aclInitCallbackFunc cbFunc, void *userData)`](#aclInitCallbackRegister)：注册初始化回调函数。
- [`aclError aclInitCallbackUnRegister(aclRegisterCallbackType type, aclInitCallbackFunc cbFunc)`](#aclInitCallbackUnRegister)：若不需要触发回调函数的调用，可调用本接口取消注册回调函数。
- [`aclError aclFinalizeCallbackRegister(aclRegisterCallbackType type, aclFinalizeCallbackFunc cbFunc, void *userData)`](#aclFinalizeCallbackRegister)：注册去初始化回调函数。
- [`aclError aclFinalizeCallbackUnRegister(aclRegisterCallbackType type, aclFinalizeCallbackFunc cbFunc)`](#aclFinalizeCallbackUnRegister)：若不需要触发回调函数的调用，可调用本接口取消注册回调函数。

<a id="aclInit"></a>

## aclInit

```c
aclError aclInit(const char *configPath)
```

### 产品支持情况

<!-- npu="950" id3235 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3235 -->
<!-- npu="A3" id3236 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3236 -->
<!-- npu="910b" id3237 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3237 -->
<!-- npu="310b" id3238 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3238 -->
<!-- npu="310p" id3239 -->
- Atlas 推理系列产品：支持
<!-- end id3239 -->
<!-- npu="910" id3240 -->
- Atlas 训练系列产品：支持
<!-- end id3240 -->
<!-- npu="IPV350" id3241 -->
- IPV350：支持
<!-- end id3241 -->
<!-- @ref: runtime/res/docs/zh/api_ref/02_initialization_and_deinitialization_res.md#id1 -->

### 功能说明

初始化函数。

使用acl接口开发应用时，必须先调用aclInit接口，否则可能会导致后续系统内部资源初始化出错，进而导致其它业务异常。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| configPath | 输入 | 配置文件所在路径（包含文件名）的指针。配置文件内容为json格式（json文件内的“{”的层级最多为10，“[”的层级最多为10）。<br>初始化时，可通过该配置文件配置开启Dump、配置Profiling采集信息等功能，详细描述请参见下文各功能配置示例中的描述。如果默认配置已满足需求，无需修改，可向aclInit接口中传入NULL，或者可将配置文件配置为空json串（即配置文件中只有{}）。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

<!-- npu="950,A3,910b,910,310p,310b" id1 -->
- 一个进程内支持多次调用aclInit接口初始化，但需调用aclFinalize或aclFinalizeReference接口去初始化，支持以下场景：
    - 每次调用aclInit接口时，配置必须保持一致，否则仅首次调用的配置有效，后续调用aclInit接口可能会导致报错或配置无效。
    - 为兼容旧版本，重复调用aclInit接口会返回ACL\_ERROR\_REPEAT\_INITIALIZE错误码，您可以忽略该错误继续处理业务。
    - 若调用aclInit、aclFinalize接口分别实现初始化、去初始化，支持重复初始化、去初始化，时序上仅支持顺序调用，接口调用时序如下：

        ```text
        aclInit-->业务处理-->aclFinalize-->aclInit-->业务处理-->aclFinalize
        ```

        该场景下，如果调用多次aclInit接口后，再去初始化，仅需调用一次aclFinalize接口，将aclInit接口的引用计数直接清零。

    - 若调用aclInit、aclFinalizeReference接口分别实现初始化、去初始化，则需成对调用aclInit、aclFinalizeReference接口。

        因为aclFinalizeReference接口内部涉及引用计数的实现，aclInit接口每被调用一次，则引用计数加一，aclFinalizeReference接口每被调用一次，则该引用计数减一，当引用计数减到0时，才会真正去初始化。

        支持重复初始化、去初始化，时序上支持顺序调用，也支持并发调用，接口调用时序如下：

        - 顺序调用时序图如下：

            ![](figures/sequential_invoking_diagram.png)

        - 并发调用时序图如下：

            ![](figures/concurrent_invoking_diagram.png)
 <!-- end id1 -->

<!-- npu="IPV350" id2 -->
- 一个进程内支持多次调用aclInit接口初始化，但要求aclInit接口与[aclFinalize](#aclFinalize)去初始化接口数量匹配，支持以下场景：
    - 成对调用aclInit、aclFinalize接口，分别实现初始化、去初始化，在每对aclInit和aclFinalize中正常处理业务，同时每次aclInit接口中的json配置都能生效：

        ```text
        aclInit-->业务处理-->aclFinalize-->aclInit-->业务处理-->aclFinalize
        ```

    - 连续调用N次aclInit接口初始化，这时也需连续调用N次aclFinalize接口才能真正去初始化，且只有第一次aclInit接口中的json配置生效：

        ```text
        aclInit-->aclInit-->业务处理-->aclFinalize-->aclFinalize
        ```

        该场景下，若在aclInit接口前调用1次或多次aclFinalize接口，此时不会触发去初始化流程；若调用N次aclInit接口后，调用aclFinalize接口的次数大于N，则多余的aclFinalize接口也不会触发去初始化流程。

    - 多线程场景推荐如下使用方式，否则可能导致业务异常：
        - 主线程调用aclInit和aclFinalize、子线程调模型推理等业务处理，主线程等待子线程的业务处理结束再调用aclFinalize：

            ![](figures/main_thread_invoking_aclFinalize.png)

        - 各子线程均成对调aclInit和aclFinalize：

            ![](figures/paired_invoking_aclInit_aclFinalize.png)

- 模型推理（同步）场景下，若开启Dump功能，只支持在一个进程中对一个或多个模型执行Dump操作，由于资源限制，其它进程中不建议启动推理程序，否则可能造成Dump异常。

    若对多个模型执行Dump操作，多个模型必须串行；

    建议单线程内对模型执行Dump操作，否则可能出现Dump数据文件路径中的序号（即data\_index）不准确，导致Dump数据存放的目录异常。

- 模型推理（异步）场景下，若开启Dump功能，建议一次异步推理、一次流同步，否则可能出现Dump数据文件路径中的序号（即data\_index）不准确，导致Dump数据存放的目录异常。
<!-- end id2 -->

<!-- @ref: runtime/res/docs/zh/api_ref/02_initialization_and_deinitialization_res.md#id8 -->

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

<!-- npu="IPV350" id3 -->
IPV350只支持模型Dump配置，不支持单算子Dump配置。若开启模型Dump配置、且在模型加载时加载exeom文件时，则dbg文件要存放在json配置文件中dump\_path参数指定的路径下，才可以生成dump数据文件，用于后续的精度问题定位及分析。exeom文件以及dbg文件是在模型转换时生成，请参见《ATC离线模型编译工具》中的“参数说明 \> 基础功能参数 \> 总体选项 \> --mode”。
<!-- end id3 -->

### 异常算子Dump配置

**异常算子Dump配置**，用于导出异常算子的输入输出数据、workspace信息、Tiling信息等。导出的数据用于分析AI Core Error问题，**默认不启用该Dump配置。**

<!-- npu="950,A3,910b,910,310p,310b" id4 -->
关于AI Core Error问题的信息收集及定义，详细说明请参见[《故障处理》](https://hiascend.com/document/redirect/CannCommunitytrouble)。
<!-- end id4 -->

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
    <!-- npu="A3,910b" id5 -->
    - aic\_err\_detail\_dump：在轻量化exception dump基础上，还会导出AI Core的内部存储、寄存器以及调用栈信息。

        配置该选项时，有以下注意事项：

        - 该选项仅支持以下型号，且需配套25.0.RC1或更高版本的驱动才可以使用：

            Atlas A3 训练系列产品/Atlas A3 推理系列产品

            Atlas A2 训练系列产品/Atlas A2 推理系列产品

            您可以单击[Link](https://www.hiascend.com/hardware/firmware-drivers/commercial)，在“固件与驱动”页面下载Ascend HDK  25.0.RC1或更高版本的驱动安装包，并参考相应版本的文档进行安装、升级。

        - 导出dump文件过程中，会暂停问题算子所在的AI Core，因此可能会影响Device上其它业务进程的正常执行，导出dump文件后，AI Core会自动恢复。因此，多个Host侧用户业务进程指定同一个Device的场景下，不建议使用aic\_err\_detail\_dump选项。
        - 导出dump文件后，会强制退出Host侧用户业务进程，强制退出过程中的报错可不作为AI Core问题分析的输入。
        - 配置aic\_err\_detail\_dump选项后，如果生成了dump文件，但不是\*.core文件，则表示aic\_err\_detail\_dump对应的功能没有使能成功，系统自动切换为按aic\_err\_brief\_dump选项dump。
    <!-- end id5 -->

    - lite\_exception：表示轻量化exception dump，为了兼容旧版本，效果等同于aic\_err\_brief\_dump。

- dump\_path是可选参数，表示导出dump文件的存储路径。

    dump文件存储路径的优先级如下：NPU\_COLLECT\_PATH环境变量 \> ASCEND\_WORK\_PATH环境变量 \> 配置文件中的dump\_path \> 应用程序的当前执行目录，环境变量的详细描述请参见[《环境变量参考》](https://hiascend.com/document/redirect/CannCommunityEnvRef)。

<!-- npu="950,A3,910b,910,310p,310b" id6 -->
- 若需查看导出的dump文件内容，请参见[《故障处理》](https://hiascend.com/document/redirect/CannCommunitytrouble)中的“故障定位工具 \> msaicerr工具使用指导 \> 解析Dump文件”章节。

    <!-- npu="A3,910b" id7 -->
    若将dump\_scene参数设置为aic\_err\_detail\_dump时，需使用msDebug工具查看导出的dump文件内容，详细方法请参见[《算子开发工具用户指南》](https://hiascend.com/document/redirect/CannCommunityopdev)。
    <!-- end id7 -->
<!-- end id6 -->

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
        "dump_level":"op",
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

- 通过dump_level设置dump数据级别，取值如下。默认配置下，dump数据文件会比较多，例如有一些aclnn开头的dump文件，若用户对dump性能有要求或内存资源有限时，则可以将该参数设置为op级别，以便提升dump性能、精简dump数据文件数量。

    - op：按算子级别dump数据。算子是一个运算逻辑的表示（如加减乘除运算）。
    - kernel：按kernel级别dump数据。
    - all：默认值，op和kernel级别的数据都dump。kernel是运算逻辑真正进行计算处理的实现，需要分配具体的计算设备完成计算。

    <!-- npu="950,A3,910b,310p,310b" id8 -->

### 算子Kernel调测信息Dump配置

**算子Kernel调测信息Dump配置**，用于导出Ascend C算子Kernel的调测信息，便于定位算子问题。**默认不启用该Dump配置。**

仅如下型号支持该配置：

<!-- npu="950" id9 -->
Ascend 950PR/Ascend 950DT
<!-- end id9 -->

<!-- npu="A3" id10 -->
Atlas A3 训练系列产品/Atlas A3 推理系列产品
<!-- end id10 -->

<!-- npu="910b" id11 -->
Atlas A2 训练系列产品/Atlas A2 推理系列产品
<!-- end id11 -->

<!-- npu="310b" id12 -->
Atlas 200I/500 A2 推理产品
<!-- end id12 -->

<!-- npu="310p" id13 -->
Atlas 推理系列产品
<!-- end id13 -->

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
    <!-- end id8 -->

### Profiling采集信息配置

**Profiling采集信息配置**，配置示例、说明及约束请参见[《性能调优工具用户指南》](https://hiascend.com/document/redirect/CannCommunityToolProfiling)。**默认不启用Profiling采集信息配置。**

建议不要同时配置Dump信息和Profiling采集信息，否则Dump操作会影响系统性能，导致Profiling采集的性能数据指标不准确。

### 算子缓存信息老化配置

<!-- npu="IPV350" id14 -->
IPV350不支持算子缓存信息老化配置。
<!-- end id14 -->

**算子缓存信息老化配置**，通过单算子模型方式执行单个算子时（aclopUpdateParams接口执行单算子除外），为节约内存和平衡调用性能，可通过max\_opqueue\_num参数配置“算子类型-单算子模型”映射队列的最大长度，如果长度达到最大，则会先删除长期未使用的映射信息以及缓存中的单算子模型，再加载最新的映射信息以及对应的单算子模型。如果不配置映射队列的最大长度，则**默认最大长度为20000**。

单算子模型执行是指基于图IR执行算子，先编译算子（例如，使用ATC工具将Ascend IR定义的单算子描述文件编译成算子om模型文件），再调用acl接口加载算子模型（例如aclopSetModelDir接口），最后调用acl接口执行算子（例如aclopExecuteV2接口）。

通过max\_opqueue\_num参数配置“算子类型-单算子模型”映射队列的最大长度，实现算子缓存信息老化，配置文件中的示例内容如下：

```json
{
        "max_opqueue_num": "10000"
}
```

相关配置说明及约束如下：

- 对于静态加载的算子（是指加载单算子编译成的\*.om文件，例如aclopSetModelDir接口），老化配置无效，不会对该部分的算子信息做老化。
- 对于在线编译的算子（是指调用acl接口直接编译算子，例如aclopCompile、aclopCompileAndExecuteV2等），接口内部会按照入参加载单算子模型，老化配置有效。

    如果用户调用aclopCompile接口编译算子、调用aclopExecuteV2接口执行算子，则在编译算子后需及时执行算子，否则可能导致执行算子时，算子信息已被老化，需要重新编译。建议调用aclopCompileAndExecuteV2接口编译执行算子。

- 接口内部分开维护固定Shape和动态Shape算子的映射队列，最大长度都为max\_opqueue\_num参数值。
- max\_opqueue\_num参数值为静态加载算子的单算子模型个数和在线编译算子的单算子模型个数的总和，因此max\_opqueue\_num参数值应大于当前进程中可用的、静态加载算子的单算子模型个数，否则会导致在线编译算子的信息无法老化。

### 错误信息上报模式配置

**错误信息上报模式配置，**用于控制[aclGetRecentErrMsg](13_exception_handling.md#aclGetRecentErrMsg)接口按进程或线程级别获取错误信息，**默认按线程级别**。

err\_msg\_mode参数取值范围：0为默认值，表示按线程级别获取错误信息；1表示按进程级别获取错误信息。

配置文件中的示例内容如下：

```json
{
        "err_msg_mode": "1"
}
```

<!-- npu="950,A3,910b,910,310p,310b" id15 -->
### 默认Device配置示例

**默认Device配置**（用于配置默认的计算设备）。若同时通过[aclrtSetDevice](04_device_management.md#aclrtSetDevice)接口指定Device，则aclrtSetDevice接口优先级高。如果用户开启默认Device功能后，若需要显式创建Context，则需要调用[aclrtSetDevice](04_device_management.md#aclrtSetDevice)，否则可能会导致业务异常。

default\_device参数处设置Device ID，Device ID可设置为0或十进制正整数，用户可调用[aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：\[0, \(可用的Device数量-1\)\]。

配置文件中的示例内容如下：

```json
{
    "defaultDevice":{
        "default_device":"0"
    }
}
```
<!-- end id15 -->

<!-- npu="950,A3,910b,310b" id16 -->
### AI Core栈空间大小配置示例

**AI Core栈空间大小配置**，用于控制进程中Kernel执行时为每个AI Core分配的栈空间大小，**默认为32K字节**。

<!-- npu="950" id17 -->
Ascend 950PR/Ascend 950DT支持该配置，在编译AI Core算子时，无需打开O0开关。
<!-- end id17 -->

<!-- npu="A3,910b" id18 -->
Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品支持该配置，但在编译AI Core算子时，只有打开O0开关，此处配置的AI Core栈空间大小才有效。
<!-- end id18 -->

<!-- npu="310b" id19 -->
Atlas 200I/500 A2 推理产品支持该配置，但在编译AI Core算子时，只有打开O0开关，此处配置的AI Core栈空间大小才有效。
<!-- end id19 -->

aicore\_stack\_size参数处设置栈空间大小，单位Byte，取值有以下要求：

- aicore\_stack\_size是16K的整数倍，若传入aicore\_stack\_size不是16K的整数倍，则会向上取整，确保其为16K的整数倍。
- aicore\_stack\_size最小值为32K，若传入的aicore\_stack\_size小于32K，则按默认配置32K处理。
- 各产品的aicore\_stack\_size最大值如下：

    <!-- npu="950" id20 -->
    在Ascend 950PR/Ascend 950DT上，aicore\_stack\_size最大值为128K。
    <!-- end id20 -->

    <!-- npu="A3,910b" id21 -->
    在Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品上，aicore\_stack\_size最大值为192K。
    <!-- end id21 -->

    <!-- npu="310b" id22 -->
    在Atlas 200I/500 A2 推理产品上，aicore\_stack\_size最大值为7680K。
    <!-- end id22 -->

配置文件中的示例内容如下：

```json
{
    "StackSize":{
        "aicore_stack_size":32768
    }
}
```
<!-- end id16 -->

<!-- npu="950" id23 -->
### SIMT算子栈空间大小配置示例

**SIMT（Single Instruction Multiple Thread）栈空间大小配置**，用于控制每个线程中SIMT算子的栈空间大小以及SIMT算子的分支（Divergence）栈空间大小，单位Byte。

<!-- npu="950" id24 -->
仅Ascend 950PR/Ascend 950DT支持该配置。
<!-- end id24 -->

simt\_stack\_size参数处设置SIMT算子每个线程的栈空间大小，单位Byte。

simt\_divergence\_stack\_size参数处设置SIMT算子的分支（Divergence）栈空间大小，单位Byte。

simt\_stack\_size和simt\_divergence\_stack\_size的取值都必须是128的整数倍，如果传入的不是128的整数倍，则接口内部会自动向上取整，确保其为128的整数倍。

配置文件中的示例内容如下：

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
### SIMT Printf维测空间大小配置示例

SIMT（Single Instruction Multiple Thread）Printf维测空间大小配置，用于控制SIMT算子可以Printf打印的空间大小，单位Byte。

<!-- npu="950" id26 -->
仅Ascend 950PR/Ascend 950DT支持该配置。
<!-- end id26 -->

simt\_printf\_fifo\_size参数处设置SIMT算子Printf维测空间大小，单位Byte。其取值都必须是8的整数倍，如果传入的不是8的整数倍，则接口内部会自动向上取整，确保其为8的整数倍。

simt\_printf\_fifo\_size配置默认值2MB，最小值是1MB，最大值64MB。

配置文件中的示例内容如下：

```json
{
  "simt_printf_fifo_size": 1048576
}
```
<!-- end id25 -->

<!-- npu="950,A3,910b" id27 -->
### SIMD Printf维测空间大小配置示例

SIMD（Single Instruction Multiple Data）Printf维测空间大小配置，用于控制每个Core上SIMD算子可以Printf打印的空间大小，单位Byte。仅如下型号支持该配置：

<!-- npu="950,A3,910b" id28 -->
仅Ascend 950PR/Ascend 950DT、Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品支持该配置。
<!-- end id28 -->

simd\_printf\_fifo\_size\_per\_core参数处设置SIMD算子Printf维测空间大小，单位Byte。其取值都必须是8的整数倍，如果传入的不是8的整数倍，则接口内部会自动向上取整，确保其为8的整数倍。

simd\_printf\_fifo\_size\_per\_core配置默认值32KB，最小值是1KB，最大值64MB。

配置文件中的示例内容如下：

```json
{
  "simd_printf_fifo_size_per_core": 1048576
}
```
<!-- end id27 -->

<br>
<br>
<br>

<a id="aclFinalize"></a>

## aclFinalize

```c
aclError aclFinalize()
```

### 产品支持情况

<!-- npu="950" id666 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id666 -->
<!-- npu="A3" id667 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id667 -->
<!-- npu="910b" id668 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id668 -->
<!-- npu="310b" id669 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id669 -->
<!-- npu="310p" id670 -->
- Atlas 推理系列产品：支持
<!-- end id670 -->
<!-- npu="910" id671 -->
- Atlas 训练系列产品：支持
<!-- end id671 -->
<!-- npu="IPV350" id672 -->
- IPV350：支持
<!-- end id672 -->
<!-- @ref: runtime/res/docs/zh/api_ref/02_initialization_and_deinitialization_res.md#id2 -->

### 功能说明

去初始化函数，用于释放进程内acl接口使用的相关资源。

<!-- npu="950,A3,910b,910,310p,310b" id29 -->
对于涉及Device业务日志回传到Host的场景，本接口默认增加2000ms延时（实际最大延时可达2000ms），以确保ERROR级别和EVENT级别日志完整回传，防止不丢失。您可以将ASCEND\_LOG\_DEVICE\_FLUSH\_TIMEOUT环境变量设置为0（命令示例：export ASCEND\_LOG\_DEVICE\_FLUSH\_TIMEOUT=0），来取消该默认延时。关于ASCEND\_LOG\_DEVICE\_FLUSH\_TIMEOUT环境变量的详细描述请参见[《环境变量参考》](https://hiascend.com/document/redirect/CannCommunityEnvRef)中的。
<!-- end id29 -->

### 参数说明

无

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

应用进程退出前，应确保已调用aclFinalize或[aclFinalizeReference](#aclFinalizeReference)接口完成去初始化，否则可能会导致异常，例如应用进程退出时有异常报错。

不建议在析构函数中调用aclFinalize或[aclFinalizeReference](#aclFinalizeReference)接口，否则在进程退出时可能由于单例析构顺序未知而导致进程异常退出的问题。

<br>
<br>
<br>

<a id="aclFinalizeReference"></a>

## aclFinalizeReference

```c
aclError aclFinalizeReference(uint64_t *refCount)
```

### 产品支持情况

<!-- npu="950" id3207 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3207 -->
<!-- npu="A3" id3208 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3208 -->
<!-- npu="910b" id3209 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3209 -->
<!-- npu="310b" id3210 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3210 -->
<!-- npu="310p" id3211 -->
- Atlas 推理系列产品：支持
<!-- end id3211 -->
<!-- npu="910" id3212 -->
- Atlas 训练系列产品：支持
<!-- end id3212 -->
<!-- npu="IPV350" id3213 -->
- IPV350：不支持
<!-- end id3213 -->
<!-- @ref: runtime/res/docs/zh/api_ref/02_initialization_and_deinitialization_res.md#id3 -->

### 功能说明

去初始化函数，用于释放进程内acl接口使用的相关资源。

aclFinalizeReference接口内部涉及引用计数的实现，aclInit接口每被调用一次，则引用计数加一，aclFinalizeReference接口每被调用一次，则该引用计数减一，当引用计数减到0时，才会真正去初始化。[aclFinalize](#aclFinalize)接口与本接口的区别在于，调用aclFinalize接口会将计数清零，直接去初始化。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| refCount | 输入&输出 | 返回调用aclFinalizeReference后的引用计数。<br>若不需要获取引用计数，此处可传nullptr。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

应用进程退出前，应确保已调用[aclFinalize](#aclFinalize)或aclFinalizeReference接口完成去初始化，否则可能会导致异常，例如应用进程退出时有异常报错。

不建议在析构函数中调用[aclFinalize](#aclFinalize)或aclFinalizeReference接口，否则在进程退出时可能由于单例析构顺序未知而导致进程异常退出的问题。

<br>
<br>
<br>

<a id="aclInitCallbackRegister"></a>

## aclInitCallbackRegister

```c
aclError aclInitCallbackRegister(aclRegisterCallbackType type, aclInitCallbackFunc cbFunc, void *userData)
```

### 产品支持情况

<!-- npu="950" id988 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id988 -->
<!-- npu="A3" id989 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id989 -->
<!-- npu="910b" id990 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id990 -->
<!-- npu="310b" id991 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id991 -->
<!-- npu="310p" id992 -->
- Atlas 推理系列产品：支持
<!-- end id992 -->
<!-- npu="910" id993 -->
- Atlas 训练系列产品：支持
<!-- end id993 -->
<!-- npu="IPV350" id994 -->
- IPV350：不支持
<!-- end id994 -->
<!-- @ref: runtime/res/docs/zh/api_ref/02_initialization_and_deinitialization_res.md#id4 -->

### 功能说明

注册初始化回调函数。

若在[aclInit](#aclInit)接口之前调用本接口，则会在初始化时触发回调函数的调用；若在[aclInit](#aclInit)接口之后调用本接口，则会在注册时立即触发回调函数的调用。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| type | 输入 | 注册类型，按照不同的功能区分，请参见[aclRegisterCallbackType](25-02_Enumerations.md#aclRegisterCallbackType)。 |
| cbFunc | 输入 | 初始化回调函数。<br>回调函数的函数原型为：<br>typedef [aclError](25-01_aclError.md#aclError) (*aclInitCallbackFunc)(const char*configStr, size_t len, void *userData);<br>configStr跟aclInit接口中的json文件内容保持一致；len表示json文件内容的长度，单位Byte。 |
| userData | 输入 | 待传递给回调函数的用户数据的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclInitCallbackUnRegister"></a>

## aclInitCallbackUnRegister

```c
aclError aclInitCallbackUnRegister(aclRegisterCallbackType type, aclInitCallbackFunc cbFunc)
```

### 产品支持情况

<!-- npu="950" id2444 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2444 -->
<!-- npu="A3" id2445 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2445 -->
<!-- npu="910b" id2446 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2446 -->
<!-- npu="310b" id2447 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2447 -->
<!-- npu="310p" id2448 -->
- Atlas 推理系列产品：支持
<!-- end id2448 -->
<!-- npu="910" id2449 -->
- Atlas 训练系列产品：支持
<!-- end id2449 -->
<!-- npu="IPV350" id2450 -->
- IPV350：不支持
<!-- end id2450 -->
<!-- @ref: runtime/res/docs/zh/api_ref/02_initialization_and_deinitialization_res.md#id5 -->

### 功能说明

若不需要触发回调函数的调用，可调用本接口取消注册回调函数。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| type | 输入 | 注册类型，按照不同的功能区分，请参见[aclRegisterCallbackType](25-02_Enumerations.md#aclRegisterCallbackType)。 |
| cbFunc | 输入 | 初始化回调函数。<br>回调函数的函数原型为：<br>typedef [aclError](25-01_aclError.md#aclError) (*aclInitCallbackFunc)(const char*configStr, size_t len, void *userData); |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclFinalizeCallbackRegister"></a>

## aclFinalizeCallbackRegister

```c
aclError aclFinalizeCallbackRegister(aclRegisterCallbackType type, aclFinalizeCallbackFunc cbFunc, void *userData)
```

### 产品支持情况

<!-- npu="950" id2332 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2332 -->
<!-- npu="A3" id2333 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2333 -->
<!-- npu="910b" id2334 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2334 -->
<!-- npu="310b" id2335 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2335 -->
<!-- npu="310p" id2336 -->
- Atlas 推理系列产品：支持
<!-- end id2336 -->
<!-- npu="910" id2337 -->
- Atlas 训练系列产品：支持
<!-- end id2337 -->
<!-- npu="IPV350" id2338 -->
- IPV350：不支持
<!-- end id2338 -->
<!-- @ref: runtime/res/docs/zh/api_ref/02_initialization_and_deinitialization_res.md#id6 -->

### 功能说明

注册去初始化回调函数。

在[aclFinalize](#aclFinalize)接口之前调用本接口，在去初始化时触发回调函数的调用。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| type | 输入 | 注册类型，按照不同的功能区分，请参见[aclRegisterCallbackType](25-02_Enumerations.md#aclRegisterCallbackType)。 |
| cbFunc | 输入 | 去初始化回调函数。<br>回调函数定义如下：<br>typedef [aclError](25-01_aclError.md#aclError) (*aclFinalizeCallbackFunc)(void*userData); |
| userData | 输入 | 待传递给回调函数的用户数据的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclFinalizeCallbackUnRegister"></a>

## aclFinalizeCallbackUnRegister

```c
aclError aclFinalizeCallbackUnRegister(aclRegisterCallbackType type, aclFinalizeCallbackFunc cbFunc)
```

### 产品支持情况

<!-- npu="950" id155 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id155 -->
<!-- npu="A3" id156 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id156 -->
<!-- npu="910b" id157 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id157 -->
<!-- npu="310b" id158 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id158 -->
<!-- npu="310p" id159 -->
- Atlas 推理系列产品：支持
<!-- end id159 -->
<!-- npu="910" id160 -->
- Atlas 训练系列产品：支持
<!-- end id160 -->
<!-- npu="IPV350" id161 -->
- IPV350：不支持
<!-- end id161 -->
<!-- @ref: runtime/res/docs/zh/api_ref/02_initialization_and_deinitialization_res.md#id7 -->

### 功能说明

若不需要触发回调函数的调用，可调用本接口取消注册回调函数。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| type | 输入 | 注册类型，按照不同的功能区分，请参见[aclRegisterCallbackType](25-02_Enumerations.md#aclRegisterCallbackType)。 |
| cbFunc | 输入 | 去初始化回调函数。<br>回调函数定义如下：<br>typedef [aclError](25-01_aclError.md#aclError) (*aclFinalizeCallbackFunc)(void*userData); |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。
