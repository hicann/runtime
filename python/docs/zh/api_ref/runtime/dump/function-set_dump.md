# 函数：set\_dump

## 产品支持情况

<!-- npu="950" id1 -->
- Ascend 950PR&950DT系列产品：支持
<!-- end id1 -->
<!-- npu="A3" id2 -->
- Atlas A3系列产品：支持
<!-- end id2 -->
<!-- npu="910b" id3 -->
- Atlas A2系列产品：支持
<!-- end id3 -->
<!-- npu="310b" id4 -->
- Atlas 200I/500 A2推理产品：支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas推理系列产品：支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：支持
<!-- end id6 -->

## 功能说明

设置dump参数。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlSetDump(const char *dumpCfgPath)
    ```

- **python函数**

    ```python
    ret = acl.mdl.set_dump(dump_cfg_path)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| dump_cfg_path | string，配置文件所在的路径，包含文件名。<br>可通过该配置文件配置开启或配置各类Dump信息，详细描述请参见下文各功能配置示例中的描述。如果算子输入或输出中包含用户的敏感信息，则存在信息泄露风险。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- [acl.mdl.init\_dump](function-init_dump.md)接口需要与[acl.mdl.set\_dump](function-set_dump.md)接口、[acl.mdl.finalize\_dump](function-finalize_dump.md)接口配合使用，用于将Dump数据记录到文件中。一个进程内，可以根据需求多次调用这些接口，基于不同的Dump配置信息，获取Dump数据。
- 场景举例：
  - 两次模型执行，需要设置不同的Dump配置信息，接口调用顺序：[acl.init](../init/function-init.md)接口 --\> acl.mdl.init\_dump接口 --\>  [acl.mdl.set\_dump](function-set_dump.md)接口 --\> 模型加载 --\> 模型执行 --\>  [acl.mdl.finalize\_dump](function-finalize_dump.md)接口 --\> 模型卸载 --\>  [acl.mdl.init\_dump](function-init_dump.md)接口 --\>  [acl.mdl.set\_dump](function-set_dump.md)接口 --\> 模型加载 --\> 模型执行 --\>  [acl.mdl.finalize\_dump](function-finalize_dump.md)接口 --\> 模型卸载 --\> 执行其它任务 --\>  [acl.finalize](../init/function-finalize.md)接口
  - 同一个模型执行两次，第一次需要Dump，第二次无需Dump，接口调用顺序：[acl.init](../init/function-init.md)接口 --\> acl.mdl.init\_dump接口 --\>  [acl.mdl.set\_dump](function-set_dump.md)接口 --\> 模型加载 --\> 模型执行 --\>  [acl.mdl.finalize\_dump](function-finalize_dump.md)接口 --\> 模型卸载 --\> 模型加载 --\> 模型执行 --\> 执行其它任务 --\>  [acl.finalize](../init/function-finalize.md)接口

- 只有在调用本接口开启Dump之后加载模型，配置的Dump信息有效。在调用本接口之前已经加载的模型不受影响，除非用户在调用本接口后重新加载该模型。

    例如以下接口调用顺序中，加载的模型1不受影响，配置的Dump信息仅对加载的模型2有效：

    [acl.mdl.init\_dump](function-init_dump.md)接口 --\> 模型1加载 --\> acl.mdl.set\_dump接口 --\> 模型2加载 --\>  [acl.mdl.finalize\_dump](function-finalize_dump.md)接口

- 多次调用本接口对同一个模型配置了Dump信息，系统内处理时会采用覆盖策略。

    例如以下接口调用顺序中，第二次调用本接口配置的Dump信息会覆盖第一次配置的Dump信息：

    [acl.mdl.init\_dump](function-init_dump.md)接口 --\> acl.mdl.set\_dump接口 --\> acl.mdl.set\_dump接口 --\> 模型1加载 --\>  [acl.mdl.finalize\_dump](function-finalize_dump.md)接口

## 资源参考

还提供了[acl.init](../init/function-init.md)接口，在初始化阶段，通过\*.json文件传入Dump配置信息，运行应用后获取Dump数据的方式。该种方式，一个进程内，只能调用一次[acl.init](../init/function-init.md)接口，如果要修改Dump配置信息，需修改\*.json文件中的配置。

## 模型Dump配置、单算子Dump配置示例

