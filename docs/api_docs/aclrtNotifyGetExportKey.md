# aclrtNotifyGetExportKey<a name="ZH-CN_TOPIC_0000002331369344"></a>

## AI处理器支持情况<a name="section8178181118225"></a>

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

## 功能说明<a name="section36583473819"></a>

将本进程中指定Notify设置为IPC（Inter-Process Communication） Notify，并返回key（即Notify共享名称），用于在多Device上不同进程间实现任务同步。

**本接口需与以下其它关键接口配合使用**，以便实现多Device上不同进程间的任务同步，此处以Device 0上的A进程、Device 1上的B进程为例，说明两个进程间的任务同步接口调用流程:

1.  在A进程中：
    1.  调用[aclrtCreateNotify](aclrtCreateNotify.md)接口创建Notify。
    2.  调用[aclrtNotifyGetExportKey](aclrtNotifyGetExportKey.md)接口导出key（即Notify共享名称）。

        调用[aclrtNotifyGetExportKey](aclrtNotifyGetExportKey.md)接口时，可指定是否启用进程白名单校验，若启用，则需单独调用[aclrtNotifySetImportPid](aclrtNotifySetImportPid.md)接口将B进程的进程ID设置为白名单；反之，则无需调用[aclrtNotifySetImportPid](aclrtNotifySetImportPid.md)接口。

    3.  调用[aclrtWaitAndResetNotify](aclrtWaitAndResetNotify.md)接口下发等待任务。
    4.  调用[aclrtDestroyNotify](aclrtDestroyNotify.md)接口销毁Notify。

        涉及IPC Notify的进程都需要释放Notify，所有涉及IPC Notify的进程都完成释放操作，Notify才真正释放。

2.  在B进程中：
    1.  调用[aclrtDeviceGetBareTgid](aclrtDeviceGetBareTgid.md)接口，获取B进程的进程ID。

        本接口内部在获取进程ID时已适配物理机、虚拟机场景，用户只需调用本接口获取进程ID，再配合其它接口使用，达到内存共享的目的。若用户不调用本接口、自行获取进程ID，可能会导致后续使用进程ID异常。

    2.  调用[aclrtNotifyImportByKey](aclrtNotifyImportByKey.md)获取key的信息，并返回本进程可以使用的Notify指针。

        调用[aclrtIpcMemImportByKey](aclrtIpcMemImportByKey.md)接口前，需确保IPC Notify，不能提前释放。

    3.  调用[aclrtRecordNotify](aclrtRecordNotify.md)接口下发Record任务。
    4.  调用[aclrtDestroyNotify](aclrtDestroyNotify.md)接口销毁Notify。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtNotifyGetExportKey(aclrtNotify notify, char *key, size_t len, uint64_t flags)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="72%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p1588612558270"><a name="p1588612558270"></a><a name="p1588612558270"></a>notify</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1688525512278"><a name="p1688525512278"></a><a name="p1688525512278"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p7884145522717"><a name="p7884145522717"></a><a name="p7884145522717"></a>指定Notify。</p>
</td>
</tr>
<tr id="row1141161375"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p10884755182711"><a name="p10884755182711"></a><a name="p10884755182711"></a>key</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p188831655192715"><a name="p188831655192715"></a><a name="p188831655192715"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p11883165517279"><a name="p11883165517279"></a><a name="p11883165517279"></a>Notify共享名称。</p>
</td>
</tr>
<tr id="row17312161210424"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p15882155510275"><a name="p15882155510275"></a><a name="p15882155510275"></a>len</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p138822558270"><a name="p138822558270"></a><a name="p138822558270"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p2881155152711"><a name="p2881155152711"></a><a name="p2881155152711"></a>Notify共享名称的长度，最小长度为65。</p>
</td>
</tr>
<tr id="row72513257495"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p27831923114713"><a name="p27831923114713"></a><a name="p27831923114713"></a>flags</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p178311230472"><a name="p178311230472"></a><a name="p178311230472"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p1349185435919"><a name="p1349185435919"></a><a name="p1349185435919"></a>是否启用进程白名单校验。</p>
<p id="p6169115715920"><a name="p6169115715920"></a><a name="p6169115715920"></a>取值为如下宏：</p>
<a name="ul33464527015"></a><a name="ul33464527015"></a><ul id="ul33464527015"><li>ACL_RT_NOTIFY_EXPORT_FLAG_DEFAULT：默认值，启用进程白名单校验。<p id="p1410617497187"><a name="p1410617497187"></a><a name="p1410617497187"></a>配置为该值时，需单独调用<a href="aclrtNotifySetImportPid.md">aclrtNotifySetImportPid</a>接口将使用Notify共享名称的进程ID设置为白名单。</p>
</li><li>ACL_RT_NOTIFY_EXPORT_FLAG_DISABLE_PID_VALIDATION：关闭进程白名单校验。<p id="p5951651141816"><a name="p5951651141816"></a><a name="p5951651141816"></a>配置为该值时，则无需调用<a href="aclrtNotifySetImportPid.md">aclrtNotifySetImportPid</a>接口。</p>
</li></ul>
<p id="p18200675010"><a name="p18200675010"></a><a name="p18200675010"></a>宏的定义如下：</p>
<pre class="screen" id="screen158584141105"><a name="screen158584141105"></a><a name="screen158584141105"></a>#define ACL_RT_NOTIFY_EXPORT_FLAG_DEFAULT                0x0UL
#define ACL_RT_NOTIFY_EXPORT_FLAG_DISABLE_PID_VALIDATION 0x02UL</pre>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section177420203915"></a>

昇腾虚拟化实例场景不支持该操作。

