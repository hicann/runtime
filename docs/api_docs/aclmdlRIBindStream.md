# aclmdlRIBindStream<a name="ZH-CN_TOPIC_0000002270959592"></a>

## AI处理器支持情况<a name="section42891738171919"></a>

<a name="table38301303189"></a>
<table><thead align="left"><tr id="row20831180131817"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="p1883113061818"><a name="p1883113061818"></a><a name="p1883113061818"></a>产品</p>
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

将模型运行实例与Stream绑定。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclmdlRIBindStream(aclmdlRI modelRI, aclrtStream stream, uint32_t flag)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="15%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="15%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="70%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row229712714517"><td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.1 "><p id="p732720321134"><a name="p732720321134"></a><a name="p732720321134"></a>modelRI</p>
</td>
<td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.2 "><p id="p832616321312"><a name="p832616321312"></a><a name="p832616321312"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p17323153215313"><a name="p17323153215313"></a><a name="p17323153215313"></a>模型运行实例。</p>
<p id="p553132319466"><a name="p553132319466"></a><a name="p553132319466"></a>此处的modelRI需与<a href="aclmdlRIBuildBegin.md">aclmdlRIBuildBegin</a>接口中的modelRI保持一致。</p>
</td>
</tr>
<tr id="row179513752718"><td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.1 "><p id="p179510714273"><a name="p179510714273"></a><a name="p179510714273"></a>stream</p>
</td>
<td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.2 "><p id="p4951147182716"><a name="p4951147182716"></a><a name="p4951147182716"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p59251277123"><a name="p59251277123"></a><a name="p59251277123"></a>指定Stream。</p>
<p id="p18267174691212"><a name="p18267174691212"></a><a name="p18267174691212"></a>此处的Stream需通过<a href="aclrtCreateStreamWithConfig.md">aclrtCreateStreamWithConfig</a>接口创建ACL_STREAM_PERSISTENT类型的Stream。</p>
<p id="p1595212717272"><a name="p1595212717272"></a><a name="p1595212717272"></a>不支持传NULL，不支持一个Stream绑定多个modelRI的场景。</p>
</td>
</tr>
<tr id="row1473714202711"><td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.1 "><p id="p94739148278"><a name="p94739148278"></a><a name="p94739148278"></a>flag</p>
</td>
<td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.2 "><p id="p16473171418272"><a name="p16473171418272"></a><a name="p16473171418272"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p167012274229"><a name="p167012274229"></a><a name="p167012274229"></a>标记该Stream是否从模型执行开始时就运行。</p>
<a name="ul16592859163116"></a><a name="ul16592859163116"></a><ul id="ul16592859163116"><li>ACL_MODEL_STREAM_FLAG_HEAD：首Stream，模型执行开始时就运行的Stream。</li><li>ACL_MODEL_STREAM_FLAG_DEFAULT：模型执行过程中，根据分支算子或循环算子激活的Stream，后续可调用<a href="aclrtActiveStream.md">aclrtActiveStream</a>接口激活Stream</li></ul>
<p id="p877233313323"><a name="p877233313323"></a><a name="p877233313323"></a>宏定义如下：</p>
<pre class="screen" id="screen9479185311818"><a name="screen9479185311818"></a><a name="screen9479185311818"></a>#define ACL_MODEL_STREAM_FLAG_HEAD    0x00000000U 
#define ACL_MODEL_STREAM_FLAG_DEFAULT 0x7FFFFFFFU</pre>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

