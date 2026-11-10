# aclprofConfigType
<!-- npu="950" id87 -->
Ascend 950PR&950DT products: ACL_PROF_DVPP_FREQ, ACL_PROF_HOST_SYS, ACL_PROF_HOST_SYS_USAGE, and ACL_PROF_HOST_SYS_USAGE_FREQ are not supported.
<!-- end id87 -->

<!-- npu="310p" id88 -->
Atlas inference products: ACL_PROF_SYS_IO_FREQ is not supported.
<!-- end id88 -->

<!-- npu="310b" id89 -->
Atlas 200I/500 A2 inference products: ACL_PROF_SYS_INTERCONNECTION_FREQ is not supported.
<!-- end id89 -->

The enumerations are described as follows:

- ACL_PROF_STORAGE_LIMIT = 1: maximum file capacity allowed in the specified flush directory. The valid value range is [200, 4294967295], in MB.
- ACL_PROF_SYS_HARDWARE_MEM_FREQ = 3: frequency of collecting on-chip memory, QoS bandwidth and memory, LLC read/write bandwidth data, acc_pmu data, SoC transmission bandwidth information, and component memory. The value range is [1, 100].
- ACL_PROF_LLC_MODE = 4: LLC profiling event. **ACL_PROF_SYS_HARDWARE_MEM_FREQ** must be set at the same time.
    The options are as follows:
    <!-- npu="310p" id5 -->
    - Atlas inference products:<br>**read**: read events, that is, the L3 cache read rate.<br>**write**: write events, that is, the L3 cache write rate. Defaults to **read**.
    <!-- end id5 -->
    <!-- npu="910" id6 -->
    - Atlas training products<br>**read**: read events, that is, the L3 cache read rate.<br>**write**: write events, that is, the L3 cache write rate. Defaults to **read**.
    <!-- end id6 -->
    <!-- npu="310b" id4 -->
    - Atlas 200I/500 A2 inference products<br>**read**: read events, that is, the L3 cache read rate.<br>**write**: write events, that is, the L3 cache write rate. Defaults to **read**.
    <!-- end id4 -->
    <!-- npu="910b" id3 -->
    - Atlas A2 products<br>**read**: read events, that is, the L3 cache read rate.<br>**write**: write events, that is, the L3 cache write rate. Defaults to **read**.
    <!-- end id3 -->
    <!-- npu="A3" id2 -->
    - Atlas A3 products<br>**read**: read events, that is, the L3 cache read rate.<br>**write**: write events, that is, the L3 cache write rate. Defaults to **read**.
    <!-- end id2 -->
- ACL\_PROF\_SYS\_IO\_FREQ = 5: NIC and RoCE profiling frequency. The value range is [1, 100], in Hz.
    <!-- npu="950" id1 -->
    Ascend 950PR&950DT products: The maximum allowed profiling frequency for QoS and SoC data is 10,000 Hz. For other profiling items, this limit remains 100 Hz, and any configuration higher than 100 Hz will automatically fall back to 100 Hz.
    <!-- end id1 -->
    <!-- npu="310b" id7 -->
    - Atlas 200I/500 A2 inference products: NIC data can be collected. The parameters do not take effect in containers.
    <!-- end id7 -->
    <!-- npu="910b" id8 -->
    - Atlas A2 products: NIC and RoCE data can be collected.
    <!-- end id8 -->
    <!-- npu="A3" id9 -->
    - Atlas A3 products: NIC and RoCE data can be collected.
    <!-- end id9 -->
- ACL_PROF_SYS_INTERCONNECTION_FREQ = 6: collective communication bandwidth (HCCS), PCIe data collection switch, inter-chip transmission bandwidth data collection frequency, SIO data, and UB bandwidth data collection switch. The value range is [1, 50], in Hz. The collected content varies slightly depending on the product.
- ACL\_PROF\_DVPP\_FREQ: DVPP profiling frequency. The value range is [1, 100].
- ACL_PROF_HOST_SYS = 8: process-level data profiling switch on the host. The value can be `cpu` or `mem`.
- ACL_PROF_HOST_SYS_USAGE = 9: system and all-process data profiling switch on the host. The value can be `cpu` or `mem`.
- ACL_PROF_HOST_SYS_USAGE_FREQ = 10: frequency of collecting CPU and memory usage data. The value range is [1, 50].
  - ACL_PROF_FTRACE = 17: switch for collecting host ftrace events. The value is a `subsystem/event` string; separate multiple events with commas, for example `sched/sched_switch,irq/irq_handler_entry`. It requires a mounted tracefs and either root permission or passwordless sudo (`sudo -n`).
  - ACL_PROF_FTRACE_PERIOD = 18: host ftrace collection window in seconds. The value range is [0, 86400] and the default value is 0, which means the window follows the profiling lifetime.
  - ACL_PROF_FTRACE_BUFSIZE = 19: host ftrace ring buffer size per CPU in KB. The value range is [1024, 4194304] and the default value is 4096. A larger buffer is less likely to drop events but uses more host kernel memory.
