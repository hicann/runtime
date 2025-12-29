# aclrtCacheLastTaskOpInfo

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

基于捕获方式构建模型运行实例场景下，把指定内存中的算子信息按照infoSize大小缓存到当前线程中最后下发的任务上。

## 函数原型

```
aclError aclrtCacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| infoPtr | 输入 | 缓存信息内存地址指针，此处是Host内存 |
| infoSize | 输入 | 缓存信息内存大小，取值范围：(0, 64K]，单位Byte。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 接口调用流程

本接口需与以下其它关键接口配合使用，以便控制后续采集性能数据时附带算子信息：

1.  调用[aclmdlRICaptureBegin](aclmdlRICaptureBegin.md)接口开始捕获任务。
2.  调用[aclrtSetStreamAttribute](aclrtSetStreamAttribute.md)接口开启算子信息缓存开关。
3.  下发算子执行任务，例如调用[aclrtLaunchKernelWithConfig](aclrtLaunchKernelWithConfig.md)接口。
4.  调用[aclrtGetStreamAttribute](aclrtGetStreamAttribute.md)接口获取算子信息缓存开关是否开启。

    只有在捕获状态下，且通过[aclrtSetStreamAttribute](aclrtSetStreamAttribute.md)接口开启了算子信息缓存开关，此处的[aclrtGetStreamAttribute](aclrtGetStreamAttribute.md)接口才能获取到算子信息缓存开关已开启的状态，后续才可以缓存算子信息。

5.  调用[aclrtCacheLastTaskOpInfo](aclrtCacheLastTaskOpInfo.md)接口缓存算子信息。
6.  再次调用[aclrtSetStreamAttribute](aclrtSetStreamAttribute.md)接口关闭算子信息缓存开关。
7.  调用[aclmdlRICaptureEnd](aclmdlRICaptureEnd.md)接口结束任务捕获。
8.  开启采集性能数据（参见[Profiling数据采集接口](Profiling数据采集接口.md)章节下的接口）后，调用[aclmdlRIExecuteAsync](aclmdlRIExecuteAsync.md)接口执行推理。

    在此过程中，采集的性能数据会附带算子信息。

9.  最后，调用[aclmdlRIDestroy](aclmdlRIDestroy.md)接口销毁模型运行实例时，算子缓存信息也会被一并释放。

