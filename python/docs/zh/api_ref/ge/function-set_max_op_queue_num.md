# 函数：set\_max\_op\_queue\_num

## 产品支持情况

<!-- npu="950" id1 -->
- Ascend 950PR&950DT系列产品：不支持
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

通过单算子模型方式执行单个算子时，配置算子缓存信息老化信息，以达到节约内存和平衡调用性能的目的。

## 函数原型

- **C函数原型**

    ```c
    aclError aclopSetMaxOpQueueNum(uint64_t maxOpNum)
    ```

- **python函数**

    ```python
    ret = acl.op.set_max_op_queue_num(max_op_num)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| max_op_num | int，“算子类型<br> 单算子模型”映射队列的最大长度。如果长度达到最大，则会先删除长期未使用的映射信息以及缓存中的单算子模型，再加载最新的映射信息以及对应的单算子模型。通过单算子模型方式执行单个算子时（aclopUpdateParams接口执行单算子除外），如果不调用本接口配置映射队列的最大长度，则默认最大长度为20000。aclopUpdateParams接口执行单算子时，如果不调用本接口配置映射队列的最大长度，则表示无需老化算子缓存信息。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |
