# aclmdlRICaptureTaskUpdateBegin<a name="ZH-CN_TOPIC_0000002265532705"></a>

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

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

标记待更新任务的开始。

本接口与[aclmdlRICaptureTaskUpdateEnd](aclmdlRICaptureTaskUpdateEnd.md)接口成对使用，位于这两个接口之间的任务需更新。

aclmdlRICaptureTaskUpdateBegin、[aclmdlRICaptureTaskUpdateEnd](aclmdlRICaptureTaskUpdateEnd.md)接口之间的任务数量、任务类型必须与[aclmdlRICaptureTaskGrpBegin](aclmdlRICaptureTaskGrpBegin.md)、[aclmdlRICaptureTaskGrpEnd](aclmdlRICaptureTaskGrpEnd.md)接口之间任务数量、任务类型保持一致。

若任务更新时返回ACL\_ERROR\_RT\_FEATURE\_NOT\_SUPPORT，则表示底层驱动不支持该特性，需要将驱动包升级到25.0.RC1或更高版本。您可以单击[Link](https://www.hiascend.com/hardware/firmware-drivers/commercial)，在“固件与驱动”页面下载Ascend HDK  25.0.RC1或更高版本的驱动安装包，并参考相应版本的文档进行安装、升级。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclmdlRICaptureTaskUpdateBegin(aclrtStream stream, aclrtTaskGrp handle)
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
<tbody><tr id="row229712714517"><td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.1 "><p id="p17580195042220"><a name="p17580195042220"></a><a name="p17580195042220"></a>stream</p>
</td>
<td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.2 "><p id="p858075018229"><a name="p858075018229"></a><a name="p858075018229"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p5224193475917"><a name="p5224193475917"></a><a name="p5224193475917"></a>指定Stream。</p>
<p id="p78350474535"><a name="p78350474535"></a><a name="p78350474535"></a>此处的Stream必须是不在捕获状态的Stream。</p>
</td>
</tr>
<tr id="row941052582315"><td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.1 "><p id="p11410425132315"><a name="p11410425132315"></a><a name="p11410425132315"></a>handle</p>
</td>
<td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.2 "><p id="p12410102515236"><a name="p12410102515236"></a><a name="p12410102515236"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p164103258236"><a name="p164103258236"></a><a name="p164103258236"></a>标识任务组的句柄。</p>
<p id="p364392275110"><a name="p364392275110"></a><a name="p364392275110"></a>提前调用<a href="aclmdlRICaptureTaskGrpBegin.md">aclmdlRICaptureTaskGrpBegin</a>、<a href="aclmdlRICaptureTaskGrpEnd.md">aclmdlRICaptureTaskGrpEnd</a>接口标记任务组之后，通过aclmdlRICaptureTaskGrpEnd接口获取任务组句柄，再作为入参传入此处。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section1424372074916"></a>

单个Device可支持同时更新的最大任务数是1024\*1024个，超出该规格，任务会在执行阶段报错。

