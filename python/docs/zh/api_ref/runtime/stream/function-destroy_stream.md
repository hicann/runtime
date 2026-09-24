# 函数：destroy\_stream

## 产品支持情况

<!-- npu="950" id1 -->
- Ascend 950PR&950DT系列产品：支持
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

销毁指定Stream，销毁通过[acl.rt.create\_stream](../stream/function-create_stream.md)或[acl.rt.create\_stream\_with\_config](function-create_stream_with_config.md)接口创建的Stream，若Stream上有未完成的任务，会等待任务完成后再销毁Stream。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtDestroyStream(aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.rt.destroy_stream(stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| stream | int，待销毁的Stream的指针地址。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 调用[acl.rt.destroy\_stream](../stream/function-destroy_stream.md)接口销毁指定Stream前，需要先调用[acl.rt.synchronize\_stream](function-destroy_stream.md)接口确保Stream中的任务都已完成。
- 调用[acl.rt.destroy\_stream](../stream/function-destroy_stream.md)接口销毁指定Stream时，需确保该Stream在当前Context下。
- 调用[acl.rt.destroy\_stream](../stream/function-destroy_stream.md)接口销毁指定Stream时，需确保其它接口没有正在使用该Stream。

## 资源参考

接口调用流程与示例，请参见《应用开发》Python部分的运行时资源申请与释放、同步等待章节。
