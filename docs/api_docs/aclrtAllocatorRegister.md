# aclrtAllocatorRegister

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

调用该接口注册用户提供的Allocator以及Allocator对应的回调函数，以便后续使用用户提供的Allocator。

## 函数原型

```
aclError aclrtAllocatorRegister(aclrtStream stream, aclrtAllocatorDesc allocatorDesc)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 该Allocator需要注册的Stream。<br>传入的stream参数值不能为NULL，否则返回报错。 |
| allocatorDesc | 输入 | Allocator描述符指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   当前仅支持在单算子模型执行、动态shape模型推理场景下使用本接口。

    单算子模型场景下，需在算子执行接口（例如：aclopExecuteV2、aclopCompileAndExecuteV2等）之前调用本接口。

    动态shape模型推理场景，本接口需配合aclmdlExecuteAsync接口一起使用，且需在aclmdlExecuteAsync接口之前调用本接口。

-   调用本接口前，需要先调用[aclrtAllocatorCreateDesc](aclrtAllocatorCreateDesc.md)创建Allocator描述符，再分别调用[aclrtAllocatorSetObjToDesc](aclrtAllocatorSetObjToDesc.md)、[aclrtAllocatorSetAllocFuncToDesc](aclrtAllocatorSetAllocFuncToDesc.md)、[aclrtAllocatorSetGetAddrFromBlockFuncToDesc](aclrtAllocatorSetGetAddrFromBlockFuncToDesc.md)、[aclrtAllocatorSetFreeFuncToDesc](aclrtAllocatorSetFreeFuncToDesc.md)设置Allocator对象及回调函数。Allocator描述符使用完成后，可调用[aclrtAllocatorDestroyDesc](aclrtAllocatorDestroyDesc.md)接口销毁Allocator描述符。
-   对于同一条流，多次调用本接口，以最后一次注册为准。
-   对于不同流，如果用户使用同一个Allocator，不可以多条流并发执行，在执行下一条Stream前，需要对上一Stream做流同步。
-   将Allocator中的内存释放给操作系统前，需要先调用[aclrtSynchronizeStream](aclrtSynchronizeStream.md)接口执行流同步，确保Stream中的任务已执行完成。

