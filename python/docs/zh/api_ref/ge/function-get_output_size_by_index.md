# 函数：get\_output\_size\_by\_index

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

根据aclmdlDesc类型的数据，获取指定输出的大小，单位为Byte。

## 函数原型

- **C函数原型**

    ```c
    size_t aclmdlGetOutputSizeByIndex(aclmdlDesc *modelDesc, size_t index)
    ```

- **python函数**

    ```python
    size = acl.mdl.get_output_size_by_index(model_desc, index)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_desc | int，aclmdlDesc类型数据的指针地址。需提前调用[acl.mdl.create_desc](function-create_desc.md)接口创建aclmdlDesc类型的数据。 |
| index | int，指定获取第几个输出的大小，index值从0开始。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| size | int，返回指定输出的大小，单位是Byte。<br> 针对动态Batch、动态分辨率（宽高）的场景，返回最大档位对应的输入的大小。<br> 静态场景下，返回指定输出的大小。单位是Byte。 |

## 约束说明

如果通过本接口获取的大小为0，有可能是由于输出Shape的范围不确定，当前支持以下两种处理方式：

- **系统内部自行申请对应index的输出内存**，节省内存，但内存数据使用结束后，需由用户释放内存，同时，系统内部申请内存时涉及内存拷贝，可能涉及性能损耗。

 调用acl.create\_data\_buffer接口创建存放对应index输出数据的aclDataBuffer类型时，可在data参数处传入0，表示创建一个空的aclDataBuffer类型，然后在模型执行过程中，系统内部自行计算并申请该index输出的内存。

- **用户预估输出内存大小，并申请内存**，由用户自行管理内存，但内存大小可能不足或超出，不足时系统会校验报错，超出时会浪费内存。

 用户需先根据实际情况预估一块较大的输出内存，在模型执行过程中，系统会校验用户指定的输出内存大小是否符合要求，如果不符合要求，系统会返回报错，并在报错信息中提示具体需要多大的输出内存。您可以通过以下两种方式查看报错：

 - 获取应用类日志，查看ERROR级别的报错，如何获取日志请参见《日志参考》。
 - 在应用程序中调用[函数：get\_recent\_err\_msg](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/API/runtimeapi/aclpythondevg_01_0010.html)接口获取报错。
