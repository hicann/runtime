# aclprofConfigType
<!-- npu="950" id87 -->
Ascend 950PR/Ascend 950DT：不支持ACL\_PROF\_DVPP\_FREQ、ACL\_PROF\_HOST\_SYS、ACL\_PROF\_HOST\_SYS\_USAGE、ACL\_PROF\_HOST\_SYS\_USAGE\_FREQ。
<!-- end id87 -->

<!-- npu="310p" id88 -->
Atlas推理系列产品：不支持ACL\_PROF\_SYS\_IO\_FREQ。
<!-- end id88 -->

<!-- npu="310b" id89 -->
Atlas 200I/500 A2推理产品：不支持ACL\_PROF\_SYS\_INTERCONNECTION\_FREQ。
<!-- end id89 -->

枚举项说明如下：

- ACL\_\PROF\_STORAGE\_LIMIT = 1：指定落盘目录允许存放的最大文件容量，有效取值范围为[200, 4294967295]，单位为MB。
- ACL\_PROF\_SYS\_HARDWARE\_MEM\_FREQ = 3：片上内存、QoS带宽及内存、LLC的读写带宽数据、acc_pmu数据和SoC传输带宽信息、组件内存采集频率，范围[1,100]。
- ACL\_PROF\_LLC\_MODE = 4：LLC Profiling采集事件。要求同时设置ACL_PROF_SYS_HARDWARE_MEM_FREQ。
    可以设置为：
    <!-- npu="310p" id5 -->
    - Atlas推理系列产品：<br>read：读事件，三级缓存读速率。<br>write：写事件，三级缓存写速率。默认为read。
    <!-- end id5 -->
    <!-- npu="910" id6 -->
    - Atlas训练系列产品：<br>read：读事件，三级缓存读速率。<br>write：写事件，三级缓存写速率。默认为read。
    <!-- end id6 -->
    <!-- npu="310b" id4 -->
    - Atlas 200I/500 A2推理产品：<br>read：读事件，三级缓存读速率。<br>write：写事件，三级缓存写速率。默认为read。
    <!-- end id4 -->
    <!-- npu="910b" id3 -->
    - Atlas A2系列产品：<br>read：读事件，三级缓存读速率。<br>write：写事件，三级缓存写速率。默认为read。
    <!-- end id3 -->
    <!-- npu="A3" id2 -->
    - Atlas A3系列产品：<br>read：读事件，三级缓存读速率。<br>write：写事件，三级缓存写速率。默认为read。
    <!-- end id2 -->
- ACL\_PROF\_SYS\_IO\_FREQ = 5：NIC、ROCE采集频率，范围[1,100]，单位hz。
    <!-- npu="950" id1 -->
    Ascend 950PR&950DT系列产品，Qos和SoC支持的采集频率最大支持配置10000，其他采集项支持的最大采集频率仍为100，若配置超出范围，其他采集项则按照最大采集频率100进行采集。
    <!-- end id1 -->
    <!-- npu="310b" id7 -->
    - Atlas 200I/500 A2推理产品：支持采集NIC，容器场景参数不生效。
    <!-- end id7 -->
    <!-- npu="910b" id8 -->
    - Atlas A2系列产品：支持采集NIC和ROCE。
    <!-- end id8 -->
    <!-- npu="A3" id9 -->
    - Atlas A3系列产品：支持采集NIC和ROCE。
    <!-- end id9 -->
- ACL\_PROF\_SYS\_INTERCONNECTION\_FREQ = 6：集合通信带宽数据（HCCS）、PCIe数据采集开关、片间传输带宽信息采集频率、SIO数据、UB带宽数据采集开关，范围[1,50]，单位hz。不同产品采集内容略有差异，请以实际结果为准。
- ACL\_PROF\_DVPP\_FREQ：DVPP采集频率，范围[1,100]。
- ACL\_PROF\_HOST\_SYS = 8：Host侧进程级别的性能数据采集开关，取值包括cpu和mem。
- ACL\_PROF\_HOST\_SYS\_USAGE = 9：Host侧系统和所有进程的性能数据采集开关，取值包括cpu和mem。
- ACL\_PROF\_HOST\_SYS\_USAGE\_FREQ = 10：CPU利用率、内存利用率的采集频率，范围[1,50]。
