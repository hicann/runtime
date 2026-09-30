# 函数：finalize\_reference

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

去初始化函数，用于释放进程内acl接口使用的相关资源。

acl.finalize\_reference接口内部涉及引用计数的实现，[acl.init](function-init.md)接口每被调用一次，则引用计数加一，acl.finalize\_reference接口每被调用一次，则该引用计数减一，当引用计数减到0时，才会真正去初始化。[acl.finalize](function-finalize.md)接口与本接口的区别在于，调用[acl.finalize](function-finalize.md)接口会将计数清零，直接去初始化。

## 函数原型

- **C函数原型**

    ```c
    aclError aclFinalizeReference(uint64_t *refCount)
    ```

- **python函数**

    ```python
    count, ret = acl.finalize_reference()
    ```

## 参数说明

无

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| count | int，引用计数。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

应用进程退出前，应确保已调用[acl.finalize](function-finalize.md)或acl.finalize\_reference接口完成去初始化，否则可能会导致异常，例如应用进程退出时有异常报错。

不建议在析构函数中调用[acl.finalize](function-finalize.md)或acl.finalize\_reference接口，否则在进程退出时可能由于单例析构顺序未知而导致进程异常退出的问题。
