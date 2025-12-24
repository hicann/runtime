# aclrtIpcGetEventHandle<a name="ZH-CN_TOPIC_0000002531369344"></a>

## AI处理器支持情况<a name="section8198181118225"></a>

<a name="table38301303189"></a>
<table><thead align="left"><tr id="row20831180131817"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="p1883113061818"><a name="p1883113061818"></a><a name="p1883113061818"></a><span id="ph20833205312295"><a name="ph20833205312295"></a><a name="ph20833205312295"></a>AI处理器类型</span></p>
</th>
<th class="cellrowborder" align="center" valign="top" width="42%" id="mcps1.1.3.1.2"><p id="p783113012187"><a name="p783113012187"></a><a name="p783113012187"></a>是否支持</p>
</th>
</tr>
</thead>
<tbody><tr id="row220181016240"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p48327011813"><a name="p48327011813"></a><a name="p48327011813"></a><span id="ph583230201815"><a name="ph583230201815"></a><a name="ph583230201815"></a><term id="zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p7948163910184"><a name="p7948163910184"></a><a name="p7948163910184"></a>√</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p19948143911820"><a name="p19948143911820"></a><a name="p19948143911820"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section46583473819"></a>

将本进程中指定Event设置为IPC（Inter-Process Communication） Event，并返回其handle（即Event句柄），用于在跨进程场景下实现任务同步，支持同一个Device内的多个进程以及跨Devie的多个进程。

**本接口需与以下其它关键接口配合使用**，此处以A进程、B进程为例：

1.  在A进程中：
    1.  调用[aclrtCreateEventExWithFlag](aclrtCreateEventExWithFlag.md)接口创建flag为ACL_EVENT_IPC的Event。
    2.  调用aclrtIpcGetEventHandle接口获取用于进程间通信的Event句柄。

    3.  调用[aclrtRecordEvent](aclrtRecordEvent.md)接口在Stream中插入前面创建的ACL_EVENT_IPC类型的Event。

2.  在B进程中：
    2.  调用[aclrtIpcOpenEventHandle](aclrtIpcOpenEventHandle.md)接口获取A进程中的Event句柄信息，并返回本进程可以使用的Event指针。

    3.  调用[aclrtStreamWaitEvent](aclrtStreamWaitEvent.md)接口阻塞指定Stream的运行，直到指定的Event完成。
    4.  Event使用完成后，调用[aclrtDestroyEvent](aclrtDestroyEvent.md)接口销毁Event。

## 函数原型<a name="section13330182415108"></a>

```
aclError aclrtIpcGetEventHandle(aclrtEvent event, aclrtIpcEventHandle *handle)
```

## 参数说明<a name="section76395119104"></a>

<a name="zh-cn_topic_0122830089_table438764396513"></a>

<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="72%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p1588612558270"><a name="p1588612558270"></a><a name="p1588612558270"></a>event</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1688525512278"><a name="p1688525512278"></a><a name="p1688525512278"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p7884145522717"><a name="p7884145522717"></a><a name="p7884145522717"></a>指定Event。</p><p>仅支持通过<a href="aclrtCreateEventExWithFlag.md">aclrtCreateEventExWithFlag</a>接口创建的、flag为ACL_EVENT_IPC的Event。</p>
</td>
</tr>
<tr id="row1141161375"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p10884755182711"><a name="p10884755182711"></a><a name="p10884755182711"></a>handle</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p188831655192715"><a name="p188831655192715"></a><a name="p188831655192715"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p11883165517279"><a name="p11883165517279"></a><a name="p11883165517279"></a>进程间通信的Event句柄。</p>
</td>
</tr>
</tbody>
</table>


## 返回值说明<a name="section35791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

