# aclrtDevAttr

枚举值及其说明：

- ACL\_DEV\_ATTR\_AICPU\_CORE\_NUM  = 1

    AI CPU数量。

- ACL\_DEV\_ATTR\_AICORE\_CORE\_NUM = 101

    AI Core数量。

- ACL\_DEV\_ATTR\_VECTOR\_CORE\_NUM = 201

    Vector Core数量。

- ACL\_DEV\_ATTR\_WARP\_SIZE = 202

    一个Warp里的线程数，在SIMT（单指令多线程，Single Instruction Multiple Thread）编程模型中，Warp是指执行相同指令的线程集合。

    <!-- npu="950" id1 -->
    仅Ascend 950PR&950DT系列产品支持该选项。

    <!-- end id1 -->
    对于不支持该选项的产品型号，默认返回0。

- ACL\_DEV\_ATTR\_MAX\_THREAD\_PER\_VECTOR\_CORE = 203

    每个VECTOR\_CORE上可同时驻留的最大线程数。

    <!-- npu="950" id2 -->
    仅Ascend 950PR&950DT系列产品支持该选项。
    <!-- end id2 -->

    对于不支持该选项的产品型号，默认返回0。

- ACL\_DEV\_ATTR\_LOCAL\_MEM\_PER\_VECTOR\_CORE = 204

    每个VECTOR\_CORE上可以使用的最大本地内存，单位Byte。

    <!-- npu="950" id3 -->
    仅Ascend 950PR&950DT系列产品支持该选项。

    <!-- end id3 -->
    对于不支持该选项的产品型号，默认返回0。

- ACL\_DEV\_ATTR\_MAX\_GRID\_DIM\_X = 205

    Grid维度X的最大值，用于SIMT编程模型中线程块的网格配置。

    <!-- npu="950" id4 -->
    仅Ascend 950PR&950DT系列产品支持该选项。

    <!-- end id4 -->
    对于不支持该选项的产品型号，默认返回0。

- ACL\_DEV\_ATTR\_MAX\_GRID\_DIM\_Y = 206

    Grid维度Y的最大值，用于SIMT编程模型中线程块的网格配置。

    <!-- npu="950" id5 -->
    仅Ascend 950PR&950DT系列产品支持该选项。

    <!-- end id5 -->
    对于不支持该选项的产品型号，默认返回0。

- ACL\_DEV\_ATTR\_MAX\_GRID\_DIM\_Z = 207

    Grid维度Z的最大值，用于SIMT编程模型中线程块的网格配置。

    <!-- npu="950" id6 -->
    仅Ascend 950PR&950DT系列产品支持该选项。

    <!-- end id6 -->
    对于不支持该选项的产品型号，默认返回0。

- ACL\_DEV\_ATTR\_MAX\_BLOCK\_PER\_GRID = 208

    每个Grid中Block的最大数量，用于SIMT编程模型中线程块的网格配置。

    <!-- npu="950" id7 -->
    仅Ascend 950PR&950DT系列产品支持该选项。

    <!-- end id7 -->
    对于不支持该选项的产品型号，默认返回0。

- ACL\_DEV\_ATTR\_MAX\_THREADS\_PER\_BLOCK = 209

    每个Block中线程的最大数量，用于SIMT编程模型中线程块的配置。

    <!-- npu="950" id8 -->
    仅Ascend 950PR&950DT系列产品支持该选项。

    <!-- end id8 -->
    对于不支持该选项的产品型号，默认返回0。

- ACL\_DEV\_ATTR\_MAX\_BLOCK\_DIM\_X = 210

    Block维度X的最大值，用于SIMT编程模型中线程块的配置。

    <!-- npu="950" id9 -->
    仅Ascend 950PR&950DT系列产品支持该选项。

    <!-- end id9 -->
    对于不支持该选项的产品型号，默认返回0。

- ACL\_DEV\_ATTR\_MAX\_BLOCK\_DIM\_Y = 211

    Block维度Y的最大值，用于SIMT编程模型中线程块的配置。

    <!-- npu="950" id10 -->
    仅Ascend 950PR&950DT系列产品支持该选项。

    <!-- end id10 -->
    对于不支持该选项的产品型号，默认返回0。

- ACL\_DEV\_ATTR\_MAX\_BLOCK\_DIM\_Z = 212

    Block维度Z的最大值，用于SIMT编程模型中线程块的配置。

    <!-- npu="950" id11 -->
    仅Ascend 950PR&950DT系列产品支持该选项。
    <!-- end id11 -->

    对于不支持该选项的产品型号，默认返回0。

- ACL\_DEV\_ATTR\_TOTAL\_GLOBAL\_MEM\_SIZE = 301

    Device上的可用总内存，单位Byte。

- ACL\_DEV\_ATTR\_L2\_CACHE\_SIZE = 302

    L2 Cache（二级缓存）大小，单位Byte。

- ACL\_DEV\_ATTR\_SMP\_ID = 401

    SMP（Symmetric Multiprocessing）ID，用于标识设备是否运行在同一操作系统上。

- ACL\_DEV\_ATTR\_PHY\_CHIP\_ID = 402

    芯片物理ID。

- ACL\_DEV\_ATTR\_SUPER\_POD\_DEVICE\_ID = 403

    SuperPOD Device ID表示超节点产品中的Device标识。

