# aclrtLaunchKernel<a name="ZH-CN_TOPIC_0000001678252928"></a>

## AI处理器支持情况<a name="section16107182283615"></a>

<a name="zh-cn_topic_0000002219420921_table38301303189"></a>
<table><thead align="left"><tr id="zh-cn_topic_0000002219420921_row20831180131817"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="zh-cn_topic_0000002219420921_p1883113061818"><a name="zh-cn_topic_0000002219420921_p1883113061818"></a><a name="zh-cn_topic_0000002219420921_p1883113061818"></a><span id="zh-cn_topic_0000002219420921_ph20833205312295"><a name="zh-cn_topic_0000002219420921_ph20833205312295"></a><a name="zh-cn_topic_0000002219420921_ph20833205312295"></a>AI处理器类型</span></p>
</th>
<th class="cellrowborder" align="center" valign="top" width="42%" id="mcps1.1.3.1.2"><p id="zh-cn_topic_0000002219420921_p783113012187"><a name="zh-cn_topic_0000002219420921_p783113012187"></a><a name="zh-cn_topic_0000002219420921_p783113012187"></a>是否支持</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0000002219420921_row220181016240"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0000002219420921_p48327011813"><a name="zh-cn_topic_0000002219420921_p48327011813"></a><a name="zh-cn_topic_0000002219420921_p48327011813"></a><span id="zh-cn_topic_0000002219420921_ph583230201815"><a name="zh-cn_topic_0000002219420921_ph583230201815"></a><a name="zh-cn_topic_0000002219420921_ph583230201815"></a><term id="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="zh-cn_topic_0000002219420921_p7948163910184"><a name="zh-cn_topic_0000002219420921_p7948163910184"></a><a name="zh-cn_topic_0000002219420921_p7948163910184"></a>√</p>
</td>
</tr>
<tr id="zh-cn_topic_0000002219420921_row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0000002219420921_p14832120181815"><a name="zh-cn_topic_0000002219420921_p14832120181815"></a><a name="zh-cn_topic_0000002219420921_p14832120181815"></a><span id="zh-cn_topic_0000002219420921_ph1483216010188"><a name="zh-cn_topic_0000002219420921_ph1483216010188"></a><a name="zh-cn_topic_0000002219420921_ph1483216010188"></a><term id="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="zh-cn_topic_0000002219420921_p19948143911820"><a name="zh-cn_topic_0000002219420921_p19948143911820"></a><a name="zh-cn_topic_0000002219420921_p19948143911820"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section73552454261"></a>

启动对应算子的计算任务，异步接口。此处的算子为使用Ascend C语言开发的自定义算子。

## 函数原型<a name="section195491952142612"></a>

