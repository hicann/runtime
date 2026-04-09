# aclrtMemcpyBatchAsyncV2

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况

| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

实现批量内存异步复制。
本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）和非锁页内存（例如通过malloc接口申请的内存）。当Host内存为非锁页内存时，本接口在内存复制任务完成后才返回；当Host内存为锁页内存时，本接口为异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功。调用本接口后，需要调用同步等待接口（例如 [aclrtSynchronizeStream](aclrtSynchronizeStream.md)）以确保内存复制任务已执行完成。
与 `aclrtMemcpyBatchAsync` 相比，本接口不再通过 `failIndex` 参数返回失败的复制项下标。

## 函数原型

```
aclError aclrtMemcpyBatchAsyncV2(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, aclrtStream stream)
```

## 参数说明

| 参数名称 | 输入/输出 | 说明 |
| --- | --- | --- |
| dsts | 输入 | 目的内存地址数组。 |
| destMaxs | 输入 | 内存复制最大长度数组，用于存放每一段待复制目标内存的最大长度，单位Byte。 |
| srcs | 输入 | 源内存地址数组。 |
| sizes | 输入 | 内存复制长度数组，用于存放每一段待复制内存的大小，单位Byte。 |
| numBatches | 输入 | `dsts`、`srcs` 和 `sizes` 数组的长度。 |
| attrs | 输入 | 内存复制属性数组。 |
| attrsIndexes | 输入 | 内存复制属性索引数组，用于指定 `attrs` 数组中每个属性项适用的复制范围。`attrs[k]` 指定的属性应用于从 `attrsIndexes[k]` 到 `attrsIndexes[k+1] - 1` 的复制操作，同时 `attrs[numAttrs - 1]` 应用于从 `attrsIndexes[numAttrs - 1]` 到 `numBatches - 1` 的复制操作。 |
| numAttrs | 输入 | `attrs` 和 `attrsIndexes` 数组的长度。 |
| stream | 输入 | 指定执行内存复制任务的Stream。 |

## 返回值说明

返回 `ACL_SUCCESS` 表示执行成功，返回其他值表示失败，详细错误码请参见 [aclError](aclError.md)。

## 约束说明

- 将 `srcs` 中指定的数据复制到 `dsts` 中指定的内存区域，每一个复制操作的大小由 `sizes` 指定，`dsts`、`srcs`、`sizes` 三个数组必须具有 `numBatches` 指定的相同长度。
- 批处理中每一个复制操作必须与 `attrs` 数组中指定的属性集相关联，`attrs` 数组中的每个条目可应用于多个复制操作，具体通过 `attrsIndexes` 数组指定对应属性条目生效的起始复制索引。`attrs` 和 `attrsIndexes` 两个数组必须具有 `numAttrs` 指定的相同长度。例如：若批处理包含 `dsts/srcs/sizes` 列出的 10 个复制操作，其中前 6 个使用一组属性，后 4 个使用另一组属性，则 `numAttrs` 为 2，`attrsIndexes` 为 `{0, 6}`，`attrs` 包含两组属性。注意，`attrsIndexes` 的首个条目必须为 0，且每个条目必须大于前一个条目，最后一个条目应小于 `numBatches`。同时 `numAttrs` 必须小于等于 `numBatches`。
- 批量内存复制的方向仅支持“从Host到Device”或者“从Device到Host”中的一种。
