# aclrtLaunchKernelWithHostArgs<a name="ZH-CN_TOPIC_0000002467490201"></a>

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
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p116858459716"><a name="p116858459716"></a><a name="p116858459716"></a>√</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p1568544511713"><a name="p1568544511713"></a><a name="p1568544511713"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section73552454261"></a>

指定任务下发的配置信息，并启动对应算子的计算任务。异步接口。

## 函数原型<a name="section195491952142612"></a>

```
aclError aclrtLaunchKernelWithHostArgs(aclrtFuncHandle funcHandle, uint32_t blockDim, aclrtStream stream, aclrtLaunchKernelCfg *cfg, void *hostArgs, size_t argsSize, aclrtPlaceHolderInfo *placeHolderArray, size_t placeHolderNum)
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
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p7651011104012"><a name="p7651011104012"></a><a name="p7651011104012"></a>funcHandle</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p16651191194015"><a name="p16651191194015"></a><a name="p16651191194015"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p20647101194014"><a name="p20647101194014"></a><a name="p20647101194014"></a>核函数句柄。</p>
</td>
</tr>
<tr id="row118310146407"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p78321454016"><a name="p78321454016"></a><a name="p78321454016"></a>blockDim</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1843143405"><a name="p1843143405"></a><a name="p1843143405"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1784111412407"><a name="p1784111412407"></a><a name="p1784111412407"></a>指定核函数将会在几个核上执行。</p>
</td>
</tr>
<tr id="row7476447193917"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p144761347143915"><a name="p144761347143915"></a><a name="p144761347143915"></a>stream</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p184766473395"><a name="p184766473395"></a><a name="p184766473395"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p147618472393"><a name="p147618472393"></a><a name="p147618472393"></a>指定执行任务的Stream。</p>
</td>
</tr>
<tr id="row62641551133916"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p3264551173917"><a name="p3264551173917"></a><a name="p3264551173917"></a>cfg</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p32641251193910"><a name="p32641251193910"></a><a name="p32641251193910"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1626418519393"><a name="p1626418519393"></a><a name="p1626418519393"></a>任务下发的配置信息。</p>
<p id="p341121111916"><a name="p341121111916"></a><a name="p341121111916"></a>不指定配置时，此处可传NULL。</p>
</td>
</tr>
<tr id="row81987215405"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1319812164017"><a name="p1319812164017"></a><a name="p1319812164017"></a>hostArgs</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p487420429610"><a name="p487420429610"></a><a name="p487420429610"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1083114573013"><a name="p1083114573013"></a><a name="p1083114573013"></a>存放核函数所有入参数据的Host内存地址指针。</p>
</td>
</tr>
<tr id="row18886162317404"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p78861723154013"><a name="p78861723154013"></a><a name="p78861723154013"></a>argsSize</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p287315421267"><a name="p287315421267"></a><a name="p287315421267"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p11717104913210"><a name="p11717104913210"></a><a name="p11717104913210"></a>hostArgs参数值的大小，单位为Byte。</p>
</td>
</tr>
<tr id="row134646518615"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p9464651669"><a name="p9464651669"></a><a name="p9464651669"></a>placeHolderArray</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p17464175113617"><a name="p17464175113617"></a><a name="p17464175113617"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p2046414514610"><a name="p2046414514610"></a><a name="p2046414514610"></a>placeholder参数数组。</p>
<p id="p123421610123716"><a name="p123421610123716"></a><a name="p123421610123716"></a>aclrtPlaceHolderInfo定义如下：</p>
<pre class="screen" id="screen418611503355"><a name="screen418611503355"></a><a name="screen418611503355"></a>typedef struct {
    uint32_t addrOffset;
    uint32_t dataOffset;
} aclrtPlaceHolderInfo;</pre>
<p id="p1735018237364"><a name="p1735018237364"></a><a name="p1735018237364"></a>成员变量说明如下：</p>
<a name="ul12150124173614"></a><a name="ul12150124173614"></a><ul id="ul12150124173614"><li>addrOffset：placeholder指向的数据区拷贝到Device后，其真实Device内存地址在launch时需要刷新到hostArgs中，该参数用于指定需刷新的位置偏移</li><li>dataOffset：placeholder指向的数据区需拷贝到Device侧，该参数用于指定数据区基于hostArgs的地址偏移</li></ul>
</td>
</tr>
<tr id="row202042589615"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p142046588619"><a name="p142046588619"></a><a name="p142046588619"></a>placeHolderNum</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p9204458768"><a name="p9204458768"></a><a name="p9204458768"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p5204125810613"><a name="p5204125810613"></a><a name="p5204125810613"></a>placeholder参数数组的大小。</p>
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

