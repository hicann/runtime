# device

本目录聚焦 Device 初始化、切换、多线程使用以及 Device 间数据交互能力。

## 样例列表

- [0_device_normal](./0_device_normal/README.md)：演示单 Device 场景下的基础初始化、执行和释放流程。
- [1_device_multi_thread](./1_device_multi_thread/README.md)：演示多线程场景下的 Device 使用方式。
- [2_device_P2P](./2_device_P2P/README.md)：演示 Device 间 P2P 数据拷贝能力。
- [3_device_identity_mapping](./3_device_identity_mapping/README.md)：枚举用户可见 Device，查询 PCI Bus ID 和 UUID，并校验用户、逻辑与物理设备 ID 的双向映射。
- [4_capability_based_aggregation](./4_capability_based_aggregation/README.md)：校验物理设备 ID 往返映射，查询硬件规格及 Host/Device 原子能力，并据此选择业务计数汇总路径。
