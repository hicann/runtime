# 函数：get\_desc\_from\_mem

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

从内存获取该模型的模型描述信息。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlGetDescFromMem(aclmdlDesc *modelDesc, const void *model, size_t modelSize)
    ```

- **python函数**

    ```python
    ret = acl.mdl.get_desc_from_mem(model_desc, model, model_size)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model | int，存放模型数据的内存的指针地址。 |
| model_size | int，内存中的模型数据长度，单位Byte。 |
| model_desc | int，aclmdlDesc类型的指针。需提前调用[create_desc](function-create_desc.md)接口创建aclmdlDesc类型的数据，调用成功后，会刷新指针地址里面的内容。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，返回0表示成功，返回非0表示失败。 |

## 约束说明

通过本接口获取到的模型描述信息，无法应用于[get\_op\_attr](function-get_op_attr.md)、[get\_cur\_output\_dims](function-get_cur_output_dims.md)接口。
 
<!-- npu="950,A3,910b,910,310p,310b" id7 -->
Ascend EP形态下，model参数处需申请Host上的内存。
<!-- end id7 -->

<!-- npu="310b" id8 -->
Ascend RC形态下，model参数处需申请Device上的内存。
<!-- end id8 -->

<!-- npu="310p" id9 -->
Control CPU开放形态下，model参数处需申请Device上的内存。
<!-- end id9 -->
