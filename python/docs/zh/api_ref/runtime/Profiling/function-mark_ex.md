# 函数：mark\_ex

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

acl.prof.mark\_ex打点接口。

调用此接口向配置的Stream流上下发打点任务，用于标识Host侧打点与Device侧打点任务的关系。

## 函数原型

- **C函数原型**

    ```c
    aclError aclprofMarkEx(const char *msg, size_t msgLen, aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.prof.mark_ex(msg, stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| msg | str，打点信息字符串。 |
| stream | int，指定Stream。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，返回0表示成功，返回其它值表示失败。 |
