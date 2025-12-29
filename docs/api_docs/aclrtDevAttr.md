# aclrtDevAttr

## 定义

```
typedef enum { 
    ACL_DEV_ATTR_AICPU_CORE_NUM  = 1, 
    ACL_DEV_ATTR_AICORE_CORE_NUM = 101, 
    ACL_DEV_ATTR_CUBE_CORE_NUM = 102,
    ACL_DEV_ATTR_VECTOR_CORE_NUM = 201,      
    ACL_DEV_ATTR_WARP_SIZE = 202,
    ACL_DEV_ATTR_MAX_THREAD_PER_VECTOR_CORE,
    ACL_DEV_ATTR_LOCAL_MEM_PER_VECTOR_CORE,
    ACL_DEV_ATTR_TOTAL_GLOBAL_MEM_SIZE = 301,
    ACL_DEV_ATTR_L2_CACHE_SIZE,
    ACL_DEV_ATTR_SMP_ID = 401U,
    ACL_DEV_ATTR_PHY_CHIP_ID = 402U,
    ACL_DEV_ATTR_SUPER_POD_DEVIDE_ID = 403U,
    ACL_DEV_ATTR_SUPER_POD_SERVER_ID = 404U,
    ACL_DEV_ATTR_SUPER_POD_ID = 405U, 
    ACL_DEV_ATTR_CUST_OP_PRIVILEGE = 406U,
    ACL_DEV_ATTR_MAINBOARD_ID = 407U,
    ACL_DEV_ATTR_IS_VIRTUAL = 501U,
} aclrtDevAttr;
```

**表 1**  枚举项说明


| 枚举项 | 说明 |
| --- | --- |
| ACL_DEV_ATTR_AICPU_CORE_NUM | AI CPU数量。 |
| ACL_DEV_ATTR_AICORE_CORE_NUM | AI Core数量。 |
| ACL_DEV_ATTR_CUBE_CORE_NUM | Cube Core数量。 |
| ACL_DEV_ATTR_VECTOR_CORE_NUM | Vector Core数量。 |
| ACL_DEV_ATTR_WARP_SIZE | 一个Warp里的线程数，在SIMT（单指令多线程，Single Instruction Multiple Thread）编程模型中，Warp是指执行相同指令的线程集合。<br>当前不支持该类型。 |
| ACL_DEV_ATTR_MAX_THREAD_PER_VECTOR_CORE | 每个VECTOR_CORE上可同时驻留的最大线程数。<br>当前不支持该类型。 |
| ACL_DEV_ATTR_LOCAL_MEM_PER_VECTOR_CORE | 每个VECTOR_CORE上可以使用的最大本地内存，单位Byte。<br>当前不支持该类型。 |
| ACL_DEV_ATTR_TOTAL_GLOBAL_MEM_SIZE | Device上的可用总内存，单位Byte。 |
| ACL_DEV_ATTR_L2_CACHE_SIZE | L2 Cache（二级缓存）大小，单位Byte。 |
| ACL_DEV_ATTR_SMP_ID | SMP（Symmetric Multiprocessing） ID，用于标识设备是否运行在同一操作系统上。 |
| ACL_DEV_ATTR_PHY_CHIP_ID | 芯片物理ID。 |
| ACL_DEV_ATTR_SUPER_POD_DEVIDE_ID | SuperPOD Device ID表示超节点产品中的Device标识。 |
| ACL_DEV_ATTR_SUPER_POD_SERVER_ID | SuperPOD Server ID表示超节点产品中的服务器标识。 |
| ACL_DEV_ATTR_SUPER_POD_ID | SuperPOD ID表示集群中的超节点ID。 |
| ACL_DEV_ATTR_CUST_OP_PRIVILEGE | 表示查询自定义算是否可以执行更多的系统调用权限。<br>取值如下：<br><br>  - 0：自定义算子执行系统调用权限受控（例如不能执行Write操作）。<br>  - 1：自定义算子可以执行更多的系统调用权限。 |
| ACL_DEV_ATTR_MAINBOARD_ID | 主板ID。 |
| ACL_DEV_ATTR_IS_VIRTUAL | 是否为昇腾虚拟化实例。<br><br>  - 0：不是昇腾虚拟化实例，是物理机。<br>  - 1：是昇腾虚拟化实例，可能是虚拟机或容器。 |

## 了解AI Core、Cube Core、Vector Core的关系

为便于理解AI Core、Cube Core、Vector Core的关系，此处先明确Core的定义，Core是指拥有独立Scalar计算单元的一个计算核，通常Scalar计算单元承担了一个计算核的SIMD（单指令多数据，Single Instruction Multiple Data）指令发射等功能，所以我们也通常也把这个Scalar计算单元称为核内的调度单元。不同产品上的AI数据处理核心单元不同，当前分为以下几类：

-   当AI数据处理核心单元是AI Core：
    -   在AI Core内，Cube和Vector共用一个Scalar调度单元。

        ![](figures/逻辑架构图.png)

    -   在AI Core内，Cube和Vector都有各自的Scalar调度单元，因此又被称为Cube Core、Vector Core。这时，一个Cube Core和一组Vector Core被定义为一个AI Core，AI Core数量通常是以多少个Cube Core为基准计算的，例如Atlas A2 训练系列产品/Atlas A2 推理系列产品。

        ![](figures/逻辑架构图-3.png)

-   当AI数据处理核心单元是AI Core以及单独的Vector Core：AI Core和Vector Core都拥有独立的Scalar调度单元。

    ![](figures/逻辑架构图-4.png)

