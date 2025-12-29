# aclrtFree

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

释放Device上的内存。

本接口会立刻释放传入的内存，接口内部不会进行隐式的Device同步或流同步、也不会等待使用该内存的任务完成。用户需确保在调用本接口后不再访问该内存指针。

## 函数原型

```
aclError aclrtFree(void *devPtr)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| devPtr | 输入 | 待释放内存的指针。<br>如果传入的devPtr为空指针，本接口会返回报错。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

[aclrtFree](aclrtFree.md)接口只能释放通过[aclrtMalloc](aclrtMalloc.md)接口或[aclrtMallocCached](aclrtMallocCached.md)接口或[aclrtMallocAlign32](aclrtMallocAlign32.md)接口申请的内存。

