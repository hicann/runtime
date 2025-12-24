# aclmdlInitDump<a name="ZH-CN_TOPIC_0000001264921894"></a>

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

## 功能说明<a name="section259105813316"></a>

Dump初始化。

本接口需与其它接口配合使用实现以下功能：

-   **Dump数据落盘到文件**

    [aclmdlInitDump](aclmdlInitDump.md)接口、[aclmdlSetDump](aclmdlSetDump.md)接口、[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口配合使用，用于将Dump数据记录到文件中。一个进程内，可以根据需求多次调用这些接口，基于不同的Dump配置信息，获取Dump数据。场景举例如下：

    -   执行两个不同的模型，需要设置不同的Dump配置信息，接口调用顺序：[aclInit](aclInit.md)接口--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>[aclmdlSetDump](aclmdlSetDump.md)接口--\>模型1加载--\>模型1执行--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>模型1卸载--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>[aclmdlSetDump](aclmdlSetDump.md)接口--\>模型2加载--\>模型2执行--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>模型2卸载--\>执行其它任务--\>[aclFinalize](aclFinalize.md)接口
    -   同一个模型执行两次，第一次需要Dump，第二次无需Dump，接口调用顺序：[aclInit](aclInit.md)接口--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>[aclmdlSetDump](aclmdlSetDump.md)接口--\>模型加载--\>模型执行--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>模型卸载--\>模型加载--\>模型执行--\>执行其它任务--\>[aclFinalize](aclFinalize.md)接口

-   **Dump数据不落盘到文件，直接通过回调函数获取**

    [aclmdlInitDump](aclmdlInitDump.md)接口、[acldumpRegCallback](acldumpRegCallback.md)接口（通过该接口注册的回调函数需由用户自行实现，回调函数实现逻辑中包括获取Dump数据及数据长度）、[acldumpUnregCallback](acldumpUnregCallback.md)接口、[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口配合使用，用于通过回调函数获取Dump数据。场景举例如下：

    -   执行一个模型，通过回调获取Dump数据：

        [aclInit](aclInit.md)接口--\>[acldumpRegCallback](acldumpRegCallback.md)接口--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>模型加载--\>模型执行--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>[acldumpUnregCallback](acldumpUnregCallback.md)接口--\>模型卸载--\>[aclFinalize](aclFinalize.md)接口

    -   执行两个不同的模型，通过回调获取Dump数据，该场景下，只要不调用[acldumpUnregCallback](acldumpUnregCallback.md)接口取消注册回调函数，则可通过回调函数获取两个模型的Dump数据：

        [aclInit](aclInit.md)接口--\>[acldumpRegCallback](acldumpRegCallback.md)接口--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>模型1加载--\>模型1执行--\>--\>模型2加载--\>模型2执行--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>模型卸载--\>[acldumpUnregCallback](acldumpUnregCallback.md)接口--\>[aclFinalize](aclFinalize.md)接口

## 函数原型<a name="section2067518173415"></a>

```
aclError aclmdlInitDump()
```

## 参数说明<a name="section158061867342"></a>

无

## 返回值说明<a name="section15770391345"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section1120717194412"></a>

-   对于模型Dump配置、单算子Dump配置、溢出算子Dump配置，如果已经通过[aclInit](aclInit.md)接口配置了dump信息，则调用aclmdlInitDump接口时会返回失败。
-   必须在调用[aclInit](aclInit.md)接口之后、模型加载接口之前调用aclmdlInitDump接口。

## 参考资源<a name="section6440646217"></a>

当前还提供了[aclInit](aclInit.md)接口，在初始化阶段，通过\*.json文件传入Dump配置信息，运行应用后获取Dump数据的方式。该种方式，一个进程内，只能调用一次[aclInit](aclInit.md)接口，如果要修改Dump配置信息，需修改\*.json文件中的配置。

