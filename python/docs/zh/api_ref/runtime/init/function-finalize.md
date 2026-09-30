# 函数：finalize

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

去初始化函数，用于释放进程内的相关资源。

在该接口内，默认增加2000ms延时（实际最大延时可达2000ms），用于Device业务日志回传，保证ERROR级别和EVENT级别日志不丢失，您可以将“ASCEND\_LOG\_DEVICE\_FLUSH\_TIMEOUT”环境变量设置为“0”（命令示例：export ASCEND\_LOG\_DEVICE\_FLUSH\_TIMEOUT=0），去除该默认延时。

关于ASCEND\_LOG\_DEVICE\_FLUSH\_TIMEOUT环境变量的详细描述请参见[《环境变量参考》](https://hiascend.com/document/redirect/CannCommunityEnvRef)中的“日志 \> ASCEND\_LOG\_DEVICE\_FLUSH\_TIMEOUT”。

## 函数原型

- **C函数原型**

    ```c
    aclError aclFinalize()
    ```

- **python函数**

    ```python
    ret = acl.finalize()
    ```

## 参数说明

无

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

应用的进程退出前，应显式调用该接口或[acl.finalize\_reference](function-finalize_reference.md)接口实现去初始化，否则可能会导致异常，例如应用进程退出时有异常报错。

不建议在析构函数中调用acl.finalize或[acl.finalize\_reference](function-finalize_reference.md)接口，否则在进程退出时可能由于单例析构顺序未知而导致进程异常退出的问题。

## 资源参考

接口调用示例，参见《应用开发》Python部分中的初始化与去初始化章节。