- ACL\_DEV\_ATTR\_SUPER\_POD\_SERVER\_ID = 404

    SuperPOD Server ID表示超节点产品中的服务器标识。

- ACL\_DEV\_ATTR\_SUPER\_POD\_ID = 405

    SuperPOD ID表示集群中的超节点ID。

- ACL\_DEV\_ATTR\_CUST\_OP\_PRIVILEGE = 406

    表示查询自定义算是否可以执行更多的系统调用权限。

    取值如下：

  - 0：自定义算子执行系统调用权限受控（例如不能执行Write操作）。
  - 1：自定义算子可以执行更多的系统调用权限。

    <!-- npu="950" id12 -->
    Ascend 950PR&950DT系列产品不支持该选项。

    <!-- end id12 -->
- ACL\_DEV\_ATTR\_MAINBOARD\_ID = 407

    主板ID。

- ACL\_DEV\_ATTR\_HD\_CONNECT\_TYPE = 408

    Host和Device间的互联协议。

    取值如下：

  - 0：通过PCIe互联传输。
  - 1：通过HCCS（Huawei Cache Coherence System，华为缓存一致性系统）互联传输。
  - 2：通过UB（Unified Bus，统一总线）互联传输。

    <!-- npu="950" id13 -->
    仅Ascend 950PR&950DT系列产品支持该选项。
    <!-- end id13 -->
    对于不支持该选项的产品型号，返回报错。

- ACL\_DEV\_ATTR\_DEVICE\_FORM\_FACTOR = 409

    设备形态。

    取值如下：

  - 0：PoD形态，表示算力机柜形态。
  - 1：A+K Server形态，表示昇腾（Ascend）+鲲鹏（Kunpeng）架构。
  - 2：A+X Server形态，表示昇腾（Ascend）+非鲲鹏架构（如X86架构）。
  - 3：PCIe标卡形态。

    <!-- npu="950" id14 -->
    仅Ascend 950PR&950DT系列产品支持该选项。
    <!-- end id14 -->

- ACL\_DEV\_ATTR\_SUPER\_POD\_CHASSIS\_ID = 410

    SuperPOD Chassis ID，表示超节点产品中的机箱ID。
    <!-- npu="950" id40 -->
    仅Ascend 950PR&950DT系列产品支持该选项。
    <!-- end id40 -->
    对于不支持该选项的产品型号，返回报错。
    
- ACL\_DEV\_ATTR\_IS\_VIRTUAL = 501

    是否为昇腾虚拟化实例。

  - 0：不是昇腾虚拟化实例，是物理机。
  - 1：是昇腾虚拟化实例，可能是虚拟机或容器。

- ACL\_DEV\_ATTR\_NPU\_ARCH = 601

    NPU的架构版本。

    产品型号和NPU架构版本的对应关系如下所示：

  <!-- npu="950" id15 -->
  - Ascend 950PR&950DT系列产品：3510
  <!-- end id15 -->
  <!-- npu="A3" id16 -->
  - Atlas A3系列产品：2201
  <!-- end id16 -->
  <!-- npu="910b" id17 -->
  - Atlas A2系列产品：2201
  <!-- end id17 -->
  <!-- npu="310b" id18 -->
  - Atlas 200I/500 A2推理产品：3002
  <!-- end id18 -->
  <!-- npu="310p" id19 -->
  - Atlas推理系列产品：2002
  <!-- end id19 -->
  <!-- npu="910" id20 -->
  - Atlas训练系列产品：1001
  <!-- end id20 -->

## 了解AI Core、Cube Core、Vector Core的关系

为便于理解AI Core、Cube Core、Vector Core的关系，此处先明确Core的定义，Core是指拥有独立Scalar计算单元的一个计算核，通常Scalar计算单元承担了一个计算核的SIMD（单指令多数据，Single Instruction Multiple Data）指令发射等功能，所以我们也通常也把这个Scalar计算单元称为核内的调度单元。不同产品上的AI数据处理核心单元不同，当前分为以下几类：

- 当AI数据处理核心单元是AI Core：
  - 在AI Core内，Cube和Vector共用一个Scalar调度单元。

        <!-- npu="910" id37 -->
        此处以Atlas训练系列产品为例。
        <!-- end id37 -->

        ![](../figures/aicore_shares_one_scalar.png)

  - 在AI Core内，Cube和Vector都有各自的Scalar调度单元，因此又被称为Cube Core、Vector Core。这时，一个Cube Core和一组Vector Core被定义为一个AI Core，AI Core数量通常是以多少个Cube Core为基准计算的。

        <!-- npu="910b" id38 -->
        此处以Atlas A2系列产品为例。
        <!-- end id38 -->

        ![](../figures/aicore_contains_multi_scalars.png)

- 当AI数据处理核心单元是AI Core以及单独的Vector Core：AI Core和Vector Core都拥有独立的Scalar调度单元。

    <!-- npu="310p" id39 -->
    此处以Atlas推理系列产品为例。
    <!-- end id39 -->

    ![](../figures/aicore_and_vectorcore.png)

## 了解SuperPOD ID、SuperPOD Server ID、SuperPOD Device ID之间的关系

![](../figures/podid_serverid_deviceid.png)
