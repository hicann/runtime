# aclrtLaunchKernelWithHostArgs

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

指定任务下发的配置信息，并启动对应算子的计算任务。异步接口。

## 函数原型

```
aclError aclrtLaunchKernelWithHostArgs(aclrtFuncHandle funcHandle, uint32_t numBlocks, aclrtStream stream, aclrtLaunchKernelCfg *cfg, void *hostArgs, size_t argsSize, aclrtPlaceHolderInfo *placeHolderArray, size_t placeHolderNum)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| funcHandle | 输入 | 核函数句柄。 |
| numBlocks | 输入 | 指定核函数将会在几个核上执行。 |
| stream | 输入 | 指定执行任务的Stream。 |
| cfg | 输入 | 任务下发的配置信息。<br>不指定配置时，此处可传NULL。 |
| hostArgs | 输入 | 存放核函数所有入参数据的Host内存地址指针。 |
| argsSize | 输入 | hostArgs参数值的大小，单位为Byte。 |
| placeHolderArray | 输入 | placeholder参数数组。<br>aclrtPlaceHolderInfo定义如下：<br>typedef struct {<br>   uint32_t addrOffset;<br>   uint32_t dataOffset;<br>} aclrtPlaceHolderInfo;<br>成员变量说明如下：<br><br>  - addrOffset：placeholder指向的数据区拷贝到Device后，其真实Device内存地址在launch时需要刷新到hostArgs中，该参数用于指定需刷新的位置偏移<br>  - dataOffset：placeholder指向的数据区需拷贝到Device侧，该参数用于指定数据区基于hostArgs的地址偏移 |
| placeHolderNum | 输入 | placeholder参数数组的大小。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 参考资源

下表的几个接口都用于启用对应算子的计算任务，但功能和使用方式有所不同：


| 接口 | 核函数参数值的传入方式 | 核函数参数值的存放位置 | 是否可指定任务下发的配置信息 |
| --- | --- | --- | --- |
| [aclrtLaunchKernel](aclrtLaunchKernel.md) | 在接口中指定存放核函数所有入参数据的Device内存地址指针 | Device内存 | 否 |
| [aclrtLaunchKernelV2](aclrtLaunchKernelV2.md) | 在接口中指定存放核函数所有入参数据的Device内存地址指针 | Device内存 | 是 |
| [aclrtLaunchKernelWithConfig](aclrtLaunchKernelWithConfig.md) | 在接口中指定参数列表句柄aclrtArgsHandle | Host内存 | 是 |
| [aclrtLaunchKernelWithHostArgs](aclrtLaunchKernelWithHostArgs.md) | 在接口中指定存放核函数所有入参数据的Host内存地址指针 | Host内存 | 是 |

