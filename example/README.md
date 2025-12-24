# 样例使用指导
examples目录下提供了一系列Runtime接口样例，包括Device管理、Stream管理、Event管理、内存管理、Kernel执行等，供开发者参考，帮助开发者快速入门，进而掌握Runtime关键特性。

## 样例列表

|样例目录|子目录            | 功能介绍 |
|--------|-----------------|--------------------------|
|device|[0_device_normal](./device/0_device_normal/)|本样例展示了从资源初始化、指定Device计算设备、在Device上执行Add算子、到最后销毁资源的全部流程，是一个基础的使用Device的样例。|
|device|[1_device_multi_thread](./device/1_device_multi_thread/)|本用例展示了多线程的场景如何管理Device，主线程中设置Device，设置资源限制，另一个线程获取Device相关信息（例如昇腾AI处理器版本、Device运行模式、Device资源限制）后，再根据Device资源限制下发和执行和函数任务，线程结束时采用aclrtResetDeviceForce接口释放Device上的资源。|
|device|[2_device_P2P](./device/2_device_P2P/)|本样例展示了如何在多个Device之间进行切换，并进行内存复制。|
|stream|[0_simple_stream](./stream/0_simple_stream/)|本样例展示单Stream下发任务的场景，包括默认Stream下发任务、新建Stream下发任务、在一个Stream多次下发任务并查询状态三个部分。|
|stream|[1_stream_with_failure_mode](./stream/1_stream_with_failure_mode/)|本样例展示Stream设置遇错即停并且模拟运行核函数时发生错误的场景。|
|stream|[2_multi_stream](./stream/2_multi_stream/)|本样例展示了多个Stream之间流间任务同步功能。|
|event|[0_event_status](./event/0_event_status/)|本样例展示了Event的不同状态，包括创建后，记录后，同步后。|
|event|[1_event_timestamp](./event/1_event_timestamp/)|本样例展示了Event计时的功能，既可以记录时间帧，还可以计算时间差。|
|memory|[0_h2h_memory_copy](./memory/0_h2h_memory_copy/)|本样例展示了Host内的内存复制功能。|
|memory|[1_h2d_sync_memory_copy](./memory/1_h2d_sync_memory_copy/)|本样例展示了Host到Device的内存复制，使用aclrtMemcpy内存复制接口。|
|memory|[2_h2d_async_memory_copy](./memory/2_h2d_async_memory_copy/)|本样例展示了Host到Device的内存复制，使用aclrtMemcpyAsync内存复制接口。|
|memory|[3_d2h_sync_memory_copy](./memory/3_d2h_sync_memory_copy/)|本样例展示了Device到Host的内存复制，使用aclrtMemcpy内存复制接口。|
|memory|[4_d2h_async_memory_copy](./memory/4_d2h_async_memory_copy/)|本样例展示了Device到Host的内存复制，使用aclrtMemcpyAsync内存复制接口。|
|memory|[5_d2d_sync_memory_copy](./memory/5_d2d_sync_memory_copy/)|本样例展示了Device内的内存复制，使用aclrtMemcpy内存复制接口。|
|memory|[6_d2d_async_memory_copy](./memory/6_d2d_async_memory_copy/)|本样例展示了Device内的内存复制，使用aclrtMemcpyAsync内存复制接口。|
|memory|[7_physical_memory_sharing_withpid](./memory/7_physical_memory_sharing_withpid/)|本样例展示了同一个Device、两个进程间的物理内存共享，但在共享内存时启用进程白名单校验。|
|memory|[8_physical_memory_sharing_withoutpid](./memory/8_physical_memory_sharing_withoutpid/)|本样例展示了同一个Device、两个进程间的物理内存共享，在共享内存时关闭进程白名单校验。|
|memory|[9_multistream_sync_memory](./memory/9_multistream_sync_memory/)|本样例会触发两个线程，一个线程A等待指定内存中的数据满足一定条件后解除阻塞，一个线程B向指定内存中写入数据，在线程B写入满足条件的数据之前线程A将持续阻塞。|
|memory|[10_ipc_memory_withpid](./memory/10_ipc_memory_withpid)|本样例展示了同一个Device、两个进程间的内存共享，在共享内存时启用进程白名单校验。|
|memory|[11_ipc_memory_withoutpid](./memory/11_ipc_memory_withoutpid)|本样例展示了同一个Device、两个进程间的内存共享，在内存共享时关闭进程白名单校验。|
|callback|[0_simple_callback](./callback/0_simple_callback/)|本样例展示了在Stream上下发一个Host侧函数，由用户显式注册线程，触发Host侧函数调用。|
|callback|[1_callback_hostfunc](./callback/1_callback_hostfunc/)|本样例展示了在Stream上下发一个Host侧函数，该Host侧函数将在当前已下发的任务执行之后被调用，并会阻塞之后添加的任务。|
|callback|[2_callback_exception](./callback/2_callback_exception/)|本样例展示了如何通过错误回调函数获取任务的异常信息，包括Device ID、Stream ID、Task ID、Error Code等。|
|model|[0_simple_model](./model/0_simple_model/)|本样例展示了如何捕获Stream中的任务并创建一个模型实例，然后执行该模型实例得到结果。|
|model|[1_model_update](./model/1_model_update/)|本样例展示了捕获一个模型实例后如何更新该实例中的任务。|
|model|[2_model_switch](./model/2_model_switch/)|本样例展示了如何使用aclmdlRIBuildBegin接口创建模型实例，并且在任务中实现了Stream跳转以及Stream激活。|
|kernel|[0_launch_kernel](./kernel/0_launch_kernel/)|本样例展示了如何基于Launch Kernel方式加载与执行Add算子。|
|kernel|[1_launch_kernel_with_reslimit](./kernel/1_launch_kernel_with_reslimit/)|本样例展示了在设置了当前进程的Device资源限制下，Add算子的加载与执行。|
|notify|[0_ipc_notify_withpid](./notify/0_ipc_notify_withpid)|本样例展示了两个Device、两个进程间的Notify共享，但在共享Notify时启用进程白名单校验。|
|notify|[1_ipc_notify_withoutpid](./notify/1_ipc_notify_withoutpid)|本样例展示了两个Device、两个进程间的Notify共享，但在共享Notify时关闭进程白名单校验。|
|adump|[0_adump_args](./adump/0_adump_args)|本样例展示了单算子执行场景下，使用aclopStartDumpArgs和aclopStopDumpArgs接口Dump算子信息。|
|adump|[1_adump_callback](./adump/1_adump_callback)|本样例展示了单算子执行场景下，使用acldumpRegCallback和acldumpUnregCallback接口Dump算子信息。|
|profiling|[0_create_config](./profiling/0_create_config)|本样例展示了Profiling采集、解析和展示性能数据。|
|profiling|[1_msproftx](./profiling/1_msproftx)|本样例展示了使用msproftx扩展接口采集、解析和展示性能数据。|
|profiling|[2_subscribe_model](./profiling/2_subscribe_model)|本样例展示了订阅算子信息, 实现将采集到的Profiling数据解析后写入管道，由用户读入内存，再由用户调用接口获取性能数据。|

