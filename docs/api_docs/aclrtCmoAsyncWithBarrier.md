# aclrtCmoAsyncWithBarrier<a name="ZH-CN_TOPIC_0000002341970321"></a>

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
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p1060918418576"><a name="p1060918418576"></a><a name="p1060918418576"></a>☓</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p561119465712"><a name="p561119465712"></a><a name="p561119465712"></a>☓</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section73552454261"></a>

实现Device上的Cache内存操作，同时携带barrierId，barrierId表示Cache内存操作的屏障标识。异步接口。

## 函数原型<a name="section195491952142612"></a>

```
aclError aclrtCmoAsyncWithBarrier(void *src, size_t size, aclrtCmoType cmoType, uint32_t barrierId, aclrtStream stream)
```

## 参数说明<a name="section155499553266"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row7909131293411"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p193251339646"><a name="p193251339646"></a><a name="p193251339646"></a>src</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p203231392043"><a name="p203231392043"></a><a name="p203231392043"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p138471318114713"><a name="p138471318114713"></a><a name="p138471318114713"></a>待操作的Device内存地址。</p>
<p id="p19992336143812"><a name="p19992336143812"></a><a name="p19992336143812"></a>只支持本Device上的Cache内存操作。</p>
</td>
</tr>
<tr id="row153124110712"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p153221739949"><a name="p153221739949"></a><a name="p153221739949"></a>size</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p113214391649"><a name="p113214391649"></a><a name="p113214391649"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1584719183476"><a name="p1584719183476"></a><a name="p1584719183476"></a>待操作的Device内存大小，单位Byte。</p>
</td>
</tr>
<tr id="row107134414713"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p2320193918411"><a name="p2320193918411"></a><a name="p2320193918411"></a>cmoType</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1531953916418"><a name="p1531953916418"></a><a name="p1531953916418"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p15847718114716"><a name="p15847718114716"></a><a name="p15847718114716"></a>Cache内存操作类型。</p>
</td>
</tr>
<tr id="row934119103813"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p193411210488"><a name="p193411210488"></a><a name="p193411210488"></a>barrierId</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1634191012816"><a name="p1634191012816"></a><a name="p1634191012816"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1635517471294"><a name="p1635517471294"></a><a name="p1635517471294"></a>屏障标识。</p>
<p id="p96642326386"><a name="p96642326386"></a><a name="p96642326386"></a>当cmoType为ACL_RT_CMO_TYPE_INVALID时，barrierId有效，支持传入大于0的数字，配合<a href="aclrtCmoWaitBarrier.md">aclrtCmoWaitBarrier</a>接口使用，等待具有指定barrierId的Invalid内存操作任务执行完成。当cmoType为其它值时，barrierId固定传0。</p>
</td>
</tr>
<tr id="row3210020182"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p4210192014811"><a name="p4210192014811"></a><a name="p4210192014811"></a>stream</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p192101820989"><a name="p192101820989"></a><a name="p192101820989"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p684731811473"><a name="p684731811473"></a><a name="p684731811473"></a>执行内存操作任务的Stream。</p>
<p id="p17756574599"><a name="p17756574599"></a><a name="p17756574599"></a>此处只支持与模型绑定过的Stream，绑定模型与Stream需调用<a href="aclmdlRIBindStream.md">aclmdlRIBindStream</a>接口。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section1435713587268"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

