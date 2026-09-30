# 函数：create\_stream

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

在当前进程或线程中创建一个Stream。

该接口不支持设置Stream的优先级；若不设置，Stream的优先级默认为最高。如需在创建Stream时设置优先级，请参见[acl.rt.create\_stream\_with\_config](function-create_stream_with_config.md)接口。

若不显式调用Stream创建接口，那么每个Context对应一个默认Stream，该默认Stream是调用[acl.rt.set\_device](../device/function-set_device.md)接口或[acl.rt.create\_context](../context/function-create_context.md)接口隐式创建的，默认Stream的优先级不支持设置，为最高优先级。默认Stream适合简单、无复杂交互逻辑的应用，但缺点在于，在多线程编程中，执行结果取决于线程调度的顺序。显式创建的Stream适合大型、复杂交互逻辑的应用，且便于提高程序的可读性、可维护性，**推荐显式**。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtCreateStream(aclrtStream *stream)
    ```

- **python函数**

    ```python
    stream, ret = acl.rt.create_stream()
    ```

## 参数说明

无

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| stream | int，返回创建的Stream的指针地址。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 每个Context对应一个默认Stream，该默认Stream是调用[acl.rt.set\_device](../device/function-set_device.md)接口或[acl.rt.create\_context](../context/function-create_context.md)接口隐式创建的，默认Stream的优先级不支持设置，为最高优先级。推荐调用aclrtCreateStream接口显式创建Stream。
  - 隐式创建Stream：适合简单、无复杂交互逻辑的应用，但缺点在于，在多线程编程中，执行结果取决于线程调度的顺序。
  - 显式创建Stream：**推荐显式**，适合大型、复杂交互逻辑的应用，且便于提高程序的可读性、可维护性。

- 不同型号的硬件支持的Stream最大数不同，如果已存在多个Stream（包含默认Stream），则只能显式创建N个Stream，N = Stream最大数 - 已存在的Stream数。例如，Stream最大数为1024，已存在2个Stream，则只能调用本接口显式创建1022个Stream。
  <!-- npu="950,A3,910b" id7 -->
  - 对于Ascend 950PR&950DT系列产品、Atlas A3系列产品、Atlas A2系列产品，Stream最大数为1984。
  <!-- end id7 -->
  <!-- npu="310b" id8 -->
  - 对于Atlas 200I/500 A2推理产品，Stream最大数为512。
  <!-- end id8 -->
  <!-- npu="310p" id9 -->
  - 对于Atlas推理系列产品，Stream最大数为1024。
  <!-- end id9 -->
  <!-- npu="910" id10 -->
  - 对于Atlas训练系列产品，Stream最大数为2024。

    进程场景下，若一次性创建的Stream数量总和接近2048，可能会出现创建Stream失败的情况，此时，建议进行以下操作

    （1）清理冗余Stream，减少不必要的Stream。

    （2）调整代码逻辑，分批创建Stream。例如，第一批创建部分Stream，然后第二批再创建部分Stream，以此类推，直到Stream总数接近2048。

  <!-- end id10 -->

## 资源参考

接口调用流程与示例，请参见《应用开发》Python部分的运行时资源申请与释放。
