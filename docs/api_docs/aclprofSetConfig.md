# aclprofSetConfig<a name="ZH-CN_TOPIC_0000001470934965"></a>

## AI处理器支持情况<a name="section8178181118225"></a>

<a name="zh-cn_topic_0000001265241414_table38301303189"></a>
<table><thead align="left"><tr id="zh-cn_topic_0000001265241414_row20831180131817"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="zh-cn_topic_0000001265241414_p1883113061818"><a name="zh-cn_topic_0000001265241414_p1883113061818"></a><a name="zh-cn_topic_0000001265241414_p1883113061818"></a><span id="zh-cn_topic_0000001265241414_ph20833205312295"><a name="zh-cn_topic_0000001265241414_ph20833205312295"></a><a name="zh-cn_topic_0000001265241414_ph20833205312295"></a>AI处理器类型</span></p>
</th>
<th class="cellrowborder" align="center" valign="top" width="42%" id="mcps1.1.3.1.2"><p id="zh-cn_topic_0000001265241414_p783113012187"><a name="zh-cn_topic_0000001265241414_p783113012187"></a><a name="zh-cn_topic_0000001265241414_p783113012187"></a>是否支持</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0000001265241414_row220181016240"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0000001265241414_p48327011813"><a name="zh-cn_topic_0000001265241414_p48327011813"></a><a name="zh-cn_topic_0000001265241414_p48327011813"></a><span id="zh-cn_topic_0000001265241414_ph583230201815"><a name="zh-cn_topic_0000001265241414_ph583230201815"></a><a name="zh-cn_topic_0000001265241414_ph583230201815"></a><term id="zh-cn_topic_0000001265241414_zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001265241414_zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001265241414_zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="zh-cn_topic_0000001265241414_p7948163910184"><a name="zh-cn_topic_0000001265241414_p7948163910184"></a><a name="zh-cn_topic_0000001265241414_p7948163910184"></a>√</p>
</td>
</tr>
<tr id="zh-cn_topic_0000001265241414_row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0000001265241414_p14832120181815"><a name="zh-cn_topic_0000001265241414_p14832120181815"></a><a name="zh-cn_topic_0000001265241414_p14832120181815"></a><span id="zh-cn_topic_0000001265241414_ph1483216010188"><a name="zh-cn_topic_0000001265241414_ph1483216010188"></a><a name="zh-cn_topic_0000001265241414_ph1483216010188"></a><term id="zh-cn_topic_0000001265241414_zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001265241414_zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001265241414_zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="zh-cn_topic_0000001265241414_p19948143911820"><a name="zh-cn_topic_0000001265241414_p19948143911820"></a><a name="zh-cn_topic_0000001265241414_p19948143911820"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="zh-cn_topic_0000001265400578_section36583473819"></a>

aclprofCreateConfig接口的扩展接口，用于设置性能数据采集参数。

该接口支持多次调用，用户需要保证数据的一致性和准确性。

## 函数原型<a name="zh-cn_topic_0000001265400578_section13230182415108"></a>

```
aclError aclprofSetConfig(aclprofConfigType configType, const char *config, size_t configLength)
```

## 参数说明<a name="zh-cn_topic_0000001265400578_section75395119104"></a>

