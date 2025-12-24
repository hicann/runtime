# aclrtIpcMemGetExportKey<a name="ZH-CN_TOPIC_0000002365447501"></a>

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

在本进程中将指定Device内存设置为IPC（Inter-Process Communication）共享内存，并返回共享内存key，以便后续将内存共享给其它进程。

**本接口需与以下其它关键接口配合使用**，以便实现内存共享，此处以A、B进程为例，说明两个进程间的内存共享接口调用流程:

1.  在A进程中：
    1.  调用[aclrtMalloc](aclrtMalloc.md)接口申请内存。
    2.  调用[aclrtIpcMemGetExportKey](aclrtIpcMemGetExportKey.md)接口导出共享内存key。

        调用[aclrtIpcMemGetExportKey](aclrtIpcMemGetExportKey.md)接口时，可指定是否启用进程白名单校验，若启用，则需单独调用[aclrtIpcMemSetImportPid](aclrtIpcMemSetImportPid.md)接口将B进程的进程ID设置为白名单；反之，则无需调用[aclrtIpcMemSetImportPid](aclrtIpcMemSetImportPid.md)接口。

    3.  调用[aclrtIpcMemClose](aclrtIpcMemClose.md)接口关闭IPC共享内存。

        B进程调用[aclrtIpcMemClose](aclrtIpcMemClose.md)接口关闭IPC共享内存后，A进程再关闭IPC共享内存，否则可能导致异常。

    4.  调用[aclrtFree](aclrtFree.md)接口释放内存。

2.  在B进程中：
    1.  调用[aclrtDeviceGetBareTgid](aclrtDeviceGetBareTgid.md)接口，获取B进程的进程ID。

        本接口内部在获取进程ID时已适配物理机、虚拟机场景，用户只需调用本接口获取进程ID，再配合其它接口使用，达到内存共享的目的。若用户不调用本接口、自行获取进程ID，可能会导致后续使用进程ID异常。

    2.  调用[aclrtIpcMemImportByKey](aclrtIpcMemImportByKey.md)获取key的信息，并返回本进程可以使用的Device内存地址指针。

        调用[aclrtIpcMemImportByKey](aclrtIpcMemImportByKey.md)接口前，需确保待共享内存存在，不能提前释放。

    3.  调用[aclrtIpcMemClose](aclrtIpcMemClose.md)接口关闭IPC共享内存。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtIpcMemGetExportKey(void *devPtr, size_t size, char *key, size_t len, uint64_t flags)
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
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p8636113813418"><a name="p8636113813418"></a><a name="p8636113813418"></a>devPtr</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p5636538184111"><a name="p5636538184111"></a><a name="p5636538184111"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p5635438174114"><a name="p5635438174114"></a><a name="p5635438174114"></a>Device内存地址。</p>
</td>
</tr>
<tr id="row1141161375"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p16349387413"><a name="p16349387413"></a><a name="p16349387413"></a>size</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p20634123894115"><a name="p20634123894115"></a><a name="p20634123894115"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p19633193884117"><a name="p19633193884117"></a><a name="p19633193884117"></a>内存大小，单位Byte。</p>
</td>
</tr>
<tr id="row12781204211413"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p1278184212414"><a name="p1278184212414"></a><a name="p1278184212414"></a>key</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p87818427418"><a name="p87818427418"></a><a name="p87818427418"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p678112422418"><a name="p678112422418"></a><a name="p678112422418"></a>共享内存key。</p>
</td>
</tr>
<tr id="row5654857144110"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p13654155734113"><a name="p13654155734113"></a><a name="p13654155734113"></a>len</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p156541557204115"><a name="p156541557204115"></a><a name="p156541557204115"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p14654957154114"><a name="p14654957154114"></a><a name="p14654957154114"></a>key的长度，固定配置为65。</p>
</td>
</tr>
<tr id="row1378382317476"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p27831923114713"><a name="p27831923114713"></a><a name="p27831923114713"></a>flag<span id="ph153520292342"><a name="ph153520292342"></a><a name="ph153520292342"></a>s</span></p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p178311230472"><a name="p178311230472"></a><a name="p178311230472"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p1349185435919"><a name="p1349185435919"></a><a name="p1349185435919"></a>是否启用进程白名单校验。</p>
<p id="p6169115715920"><a name="p6169115715920"></a><a name="p6169115715920"></a>取值为如下宏：</p>
<a name="ul33464527015"></a><a name="ul33464527015"></a><ul id="ul33464527015"><li>ACL_RT_IPC_MEM_EXPORT_FLAG_DEFAULT：默认值，启用进程白名单校验。<p id="p1410617497187"><a name="p1410617497187"></a><a name="p1410617497187"></a>配置为该值时，需单独调用<a href="aclrtIpcMemSetImportPid.md">aclrtIpcMemSetImportPid</a>接口将使用共享内存key的进程ID设置为白名单。</p>
</li><li>ACL_RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION：关闭进程白名单校验。<p id="p5951651141816"><a name="p5951651141816"></a><a name="p5951651141816"></a>配置为该值时，则无需调用<a href="aclrtIpcMemSetImportPid.md">aclrtIpcMemSetImportPid</a>接口。</p>
</li></ul>
<p id="p18200675010"><a name="p18200675010"></a><a name="p18200675010"></a>宏的定义如下：</p>
<pre class="screen" id="screen158584141105"><a name="screen158584141105"></a><a name="screen158584141105"></a>#define ACL_RT_IPC_MEM_EXPORT_FLAG_DEFAULT                0x0UL
#define ACL_RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION 0x1UL</pre>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section158721720145511"></a>

不同Device上的两个进程通过IPC共享时，如下图，Device 0上的A进程通过IPC方式将内存共享给Device 1上的B进程，在B进程中使用此共享内存地址时：

-   内存复制时，不支持根据源内存地址指针、目的内存地址指针自动判断复制方向；不支持Host-\>Device或Device-\>Host方向的内存复制操作，同步复制、异步复制都不支持；不支持同一个Device内的同步内存复制，但支持同一个Device内的异步内存复制；
-   支持Cube计算单元、Vector计算单元跨片访问。

![](figures/同步等待流程_多Device场景.png)

同一个Device上的两个进程通过IPC共享内存时，不存在以上约束。

