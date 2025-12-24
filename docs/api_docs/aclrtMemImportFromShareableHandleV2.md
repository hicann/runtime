# aclrtMemImportFromShareableHandleV2<a name="ZH-CN_TOPIC_0000002483511153"></a>

## AI处理器支持情况<a name="section15254644421"></a>

<a name="zh-cn_topic_0000002219420921_table14931115524110"></a>
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

## 功能说明<a name="section36583473819"></a>

在本进程中获取shareableHandle里的信息，并返回本进程中的handle，用于在本进程中建立虚拟地址与物理地址之间的映射关系。

本接口是在接口[aclrtMemImportFromShareableHandle](aclrtMemImportFromShareableHandle.md)基础上进行了增强，用户可通过shareType参数指定导出AI Server内的共享句柄，或导出跨AI Server的共享句柄。

本接口的使用流程可参见[aclrtMemExportToShareableHandle](aclrtMemExportToShareableHandle.md)，但本接口需配合调用[aclrtMemExportToShareableHandleV2](aclrtMemExportToShareableHandleV2.md)接口导出共享句柄、调用[aclrtMemSetPidToShareableHandleV2](aclrtMemSetPidToShareableHandleV2.md)接口设置进程白名单。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtMemImportFromShareableHandleV2(void *shareableHandle, aclrtMemSharedHandleType shareType, uint64_t flags, aclrtDrvMemHandle *handle);
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="18.86%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="12.43%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68.71000000000001%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="18.86%" headers="mcps1.1.4.1.1 "><p id="p142411213163111"><a name="p142411213163111"></a><a name="p142411213163111"></a>shareableHandle</p>
</td>
<td class="cellrowborder" valign="top" width="12.43%" headers="mcps1.1.4.1.2 "><p id="p42407139317"><a name="p42407139317"></a><a name="p42407139317"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68.71000000000001%" headers="mcps1.1.4.1.3 "><p id="p12239111314314"><a name="p12239111314314"></a><a name="p12239111314314"></a>待共享的shareableHandle，与<a href="aclrtMemExportToShareableHandleV2.md">aclrtMemExportToShareableHandleV2</a>接口中导出的shareableHandle保持一致。</p>
<p id="p3557825184312"><a name="p3557825184312"></a><a name="p3557825184312"></a>handle与shareableHandle是一一对应的关系，在同一个进程中，不允许一对多、或多对一。</p>
</td>
</tr>
<tr id="row1660814462512"><td class="cellrowborder" valign="top" width="18.86%" headers="mcps1.1.4.1.1 "><p id="p1152119775012"><a name="p1152119775012"></a><a name="p1152119775012"></a>shareType</p>
</td>
<td class="cellrowborder" valign="top" width="12.43%" headers="mcps1.1.4.1.2 "><p id="p7521573506"><a name="p7521573506"></a><a name="p7521573506"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68.71000000000001%" headers="mcps1.1.4.1.3 "><p id="p195211971504"><a name="p195211971504"></a><a name="p195211971504"></a>导出的共享句柄类型。</p>
</td>
</tr>
<tr id="row3577115016277"><td class="cellrowborder" valign="top" width="18.86%" headers="mcps1.1.4.1.1 "><p id="p6577195072716"><a name="p6577195072716"></a><a name="p6577195072716"></a>flags</p>
</td>
<td class="cellrowborder" valign="top" width="12.43%" headers="mcps1.1.4.1.2 "><p id="p165771550102718"><a name="p165771550102718"></a><a name="p165771550102718"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68.71000000000001%" headers="mcps1.1.4.1.3 "><p id="p155771450122720"><a name="p155771450122720"></a><a name="p155771450122720"></a>预留参数，当前固定设置为0。</p>
</td>
</tr>
<tr id="row187221499516"><td class="cellrowborder" valign="top" width="18.86%" headers="mcps1.1.4.1.1 "><p id="p6234121363114"><a name="p6234121363114"></a><a name="p6234121363114"></a>handle</p>
</td>
<td class="cellrowborder" valign="top" width="12.43%" headers="mcps1.1.4.1.2 "><p id="p132342013133119"><a name="p132342013133119"></a><a name="p132342013133119"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="68.71000000000001%" headers="mcps1.1.4.1.3 "><p id="p1923319132315"><a name="p1923319132315"></a><a name="p1923319132315"></a>本进程的物理内存handle。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section3162183620010"></a>

-   在调用本接口前，需确保待共享的物理内存存在，不能提前释放。
-   不支持同一个进程中调用aclrtMemImportFromShareableHandleV2、[aclrtMemExportToShareableHandle](aclrtMemExportToShareableHandle.md)V2这两个接口，只支持跨进程调用。
-   内存使用完成后，要及时调用[aclrtFreePhysical](aclrtFreePhysical.md)销毁handle，并且需所有调用本接口的进程都销毁shareableHandle的情况下，handle才会真正销毁。

