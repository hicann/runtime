# 总体说明

- 若涉及媒体数据处理功能，关于内存使用，有以下注意事项：
    1. 由于媒体数据处理功能对存放输入、输出数据的内存有更高的要求（例如，内存首地址128对齐），因此需调用专用的内存申请接口，如下。
        - 调用[媒体数据处理V1]( https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/acce/dvpp/aclpythondevg_01_0220.html)版本的接口对图片进行抠图、缩放等操作时，调用[acl.media.dvpp\_malloc]( https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/acce/dvpp/aclpythondevg_01_0223.html)接口申请内存。
        - 调用[媒体数据处理V2]( https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/acce/dvpp/aclpythondevg_01_0411.html)版本的接口对图片进行抠图、缩放等操作时，调用[acl.himpi.dvpp\_malloc]( https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/acce/dvpp/aclpythondevg_01_0416.html)接口申请内存。

    2. 调用上述接口申请出来的内存可以满足媒体数据处理的要求，也可以在其它任务中使用，例如，从性能角度，为了减少拷贝，媒体数据处理的输出作为模型推理的输入，实现内存复用。
    3. 由于媒体数据处理访问的地址空间有限，为确保媒体数据处理时内存足够，除媒体数据处理功能外的其它功能（例如，模型加载），建议调用[内存管理]( memory_management.md)章节下的[acl.rt.malloc](../memory/function-malloc.md)接口、[acl.rt.malloc\_host](function-malloc_host.md)接口或[acl.rt.malloc\_cached](function-malloc_cached.md)接口申请内存。

<!-- npu="910b" id6 -->
- 对于Atlas A2系列产品，若涉及申请Device上的大页内存，需注意，当前版本为防止大页内存不够用，系统内部已提前预留大页内存，用户在使用大页内存前，可调用acl.rt.get\_mem\_info接口，查询空闲的片上内存大页内存（对应ACL\_HBM\_MEM\_HUGE类型）、片上内存普通内存（对应ACL\_HBM\_MEM\_NORMAL类型）。
<!-- end id6 -->
<!-- npu="A3,910b,910,310p,310b" id7 -->
- Ascend EP形态下，Device启动后首次执行推理或训练任务时，会将AI CPU算子从Host搬迁到Device上并缓存在Device上，用于提升性能，因此会占用部分Device内存（100M\~200M，不同芯片有所不同）。若Device重启，这部分AI CPU算子缓存才会释放。

    以下产品涉及该约束：

  <!-- npu="310p" id1 -->
  - Atlas推理系列产品
  <!-- end id1 -->
  <!-- npu="310b" id2 -->
  - Atlas 200I/500 A2推理产品
  <!-- end id2 -->
  <!-- npu="910" id3 -->
  - Atlas训练系列产品
  <!-- end id3 -->
  <!-- npu="910b" id4 -->
  - Atlas A2训练系列产品
  <!-- end id4 -->
  <!-- npu="A3" id5 -->
  - Atlas A3系列产品
  <!-- end id5 -->

<!-- end id7 -->