模型Dump配置（用于导出模型中每一层算子输入和输出数据）、单算子Dump配置（用于导出单个算子的输入和输出数据），导出的数据用于与指定模型或算子进行比对，定位精度问题，具体比对方法请参见[《精度调试工具》](https://hiascend.com/document/redirect/CannCommunityToolAccucacy)。默认不启用该dump配置。

通过本接口启用Dump配置，需通过dump\_path参数配置保存Dump数据的路径。详细参数解释请参见[《精度调试工具》](https://hiascend.com/document/redirect/CannCommunityToolAccucacy)中的“NPU vs NPU（离线推理）\> 准备离线模型dump数据文件”。

模型Dump配置示例如下：

```json
{                                                                                            
 "dump":{
  "dump_list":[                                                                        
   { "model_name":"ResNet-101"
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
        "dump_path":"output",
        "dump_list":[], 
 "dump_op_switch":"on",
        "dump_data":"tensor"
    }
}
```

## 异常算子Dump配置示例

**异常算子Dump配置**（用于导出异常算子的输入输出数据、workspace信息、Tiling信息），导出的数据用于分析AI Core Error问题。默认不启用该dump配置。

关于AI Core Error问题的信息收集及定位，详细说明请参见《[故障处理]( https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/maintenref/troubleshooting/docs/zh/troubleshooting/troubleshooting_intro.md)》中的“典型故障专题 \> AI Core Error问题定位专题”。

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
  - aic\_err\_detail\_dump：在轻量化exception dump基础上，还会导出AI Core的内部存储、寄存器以及调用栈信息。

    配置该选项时，有以下注意事项：

    <!-- npu="A3,910b" id7 -->
    - 该选项仅支持以下型号，且需配套25.0.RC1或更高版本的驱动才可以使用：

        <!-- npu="910b" id8 -->
        Atlas A2系列产品
        <!-- end id8 -->

        <!-- npu="A3" id9 -->
        Atlas A3系列产品
        <!-- end id9 -->

        您可以单击[Link](https://www.hiascend.com/hardware/firmware-drivers)，下载Ascend HDK  25.0.RC1或更高版本的驱动安装包，并参考相应版本的文档进行安装、升级。
    <!-- end id7 -->

    - 导出dump文件过程中，会暂停问题算子所在的AI Core，因此可能会影响Device上其它业务进程的正常执行，导出dump文件后，会自行恢复AI Core。因此，多个Host侧用户业务进程指定同一个Device的场景下，不建议使用aic\_err\_detail\_dump选项。
    - 导出dump文件后，会强制退出Host侧用户业务进程，强制退出过程中的报错可不作为AI Core问题分析的输入。
    - 配置aic\_err\_detail\_dump选项后，如果生成了dump文件，但不是\*.core文件，则表示aic\_err\_detail\_dump对应的功能没有使能成功，系统自动切换为按aic\_err\_brief\_dump选项dump。

  - lite\_exception：表示轻量化exception dump，为了兼容旧版本，效果等同于aic\_err\_brief\_dump。

- dump\_path是可选参数，表示导出dump文件的存储路径。

    dump文件存储路径的优先级如下：NPU\_COLLECT\_PATH环境变量 \> ASCEND\_WORK\_PATH环境变量 \> 配置文件中的dump\_path \> 应用程序的当前执行目录

    环境变量的详细描述请参见[《环境变量参考》](https://hiascend.com/document/redirect/CannCommunityEnvRef)。

- 若需查看导出的dump文件内容，先将dump文件转换为numpy格式文件后，再通过Python查看numpy格式文件，详细转换步骤请参见[《精度调试工具》](https://hiascend.com/document/redirect/CannCommunityToolAccucacy)中的“扩展功能 \> 查看dump数据文件”章节。

    若将dump\_scene参数设置为aic\_err\_detail\_dump时，需使用msDebug工具查看导出的dump文件内容，详细方法请参见《[算子开发工具]( https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/devaids/optool/MindStudio/26.1.0/zh/user_guide/msot_user_guide.md)》。

- 异常算子Dump配置，不能与模型Dump配置或单算子Dump配置同时开启。

## 溢出算子Dump配置示例

**溢出算子Dump配置**（用于导出模型中溢出算子的输入和输出数据），导出的数据用于分析溢出原因，定位模型精度的问题。默认不启用该dump配置。

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

    获取导出的数据文件后，文件的解析请参见[《精度调试工具》](https://hiascend.com/document/redirect/CannCommunityToolAccucacy)中的“扩展功能 \> 溢出算子数据采集与解析”章节。

    dump\_path支持配置绝对路径或相对路径：

  - 绝对路径配置以“/”开头，例如：/home。
  - 相对路径配置直接以目录名开始，例如：output。

- 溢出算子Dump配置，不能与模型Dump配置或单算子Dump配置同时开启，否则会返回报错。
- 仅支持采集AI Core算子的溢出数据。

## 算子Dump Watch模式配置示例

**算子Dump Watch模式配置**（用于开启指定算子输出数据的观察模式），在定位部分算子精度问题且已排除算子本身的计算问题后，若怀疑被其它算子踩踏内存导致精度问题，可开启Dump Watch模式。**默认不开启Dump Watch模式。**

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

- Dump Watch模式在单算子API Dump场景下不生效。
- 若开启算子Dump Watch模式，则不支持同时开启溢出算子Dump（配置dump\_debug参数）或开启单算子模型Dump（配置dump\_op\_switch参数），否则报错。
- 在dump\_list中，通过layer参数配置可能踩踏其它算子内存的算子名称，通过watcher\_nodes参数配置可能被其它算子踩踏输出内存导致精度有问题的算子名称。
  - 若不指定layer，则模型内所有支持Dump的算子在执行后，都会将watcher\_nodes中配置的算子的输出Dump出来。
  - layer和watcher\_nodes处配置的算子都必须是静态图、静态子图中的算子，否则不生效。
  - 若layer和watcher\_nodes处配置的算子名称相同，或者layer处配置的是集合通信类算子（算子类型以Hcom开头，例如HcomAllReduce），则只导出watcher\_nodes中所配置算子的dump文件。
  - 对于融合算子，watcher\_nodes处配置的算子名称必须是融合后的算子名称，若配置融合前的算子名称，则不导出dump文件。
  - dump\_list内暂不支持配置model\_name。

- 开启算子Dump Watch模式，则dump\_path必须配置，表示导出dump文件的存储路径。

    此处收集的dump文件无法通过文本工具直接查看其内容，若需查看dump文件内容，先将dump文件转换为numpy格式文件后，再通过Python查看numpy格式文件，详细转换步骤请参见[《精度调试工具》](https://hiascend.com/document/redirect/CannCommunityToolAccucacy)中的“扩展功能 \> 查看dump数据文件”章节。

    dump\_path支持配置绝对路径或相对路径：

  - 绝对路径配置以“/”开头，例如：/home。
  - 相对路径配置直接以目录名开始，例如：output。

- 通过dump\_mode参数控制导出watcher\_nodes中所配置算子的哪部分数据，当前仅支持配置为output。
- 通过dump\_level设置dump数据级别，取值：

  - op：按算子级别dump数据。
  - kernel：按kernel级别dump数据。
  - all：默认值，op和kernel级别的数据都dump。

    默认配置下，dump数据文件会比较多，例如有一些aclnn开头的dump文件，若用户对dump性能有要求或内存资源有限时，则可以将该参数设置为op级别，以便提升dump性能、精简dump数据文件数量。

    **说明**：算子是一个运算逻辑的表示（如加减乘除运算），kernel是运算逻辑真正进行计算处理的实现，需要分配具体的计算设备完成计算。

<!-- npu="950,A3,910b,310p,310b" id10 -->
## 算子Kernel调测信息Dump配置

**算子Kernel调测信息Dump配置**，用于导出Ascend C算子Kernel的调测信息，便于定位算子问题。**默认不启用该Dump配置。**

仅如下型号支持该配置：

<!-- npu="950" id11 -->
Ascend 950PR&950DT系列产品
<!-- end id11 -->

<!-- npu="A3" id12 -->
Atlas A3系列产品
<!-- end id12 -->

<!-- npu="910b" id13 -->
Atlas A2系列产品
<!-- end id13 -->

<!-- npu="310b" id14 -->
Atlas 200I/500 A2推理产品
<!-- end id14 -->

Atlas推理系列产品
<!-- npu="310p" id15 -->
Atlas推理系列产品
<!-- end id15 -->
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

    导出的Dump文件无法通过文本工具直接查看其内容，若需查看，需使用show\_kernel\_debug\_data工具将调测信息解析为可读格式，工具使用指导请参见[《Ascend C算子开发》](https://hiascend.com/document/redirect/CannCommunityOpdevAscendC)中的“编程指南 \> 附录 \> show\_kernel\_debug\_data工具”。

<!-- end id10 -->