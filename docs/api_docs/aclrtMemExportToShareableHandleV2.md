# aclrtMemExportToShareableHandleV2

## AI处理器支持情况

<table><thead align="left"><tr id="zh-cn_topic_0000002219420921_row1993118556414"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="zh-cn_topic_0000002219420921_p29315553419"><a name="zh-cn_topic_0000002219420921_p29315553419"></a><a name="zh-cn_topic_0000002219420921_p29315553419"></a><span id="zh-cn_topic_0000002219420921_ph59311455164119"><a name="zh-cn_topic_0000002219420921_ph59311455164119"></a><a name="zh-cn_topic_0000002219420921_ph59311455164119"></a>AI处理器类型</span></p>
</th>
<th class="cellrowborder" align="center" valign="top" width="42%" id="mcps1.1.3.1.2"><p id="zh-cn_topic_0000002219420921_p59313557417"><a name="zh-cn_topic_0000002219420921_p59313557417"></a><a name="zh-cn_topic_0000002219420921_p59313557417"></a>是否支持</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0000002219420921_row1693117553411"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0000002219420921_p1493195513412"><a name="zh-cn_topic_0000002219420921_p1493195513412"></a><a name="zh-cn_topic_0000002219420921_p1493195513412"></a><span id="zh-cn_topic_0000002219420921_ph1093110555418"><a name="zh-cn_topic_0000002219420921_ph1093110555418"></a><a name="zh-cn_topic_0000002219420921_ph1093110555418"></a><term id="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="zh-cn_topic_0000002219420921_p20931175524111"><a name="zh-cn_topic_0000002219420921_p20931175524111"></a><a name="zh-cn_topic_0000002219420921_p20931175524111"></a>√</p>
</td>
</tr>
<tr id="zh-cn_topic_0000002219420921_row199312559416"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0000002219420921_p0931555144119"><a name="zh-cn_topic_0000002219420921_p0931555144119"></a><a name="zh-cn_topic_0000002219420921_p0931555144119"></a><span id="zh-cn_topic_0000002219420921_ph1693115559411"><a name="zh-cn_topic_0000002219420921_ph1693115559411"></a><a name="zh-cn_topic_0000002219420921_ph1693115559411"></a><term id="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="zh-cn_topic_0000002219420921_p129321955154117"><a name="zh-cn_topic_0000002219420921_p129321955154117"></a><a name="zh-cn_topic_0000002219420921_p129321955154117"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明

将本进程通过[aclrtMallocPhysical](aclrtMallocPhysical.md)接口获取到的Device物理内存handle导出，以便后续将Device物理内存共享给其它进程。

本接口是在接口[aclrtMemExportToShareableHandle](aclrtMemExportToShareableHandle.md)基础上进行了增强，用户可通过shareType参数指定导出AI Server内的共享句柄，或导出跨AI Server的共享句柄。AI Server通常多个NPU设备组成的服务器形态的统称。

本接口的使用流程可参见[aclrtMemExportToShareableHandle](aclrtMemExportToShareableHandle.md)，但本接口需配合调用[aclrtMemSetPidToShareableHandleV2](aclrtMemSetPidToShareableHandleV2.md)接口设置进程白名单、调用[aclrtMemImportFromShareableHandleV2](aclrtMemImportFromShareableHandleV2.md)接口导入共享句柄。

## 函数原型

```
aclError aclrtMemExportToShareableHandleV2(aclrtDrvMemHandle handle, uint64_t flags, aclrtMemSharedHandleType shareType, void *shareableHandle)
```

## 参数说明