```
aclError aclrtLaunchKernel(aclrtFuncHandle funcHandle, uint32_t blockDim, const void *argsData, size_t argsSize, aclrtStream stream)
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
<tbody><tr id="row19528140192112"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p2528184011211"><a name="p2528184011211"></a><a name="p2528184011211"></a>funcHandle</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1552934062118"><a name="p1552934062118"></a><a name="p1552934062118"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1852964017219"><a name="p1852964017219"></a><a name="p1852964017219"></a>调用<a href="aclrtBinaryGetFunction.md">aclrtBinaryGetFunction</a>接口根据kernelName获取funcHandle。</p>
</td>
</tr>
<tr id="row79539477320"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p19533472326"><a name="p19533472326"></a><a name="p19533472326"></a>blockDim</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p189537476322"><a name="p189537476322"></a><a name="p189537476322"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1995384713327"><a name="p1995384713327"></a><a name="p1995384713327"></a>指定核函数将会在几个核上执行。</p>
</td>
</tr>
<tr id="row5973115114328"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1497355113217"><a name="p1497355113217"></a><a name="p1497355113217"></a>argsData</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p139731151113218"><a name="p139731151113218"></a><a name="p139731151113218"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1083114573013"><a name="p1083114573013"></a><a name="p1083114573013"></a>存放核函数所有入参数据的Device内存地址指针。</p>
<p id="p728524412314"><a name="p728524412314"></a><a name="p728524412314"></a>内存申请接口请参见<a href="内存管理.md">内存管理</a>。</p>
<p id="p1712583317204"><a name="p1712583317204"></a><a name="p1712583317204"></a>注意，执行本接口下发任务的Device需与argsData中使用的Device内存要是同一个Device。</p>
</td>
</tr>
<tr id="row07176496325"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p14717174918323"><a name="p14717174918323"></a><a name="p14717174918323"></a>argsSize</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p18717154913217"><a name="p18717154913217"></a><a name="p18717154913217"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p11717104913210"><a name="p11717104913210"></a><a name="p11717104913210"></a>argsData参数值的大小，单位为Byte。</p>
</td>
</tr>
<tr id="row1363319533318"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p66339512339"><a name="p66339512339"></a><a name="p66339512339"></a>stream</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p36333515331"><a name="p36333515331"></a><a name="p36333515331"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p22341547102313"><a name="p22341547102313"></a><a name="p22341547102313"></a>指定执行任务的Stream，可复用已创建的Stream节省资源或调用<a href="aclrtCreateStream.md">aclrtCreateStream</a>接口创建Stream，再作为入参在此处传入。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section1435713587268"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 参考资源<a name="section63349400313"></a>

下表的几个接口都用于启用对应算子的计算任务，但功能和使用方式有所不同：

<a name="zh-cn_topic_0000002433971566_table1398593611188"></a>
<table><thead align="left"><tr id="zh-cn_topic_0000002433971566_row798593617187"><th class="cellrowborder" valign="top" width="28.782878287828783%" id="mcps1.1.5.1.1"><p id="zh-cn_topic_0000002433971566_p1698512361184"><a name="zh-cn_topic_0000002433971566_p1698512361184"></a><a name="zh-cn_topic_0000002433971566_p1698512361184"></a>接口</p>
</th>
<th class="cellrowborder" valign="top" width="25.912591259125918%" id="mcps1.1.5.1.2"><p id="zh-cn_topic_0000002433971566_p166701823172413"><a name="zh-cn_topic_0000002433971566_p166701823172413"></a><a name="zh-cn_topic_0000002433971566_p166701823172413"></a>核函数参数值的传入方式</p>
</th>
<th class="cellrowborder" valign="top" width="21.692169216921695%" id="mcps1.1.5.1.3"><p id="zh-cn_topic_0000002433971566_p3985163614183"><a name="zh-cn_topic_0000002433971566_p3985163614183"></a><a name="zh-cn_topic_0000002433971566_p3985163614183"></a>核函数参数值的存放位置</p>
</th>
<th class="cellrowborder" valign="top" width="23.612361236123615%" id="mcps1.1.5.1.4"><p id="zh-cn_topic_0000002433971566_p1498533651816"><a name="zh-cn_topic_0000002433971566_p1498533651816"></a><a name="zh-cn_topic_0000002433971566_p1498533651816"></a>是否可指定任务下发的配置信息</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0000002433971566_row129851736101816"><td class="cellrowborder" valign="top" width="28.782878287828783%" headers="mcps1.1.5.1.1 "><p id="zh-cn_topic_0000002433971566_p998513367181"><a name="zh-cn_topic_0000002433971566_p998513367181"></a><a name="zh-cn_topic_0000002433971566_p998513367181"></a><a href="aclrtLaunchKernel.md">aclrtLaunchKernel</a></p>
</td>
<td class="cellrowborder" valign="top" width="25.912591259125918%" headers="mcps1.1.5.1.2 "><p id="zh-cn_topic_0000002433971566_p11670323122413"><a name="zh-cn_topic_0000002433971566_p11670323122413"></a><a name="zh-cn_topic_0000002433971566_p11670323122413"></a>在接口中指定存放核函数所有入参数据的Device内存地址指针</p>
</td>
<td class="cellrowborder" valign="top" width="21.692169216921695%" headers="mcps1.1.5.1.3 "><p id="zh-cn_topic_0000002433971566_p14985173691814"><a name="zh-cn_topic_0000002433971566_p14985173691814"></a><a name="zh-cn_topic_0000002433971566_p14985173691814"></a>Device内存</p>
</td>
<td class="cellrowborder" valign="top" width="23.612361236123615%" headers="mcps1.1.5.1.4 "><p id="zh-cn_topic_0000002433971566_p129852368180"><a name="zh-cn_topic_0000002433971566_p129852368180"></a><a name="zh-cn_topic_0000002433971566_p129852368180"></a>否</p>
</td>
</tr>
<tr id="zh-cn_topic_0000002433971566_row19985143641817"><td class="cellrowborder" valign="top" width="28.782878287828783%" headers="mcps1.1.5.1.1 "><p id="zh-cn_topic_0000002433971566_p798543621812"><a name="zh-cn_topic_0000002433971566_p798543621812"></a><a name="zh-cn_topic_0000002433971566_p798543621812"></a><a href="aclrtLaunchKernelWithConfig.md">aclrtLaunchKernelWithConfig</a></p>
</td>
<td class="cellrowborder" valign="top" width="25.912591259125918%" headers="mcps1.1.5.1.2 "><p id="zh-cn_topic_0000002433971566_p116709239242"><a name="zh-cn_topic_0000002433971566_p116709239242"></a><a name="zh-cn_topic_0000002433971566_p116709239242"></a>在接口中指定参数列表句柄aclrtArgsHandle</p>
</td>
<td class="cellrowborder" valign="top" width="21.692169216921695%" headers="mcps1.1.5.1.3 "><p id="zh-cn_topic_0000002433971566_p4985123618183"><a name="zh-cn_topic_0000002433971566_p4985123618183"></a><a name="zh-cn_topic_0000002433971566_p4985123618183"></a>Host内存</p>
</td>
<td class="cellrowborder" valign="top" width="23.612361236123615%" headers="mcps1.1.5.1.4 "><p id="zh-cn_topic_0000002433971566_p1198543613189"><a name="zh-cn_topic_0000002433971566_p1198543613189"></a><a name="zh-cn_topic_0000002433971566_p1198543613189"></a>是</p>
</td>
</tr>
</tbody>
</table>

