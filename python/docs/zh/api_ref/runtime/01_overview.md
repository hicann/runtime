# 1. 概述

本章节介绍 CANN Runtime API 的基本概念、pyACL表达约定、同步/异步接口说明及废弃接口列表。

## pyACL表达约定

### 接口命名规则

接口命名同时满足如下规则：

1. acl+_接口类别缩写_+_操作动词_+_对象_
2. 操作动词和对象均采用首字母大写。

### 接口类别

| 接口类别 | 缩写 | 描述 |
| --- | --- | --- |
| runtime | rt | 表示运行管理类的接口 |
| CBLAS | blas | 表示blas类的接口 |
| Profiling | prof | 表示Profiling配置类接口 |

>[!NOTE]
>
>- 缩写原则上不超过4个字母。
>- 在接口命名中，如果类别与操作对象重叠时，操作动词后的对象将省略。如：acl.mdl.load\_from\_file\_with\_mem，表示model类接口，这个接口表示含义是load model from file，因此在接口命名中Load后面mdl将被省略。

### 变量命名

本文代码示例中涉及的变量，其中，命名带下划线的变量（例如：\_deviceId\_）表示类的私有变量。

### 表达约定

本文档中存在“支持”、“不支持”、“试验”、“预留”、“废弃”等接口或参数状态的标识，这类标识的含义如下：

- “支持”：表示支持某接口或参数。

- “不支持”：表示不支持某接口或参数，若使用该接口或参数，将产生未定义行为，例如接口返回报错、后续业务功能异常。

- “预留”：表示接口或参数预留，当前暂未实现或功能不完善，不支持调用，后续版本可能开放。

- “废弃”：后续版本待删除，建议使用文档中的替换接口或参数。

## 同步和异步API说明

CANN支持以下几类显式同步，调用此类接口后，主机线程会阻塞直到相关的任务执行完成。

- **设备同步：acl.rt.synchronize\_device**

    阻塞当前主机线程直到Device上所有显式或隐式创建的Stream都完成所有先前下发的任务。应该尽量少使用该函数，以免拖延主机运行。

- **流同步：acl.rt.synchronize\_stream**

    阻塞当前主机线程直到指定的Stream中完成所有下发的任务。

- **事件同步：acl.rt.synchronize\_event**

    阻塞当前主机线程直到指定的Event事件完成。属于更细粒度的同步。

**对于异步接口**，主机线程调用异步接口后仅代表下发任务，在任务未完成前，函数就已经返回给主机线程。用户需要调用以上显式同步接口阻塞主机线程，等待任务完成。

## 废弃接口/返回码列表

### 接口

- [acl.get\_data\_buffer\_size](datatypes/function-get_data_buffer_size.md)接口

    此接口后续版本会废弃，请使用[acl.get\_data\_buffer\_size\_v2](datatypes/function-get_data_buffer_size_v2.md)接口。

- [acl.rt.query\_event](event/function-query_event.md)接口

    此接口后续版本会废弃，请使用[acl.rt.query\_event\_status](event/function-query_event_status.md)接口。

- [acl.util.numpy\_to\_ptr](util/function-numpy_to_ptr.md)接口

    此接口后续版本会废弃，请使用[acl.util.bytes\_to\_ptr](util/function-bytes_to_ptr.md)接口。

- [acl.util.numpy\_contiguous\_to\_ptr](util/function-numpy_contiguous_to_ptr.md)接口

    此接口后续版本会废弃，请使用[acl.util.bytes\_to\_ptr](util/function-bytes_to_ptr.md)接口。

- [acl.util.ptr\_to\_numpy](util/function-ptr_to_numpy.md)接口

    此接口后续版本会废弃，请使用[acl.util.ptr\_to\_bytes](util/function-ptr_to_bytes.md)接口。

### 返回码

- [ACL\_ERROR\_NONE](datatypes/aclError.md)

    此返回码后续版本会废弃，请使用[ACL\_SUCCESS](datatypes/aclError.md)返回码。

- [ACL\_ERROR\_NOT\_STATIC\_AIPP](datatypes/aclError.md)

    此返回码后续版本会废弃，请使用[ACL\_ERROR\_GE\_AIPP\_NOT\_EXIST](datatypes/aclError.md)返回码。

- [ACL\_ERROR\_STREAM\_NOT\_SUBSCRIBE](datatypes/aclError.md)

    此返回码后续版本会废弃，请使用[ACL\_ERROR\_RT\_STREAM\_NO\_CB\_REG](datatypes/aclError.md)返回码。

- [ACL\_ERROR\_THREAD\_NOT\_SUBSCRIBE](datatypes/aclError.md)

    此返回码后续版本会废弃，请使用[ACL\_ERROR\_RT\_THREAD\_SUBSCRIBE](datatypes/aclError.md)返回码。

- [ACL\_ERROR\_WAIT\_CALLBACK\_TIMEOUT](datatypes/aclError.md)

    此返回码后续版本会废弃，请使用[ACL\_ERROR\_RT\_REPORT\_TIMEOUT](datatypes/aclError.md)返回码。

- [ACL\_ERROR\_INVALID\_DEVICE](datatypes/aclError.md)

    此返回码后续版本会废弃，请使用[ACL\_ERROR\_RT\_INVALID\_DEVICEID](datatypes/aclError.md)返回码。

- [ACL\_ERROR\_GROUP\_NOT\_SET](datatypes/aclError.md)

    此返回码后续版本会废弃，请使用[ACL\_ERROR\_RT\_GROUP\_NOT\_SET](datatypes/aclError.md)返回码。

- [ACL\_ERROR\_GROUP\_NOT\_CREATE](datatypes/aclError.md)

    此返回码后续版本会废弃，请使用[ACL\_ERROR\_RT\_GROUP\_NOT\_CREATE](datatypes/aclError.md)返回码。
