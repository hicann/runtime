# 函数：destroy\_dataset

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

销毁通过[acl.mdl.create\_dataset](function-create_dataset.md)接口创建的aclmdlDataset类型的数据。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlDestroyDataset(const aclmdlDataset *dataset)
    ```

- **python函数**

    ```python
    ret = acl.mdl.destroy_dataset(dataset)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| dataset | int，待销毁的aclmdlDataset的指针地址。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |

## 约束说明

销毁类接口：调用该接口后，不能继续使用已释放或销毁的资源，建议调用该接口后，将相关资源设置为无效值（例如，置为0或None）。
