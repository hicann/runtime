# 函数：get\_recent\_err\_msg

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

获取并清空与本接口在同一个线程中的其它pyacl接口调用失败时的错误描述信息。

获取进程级别、还是线程级别的错误描述信息由[acl.init](../init/function-init.md)接口中的“err\_msg\_mode”配置控制，默认线程级别。

## 函数原型

- **C函数原型**

    ```c
    const char *aclGetRecentErrMsg()
    ```

- **python函数**

    ```python
    msg = acl.get_recent_err_msg()
    ```

## 参数说明

无

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 建议在每次调用pyacl接口失败时都调用acl.get\_recent\_err\_msg接口，以便获取调用pyacl接口异常时的错误描述信息，用于定位问题。
- 同一个线程中多次调用acl.get\_recent\_err\_msg接口后，只有最后一次调用acl.get\_recent\_err\_msg接口返回的错误描述字符串有效，之前acl.get\_recent\_err\_msg接口返回的错误描述字符串不能使用，否则可能导致内存非法访问。
- 如果未在每次调用pyacl接口失败时调用acl.get\_recent\_err\_msg接口可能导致错误信息堆积、丢失。
