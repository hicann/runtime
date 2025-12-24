# aclFinalizeCallbackRegister<a name="ZH-CN_TOPIC_0000002442663234"></a>

## AI处理器支持情况<a name="section59316553412"></a>

<a name="table14931115524110"></a>
<table><thead align="left"><tr id="row1993118556414"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="p29315553419"><a name="p29315553419"></a><a name="p29315553419"></a><span id="ph59311455164119"><a name="ph59311455164119"></a><a name="ph59311455164119"></a>AI处理器类型</span></p>
</th>
<th class="cellrowborder" align="center" valign="top" width="42%" id="mcps1.1.3.1.2"><p id="p59313557417"><a name="p59313557417"></a><a name="p59313557417"></a>是否支持</p>
</th>
</tr>
</thead>
<tbody><tr id="row1693117553411"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p1493195513412"><a name="p1493195513412"></a><a name="p1493195513412"></a><span id="ph1093110555418"><a name="ph1093110555418"></a><a name="ph1093110555418"></a><term id="zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p20931175524111"><a name="p20931175524111"></a><a name="p20931175524111"></a>√</p>
</td>
</tr>
<tr id="row199312559416"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p0931555144119"><a name="p0931555144119"></a><a name="p0931555144119"></a><span id="ph1693115559411"><a name="ph1693115559411"></a><a name="ph1693115559411"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p129321955154117"><a name="p129321955154117"></a><a name="p129321955154117"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section36583473819"></a>

注册去初始化回调函数。

在[aclFinalize](aclFinalize.md)接口之前调用本接口，在去初始化时触发回调函数的调用。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclFinalizeCallbackRegister(aclRegisterCallbackType type, aclFinalizeCallbackFunc cbFunc, void *userData)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.360000000000001%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="71.64%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row16791142193514"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p15958212071"><a name="p15958212071"></a><a name="p15958212071"></a>type</p>
</td>
<td class="cellrowborder" valign="top" width="14.360000000000001%" headers="mcps1.1.4.1.2 "><p id="p195951218713"><a name="p195951218713"></a><a name="p195951218713"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="71.64%" headers="mcps1.1.4.1.3 "><p id="p17756574599"><a name="p17756574599"></a><a name="p17756574599"></a>注册类型，按照不同的功能区分。</p>
</td>
</tr>
<tr id="row19988133618518"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p16593182119716"><a name="p16593182119716"></a><a name="p16593182119716"></a>cbFunc</p>
</td>
<td class="cellrowborder" valign="top" width="14.360000000000001%" headers="mcps1.1.4.1.2 "><p id="p2593112118713"><a name="p2593112118713"></a><a name="p2593112118713"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="71.64%" headers="mcps1.1.4.1.3 "><p id="p48811531152813"><a name="p48811531152813"></a><a name="p48811531152813"></a>去初始化回调函数。</p>
<p id="p153743193280"><a name="p153743193280"></a><a name="p153743193280"></a>回调函数定义如下：</p>
<pre class="screen" id="screen145924573486"><a name="screen145924573486"></a><a name="screen145924573486"></a>typedef aclError (*aclFinalizeCallbackFunc)(void *userData);</pre>
</td>
</tr>
<tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p1559292116710"><a name="p1559292116710"></a><a name="p1559292116710"></a>userData</p>
</td>
<td class="cellrowborder" valign="top" width="14.360000000000001%" headers="mcps1.1.4.1.2 "><p id="p115911821270"><a name="p115911821270"></a><a name="p115911821270"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="71.64%" headers="mcps1.1.4.1.3 "><p id="p164136586148"><a name="p164136586148"></a><a name="p164136586148"></a>待传递给回调函数的用户数据的指针。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

