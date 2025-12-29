# aclrtLaunchKernelWithConfig

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

指定任务下发的配置信息，并启动对应算子的计算任务。异步接口。

若使用本接口下发AI Core算子的计算任务，需配套使用[aclrtBinaryLoadFromFile](aclrtBinaryLoadFromFile.md)接口加载并解析算子二进制文件。

## 函数原型

```
aclError aclrtLaunchKernelWithConfig(aclrtFuncHandle funcHandle, uint32_t blockDim, aclrtStream stream, aclrtLaunchKernelCfg *cfg, aclrtArgsHandle argsHandle, void *reserve)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| funcHandle | 输入 | 核函数句柄。 |
| blockDim | 输入 | 指定核函数将会在几个核上执行。 |
| stream | 输入 | 指定执行任务的Stream。 |
| cfg | 输入 | 任务下发的配置信息。<br>不指定配置时，此处可传NULL。 |
| argsHandle | 输入 | 参数列表句柄。 |
| reserve | 输入 | 预留参数。当前固定传NULL。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 参考资源

下表的几个接口都用于启用对应算子的计算任务，但功能和使用方式有所不同：


| 接口 | 核函数参数值的传入方式 | 核函数参数值的存放位置 | 是否可指定任务下发的配置信息 |
| --- | --- | --- | --- |
| [aclrtLaunchKernel](aclrtLaunchKernel.md) | 在接口中指定存放核函数所有入参数据的Device内存地址指针 | Device内存 | 否 |
| [aclrtLaunchKernelWithConfig](aclrtLaunchKernelWithConfig.md) | 在接口中指定参数列表句柄aclrtArgsHandle | Host内存 | 是 |

