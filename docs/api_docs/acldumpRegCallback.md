# acldumpRegCallback<a name="ZH-CN_TOPIC_0000001825353736"></a>

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

## 功能说明<a name="section259105813316"></a>

Dump数据回调函数注册接口。

[aclmdlInitDump](aclmdlInitDump.md)接口、[acldumpRegCallback](acldumpRegCallback.md)接口（通过该接口注册的回调函数需由用户自行实现，回调函数实现逻辑中包括获取Dump数据及数据长度）、[acldumpUnregCallback](acldumpUnregCallback.md)接口、[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口配合使用，用于通过回调函数获取Dump数据。**场景举例如下：**

-   **执行一个模型，通过回调获取Dump数据：**

    支持以下两种方式：

    -   在aclInit接口处**不启用**模型Dump配置、单算子Dump配置

        [aclInit](aclInit.md)接口--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>[acldumpRegCallback](acldumpRegCallback.md)接口--\>模型加载--\>模型执行--\>[acldumpUnregCallback](acldumpUnregCallback.md)接口--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>模型卸载--\>[aclFinalize](aclFinalize.md)接口

    -   在aclInit接口处**启用**模型Dump配置、单算子Dump配置，在aclInit接口处启用Dump配置时需配置落盘路径，但如果调用了[acldumpRegCallback](acldumpRegCallback.md)接口，则落盘不生效，以回调函数获取的Dump数据为准

        [aclInit](aclInit.md)接口--\>[acldumpRegCallback](acldumpRegCallback.md)接口--\>模型加载--\>模型执行--\>[acldumpUnregCallback](acldumpUnregCallback.md)接口--\>模型卸载--\>[aclFinalize](aclFinalize.md)接口

-   **执行两个不同的模型，通过回调获取Dump数据**，该场景下，只要不调用[acldumpUnregCallback](acldumpUnregCallback.md)接口取消注册回调函数，则可通过回调函数获取两个模型的Dump数据：

    [aclInit](aclInit.md)接口--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>[acldumpRegCallback](acldumpRegCallback.md)接口--\>模型1加载--\>模型1执行--\>--\>模型2加载--\>模型2执行--\>[acldumpUnregCallback](acldumpUnregCallback.md)接口--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>模型卸载--\>[aclFinalize](aclFinalize.md)接口

## 函数原型<a name="section2067518173415"></a>

```
aclError acldumpRegCallback(int32_t (* const messageCallback)(const acldumpChunk *, int32_t len), int32_t flag)
```

## 参数说明<a name="section158061867342"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row1919192774810"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p15161451803"><a name="p15161451803"></a><a name="p15161451803"></a>messageCallback</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p7896143816266"><a name="p7896143816266"></a><a name="p7896143816266"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p117941011172714"><a name="p117941011172714"></a><a name="p117941011172714"></a>回调函数指针，用于接收回调数据的回调。</p>
<a name="ul1302857173511"></a><a name="ul1302857173511"></a><ul id="ul1302857173511"><li>acldumpChunk结构体的定义如下，在实现messageCallback回调函数时可以获取acldumpChunk结构体中的dataBuf、bufLen等参数值，用于获取Dump数据及其数据长度：<pre class="screen" id="screen5372181218284"><a name="screen5372181218284"></a><a name="screen5372181218284"></a>typedef struct acldumpChunk  {
    char       fileName[ACL_DUMP_MAX_FILE_PATH_LENGTH];   // 待落盘的Dump数据文件名，ACL_DUMP_MAX_FILE_PATH_LENGTH表示文件名最大长度，当前为4096
    uint32_t   bufLen;                           // dataBuf数据长度，单位Byte
    uint32_t   isLastChunk;                      // 标识Dump数据是否为最后一个分片，0表示不是最后一个分片，1表示最后一个分片
    int64_t    offset;                           // Dump数据文件内容的偏移，其中-1表示文件追加内容
    int32_t    flag;                             // 预留Dump数据标识，当前数据无标识
    uint8_t    dataBuf[0];                       // Dump数据的内存地址
} acldumpChunk;</pre>
</li><li>len：表示acldumpChunk结构体的长度，单位Byte。</li></ul>
</td>
</tr>
<tr id="row12453627192614"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p4453227142613"><a name="p4453227142613"></a><a name="p4453227142613"></a>flag</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p94531427202615"><a name="p94531427202615"></a><a name="p94531427202615"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p61621021102711"><a name="p61621021102711"></a><a name="p61621021102711"></a>在调用回调接口后是否还落盘dump数据：</p>
<a name="ul4588142252715"></a><a name="ul4588142252715"></a><ul id="ul4588142252715"><li>0：不落盘，当前仅支持0</li></ul>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section15770391345"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