<a name="zh-cn_topic_0000001265400578_zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0000001265400578_zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0000001265400578_zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0000001265400578_zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0000001265400578_zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="zh-cn_topic_0000001265400578_p1769255516412"><a name="zh-cn_topic_0000001265400578_p1769255516412"></a><a name="zh-cn_topic_0000001265400578_p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0000001265400578_zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0000001265400578_zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0000001265400578_zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0000001265400578_row1181143610812"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p17501530216"><a name="p17501530216"></a><a name="p17501530216"></a>configType</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="zh-cn_topic_0000001265400578_p73789014337"><a name="zh-cn_topic_0000001265400578_p73789014337"></a><a name="zh-cn_topic_0000001265400578_p73789014337"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p19514260517"><a name="p19514260517"></a><a name="p19514260517"></a>作为configType参数值。每个枚举表示不同采集配置，若要使用该接口下不同的选项采集多种性能数据，则需要多次调用该接口，详细说明如下：</p>
<a name="ul15592615511"></a><a name="ul15592615511"></a><ul id="ul15592615511"><li>ACL_PROF_STORAGE_LIMIT ：指定落盘目录允许存放的最大文件容量，有效取值范围为[200, 4294967295]，单位为MB。</li><li>ACL_PROF_SYS_HARDWARE_MEM_FREQ：片上内存读写速率、QoS传输带宽、LLC三级缓存带宽、加速器带宽、SoC传输带宽、组件内存占用等的采集频率，范围[1,100]，单位Hz。不同产品的采集内容略有差异，请以实际结果为准。<p id="p14216522114017"><a name="p14216522114017"></a><a name="p14216522114017"></a>已知在安装有glibc&lt;2.34的环境上采集memory数据，可能触发glibc的一个已知<a href="https://sourceware.org/bugzilla/show_bug.cgi?id=19329" target="_blank" rel="noopener noreferrer">Bug 19329</a>，通过升级环境的glibc版本可解决此问题。</p>
<div class="note" id="note3716182418422"><a name="note3716182418422"></a><a name="note3716182418422"></a><span class="notetitle"> 说明： </span><div class="notebody"><p id="zh-cn_topic_0000001312388789_p15913134474213"><a name="zh-cn_topic_0000001312388789_p15913134474213"></a><a name="zh-cn_topic_0000001312388789_p15913134474213"></a>对于以下型号，采集任务结束后，不建议用户增大采集频率，否则可能导致SoC传输带宽数据丢失。</p>
<p id="zh-cn_topic_0000001312388789_p6913204153019"><a name="zh-cn_topic_0000001312388789_p6913204153019"></a><a name="zh-cn_topic_0000001312388789_p6913204153019"></a><span id="zh-cn_topic_0000001312388789_ph189131493020"><a name="zh-cn_topic_0000001312388789_ph189131493020"></a><a name="zh-cn_topic_0000001312388789_ph189131493020"></a><term id="zh-cn_topic_0000001312388789_zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312388789_zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312388789_zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
<p id="zh-cn_topic_0000001312388789_p6913844307"><a name="zh-cn_topic_0000001312388789_p6913844307"></a><a name="zh-cn_topic_0000001312388789_p6913844307"></a><span id="zh-cn_topic_0000001312388789_ph39132413306"><a name="zh-cn_topic_0000001312388789_ph39132413306"></a><a name="zh-cn_topic_0000001312388789_ph39132413306"></a><term id="zh-cn_topic_0000001312388789_zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001312388789_zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001312388789_zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
</div></div>
</li><li>ACL_PROF_LLC_MODE：LLC Profiling采集事件。要求同时设置ACL_PROF_SYS_HARDWARE_MEM_FREQ。可以设置为：<a name="ul6307192911281"></a><a name="ul6307192911281"></a><ul id="ul6307192911281"><li>read：读事件，三级缓存读速率。</li><li>write：写事件，三级缓存写速率。默认为read。</li></ul>
</li><li>ACL_PROF_SYS_IO_FREQ：NIC、ROCE采集频率，范围[1,100]，单位hz。<a name="ul187971121366"></a><a name="ul187971121366"></a><ul id="ul187971121366"><li><span id="ph18311529172811"><a name="ph18311529172811"></a><a name="ph18311529172811"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span>：支持采集NIC和ROCE。</li><li><span id="ph11319936195510"><a name="ph11319936195510"></a><a name="ph11319936195510"></a><term id="zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span>：支持采集NIC和ROCE。</li></ul>
</li><li>ACL_PROF_SYS_INTERCONNECTION_FREQ：集合通信带宽数据（HCCS）、PCIe数据采集开关、片间传输带宽信息采集频率、SIO数据采集开关，范围[1,50]，单位hz。<a name="ul126961356154013"></a><a name="ul126961356154013"></a><ul id="ul126961356154013"><li><span id="ph1535512355400"><a name="ph1535512355400"></a><a name="ph1535512355400"></a><term id="zh-cn_topic_0000001312391781_term11962195213215_1"><a name="zh-cn_topic_0000001312391781_term11962195213215_1"></a><a name="zh-cn_topic_0000001312391781_term11962195213215_1"></a>Ascend 910B</term></span>：支持采集HCCS、PCIe数据、片间传输带宽信息。</li><li><span id="ph17513121518565"><a name="ph17513121518565"></a><a name="ph17513121518565"></a><term id="zh-cn_topic_0000001312391781_term1253731311225_1"><a name="zh-cn_topic_0000001312391781_term1253731311225_1"></a><a name="zh-cn_topic_0000001312391781_term1253731311225_1"></a>Ascend 910C</term></span>：支持采集HCCS、PCIe数据、片间传输带宽信息、SIO数据。</li></ul>
</li><li>ACL_PROF_DVPP_FREQ：DVPP采集频率，范围[1,100]。</li><li>ACL_PROF_HOST_SYS：<span id="ph11758754164613"><a name="ph11758754164613"></a><a name="ph11758754164613"></a>Host</span>侧进程级别的性能数据采集开关，取值包括cpu和mem。</li><li>ACL_PROF_HOST_SYS_USAGE：<span id="ph1726151917134"><a name="ph1726151917134"></a><a name="ph1726151917134"></a>Host</span>侧系统和所有进程的性能数据采集开关，取值包括cpu和mem。</li><li>ACL_PROF_HOST_SYS_USAGE_FREQ：CPU利用率、内存利用率的采集频率，范围[1,50]。</li></ul>
</td>
</tr>
<tr id="zh-cn_topic_0000001265400578_row6243436105811"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p12167449749"><a name="p12167449749"></a><a name="p12167449749"></a>config</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="zh-cn_topic_0000001265400578_p12244736155812"><a name="zh-cn_topic_0000001265400578_p12244736155812"></a><a name="zh-cn_topic_0000001265400578_p12244736155812"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="zh-cn_topic_0000001265400578_p1624443645813"><a name="zh-cn_topic_0000001265400578_p1624443645813"></a><a name="zh-cn_topic_0000001265400578_p1624443645813"></a>指定配置项参数值。</p>
</td>
</tr>
<tr id="zh-cn_topic_0000001265400578_row969144517278"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p71131721858"><a name="p71131721858"></a><a name="p71131721858"></a>configLength</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="zh-cn_topic_0000001265400578_p13661010338"><a name="zh-cn_topic_0000001265400578_p13661010338"></a><a name="zh-cn_topic_0000001265400578_p13661010338"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="zh-cn_topic_0000001265241414_p16733443132315"><a name="zh-cn_topic_0000001265241414_p16733443132315"></a><a name="zh-cn_topic_0000001265241414_p16733443132315"></a>config的长度，单位为Byte，最大长度不超过256字节。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="zh-cn_topic_0000001265400578_section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section691818403409"></a>

先调用aclprofSetConfig接口再调用[aclprofStart](aclprofStart.md)接口，可根据需求选择调用该接口。

