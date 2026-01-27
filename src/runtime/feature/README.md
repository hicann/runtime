[TOC]

# Runtime发布件

## 概述

`Runtime`作为AI计算调度运行平台，提供了`Device`管理、`Context`管理、`Stream`管理、`Event`管理， 内存管理、模型加载与执行、算子加载与执行等`API`，供GE/HCCL/ACL等使用，使能硬件资源。

## 发布二进制说明
本目录代码后续定位为运行时库源码，当前只有一个库发布，为了解决二进制大小膨胀，新增芯片适配代码对其他芯片的影响，易于扩展代码，计划发布多个so，实现插件式管理。功能及包含源码如下：

### libruntime.so

#### 功能

对外c api的实现源码

#### 源码路径

- feature/src/api目录：
  - 对外API代码，被GE/HCCL/ACL等链接，会链接slog等三方通用库，以及libruntime_common.so；

  - 通过dlopen libruntime_xx.so，然后dlsym方式获取Runtime::Instance返回的抽象类指针，通过访问该指针的纯虚public方法实现具体功能；

- feature/src/api/api.cc代码：Api::Instance实例构造代码；

- feature/src/plugin_manage/runtime_keeper.cc：
  - RuntimeKeeper 类定义，用于生成全局对象static RuntimeKeeper g_runtimeKeeper，同时负责Runtime::Instance构造；

  - 在RuntimeKeeper类成员中新增so句柄，修改BootRuntime实现，根据芯片形态，构造不同的Runtime::Instance对象指针;

- feature/src/profiler/prof_map_ge_model_device.cc:
  - API代码中使用到的geModelId-deviceId管理单例ProfMapGeModelDevice;

#### 注意事项
- 在低版本CentOS中，会出现glibc(2.x < 2.21)的bug，pthread接口初始化tls失败，x86环境增加线程变量后，问题规避，aarch64增加线程变量会失败，所以
该so后续不新增线程变量。

### libruntime_common.so

#### 功能

只包含无状态、无业务相关C++类代码的使用、被API（libruntime.so）和内部代码（libruntime_xx.so）都使用的公共代码或者工具类代码；包含全局变量的单例；会被Runtime::Instance对象使用的单例代码；被 libruntime.so以PRIVATE方式链接，同步发布给GE/HCCL/ACL等，也被libruntime_xx.so链接使用。

#### 源码路径

- feature/src/common:工具类代码，单例;

#### 注意事项

为了确保单例生命周期的正确性，libruntime_common.so对应的目录代码会包含单例源码，要求:

- 单例代码中无业务逻辑，无业务相关C++类和对象的使用，即不能直接访问Device/Stream等类对象，指针类型可以使用，但不能通过指针访问其方法或者成员变量;
- 由于该so只能被链接，所以不能使用Runtime::Instance，因为该指针在不同的so中实现方法不一致（但是内存中只有一份）;

**举例**: ContextDataManager单例的功能是管理老流程中ContextManager的成员数据set和map，由于libcommon.so处理依赖关系的最下层，不能向上依赖真实的业务逻辑libruntime_xx.so中的具体Context实现逻辑，因此ContextDataManager单例中只能对Context *进行操作，而不能直接访问通过Context 指针访问Context的具体成员和方法，否则编译libruntime_common.so时会链接失败，找不到Context的具体成员和方法定义。

```C++
class ContextDataManager {
public:
......
private:
  mmRWLock_t setLock_;
  std::unordered_set<Context *> set_;
  mmRWLock_t map_lock_;
  std::unordered_map<Context *, std::shared_ptr<MultiDieContext>> map_;
};
```

### libruntime_xx.so

#### 功能

部署具体业务逻辑代码，除libruntime.so和libruntime_common.so之外的代码。当前计划以David为界，历史代码合并为一个so，后续代码新增为一个so。

#### 源码路径

- 除api和commong外的所有代码：
  - 不同so的实现差异代码，建议通过子目录隔离，在CMakeLists.txt中target源码目录区分, 会链接slog等三方通用库，链接libruntime_common.so;
- feature/src/plugin_manage/plugin_old_arch.cc：新增构造和析构Runtime对象指针的函数：
  - Runtime* ConstructRuntimeImpl()：根据芯片类型，构造对应的Runtime实例
  - void DestructorRuntimeImpl(Runtime* rt)：删除Runtime实例

#### 注意事项

