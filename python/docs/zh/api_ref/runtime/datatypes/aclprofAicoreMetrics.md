# aclprofAicoreMetrics

AI Core性能指标采集项及对应的含义如下：

ACL\_AICORE\_ARITHMETIC\_UTILIZATION = 0：各种计算类指标占比统计。

ACL\_AICORE\_PIPE\_UTILIZATION = 1：计算单元和搬运单元耗时占比。

ACL\_AICORE\_MEMORY\_BANDWIDTH = 2：外部内存读写类指令占比。

ACL\_AICORE\_L0B\_AND\_WIDTH = 3：内部内存读写类指令占比。

ACL\_AICORE\_RESOURCE\_CONFLICT\_RATIO = 4：流水线队列类指令占比。

ACL\_AICORE\_MEMORY\_UB = 5：内部内存读写指令占比。

ACL\_AICORE\_L2\_CACHE = 6：读写cache命中次数和缺失后重新分配次数，仅支持Atlas A2系列产品、Atlas A3系列产品。

ACL\_AICORE\_L2\_CACHE = 6：读写cache命中次数和缺失后重新分配次数，仅支持：Atlas 200I/500 A2推理产品。

ACL\_AICORE\_PIPE\_EXECUTE\_UTILIZATION = 7：计算单元和搬运单元耗时占比，仅支持Atlas 200I/500 A2推理产品。

ACL\_AICORE\_MEMORY\_ACCESS = 8：算子在核上访存的带宽数据量，仅支持Atlas A2系列产品、Atlas A3系列产品。

ACL\_AICORE\_NONE = 0xFF：表示不采集数据。
