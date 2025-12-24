# aclprofCreateConfig<a name="ZH-CN_TOPIC_0000001265400578"></a>

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

## 功能说明<a name="section36583473819"></a>

创建aclprofConfig类型的数据，表示创建Profiling配置数据。

aclProfConfig类型数据可以只创建一次、多处使用，用户需要保证数据的一致性和准确性。

如需销毁aclprofConfig类型的数据，请参见[aclprofDestroyConfig](aclprofDestroyConfig.md)。

## 约束说明<a name="section691818403409"></a>

-   使用aclprofDestroyConfig接口销毁aclprofConfig类型的数据，如不销毁会导致内存未被释放。

-   与[aclprofDestroyConfig](aclprofDestroyConfig.md)接口配对使用，先调用aclprofCreateConfig接口再调用aclprofDestroyConfig接口。

## 函数原型<a name="section13230182415108"></a>

```
aclprofConfig *aclprofCreateConfig(uint32_t *deviceIdList, uint32_t deviceNums, aclprofAicoreMetrics aicoreMetrics, const aclprofAicoreEvents *aicoreEvents, uint64_t dataTypeConfig)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row1181143610812"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1438017020336"><a name="p1438017020336"></a><a name="p1438017020336"></a>deviceIdList</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p73789014337"><a name="p73789014337"></a><a name="p73789014337"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1737614033316"><a name="p1737614033316"></a><a name="p1737614033316"></a>Device ID列表。须根据实际环境的Device ID配置。</p>
</td>
</tr>
<tr id="row6243436105811"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p10244153645813"><a name="p10244153645813"></a><a name="p10244153645813"></a>deviceNums</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p12244736155812"><a name="p12244736155812"></a><a name="p12244736155812"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1624443645813"><a name="p1624443645813"></a><a name="p1624443645813"></a>Device的个数。需由用户保证deviceIdList中的Device个数与deviceNums参数值一致，否则可能会导致后续业务异常。</p>
</td>
</tr>
<tr id="row969144517278"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p336811017338"><a name="p336811017338"></a><a name="p336811017338"></a>aicoreMetrics</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p13661010338"><a name="p13661010338"></a><a name="p13661010338"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1836413017337"><a name="p1836413017337"></a><a name="p1836413017337"></a>表示AI Core性能指标采集项。</p>
</td>
</tr>
<tr id="row9669102311598"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p18669023165916"><a name="p18669023165916"></a><a name="p18669023165916"></a>aicoreEvents</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p366922313595"><a name="p366922313595"></a><a name="p366922313595"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p20669112319595"><a name="p20669112319595"></a><a name="p20669112319595"></a>表示AI Core事件，目前配置为NULL。</p>
</td>
</tr>
<tr id="row734474842718"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1136217013333"><a name="p1136217013333"></a><a name="p1136217013333"></a>dataTypeConfig</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p193603013317"><a name="p193603013317"></a><a name="p193603013317"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="zh-cn_topic_0000001265400578_p123351050102719"><a name="zh-cn_topic_0000001265400578_p123351050102719"></a><a name="zh-cn_topic_0000001265400578_p123351050102719"></a>用户选择如下多个宏进行逻辑或（例如：ACL_PROF_ACL_API | ACL_PROF_AICORE_METRICS），作为dataTypeConfig参数值。每个宏表示某一类性能数据，详细说明如下：</p>
<a name="zh-cn_topic_0000001265400578_ul648820489306"></a><a name="zh-cn_topic_0000001265400578_ul648820489306"></a><ul id="zh-cn_topic_0000001265400578_ul648820489306"><li>ACL_PROF_ACL_API：表示采集接口的性能数据，包括Host与Device之间、Device间的同步异步内存复制时延等。</li><li>ACL_PROF_TASK_TIME：采集算子下发耗时、算子执行耗时数据以及算子基本信息数据，提供更全面的性能分析数据。</li><li>ACL_PROF_TASK_TIME_L0：采集算子下发耗时、算子执行耗时数据。与ACL_PROF_TASK_TIME相比，由于不采集算子基本信息数据，采集时性能开销较小，可更精准统计相关耗时数据。</li><li>ACL_PROF_GE_API_L0：采集动态Shape算子在Host调度主要阶段的耗时数据，可更精准统计相关耗时数据。</li><li>ACL_PROF_GE_API_L1：采集动态Shape算子在Host调度阶段更细粒度的耗时数据，提供更全面的性能分析数据。</li><li>ACL_PROF_OP_ATTR：控制采集算子的属性信息，当前仅支持aclnn算子。</li><li>ACL_PROF_AICORE_METRICS：表示采集AI Core性能指标数据，逻辑或时必须包括该宏，aicoreMetrics入参处配置的性能指标采集项才有效。</li><li>ACL_PROF_TASK_MEMORY：控制CANN算子的内存占用情况采集开关，用于优化内存使用。单算子场景下，按照GE组件维度和算子维度采集算子内存大小及生命周期信息（单算子API执行方式不采集GE组件内存）；静态图和静态子图场景下，在算子编译阶段按照算子维度采集算子内存大小及生命周期信息。</li><li>ACL_PROF_AICPU：表示采集AI CPU任务的开始、结束数据。</li><li>ACL_PROF_L2CACHE：表示采集L2 Cache数据和TLB页表缓存命中率。</li><li>ACL_PROF_HCCL_TRACE：控制通信数据采集开关。</li><li>ACL_PROF_MSPROFTX：获取用户和上层框架程序输出的性能数据。可在采集进程内（aclprofStart接口、aclprofStop接口之间）调用msproftx扩展接口或mstx接口开启记录应用程序执行期间特定事件发生的时间跨度，并写入性能数据文件，再使用msprof工具解析该文件，并导出展示性能分析数据。</li><li>ACL_PROF_TRAINING_TRACE：控制迭代轨迹数据采集开关。</li><li>ACL_PROF_RUNTIME_API：控制runtime api性能数据采集开关。</li></ul>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

-   返回aclprofConfig类型的指针，表示成功。
-   返回nullptr，表示失败。

