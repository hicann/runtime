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

# aclmdlInitDump

```c
aclError aclmdlInitDump()
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

Dump初始化。

本接口需与其它接口配合使用实现以下功能：

-   **Dump数据落盘到文件**

    [aclmdlInitDump](#aclmdlInitDump)接口、[aclmdlSetDump](#aclmdlSetDump)接口、[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口配合使用，用于将Dump数据记录到文件中。一个进程内，可以根据需求多次调用这些接口，基于不同的Dump配置信息，获取Dump数据。场景举例如下：

    -   执行两个不同的模型，需要设置不同的Dump配置信息，接口调用顺序：[aclInit](02_初始化与去初始化.md#aclInit)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[aclmdlSetDump](#aclmdlSetDump)接口--\>模型1加载--\>模型1执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型1卸载--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[aclmdlSetDump](#aclmdlSetDump)接口--\>模型2加载--\>模型2执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型2卸载--\>执行其它任务--\>[aclFinalize](02_初始化与去初始化.md#aclFinalize)接口
    -   同一个模型执行两次，第一次需要Dump，第二次无需Dump，接口调用顺序：[aclInit](02_初始化与去初始化.md#aclInit)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[aclmdlSetDump](#aclmdlSetDump)接口--\>模型加载--\>模型执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型卸载--\>模型加载--\>模型执行--\>执行其它任务--\>[aclFinalize](02_初始化与去初始化.md#aclFinalize)接口

-   **Dump数据不落盘到文件，直接通过回调函数获取**

    [aclmdlInitDump](#aclmdlInitDump)接口、[acldumpRegCallback](#acldumpRegCallback)接口（通过该接口注册的回调函数需由用户自行实现，回调函数实现逻辑中包括获取Dump数据及数据长度）、[acldumpUnregCallback](#acldumpUnregCallback)接口、[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口配合使用，用于通过回调函数获取Dump数据。场景举例如下：

    -   执行一个模型，通过回调获取Dump数据：

        [aclInit](02_初始化与去初始化.md#aclInit)接口--\>[acldumpRegCallback](#acldumpRegCallback)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>模型加载--\>模型执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>[acldumpUnregCallback](#acldumpUnregCallback)接口--\>模型卸载--\>[aclFinalize](02_初始化与去初始化.md#aclFinalize)接口

    -   执行两个不同的模型，通过回调获取Dump数据，该场景下，只要不调用[acldumpUnregCallback](#acldumpUnregCallback)接口取消注册回调函数，则可通过回调函数获取两个模型的Dump数据：

        [aclInit](02_初始化与去初始化.md#aclInit)接口--\>[acldumpRegCallback](#acldumpRegCallback)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>模型1加载--\>模型1执行--\>--\>模型2加载--\>模型2执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型卸载--\>[acldumpUnregCallback](#acldumpUnregCallback)接口--\>[aclFinalize](02_初始化与去初始化.md#aclFinalize)接口

### 参数说明

无

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

-   对于模型Dump配置、单算子Dump配置、溢出算子Dump配置，如果已经通过[aclInit](02_初始化与去初始化.md#aclInit)接口配置了dump信息，则调用aclmdlInitDump接口时会返回失败。
-   必须在调用[aclInit](02_初始化与去初始化.md#aclInit)接口之后、模型加载接口之前调用aclmdlInitDump接口。

### 参考资源

当前还提供了[aclInit](02_初始化与去初始化.md#aclInit)接口，在初始化阶段，通过\*.json文件传入Dump配置信息，运行应用后获取Dump数据的方式。该种方式，一个进程内，只能调用一次[aclInit](02_初始化与去初始化.md#aclInit)接口，如果要修改Dump配置信息，需修改\*.json文件中的配置。


<br>
<br>
<br>



<a id="aclmdlSetDump"></a>

# aclmdlSetDump

```c
aclError aclmdlSetDump(const char *dumpCfgPath)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

设置Dump参数。

