# aclrtMemcpyBatchAsync

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

实现批量内存复制。

本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）、非锁页内存（通过malloc接口申请的内存）。当Host内存是非锁页内存时，本接口在内存复制任务完成后才返回；当Host内存是锁页内存时，本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，调用本接口后，需调用同步等待接口（例如，[aclrtSynchronizeStream](aclrtSynchronizeStream.md)）确保内存复制的任务已执行完成。

## 函数原型

```
aclError aclrtMemcpyBatchAsync(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, size_t *failIndex, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dsts | 输入 | 目的内存地址数组。 |
| destMax | 输入 | 内存复制最大长度数组，用于存放每一段要复制的内存的最大长度，单位Byte。 |
| srcs | 输入 | 源内存地址数组。 |
| sizes | 输入 | 内存复制长度数组，用于存放每一段要复制的内存大小，单位Byte。 |
| numBatches | 输入 | dsts、srcs和sizes数组的长度。 |
| attrs | 输入 | 内存复制属性数组。 |
| attrsIndexes | 输入 | 内存复制属性索引数组，用于指定attrs数组中每个条目适用的复制范围。attrs[k]中指定的属性将应用于从attrsIndexes[k]到attrsIndexes[k+1] - 1的复制操作，同时attrs[numAttrs-1]将应用于从attrsIndexes[numAttrs-1]到numBatches - 1的复制操作。 |
| numAttrs | 输入 | attrs和attrsIndexes数组的长度。 |
| failIndex | 输出 | 用于发生错误时指示出错的复制项下标（仅支持对内存属性和复制方向的校验）。若错误不涉及特定复制操作，该值将为SIZE_MAX。 |
| stream | 输入 | 指定执行内存复制任务的Stream。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   将srcs中指定的数据复制到dsts中指定的内存区域，每个复制操作的大小由sizes指定，dsts、srcs、sizes这三个数组必须具有numBatches指定的相同长度。
-   批处理中的每个复制操作必须与attrs数组中指定的属性集相关联，attrs数组中的每个条目可应用于多个复制操作，具体通过attrsIndexes数组指定对应属性条目生效的起始复制索引。attrs和attrsIndexes这两个数组必须具有numAttrs指定的相同长度。例如：若批处理包含dsts/srcs/sizes列出的10个复制操作，其中前6个使用一组属性，后4个使用另一组属性，则numAttrs为2，attrsIndexes为\{0,6\}，attrs包含两组属性。注意，attrsIndexes的首个条目必须为0，且每个条目必须大于前一个条目，最后一个条目应小于numBatches。此外numAttrs必须小于等于numBatches。
-   批量内存复制的方向仅支持“从Host到Device”或者“从Device到Host”中的一种。