- libruntime_xx.so以dlopen的方式被libruntime.so打开，被libruntime.so依赖，因此该so中不能调用上层libruntime.so中实现的API接口，即rtXXXX接口，否则会造成反向依赖；
- 不同的libruntime_xx.so中含有不同的Runtime子类实现，Runtime通过public方式继承纯虚接口类RuntimeIntf，实现其纯虚接口，根据C++规范，子类Runtime类的析构过程中，所有的代码，不能调用RuntimeIntf里面的纯虚函数(会导致未定义行为（Undefined Behavior），甚至可能引发程序崩溃（例如触发 pure virtual method called 异常）)
- 上库验证:由于libruntime_xx.so以dlopen的方式被libruntime.so打开, 新增源文件时,上库前一定要上板验证dlopen是否正常,否则容易出现未定义符号（如新增函数源文件未放到libruntime_xx.so的CMakeList）
- 低版本的glibc,aarch64等环境有系统bug,该so中不能出现过大的线程变量，__THREAD__LOCAL__ 或thread_local修饰的变量
  如果有较大需求，请优先使用动态pthread_key_t相关方法，代码存放在libruntime_common.so中。

## 目录结构说明

本源码仓目录结构如下：

```feature
├── CMakeLists.txt                        # 编译目录
├── inc                                   # 头文件
│   ├── aicpu_err_msg.hpp
│   ├── aicpu_scheduler_agent.hpp
│   ├── api_impl.hpp
│   ├── arg_loader.hpp
│   ├── atrace_log.hpp
│   ├── base.hpp
│   ├── capability.hpp
│   ├── common                            # 部署在libruntime_common.so对应源码的头文件
│   │   ├── errcode_manage.hpp
│   │   ├── error_message_manage.hpp
│   │   ├── rw_lock.h
│   │   └── thread_local_container.hpp
│   ├── spec
|   |   ├── base_info.hpp                 # 各soc sq数量, 超时时间，日志级别等信息  
|   |   ├── config_define_mdc.hpp         # mdc 各个加速器 soc 等信息
|   |   ├── config_define_mini.hpp        # mini 各个加速器 soc 等信息
|   ├── config_define.hpp                 # dc  各个加速器 soc 等信息
│   ├── config.hpp
│   ├── context
│   │   ├── context.hpp
│   │   ├── context_manage.hpp
│   │   └── context_protect.hpp
│   ├── ...                               # 其他头文件
│   └── task_submit.hpp
└── src                                   # 源码
    ├── aicpu_err_msg.cc
    ├── aicpu_scheduler_agent.cc
    ├── api                               # 只部署在libruntime.so的源码，对外提供的API接口，不能包含业务代码
    │   ├── api.cc                        # 部署在libruntime.so
    │   ├── api_c.cc
    │   ├── api_c_device.cc
    │   ├── api_c_event.cc
    │   ├── api_c.h
    │   ├── api_c_kernel.cc
    │   ├── api_c_mbuf.cc
    │   ├── api_c_memory.cc
    │   ├── api_c_model.cc
    │   ├── api_c_soc.cc
    │   ├── api_c_stream.cc
    │   ├── api_global_err.cc
    │   ├── api_global_err.h
    │   ├── api.hpp
    │   ├── api_preload_task.cc           # NANO芯片编译态API接口代码
    │   ├── inner.cc
    │   └── interface_adpt.cc
    ├── api_impl                          # api实现的封装层，包含error处理，具体实现等，在libruntime_xx.so
    │   ├── api_decorator.cc
    │   ├── api_decorator.hpp
    │   ├── api_error.hpp
    │   ├── api_error.cc
    │   └── api_impl.cc
    ├── arg_loader
    │   ├── uma_arg_loader.cc
    │   └── uma_arg_loader.hpp
    ├── atrace_log.cc
    ├── callback
    │   ├── device_state_callback_manager.cc
    │   ├── device_state_callback_manager.hpp
    │   ├── prof_ctrl_callback_manager.hpp
    │   ├── stream_state_callback_manager.cc
    │   ├── stream_state_callback_manager.hpp
    │   ├── task_fail_callback_manager.cc
    │   └── task_fail_callback_manager.hpp
    ├── capability.cc
    ├── common                           # 公共使用，代码中无业务对象构造和方法调用的代码，例如通用工具类，部署在libruntime_common.so中
    │   ├── context_data_manage.cc
    │   ├── context_data_manage.h
    │   ├── device_sq_cq_pool.cc
    │   ├── device_sq_cq_pool.hpp
    │   ├── errcode_manage.cc
    │   ├── error_code.cc
    │   ├── error_code.h
    │   ├── error_message_manage.cc
    │   ├── heterogenous.cc
    │   ├── heterogenous.h
    │   ├── prof_ctrl_callback_manager.cc
    │   ├── profiling_agent.cc
    │   ├── soc_info.cc
    │   ├── soc_info.h
    │   ├── task_fail_callback_data_manager.cc
    │   ├── task_fail_callback_data_manager.h
    │   ├── thread_local_container.cc
    │   ├── inner_thread_local.cpp       # libruntime_xx.so使用
    │   ├── utils.cc
    │   └── utils.h
    ├── config.cc
    ├── context
    │   ├── context.cc
    │   ├── context_manage.cc
    │   └── context_protect.cc
    ├── ctrl_res_pool.cpp
    ├── device                           # device类处理
    │   ├── device.cc
    │   ├── device_error_proc.cc
    │   ├── device.hpp
    │   ├── device_info.hpp
    │   ├── device_msg_handler.cc
    │   ├── raw_device.cc
    │   └── raw_device.hpp
    ├── drv
    │   ├── cpu_driver.cc
    │   ├── driver.cc
    │   ├── npu_driver_base.hpp
    │   ├── npu_driver.cc
    │   ├── npu_driver.hpp
    │   └── npu_driver_tiny.cpp
    ├── dvpp_grp.cc
    ├── elf.cc
    ├── engine
    │   ├── async_hwts_engine.cc
    │   ├── async_hwts_engine.hpp
    │   ├── direct_hwts_engine.cc
    │   ├── direct_hwts_engine.hpp
    │   ├── engine.cc
    │   ├── engine_factory.cc
    │   ├── engine_factory.hpp
    │   ├── hwts_engine.cc
    │   ├── hwts_engine.hpp
    │   ├── package_rebuilder.cc
    │   ├── package_rebuilder.hpp
    │   ├── shm_cq.cc
    │   ├── shm_cq.hpp
    │   ├── stars_engine.cc
    │   └── stars_engine.hpp
    ├── engine_lite.cc
    ├── event.cc
    ├── func    # function模块，包含binary二进制的加载, elf解析，program管理，Kernel注册，算子查找，funcAddr查询
    │   └── binary_loader.cc
    ├── host_task.cc
    ├── kernel.cc
    ├── kstars_ioctl_util.cc
    ├── kstars_stub.cc
    ├── label.cc
    ├── logger.cc
    ├── model.cc
    ├── module.cc
    ├── module.mk
    ├── notify.cc
    ├── onlineprof.cc
    ├── osal.cc
    ├── task_to_sqe.cc
    ├── pctrace.cc
    ├── plugin_manage
    │   ├── plugin_old_arch.cc
    │   ├── runtime_keeper.cc
    │   └── runtime_keeper.h
    ├── pool
    │   ├── bitmap.cc
    │   ├── bitmap.hpp
    │   ├── buffer_allocator.cc
    │   ├── buffer_allocator.hpp
    │   ├── event_expanding.cc
    │   ├── event_expanding.hpp
    │   ├── event_pool.cc
    │   ├── event_pool.hpp
    │   ├── h2d_copy_mgr.cc
    │   ├── h2d_copy_mgr.hpp
    │   ├── memory_list.cc
    │   ├── memory_list.hpp
    │   ├── memory_pool.cc
    │   ├── memory_pool.hpp
    │   ├── memory_pool_manager.cc
    │   ├── memory_pool_manager.hpp
    │   ├── pool.hpp
    │   ├── spm_pool.cc
    │   ├── spm_pool.hpp
    │   ├── task_allocator.cc
    │   └── task_allocator.hpp
    ├── profile
    │   ├── api_profile_decorator.cc
    │   ├── api_profile_decorator.hpp
    │   ├── api_profile_log_decorator.cc
    │   ├── api_profile_log_decorator.hpp
    │   ├── context_record.hpp
    │   ├── npu_driver_record.cc
    │   ├── npu_driver_record.hpp
    │   ├── profile_log_record.cc
    │   ├── profile_log_record.hpp
    │   ├── profiler.cc
    │   ├── profiler.hpp
    │   ├── prof_map_ge_model_device.cc
    │   └── prof_map_ge_model_device.hpp
    ├── program.cc
    ├── runtime.cc
    ├── scheduler.cc
    ├── stars_cond_isa_helper.cc
    ├── stars_david.cc
    ├── stream
    │   ├── coprocessor_stream.cc
    │   ├── coprocessor_stream.hpp
    │   ├── ctrl_stream.cc
    │   ├── ctrl_stream.hpp
    │   ├── engine_stream_observer.cc
    │   ├── engine_stream_observer.hpp
    │   ├── stream.cc
    │   ├── stream.hpp
    │   ├── stream_sqcq_manage.cc
    │   ├── stream_sqcq_manage.hpp
    │   ├── tsch_stream.cc
    │   └── tsch_stream.hpp
    ├── subscribe.cc
    ├── task                          # task构造管理
    │   ├── barrier_task.cc
    │   └── ...
    └── ttlv
```