# aclmdlSetDump

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

设置Dump参数。

[aclmdlInitDump](aclmdlInitDump.md)接口、[aclmdlSetDump](aclmdlSetDump.md)接口、[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口配合使用，用于将Dump数据记录到文件中。一个进程内，可以根据需求多次调用这些接口，基于不同的Dump配置信息，获取Dump数据。场景举例如下：

-   执行两个不同的模型，需要设置不同的Dump配置信息，接口调用顺序：[aclInit](aclInit.md)接口--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>[aclmdlSetDump](aclmdlSetDump.md)接口--\>模型1加载--\>模型1执行--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>模型1卸载--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>[aclmdlSetDump](aclmdlSetDump.md)接口--\>模型2加载--\>模型2执行--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>模型2卸载--\>执行其它任务--\>[aclFinalize](aclFinalize.md)接口
-   同一个模型执行两次，第一次需要Dump，第二次无需Dump，接口调用顺序：[aclInit](aclInit.md)接口--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>[aclmdlSetDump](aclmdlSetDump.md)接口--\>模型加载--\>模型执行--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>模型卸载--\>模型加载--\>模型执行--\>执行其它任务--\>[aclFinalize](aclFinalize.md)接口

## 函数原型

```
aclError aclmdlSetDump(const char *dumpCfgPath)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dumpCfgPath | 输入 | 配置文件路径的指针，包含文件名。配置文件格式为json格式。<br>可通过该配置文件配置开启或配置各类Dump信息，详细描述请参见下文各功能配置示例中的描述。如果算子输入或输出中包含用户的敏感信息，则存在信息泄露风险。 |

## 模型Dump配置、单算子Dump配置

**模型Dump配置**（用于导出模型中每一层算子输入和输出数据）、**单算子Dump配置**（用于导出单个算子的输入和输出数据），导出的数据用于与指定模型或算子进行比对，定位精度问题，具体比对方法请参见《精度调试工具用户指南》。**默认不启用该Dump配置。**

通过本接口启用Dump配置，需通过dump\_path参数配置Dump数据的落盘路径。

模型Dump配置示例如下：

```
{                                                                                            
	"dump":{
		"dump_list":[                                                                        
			{	"model_name":"ResNet-101"
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

```
{
    "dump":{
        "dump_path":"/home/output",
        "dump_list":[{}], 
	"dump_op_switch":"on",
        "dump_data":"tensor"
    }
}
```

**表 1**  acl.json文件格式说明


| 配置项 | 参数说明 |
| --- | --- |
| dump_list | （必选）待dump数据的整网模型列表。<br><br>  - 模型推理场景下，当需要Dump全部算子时，配置为："dump_list":[{}]<br>当需要Dump多个模型或特定算子时，需要结合model_name和layer使用。<br>  - 在单算子调用场景（包括单算子模型执行和单算子API执行）下，dump_list建议配置为："dump_list":[{}] |
| model_name | 模型名称，各个模型的model_name值须唯一。<br><br>  - 模型加载方式为文件加载时，填入模型文件的名称，不需要带后缀名；也可以配置为ATC模型文件转换后的json文件里的最外层"name"字段对应值。<br>  - 模型加载方式为内存加载时，配置为ATC模型文件转换后的json文件里的最外层"name"字段对应值。 |
| layer | IO性能较差时，可能会因为数据量过大而导致执行超时，因此不建议进行全量dump，请指定算子进行dump。通过该字段可以指定需要dump的算子名，支持指定为ATC模型转换后的算子名，也支持指定为转换前的原始算子名，配置时需注意：<br><br>  - 需按格式配置，每行配置模型中的一个算子名，且每个算子之间用英文逗号隔开。<br>  - 用户可以无需设置model_name，此时会默认dump所有model下的相应算子。如果配置了model_name，则dump对应model下的相应算子。<br>  - 若指定的算子其输入涉及data算子，会同时将data算子信息dump出来；若需dump data算子，需要一并填写data节点算子的后继节点，才能dump出data节点算子数据。<br>  - 当需要dump模型中所有算子时，不需要包含layer字段。 |
| optype_blacklist | 配置dump数据黑名单，黑名单中的指定类型的算子的输入或输出数据不会进行数据dump，用户可通过该配置控制dump的数据量。<br>该功能仅在执行模型数据dump操作，且dump_level为op时生效，同时支持和opname_blacklist配合使用。<br>配置示例：<br>{<br>	"dump":{<br>		"dump_list":[   <br>			{   <br>				"model_name":"ResNet-50",<br>				"optype_blacklist":[<br>				  {<br>					  "name":"conv"<br>					  "pos":["input0", "input1"]<br>					} <br>				] <br>			}<br>		],  <br>		"dump_path":"/home/output",<br>   "dump_mode":"input",<br>	}  <br>}<br>以上示例表示：不对conv算子的input0数据和input1数据执行dump操作，conv为算子类型。<br>optype_blacklist中包括name和pos字段，配置时需注意：<br><br>  - name表示算子类型，支持指定为ATC模型转换后的算子类型，配置为空时该过滤项不生效。<br>  - pos表示算子的输入或输出，仅支持配置为inputn或outputn格式，其中n表示输入输出索引号。配置为空时该过滤项不生效。<br>  - optype_blacklist内最多支持配置100个过滤项。<br>  - 如果配置了model_name，则仅对该model下的算子生效。如果不配置model_name，则对所有model下的算子生效。 |
| opname_blacklist | 配置dump数据黑名单，黑名单中的指定名称的算子的输入或输出数据不会进行数据dump，用户可通过该配置控制dump的数据量。<br>该功能仅在执行模型数据dump操作，且dump_level为op时生效，同时支持和optype_blacklist配合使用。<br>配置示例：<br>{<br>	"dump":{<br>		"dump_list":[   <br>			{   <br>				"model_name":"ResNet-50",<br>				"opname_blacklist":[<br>				  {<br>					  "name":"conv"<br>					  "pos":["input0", "input1"]<br>					} <br>				] <br>			}<br>		],  <br>		"dump_path":"/home/output",<br>   "dump_mode":"input",<br>	}  <br>}<br>以上示例表示：不对conv算子的input0数据和input1数据执行dump操作，conv为算子名称。<br>opname_blacklist中包括name和pos字段，配置时需注意：<br><br>  - name表示算子名称，支持指定为ATC模型转换后的算子名称，配置为空时该过滤项不生效。<br>  - pos表示算子的输入或输出，仅支持配置为inputn或outputn格式，其中n表示输入输出索引号。配置为空时该过滤项不生效。<br>  - opname_blacklist内最多支持配置100个过滤项。<br>  - 如果配置了model_name，则仅对该model下的算子生效。如果不配置model_name，则对所有model下的算子生效。 |
| opname_range | 配置dump数据范围，对begin到end闭区间内的数据执行dump操作。<br>该功能仅在执行模型数据dump操作，且dump_level为op时生效。<br>配置示例：<br>{<br>	"dump":{<br>		"dump_list":[<br>			{<br>				"model_name":"ResNet-50",<br>				"opname_range":[{"begin":"conv1", "end":"relu1" }, {"begin":"conv2", "end":"pool1"}]<br>			}<br>		],<br>		"dump_mode":"output",<br>   "dump_level": "op",<br>   "dump_path":"/home/output"<br>	}<br>}<br>以上示例表示对conv1到relu1、conv2到pool1闭区间内的数据执行dump操作，conv1、relu1、conv2、pool1表示算子名称。<br>配置时需注意：<br><br>  - model_name不允许为空。<br>  - begin和end中的参数表示算子名称，支持指定为ATC模型转换后的算子名称。<br>  - begin和end不允许为空，且只能配置为非data算子；若begin和end范围内算子的输入涉及data算子，会同时对data算子信息执行dump操作。 |
| dump_path | （必选）dump数据文件存储到运行环境的目录，该目录需要提前创建且确保安装时配置的运行用户具有读写权限。<br>支持配置绝对路径或相对路径：<br>  - 绝对路径配置以“/”开头，例如：/home/output。<br>  - 相对路径配置直接以目录名开始，例如：output。 |
| dump_mode | dump数据模式。<br><br>  - input：dump算子的输入数据。<br>  - output：dump算子的输出数据，默认取值output。<br>  - all：dump算子的输入、输出数据。注意，配置为all时，由于部分算子在执行过程中会修改输入数据，例如集合通信类算子HcomAllGather、HcomAllReduce等，因此系统在进行dump时，会在算子执行前dump算子输入，在算子执行后dump算子输出，这样，针对同一个算子，算子输入、输出的dump数据是分开落盘，会出现多个dump文件，在解析dump文件后，用户可通过文件内容判断是输入还是输出。 |
| dump_level | dump数据级别，取值：<br><br>  - op：按算子级别dump数据。<br>  - kernel：按kernel级别dump数据。<br>  - all：默认值，op和kernel级别的数据都dump。<br><br>默认配置下，dump数据文件会比较多，例如有一些aclnn开头的dump文件，若用户对dump性能有要求或内存资源有限时，则可以将该参数设置为op级别，以便提升dump性能、精简dump数据文件数量。<br>说明：算子是一个运算逻辑的表示（如加减乘除运算），kernel是运算逻辑真正进行计算处理的实现，需要分配具体的计算设备完成计算。 |
| dump_op_switch | 单算子调用场景（包括单算子模型执行和单算子API执行）下，是否开启dump数据采集。<br><br>  - on：开启。<br>  - off：关闭，默认取值off。 |
| dump_step | 指定采集哪些迭代的dump数据。推理场景无需配置。<br>不配置该参数，默认所有迭代都会产生dump数据，数据量比较大，建议按需指定迭代。<br>多个迭代用“|”分割，例如：0|5|10；也可以用“-”指定迭代范围，例如：0|3-5|10。<br>配置示例：<br>{<br>	"dump":{<br>		"dump_list":[   <br>			...... <br>		],  <br>		"dump_path":"/home/output",<br>   "dump_mode":"output",<br>		"dump_op_switch":"off",<br>   "dump_step": "0|3-5|10"<br>	}  <br>}<br>训练场景下，若通过acl.json中的dump_step参数指定采集哪些迭代的dump数据，又同时在GEInitialize接口中配置了ge.exec.dumpStep参数（该参数也用于指定采集哪些迭代的dump数据），则以最后配置的参数为准。GEInitialize接口的详细介绍请参见《图模式开发指南》。 |
| dump_data | 算子dump内容类型，取值：<br><br>  - tensor: dump算子数据，默认为tensor。<br>  - stats: dump算子统计数据，结果文件为csv格式，文件中包含算子名称、输入/输出的数据类型、最大值、最小值等。<br><br>通常dump数据量太大并且耗时长，可以先对算子统计数据进行dump，根据统计数据识别可能异常的算子，然后再dump算子数据。 |
| dump_stats | 仅Atlas A2 训练系列产品/Atlas A2 推理系列产品支持该参数，当dump_data=stats时，可通过本参数设置收集统计数据中的哪一类数据，本参数取值如下（若不指定取值，默认采集Max、Min、Avg、Nan、Negative Inf、Positive Inf数据）：<br><br>  - Max：dump算子统计数据中的最大值。<br>  - Min：dump算子统计数据中的最小值。<br>  - Avg：dump算子统计数据中的平均值。<br>  - Nan：dump算子统计数据中未定义或不可表示的数值，仅针对浮点类型half、bfloat、float。<br>  - Negative Inf：dump算子统计数据中的负无穷值，仅针对浮点类型half、bfloat、float。<br>  - Positive Inf：dump算子统计数据中的正无穷值，仅针对浮点类型half、bfloat、float。<br>  - L2norm：dump算子统计数据的L2Norm值。<br><br>配置示例：<br>{<br>   "dump":{<br>	"dump_list":[   <br>		...... <br>	],  <br>   "dump_path":"/home/output",<br>   "dump_mode":"output",<br>   "dump_data":"stats",<br>   "dump_stats":["Max", "Min"]<br>   }<br>} |

## 配置文件示例（异常算子Dump配置）

**异常算子Dump配置**（用于导出异常算子的输入输出数据、workspace信息、Tiling信息），导出的数据用于分析AI Core Error问题。默认不启用该Dump配置

通过配置dump\_scene参数值开启异常算子Dump功能，配置文件中的示例内容如下，表示开启轻量化的exception dump：

```
{
    "dump":{
        "dump_path":"output",
        "dump_scene":"aic_err_brief_dump"
    }
}
```

详细配置说明及约束如下：

-   dump\_scene参数支持如下取值：
    -   aic\_err\_brief\_dump：表示轻量化exception dump，用于导出AI Core错误算子的输入&输出、workspace数据。
    -   aic\_err\_norm\_dump：表示普通exception dump，在轻量化exception dump基础上，还会导出Shape、Data Type、Format以及属性信息。
    -   aic\_err\_detail\_dump：在轻量化exception dump基础上，还会导出AI Core的内部存储、寄存器以及调用栈信息。

        配置该选项时，有以下注意事项：

        -   该选项仅支持以下型号，且需配套25.0.RC1或更高版本的驱动才可以使用：

            Atlas A2 训练系列产品/Atlas A2 推理系列产品

            Atlas A3 训练系列产品/Atlas A3 推理系列产品

            您可以单击[Link](https://www.hiascend.com/hardware/firmware-drivers/commercial)，在“固件与驱动”页面下载Ascend HDK  25.0.RC1或更高版本的驱动安装包，并参考相应版本的文档进行安装、升级。

        -   若设置aic\_err\_detail\_dump选项，则需在[aclrtSetDevice](aclrtSetDevice.md)接口之前调用本接口，且通过[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口无法实现Dump去初始化。
        -   导出dump文件过程中，会暂停问题算子所在的AI Core，因此可能会影响Device上其它业务进程的正常执行，导出dump文件后，会自行恢复AI Core。
        -   导出dump文件后，会强制退出Host侧用户业务进程，强制退出过程中的报错可不作为AI Core问题分析的输入。
        -   如果多个Host侧用户业务进程指定同一个Device、且都配置了aic\_err\_detail\_dump选项，则先执行的进程按aic\_err\_detail\_dump选项导出dump文件，后执行的进程按照aic\_err\_brief\_dump选项导出dump文件。

    -   lite\_exception：表示轻量化exception dump，为了兼容旧版本，效果等同于aic\_err\_brief\_dump。

-   dump\_path是可选参数，表示导出dump文件的存储路径。

    dump文件存储路径的优先级如下：NPU\_COLLECT\_PATH环境变量 \> ASCEND\_WORK\_PATH环境变量 \> 配置文件中的dump\_path \> 应用程序的当前执行目录

    环境变量的详细描述请参见《环境变量参考》。

-   若需查看导出的dump文件内容，先将dump文件转换为numpy格式文件后，再通过Python查看numpy格式文件，详细转换步骤请参见《精度调试工具用户指南》。

    若将dump\_scene参数设置为aic\_err\_detail\_dump时，需使用msDebug工具查看导出的dump文件内容，详细方法请参见《算子开发工具用户指南》。

-   异常算子Dump配置，不能与模型Dump配置或单算子Dump配置同时开启。

## 溢出算子Dump配置

**溢出算子Dump配置**（用于导出模型中溢出算子的输入和输出数据），导出的数据用于分析溢出原因，定位模型精度的问题。**默认不启用该Dump配置。**

将dump\_debug参数设置为on表示开启溢出算子配置，配置文件中的示例内容如下：

```
{
    "dump":{
        "dump_path":"output",
        "dump_debug":"on"
    }
}
```

详细配置说明及约束如下：

-   不配置dump\_debug或将dump\_debug配置为off表示不开启溢出算子配置。
-   若开启溢出算子配置，则dump\_path必须配置，表示导出dump文件的存储路径。

    获取导出的数据文件后，文件的解析请参见《精度调试工具用户指南》。

    dump\_path支持配置绝对路径或相对路径：

    -   绝对路径配置以“/“开头，例如：/home。
    -   相对路径配置直接以目录名开始，例如：output。

-   溢出算子Dump配置，不能与模型Dump配置或单算子Dump配置同时开启，否则会返回报错。
-   仅支持采集AI Core算子的溢出数据。

## 算子Dump Watch模式配置

**算子Dump Watch模式配置**（用于开启指定算子输出数据的观察模式），在定位部分算子精度问题且已排除算子本身的计算问题后，若怀疑被其它算子踩踏内存导致精度问题，可开启Dump Watch模式。**默认不开启Dump Watch模式。**

将dump\_scene参数设置为watcher，开启算子Dump Watch模式，配置文件中的示例内容如下，配置效果为：（1）当执行完A算子、B算子时，会把C算子和D算子的输出Dump出来；（2）当执行完C算子、D算子时，也会把C算子和D算子的输出Dump出来。将（1）、（2）中的C算子、D算子的Dump文件进行比较，用于排查A算子、B算子是否会踩踏C算子、D算子的输出内存。

```
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

-   若开启算子Dump Watch模式，则不支持同时开启溢出算子Dump（配置dump\_debug参数）或开启单算子模型Dump（配置dump\_op\_switch参数），否则报错。该模式在单算子API Dump场景下不生效。
-   在dump\_list中，通过layer参数配置可能踩踏其它算子内存的算子名称，通过watcher\_nodes参数配置可能被其它算子踩踏输出内存导致精度有问题的算子名称。
    -   若不指定layer，则模型内所有支持Dump的算子在执行后，都会将watcher\_nodes中配置的算子的输出Dump出来。
    -   layer和watcher\_nodes处配置的算子都必须是静态图、静态子图中的算子，否则不生效。
    -   若layer和watcher\_nodes处配置的算子名称相同，或者layer处配置的是集合通信类算子（算子类型以Hcom开头，例如HcomAllReduce），则只导出watcher\_nodes中所配置算子的dump文件。
    -   对于融合算子，watcher\_nodes处配置的算子名称必须是融合后的算子名称，若配置融合前的算子名称，则不导出dump文件。
    -   dump\_list内暂不支持配置model\_name。

-   开启算子Dump Watch模式，则dump\_path必须配置，表示导出dump文件的存储路径。

    此处收集的dump文件无法通过文本工具直接查看其内容，若需查看dump文件内容，先将dump文件转换为numpy格式文件后，再通过Python查看numpy格式文件，详细转换步骤请参见《精度调试工具用户指南》。

    dump\_path支持配置绝对路径或相对路径：

    -   绝对路径配置以“/“开头，例如：/home。
    -   相对路径配置直接以目录名开始，例如：output。

-   通过dump\_mode参数控制导出watcher\_nodes中所配置算子的哪部分数据，当前仅支持配置为output。

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   只有在调用本接口开启Dump之后加载模型，配置的Dump信息有效。在调用本接口之前已经加载的模型不受影响，除非用户在调用本接口后重新加载该模型。

    例如以下接口调用顺序中，加载的模型1不受影响，配置的Dump信息仅对加载的模型2有效：

    [aclmdlInitDump](aclmdlInitDump.md)接口--\>模型1加载--\>aclmdlSetDump接口--\>模型2加载--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口

-   多次调用本接口对同一个模型配置了Dump信息，系统内处理时会采用覆盖策略。

    例如以下接口调用顺序中，第二次调用本接口配置的Dump信息会覆盖第一次配置的Dump信息：

    [aclmdlInitDump](aclmdlInitDump.md)接口--\>aclmdlSetDump接口--\>aclmdlSetDump接口--\>模型1加载--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口

## 参考资源

当前还提供了[aclInit](aclInit.md)接口，在初始化阶段，通过\*.json文件传入Dump配置信息，运行应用后获取Dump数据的方式。该种方式，一个进程内，只能调用一次[aclInit](aclInit.md)接口，如果要修改Dump配置信息，需修改\*.json文件中的配置。

