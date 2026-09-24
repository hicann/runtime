# 函数：set\_context

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

设置线程的Context。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtSetCurrentContext(aclrtContext context)
    ```

- **python函数**

    ```python
    ret = acl.rt.set_context(context)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| context | int，线程当前的Context对象指针地址。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 支持以下场景：
  - 如果在某线程（例如：thread1）中调用[acl.rt.create\_context](function-create_context.md)接口显式创建一个Context（例如：ctx1），则可以不调用acl.rt.set\_context接口指定该线程的Context，系统默认将ctx1作为thread1的Context。
  - 如果没有调用[acl.rt.create\_context](function-create_context.md)接口显式创建Context，则系统将默认Context作为线程的Context，此时，不能通过[acl.rt.destroy\_context](function-destroy_context.md)接口来释放默认Context。
  - 如果多次调用acl.rt.set\_context接口设置线程的Context，以最后一次为准。

- 若给线程设置的Context所对应的Device已经被复位，则不能将该Context设置为线程的Context，否则会导致业务异常。
- 推荐在某一线程中创建的Context，在该线程中使用。若在线程A中调用[acl.rt.create\_context](function-create_context.md)接口创建Context，在线程B中使用该Context，则需由用户自行保证两个线程中同一个Context下同一个Stream中任务执行的顺序。
