# 函数：app\_log

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

将日志记录到系统相应的日志文件中。

## 函数原型

- **C函数原型**

    ```c
    ACL_APP_LOG(aclLogLevel logLevel, const char *message)
    ```

- **python函数**

    ```python
    acl.app_log(log_level, message)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| log_level | int，设定日志级别。<br>0：DEBUG<br>1：INFO<br>2：WARNING<br>3：ERROR |
| message | str，记录的日志信息。 |

## 返回值说明

无
