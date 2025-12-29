# aclprofSetConfig

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

aclprofCreateConfig接口的扩展接口，用于设置性能数据采集参数。

该接口支持多次调用，用户需要保证数据的一致性和准确性。

## 函数原型

```
aclError aclprofSetConfig(aclprofConfigType configType, const char *config, size_t configLength)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| configType | 输入 | 作为configType参数值。每个枚举表示不同采集配置，若要使用该接口下不同的选项采集多种性能数据，则需要多次调用该接口，详细说明如下：<br><br>  - ACL_PROF_STORAGE_LIMIT ：指定落盘目录允许存放的最大文件容量，有效取值范围为[200, 4294967295]，单位为MB。<br>  - ACL_PROF_SYS_HARDWARE_MEM_FREQ：片上内存读写速率、QoS传输带宽、LLC三级缓存带宽、加速器带宽、SoC传输带宽、组件内存占用等的采集频率，范围[1,100]，单位Hz。不同产品的采集内容略有差异，请以实际结果为准。已知在安装有glibc<2.34的环境上采集memory数据，可能触发glibc的一个已知[Bug 19329](https://sourceware.org/bugzilla/show_bug.cgi?id=19329)，通过升级环境的glibc版本可解决此问题。<br> 说明： 对于以下型号，采集任务结束后，不建议用户增大采集频率，否则可能导致SoC传输带宽数据丢失。<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>  - ACL_PROF_LLC_MODE：LLC Profiling采集事件。要求同时设置ACL_PROF_SYS_HARDWARE_MEM_FREQ。可以设置为：read：读事件，三级缓存读速率。write：写事件，三级缓存写速率。默认为read。<br>  - read：读事件，三级缓存读速率。<br>  - write：写事件，三级缓存写速率。默认为read。<br>  - ACL_PROF_SYS_IO_FREQ：NIC、ROCE采集频率，范围[1,100]，单位hz。Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持采集NIC和ROCE。Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持采集NIC和ROCE。<br>  - Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持采集NIC和ROCE。<br>  - Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持采集NIC和ROCE。<br>  - ACL_PROF_SYS_INTERCONNECTION_FREQ：集合通信带宽数据（HCCS）、PCIe数据采集开关、片间传输带宽信息采集频率、SIO数据采集开关，范围[1,50]，单位hz。Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持采集HCCS、PCIe数据、片间传输带宽信息。Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持采集HCCS、PCIe数据、片间传输带宽信息、SIO数据。<br>  - Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持采集HCCS、PCIe数据、片间传输带宽信息。<br>  - Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持采集HCCS、PCIe数据、片间传输带宽信息、SIO数据。<br>  - ACL_PROF_DVPP_FREQ：DVPP采集频率，范围[1,100]。<br>  - ACL_PROF_HOST_SYS：Host侧进程级别的性能数据采集开关，取值包括cpu和mem。<br>  - ACL_PROF_HOST_SYS_USAGE：Host侧系统和所有进程的性能数据采集开关，取值包括cpu和mem。<br>  - ACL_PROF_HOST_SYS_USAGE_FREQ：CPU利用率、内存利用率的采集频率，范围[1,50]。 |
| config | 输入 | 指定配置项参数值。 |
| configLength | 输入 | config的长度，单位为Byte，最大长度不超过256字节。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

先调用aclprofSetConfig接口再调用[aclprofStart](aclprofStart.md)接口，可根据需求选择调用该接口。