[aclmdlInitDump](#aclmdlInitDump)接口、[aclmdlSetDump](#aclmdlSetDump)接口、[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口配合使用，用于将Dump数据记录到文件中。一个进程内，可以根据需求多次调用这些接口，基于不同的Dump配置信息，获取Dump数据。场景举例如下：

-   执行两个不同的模型，需要设置不同的Dump配置信息，接口调用顺序：[aclInit](02_初始化与去初始化.md#aclInit)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[aclmdlSetDump](#aclmdlSetDump)接口--\>模型1加载--\>模型1执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型1卸载--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[aclmdlSetDump](#aclmdlSetDump)接口--\>模型2加载--\>模型2执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型2卸载--\>执行其它任务--\>[aclFinalize](02_初始化与去初始化.md#aclFinalize)接口
-   同一个模型执行两次，第一次需要Dump，第二次无需Dump，接口调用顺序：[aclInit](02_初始化与去初始化.md#aclInit)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[aclmdlSetDump](#aclmdlSetDump)接口--\>模型加载--\>模型执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型卸载--\>模型加载--\>模型执行--\>执行其它任务--\>[aclFinalize](02_初始化与去初始化.md#aclFinalize)接口

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dumpCfgPath | 输入 | 配置文件路径的指针，包含文件名。配置文件格式为json格式。<br>可通过该配置文件配置开启或配置各类Dump信息，详细描述请参见下文各功能配置示例中的描述。如果算子输入或输出中包含用户的敏感信息，则存在信息泄露风险。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

-   只有在调用本接口开启Dump之后加载模型，配置的Dump信息有效。在调用本接口之前已经加载的模型不受影响，除非用户在调用本接口后重新加载该模型。

    例如以下接口调用顺序中，加载的模型1不受影响，配置的Dump信息仅对加载的模型2有效：

    [aclmdlInitDump](#aclmdlInitDump)接口--\>模型1加载--\>aclmdlSetDump接口--\>模型2加载--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口

-   多次调用本接口对同一个模型配置了Dump信息，系统内处理时会采用覆盖策略。

    例如以下接口调用顺序中，第二次调用本接口配置的Dump信息会覆盖第一次配置的Dump信息：

    [aclmdlInitDump](#aclmdlInitDump)接口--\>aclmdlSetDump接口--\>aclmdlSetDump接口--\>模型1加载--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口

### 模型Dump配置、单算子Dump配置

**模型Dump配置**（用于导出模型中每一层算子输入和输出数据）、**单算子Dump配置**（用于导出单个算子的输入和输出数据），导出的数据用于与指定模型或算子进行比对，定位精度问题，具体比对方法请参见《精度调试工具用户指南》。**默认不启用该Dump配置。**

通过本接口启用Dump配置，需通过dump\_path参数配置保存Dump数据的路径。

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
| dump_step | 指定采集哪些迭代的dump数据。推理场景无需配置。<br>不配置该参数，默认所有迭代都会产生dump数据，数据量比较大，建议按需指定迭代。<br>多个迭代用“|”分割，例如：0|5|10；也可以用“-”指定迭代范围，例如：0|3-5|10。<br>配置示例：<br>{<br>	"dump":{<br>		"dump_list":[   <br>			...... <br>		],  <br>		"dump_path":"/home/output",<br>   "dump_mode":"output",<br>		"dump_op_switch":"off",<br>   "dump_step": "0|3-5|10"<br>	}  <br>}<br>训练场景下，若通过acl.json中的dump_step参数指定采集哪些迭代的dump数据，又同时在GEInitialize接口中配置了ge.exec.dumpStep参数（该参数也用于指定采集哪些迭代的dump数据），则以最后配置的参数为准。GEInitialize接口的详细介绍请参见《图开发指南》。 |
| dump_data | 算子dump内容类型，取值：<br><br>  - tensor: dump算子数据，默认为tensor。<br>  - stats: dump算子统计数据，结果文件为csv格式，文件中包含算子名称、输入/输出的数据类型、最大值、最小值等。<br><br>通常dump数据量太大并且耗时长，可以先对算子统计数据进行dump，根据统计数据识别可能异常的算子，然后再dump算子数据。 |
| dump_stats | 当dump_data=stats时，可通过本参数设置收集统计数据中的哪一类数据。<br>仅Atlas A2 训练系列产品/Atlas A2 推理系列产品支持该参数。<br>本参数取值如下（若不指定取值，默认采集Max、Min、Avg、Nan、Negative Inf、Positive Inf数据）：<br><br>  - Max：dump算子统计数据中的最大值。<br>  - Min：dump算子统计数据中的最小值。<br>  - Avg：dump算子统计数据中的平均值。<br>  - Nan：dump算子统计数据中未定义或不可表示的数值，仅针对浮点类型half、bfloat、float。<br>  - Negative Inf：dump算子统计数据中的负无穷值，仅针对浮点类型half、bfloat、float。<br>  - Positive Inf：dump算子统计数据中的正无穷值，仅针对浮点类型half、bfloat、float。<br>  - L2norm：dump算子统计数据的L2Norm值。<br><br>配置示例：<br>{<br>   "dump":{<br>	"dump_list":[   <br>		...... <br>	],  <br>   "dump_path":"/home/output",<br>   "dump_mode":"output",<br>   "dump_data":"stats",<br>   "dump_stats":["Max", "Min"]<br>   }<br>} |

### 配置文件示例（异常算子Dump配置）

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

        -   若设置aic\_err\_detail\_dump选项，则需在[aclrtSetDevice](04_Device管理.md#aclrtSetDevice)接口之前调用本接口，且通过[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口无法实现Dump去初始化。
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

### 溢出算子Dump配置

**溢出算子Dump配置**，用于导出模型中溢出算子的输入和输出数据。导出的数据用于分析溢出原因，定位模型精度的问题。**默认不启用该Dump配置。**

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

### 算子Dump Watch模式配置

**算子Dump Watch模式配置**，用于开启指定算子输出数据的观察模式。在定位部分算子精度问题且已排除算子本身的计算问题后，若怀疑被其它算子踩踏内存导致精度问题，可开启Dump Watch模式。**默认不开启Dump Watch模式。**

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

### 算子Kernel调测信息Dump配置

**算子Kernel调测信息Dump配置**，用于导出Ascend C算子Kernel的调测信息，便于定位算子问题。**默认不启用该Dump配置。**

仅如下型号支持该配置：

Ascend 950PR/Ascend 950DT

Atlas A3 训练系列产品/Atlas A3 推理系列产品

Atlas A2 训练系列产品/Atlas A2 推理系列产品

配置dump\_kernel\_data参数开启算子Kernel调测信息Dump功能，配置文件中的示例如下：

```
{
    "dump":{
        "dump_kernel_data":"printf,assert",
        "dump_path":"/home/"
    }
}
```

详细配置说明及约束如下：

-   dump\_kernel\_data：指定导出数据的类型，支持配置多个类型，用英文逗号隔开。如果未配置该字段，但启用了模型Dump配置、单算子Dump配置，则默认按all导出调测信息。

    当前支持如下类型：

    -   all：导出以下所有类型调测的输出数据。
    -   printf：导出通过AscendC::printf调测的输出数据。
    -   tensor：导出通过AscendC::DumpTensor调测的输出数据。
    -   assert：导出通过assert/ascendc\_assert调测的输出数据。
    -   timestamp：导出通过AscendC::PrintTimeStamp调测的输出数据。

-   dump\_path：启用算子Kernel调测信息Dump功能时，dump\_path必须配置，表示导出Dump文件的存储路径，支持配置绝对路径或相对路径。

    Dump文件存储路径的优先级如下：ASCEND\_DUMP\_PATH环境变量 \> ASCEND\_WORK\_PATH环境变量 \> 配置文件中的dump\_path，环境变量的详细描述请参见《环境变量参考》。

    导出的Dump文件无法通过文本工具直接查看其内容，若需查看，需使用show\_kernel\_debug\_data工具将调测信息解析为可读格式，工具使用指导请参见《Ascend C算子开发指南》中的”。

### 参考资源

当前还提供了[aclInit](02_初始化与去初始化.md#aclInit)接口，在初始化阶段，通过\*.json文件传入Dump配置信息，运行应用后获取Dump数据的方式。该种方式，一个进程内，只能调用一次[aclInit](02_初始化与去初始化.md#aclInit)接口，如果要修改Dump配置信息，需修改\*.json文件中的配置。


<br>
<br>
<br>



<a id="acldumpRegCallback"></a>

# acldumpRegCallback

```c
aclError acldumpRegCallback(int32_t (* const messageCallback)(const acldumpChunk *, int32_t len), int32_t flag)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

Dump数据回调函数注册接口。

[aclmdlInitDump](#aclmdlInitDump)接口、[acldumpRegCallback](#acldumpRegCallback)接口（通过该接口注册的回调函数需由用户自行实现，回调函数实现逻辑中包括获取Dump数据及数据长度）、[acldumpUnregCallback](#acldumpUnregCallback)接口、[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口配合使用，用于通过回调函数获取Dump数据。**场景举例如下：**

-   **执行一个模型，通过回调获取Dump数据：**

    支持以下两种方式：

    -   在aclInit接口处**不启用**模型Dump配置、单算子Dump配置

        [aclInit](02_初始化与去初始化.md#aclInit)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[acldumpRegCallback](#acldumpRegCallback)接口--\>模型加载--\>模型执行--\>[acldumpUnregCallback](#acldumpUnregCallback)接口--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型卸载--\>[aclFinalize](02_初始化与去初始化.md#aclFinalize)接口

    -   在aclInit接口处**启用**模型Dump配置、单算子Dump配置，在aclInit接口处启用Dump配置时需配置落盘路径，但如果调用了[acldumpRegCallback](#acldumpRegCallback)接口，则落盘不生效，以回调函数获取的Dump数据为准

        [aclInit](02_初始化与去初始化.md#aclInit)接口--\>[acldumpRegCallback](#acldumpRegCallback)接口--\>模型加载--\>模型执行--\>[acldumpUnregCallback](#acldumpUnregCallback)接口--\>模型卸载--\>[aclFinalize](02_初始化与去初始化.md#aclFinalize)接口

-   **执行两个不同的模型，通过回调获取Dump数据**，该场景下，只要不调用[acldumpUnregCallback](#acldumpUnregCallback)接口取消注册回调函数，则可通过回调函数获取两个模型的Dump数据：

    [aclInit](02_初始化与去初始化.md#aclInit)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[acldumpRegCallback](#acldumpRegCallback)接口--\>模型1加载--\>模型1执行--\>--\>模型2加载--\>模型2执行--\>[acldumpUnregCallback](#acldumpUnregCallback)接口--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型卸载--\>[aclFinalize](02_初始化与去初始化.md#aclFinalize)接口

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| messageCallback | 输入 | 回调函数指针，用于接收回调数据的回调。<br><br>  - acldumpChunk结构体的定义如下，在实现messageCallback回调函数时可以获取acldumpChunk结构体中的dataBuf、bufLen等参数值，用于获取Dump数据及其数据长度：typedef struct acldumpChunk  {<br>   char  fileName[ACL_DUMP_MAX_FILE_PATH_LENGTH];  // 待落盘的Dump数据文件名，ACL_DUMP_MAX_FILE_PATH_LENGTH表示文件名最大长度，当前为4096<br>   uint32_t  bufLen;  // dataBuf数据长度，单位Byte<br>   uint32_t  isLastChunk;  // 标识Dump数据是否为最后一个分片，0表示不是最后一个分片，1表示最后一个分片<br>   int64_t  offset;  // Dump数据文件内容的偏移，其中-1表示文件追加内容<br>   int32_t  flag;  // 预留Dump数据标识，当前数据无标识<br>   uint8_t  dataBuf[0];  // Dump数据的内存地址<br>} acldumpChunk;<br>  - len：表示acldumpChunk结构体的长度，单位Byte。 |
| flag | 输入 | 在调用回调接口后是否还落盘dump数据：<br><br>  - 0：不落盘，当前仅支持0 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="acldumpUnregCallback"></a>

# acldumpUnregCallback

```c
void acldumpUnregCallback()
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

Dump数据回调函数取消注册接口。acldumpUnregCallback需要和acldumpRegCallback配合使用，且必须在acldumpRegCallback调用后才有效。

[aclmdlInitDump](#aclmdlInitDump)接口、[acldumpRegCallback](#acldumpRegCallback)接口（通过该接口注册的回调函数需由用户自行实现，回调函数实现逻辑中包括获取Dump数据及数据长度）、[acldumpUnregCallback](#acldumpUnregCallback)接口、[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口配合使用，用于通过回调函数获取Dump数据。场景举例如下：

-   执行一个模型，通过回调获取Dump数据：

    [aclInit](02_初始化与去初始化.md#aclInit)接口--\>[acldumpRegCallback](#acldumpRegCallback)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>模型加载--\>模型执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>[acldumpUnregCallback](#acldumpUnregCallback)接口--\>模型卸载--\>[aclFinalize](02_初始化与去初始化.md#aclFinalize)接口

-   执行两个不同的模型，通过回调获取Dump数据，该场景下，只要不调用[acldumpUnregCallback](#acldumpUnregCallback)接口取消注册回调函数，则可通过回调函数获取两个模型的Dump数据：

    [aclInit](02_初始化与去初始化.md#aclInit)接口--\>[acldumpRegCallback](#acldumpRegCallback)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>模型1加载--\>模型1执行--\>--\>模型2加载--\>模型2执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型卸载--\>[acldumpUnregCallback](#acldumpUnregCallback)接口--\>[aclFinalize](02_初始化与去初始化.md#aclFinalize)接口

### 参数说明

无

### 返回值说明

无


<br>
<br>
<br>



<a id="acldumpGetPath"></a>

# acldumpGetPath

```c
const char* acldumpGetPath(acldumpType dumpType)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取Dump数据存放路径，以便用户将自定维测数据保存到该路径下。

在调用本接口前，需通过[aclmdlInitDump](#aclmdlInitDump)接口初始化Dump功能、通过[aclmdlSetDump](#aclmdlSetDump)接口配置Dump信息，或者直接通过[aclInit](02_初始化与去初始化.md#aclInit)接口配置Dump信息。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dumpType | 输入 | Dump类型。类型定义请参见[acldumpType](25_数据类型及其操作接口.md#acldumpType)。 |

### 返回值说明

返回Dump数据的路径。如果返回空指针，则表示未查询到Dump路径。


<br>
<br>
<br>



<a id="aclmdlFinalizeDump"></a>

# aclmdlFinalizeDump

```c
aclError aclmdlFinalizeDump()
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

Dump去初始化。

本接口需与其它接口配合使用实现以下功能：

-   **Dump数据落盘到文件**

    [aclmdlInitDump](#aclmdlInitDump)接口、[aclmdlSetDump](#aclmdlSetDump)接口、[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口配合使用，用于将Dump数据记录到文件中。一个进程内，可以根据需求多次调用这些接口，基于不同的Dump配置信息，获取Dump数据。场景举例如下：

    -   执行两个不同的模型，需要设置不同的Dump配置信息，接口调用顺序：[aclInit](02_初始化与去初始化.md#aclInit)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[aclmdlSetDump](#aclmdlSetDump)接口--\>模型1加载--\>模型1执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型1卸载--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[aclmdlSetDump](#aclmdlSetDump)接口--\>模型2加载--\>模型2执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型2卸载--\>执行其它任务--\>[aclFinalize](02_初始化与去初始化.md#aclFinalize)接口
    -   同一个模型执行两次，第一次需要Dump，第二次无需Dump，接口调用顺序：[aclInit](02_初始化与去初始化.md#aclInit)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>[aclmdlSetDump](#aclmdlSetDump)接口--\>模型加载--\>模型执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型卸载--\>模型加载--\>模型执行--\>执行其它任务--\>[aclFinalize](02_初始化与去初始化.md#aclFinalize)接口

-   **Dump数据不落盘到文件，直接通过回调函数获取**

    [aclmdlInitDump](#aclmdlInitDump)接口、[acldumpRegCallback](#acldumpRegCallback)接口（通过该接口注册的回调函数需由用户自行实现，回调函数实现逻辑中包括获取Dump数据及数据长度）、[acldumpUnregCallback](#acldumpUnregCallback)接口、[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口配合使用，用于通过回调函数获取Dump数据。场景举例如下：

    -   执行一个模型，通过回调获取Dump数据：

        [aclInit](02_初始化与去初始化.md#aclInit)接口--\>[acldumpRegCallback](#acldumpRegCallback)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>模型加载--\>模型执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>[acldumpUnregCallback](#acldumpUnregCallback)接口--\>模型卸载--\>[aclFinalize](02_初始化与去初始化.md#aclFinalize)接口

    -   执行两个不同的模型，通过回调获取Dump数据，该场景下，只要不调用[acldumpUnregCallback](#acldumpUnregCallback)接口取消注册回调函数，则可通过回调函数获取两个模型的Dump数据：

        [aclInit](02_初始化与去初始化.md#aclInit)接口--\>[acldumpRegCallback](#acldumpRegCallback)接口--\>[aclmdlInitDump](#aclmdlInitDump)接口--\>模型1加载--\>模型1执行--\>--\>模型2加载--\>模型2执行--\>[aclmdlFinalizeDump](#aclmdlFinalizeDump)接口--\>模型卸载--\>[acldumpUnregCallback](#acldumpUnregCallback)接口--\>[aclFinalize](02_初始化与去初始化.md#aclFinalize)接口

### 参数说明

无

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 参考资源

当前还提供了[aclInit](02_初始化与去初始化.md#aclInit)接口，在初始化阶段，通过\*.json文件传入Dump配置信息，运行应用后获取Dump数据的方式。该种方式，一个进程内，只能调用一次[aclInit](02_初始化与去初始化.md#aclInit)接口，如果要修改Dump配置信息，需修改\*.json文件中的配置。


<br>
<br>
<br>



<a id="aclopStartDumpArgs"></a>

# aclopStartDumpArgs

```c
aclError aclopStartDumpArgs(uint32_t dumpType, const char *path)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

调用本接口开启算子信息统计功能，并需与[aclopStopDumpArgs](#aclopStopDumpArgs)接口配合使用，将算子信息文件输出到path参数指定的目录，一个shape对应一个算子信息文件，文件中包含算子类型、算子属性、算子输入&输出的format/数据类型/shape等信息。

**使用场景：**例如要统计某个模型执行涉及哪些算子，可在模型执行之前调用aclopStartDumpArgs接口，在模型执行之后调用aclopStopDumpArgs接口，接口调用成功后，在path参数指定的目录下生成每个算子shape的算子信息文件。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dumpType | 输入 | 指定dump信息的类型。<br>当前仅支持ACL_OP_DUMP_OP_AICORE_ARGS，表示统计所有算子信息。<br>#define ACL_OP_DUMP_OP_AICORE_ARGS 0x00000001U |
| path | 输入 | 指定dump文件的保存路径，支持绝对路径或相对路径（指相对应用可执行文件所在的目录），但用户需确保路径存在或者该路径可以被创建。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

仅支持在单算子API执行（例如，接口名前缀为aclnn的接口）场景下使用本接口，否则无法生成dump文件。


<br>
<br>
<br>



<a id="aclopStopDumpArgs"></a>

# aclopStopDumpArgs

```c
aclError aclopStopDumpArgs(uint32_t dumpType)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

调用本接口关闭算子信息统计功能，并需与[aclopStartDumpArgs](#aclopStartDumpArgs)接口配合使用，将算子信息文件输出到path参数指定的目录，一个shape对应一个算子信息文件，文件中包含算子类型、算子属性、算子输入&输出的format/数据类型/shape等信息。

**使用场景：**例如要统计某个模型执行涉及哪些算子，可在模型执行之前调用aclopStartDumpArgs接口，在模型执行之后调用aclopStopDumpArgs接口，接口调用成功后，在path参数指定的目录下生成每个算子shape的算子信息文件。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dumpType | 输入 | 指定dump信息的类型。<br>当前仅支持ACL_OP_DUMP_OP_AICORE_ARGS，表示统计所有算子信息。<br>#define ACL_OP_DUMP_OP_AICORE_ARGS 0x00000001U |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

仅支持在单算子API执行（例如，接口名前缀为aclnn的接口）场景下使用本接口，否则无法生成dump文件。