<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="19.17%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="13.03%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="67.80000000000001%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="19.17%" headers="mcps1.1.4.1.1 "><p id="p4579181641514"><a name="p4579181641514"></a><a name="p4579181641514"></a>handle</p>
</td>
<td class="cellrowborder" valign="top" width="13.03%" headers="mcps1.1.4.1.2 "><p id="p783015417719"><a name="p783015417719"></a><a name="p783015417719"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="67.80000000000001%" headers="mcps1.1.4.1.3 "><p id="p1039820018572"><a name="p1039820018572"></a><a name="p1039820018572"></a>存放物理内存信息的handle。</p>
<p id="p513515485719"><a name="p513515485719"></a><a name="p513515485719"></a>需先在本进程调用aclrtMallocPhysical接口申请物理内存，该接口调用成功，会返回一个handle。</p>
<p id="p96631222379"><a name="p96631222379"></a><a name="p96631222379"></a>handle与shareableHandle是一一对应的关系，在同一个进程中，不允许一对多、或多对一，否则报错，例如重复调用本接口导出时则会返回报错。</p>
</td>
</tr>
<tr id="row187221499516"><td class="cellrowborder" valign="top" width="19.17%" headers="mcps1.1.4.1.1 "><p id="p67237494519"><a name="p67237494519"></a><a name="p67237494519"></a>flags</p>
</td>
<td class="cellrowborder" valign="top" width="13.03%" headers="mcps1.1.4.1.2 "><p id="p97231849555"><a name="p97231849555"></a><a name="p97231849555"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="67.80000000000001%" headers="mcps1.1.4.1.3 "><p id="p1349185435919"><a name="p1349185435919"></a><a name="p1349185435919"></a>是否启用进程白名单校验。</p>
<p id="p6169115715920"><a name="p6169115715920"></a><a name="p6169115715920"></a>取值为如下宏：</p>
<a name="ul33464527015"></a><a name="ul33464527015"></a><ul id="ul33464527015"><li>ACL_RT_VMM_EXPORT_FLAG_DEFAULT：默认值，启用进程白名单校验。<p id="p1410617497187"><a name="p1410617497187"></a><a name="p1410617497187"></a>配置为该值时，需单独调用<a href="aclrtMemSetPidToShareableHandleV2.md">aclrtMemSetPidToShareableHandleV2</a>接口将使用shareableHandle的进程ID设置为白名单。</p>
</li><li>ACL_RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION：关闭进程白名单校验。<p id="p5951651141816"><a name="p5951651141816"></a><a name="p5951651141816"></a>配置为该值时，则无需调用<a href="aclrtMemSetPidToShareableHandleV2.md">aclrtMemSetPidToShareableHandleV2</a>接口。</p>
</li></ul>
<p id="p18200675010"><a name="p18200675010"></a><a name="p18200675010"></a>宏的定义如下：</p>
<pre class="screen" id="screen158584141105"><a name="screen158584141105"></a><a name="screen158584141105"></a>#define ACL_RT_VMM_EXPORT_FLAG_DEFAULT                0x0UL
#define ACL_RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION 0x1UL</pre>
</td>
</tr>
<tr id="row2052067135017"><td class="cellrowborder" valign="top" width="19.17%" headers="mcps1.1.4.1.1 "><p id="p1152119775012"><a name="p1152119775012"></a><a name="p1152119775012"></a>shareType</p>
</td>
<td class="cellrowborder" valign="top" width="13.03%" headers="mcps1.1.4.1.2 "><p id="p7521573506"><a name="p7521573506"></a><a name="p7521573506"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="67.80000000000001%" headers="mcps1.1.4.1.3 "><p id="p195211971504"><a name="p195211971504"></a><a name="p195211971504"></a>导出的共享句柄类型。</p>
</td>
</tr>
<tr id="row7307528520"><td class="cellrowborder" valign="top" width="19.17%" headers="mcps1.1.4.1.1 "><p id="p5312052954"><a name="p5312052954"></a><a name="p5312052954"></a>shareableHandle</p>
</td>
<td class="cellrowborder" valign="top" width="13.03%" headers="mcps1.1.4.1.2 "><p id="p143135211517"><a name="p143135211517"></a><a name="p143135211517"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="67.80000000000001%" headers="mcps1.1.4.1.3 "><p id="p1124111411310"><a name="p1124111411310"></a><a name="p1124111411310"></a>指向共享句柄的指针。其指向的内存由调用者提供，大小根据shareType决定：</p>
<p id="p19311719161313"><a name="p19311719161313"></a><a name="p19311719161313"></a>若shareType为ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT，则指向一个uint64_t变量。</p>
<p id="p239517085718"><a name="p239517085718"></a><a name="p239517085718"></a>若shareType为ACL_MEM_SHARE_HANDLE_TYPE_FABRIC，则指向一个aclrtMemFabricHandle结构体。</p>
<pre class="screen" id="screen11516201313565"><a name="screen11516201313565"></a><a name="screen11516201313565"></a>typedef struct aclrtMemFabricHandle { 
    uint8_t data[128];
} aclrtMemFabricHandle;</pre>
</td>
</tr>
</tbody>
</table>

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   支持AI Server内跨进程共享物理内存的产品型号如下，若跨Device还需配合[aclrtDeviceEnablePeerAccess](aclrtDeviceEnablePeerAccess.md)接口使用。

    Ascend 910C

    Ascend 910B

-   仅Ascend 910C支持跨AI Server的跨进程共享物理内存。
-   不支持昇腾虚拟化实例场景。

