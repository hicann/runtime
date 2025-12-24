# aclrtAllocatorRegister<a name="ZH-CN_TOPIC_0000001571667480"></a>

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

调用该接口注册用户提供的Allocator以及Allocator对应的回调函数，以便后续使用用户提供的Allocator。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtAllocatorRegister(aclrtStream stream, aclrtAllocatorDesc allocatorDesc)
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
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p039116593511"><a name="p039116593511"></a><a name="p039116593511"></a>stream</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p16390135183518"><a name="p16390135183518"></a><a name="p16390135183518"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p23858144117"><a name="p23858144117"></a><a name="p23858144117"></a>该Allocator需要注册的Stream。</p>
<p id="p12906163014240"><a name="p12906163014240"></a><a name="p12906163014240"></a>传入的stream参数值不能为NULL，否则返回报错。</p>
</td>
</tr>
<tr id="row198943121925"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p17896151210210"><a name="p17896151210210"></a><a name="p17896151210210"></a>allocatorDesc</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1189618121627"><a name="p1189618121627"></a><a name="p1189618121627"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p66935211796"><a name="p66935211796"></a><a name="p66935211796"></a>Allocator描述符指针。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section3162183620010"></a>

-   当前仅支持在单算子模型执行、动态shape模型推理场景下使用本接口。

    单算子模型场景下，需在算子执行接口（例如：aclopExecuteV2、aclopCompileAndExecuteV2等）之前调用本接口。

    动态shape模型推理场景，本接口需配合aclmdlExecuteAsync接口一起使用，且需在aclmdlExecuteAsync接口之前调用本接口。

-   调用本接口前，需要先调用[aclrtAllocatorCreateDesc](aclrtAllocatorCreateDesc.md)创建Allocator描述符，再分别调用[aclrtAllocatorSetObjToDesc](aclrtAllocatorSetObjToDesc.md)、[aclrtAllocatorSetAllocFuncToDesc](aclrtAllocatorSetAllocFuncToDesc.md)、[aclrtAllocatorSetGetAddrFromBlockFuncToDesc](aclrtAllocatorSetGetAddrFromBlockFuncToDesc.md)、[aclrtAllocatorSetFreeFuncToDesc](aclrtAllocatorSetFreeFuncToDesc.md)设置Allocator对象及回调函数。Allocator描述符使用完成后，可调用[aclrtAllocatorDestroyDesc](aclrtAllocatorDestroyDesc.md)接口销毁Allocator描述符。
-   对于同一条流，多次调用本接口，以最后一次注册为准。
-   对于不同流，如果用户使用同一个Allocator，不可以多条流并发执行，在执行下一条Stream前，需要对上一Stream做流同步。
-   将Allocator中的内存释放给操作系统前，需要先调用[aclrtSynchronizeStream](aclrtSynchronizeStream.md)接口执行流同步，确保Stream中的任务已执行完成。