## 环境准备
编译运行样例前，需获取固件、驱动及CANN软件包安装，详情步骤请参见《[CANN软件安装指南](https://www.hiascend.com/document/redirect/CannCommercialInstSoftware)》。

若对runtime仓src目录下的源码有定制，那么在安装CANN软件之后，还需编译源码并部署到环境上，具体操作请参见runtime仓下的[README](../README.md)。

有些样例依赖ops算子包，需要根据产品型号和环境架构下载安装对应的软件包。

## 编译运行

  1.设置环境变量。
  ```bash
  # ${ascend_name}替换为昇腾AI处理器的型号
  export SOC_VERSION=${ascend_name}
  # 部分样例中涉及调用AscendC算子，需配置AscendC编译器ascendc.cmake所在的路径
  # 可在CANN包安装路径下查找ascendc_kernel_cmake，例如find ./ -name ascendc_kernel_cmake，并将${cmake_path}替换为ascendc_kernel_cmake所在路径
  export ASCENDC_CMAKE_DIR=${cmake_path}
  # ${install_path}替换为CANN toolkit包的安装路径，默认安装在`/usr/local/Ascend`目录
  export ASCEND_INSTALL_PATH=${install_path}/cann
  ```

  2.下载样例代码并上传至安装CANN软件的环境，切换到样例目录。
  ```bash
  # 此处以0_h2h_memory_copy样例为例
  cd ${git_clone_path}/example/memory/0_h2h_memory_copy
  ```

  3.执行以下命令运行样例。
  ```bash
  # 请注意部分用例的运行命令不同，具体以各用例目录下的README.md中的编译运行命令为准
  bash run.sh
  ```