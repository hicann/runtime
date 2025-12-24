# acldumpUnregCallback<a name="ZH-CN_TOPIC_0000001872193289"></a>

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

Dump数据回调函数取消注册接口。acldumpUnregCallback需要和acldumpRegCallback配合使用，且必须在acldumpRegCallback调用后才有效。

[aclmdlInitDump](aclmdlInitDump.md)接口、[acldumpRegCallback](acldumpRegCallback.md)接口（通过该接口注册的回调函数需由用户自行实现，回调函数实现逻辑中包括获取Dump数据及数据长度）、[acldumpUnregCallback](acldumpUnregCallback.md)接口、[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口配合使用，用于通过回调函数获取Dump数据。场景举例如下：

-   执行一个模型，通过回调获取Dump数据：

    [aclInit](aclInit.md)接口--\>[acldumpRegCallback](acldumpRegCallback.md)接口--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>模型加载--\>模型执行--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>[acldumpUnregCallback](acldumpUnregCallback.md)接口--\>模型卸载--\>[aclFinalize](aclFinalize.md)接口

-   执行两个不同的模型，通过回调获取Dump数据，该场景下，只要不调用[acldumpUnregCallback](acldumpUnregCallback.md)接口取消注册回调函数，则可通过回调函数获取两个模型的Dump数据：

    [aclInit](aclInit.md)接口--\>[acldumpRegCallback](acldumpRegCallback.md)接口--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>模型1加载--\>模型1执行--\>--\>模型2加载--\>模型2执行--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>模型卸载--\>[acldumpUnregCallback](acldumpUnregCallback.md)接口--\>[aclFinalize](aclFinalize.md)接口

## 函数原型<a name="section2067518173415"></a>

```
void acldumpUnregCallback()
```

## 参数说明<a name="section158061867342"></a>

无

## 返回值说明<a name="section15770391345"></a>

无

