# aclrtLaunchKernelAttrValue<a name="ZH-CN_TOPIC_0000002253031453"></a>

```
typedef union aclrtLaunchKernelAttrValue {
    uint8_t schemMode;
    uint32_t localMemorySize;
    aclrtEngineType engineType; 
    uint32_t blockDimOffset; 
    uint8_t isBlockTaskPrefetch; 
    uint8_t isDataDump; 
    uint16_t timeout;
    aclrtTimeoutUs timeoutUs;
    uint32_t rsv[4];
} aclrtLaunchKernelAttrValue;
```

<a name="zh-cn_topic_0249624707_table6284194414136"></a>
<table><thead align="left"><tr id="zh-cn_topic_0249624707_row341484411134"><th class="cellrowborder" valign="top" width="20.87%" id="mcps1.1.3.1.1"><p id="zh-cn_topic_0249624707_p154141244121314"><a name="zh-cn_topic_0249624707_p154141244121314"></a><a name="zh-cn_topic_0249624707_p154141244121314"></a>成员名称</p>
</th>
<th class="cellrowborder" valign="top" width="79.13%" id="mcps1.1.3.1.2"><p id="zh-cn_topic_0249624707_p10414344151315"><a name="zh-cn_topic_0249624707_p10414344151315"></a><a name="zh-cn_topic_0249624707_p10414344151315"></a>描述</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0249624707_row754710296481"><td class="cellrowborder" valign="top" width="20.87%" headers="mcps1.1.3.1.1 "><p id="p106121425182514"><a name="p106121425182514"></a><a name="p106121425182514"></a>schemMode</p>
</td>
<td class="cellrowborder" valign="top" width="79.13%" headers="mcps1.1.3.1.2 "><p id="p1299784110142"><a name="p1299784110142"></a><a name="p1299784110142"></a>调度模式。</p>
<p id="p165383394129"><a name="p165383394129"></a><a name="p165383394129"></a>取值如下：</p>
<a name="ul596513401217"></a><a name="ul596513401217"></a><ul id="ul596513401217"><li>0：普通调度模式，有空闲的核，就启动算子执行。例如，当blockDim为8时，表示算子核函数将会在8个核上执行，这时如果指定普通调度模式，则表示只要有1个核空闲了，就启动算子执行。</li><li>1：batch调度模式，必须所有所需的核都空闲了，才启动算子执行。例如，当blockDim为8时，表示算子核函数将会在8个核上执行，这时如果指定batch调度模式，则表示必须等8个核都空闲了，才启动算子执行。</li></ul>
</td>
</tr>
<tr id="zh-cn_topic_0249624707_row936773214820"><td class="cellrowborder" valign="top" width="20.87%" headers="mcps1.1.3.1.1 "><p id="p0611152513258"><a name="p0611152513258"></a><a name="p0611152513258"></a>localMemorySize</p>
</td>
<td class="cellrowborder" valign="top" width="79.13%" headers="mcps1.1.3.1.2 "><p id="p633472315365"><a name="p633472315365"></a><a name="p633472315365"></a>用于指定SIMT（Single Instruction Multiple Thread）算子执行时需要的VECTOR CORE内部UB buffer的大小，单位Byte。</p>
<p id="p167411110183718"><a name="p167411110183718"></a><a name="p167411110183718"></a>当前不支持该参数，配置该参数不生效。</p>
</td>
</tr>
<tr id="row1428365317200"><td class="cellrowborder" valign="top" width="20.87%" headers="mcps1.1.3.1.1 "><p id="p9283653162010"><a name="p9283653162010"></a><a name="p9283653162010"></a>engineType</p>
</td>
<td class="cellrowborder" valign="top" width="79.13%" headers="mcps1.1.3.1.2 "><p id="p123314311142"><a name="p123314311142"></a><a name="p123314311142"></a>算子执行引擎。取值请参见<a href="aclrtEngineType.md">aclrtEngineType</a>。</p>
<p id="p311757132213"><a name="p311757132213"></a><a name="p311757132213"></a>以下产品型号配置该参数不生效：</p>
<a name="ul1134718182249"></a><a name="ul1134718182249"></a><ul id="ul1134718182249"><li><span id="ph583230201815"><a name="ph583230201815"></a><a name="ph583230201815"></a><term id="zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></li><li><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></li></ul>
</td>
</tr>
<tr id="row99015432116"><td class="cellrowborder" valign="top" width="20.87%" headers="mcps1.1.3.1.1 "><p id="p2090164182118"><a name="p2090164182118"></a><a name="p2090164182118"></a>blockDimOffset</p>
</td>
<td class="cellrowborder" valign="top" width="79.13%" headers="mcps1.1.3.1.2 "><p id="p1821280204215"><a name="p1821280204215"></a><a name="p1821280204215"></a>blockDim偏移量。</p>
<a name="ul16917575011"></a><a name="ul16917575011"></a><ul id="ul16917575011"><li><strong id="b927592813319"><a name="b927592813319"></a><a name="b927592813319"></a>如果blockDim ≤ AI Core核数</strong>，则无需使用Vector Core上计算，可将engineType配置为ACL_RT_ENGINE_TYPE_AIC（表示在AI Core上计算），则此处的blockDimOffset配置为0。</li><li><strong id="b1963243219316"><a name="b1963243219316"></a><a name="b1963243219316"></a>如果blockDim &gt; AI Core核数</strong>，则需：<a name="ul3105381411"></a><a name="ul3105381411"></a><ul id="ul3105381411"><li>在一个Stream上下发任务，将engineType配置为ACL_RT_ENGINE_TYPE_AIC（表示在AI Core上计算），此处的blockDimOffset配置为0。</li><li>在另一个Stream上下发任务，将engineType配置为ACL_RT_ENGINE_TYPE_AIV（表示在Vector Core上计算），此处的blockDimOffset配置为aicoreblockdim，aicoreblockdim的计算公式如下：<a name="ul44467527215"></a><a name="ul44467527215"></a><ul id="ul44467527215"><li>blockDim ≤ AI Core核数+Vector Core核数时，aicoreblockdim = AI Core核数</li><li>否则，aicoreblockdim = 向上取整 ( blockDim * ( AI Core核数 ) / ( AI Core核数 + Vector Core核数 ))</li></ul>
</li></ul>
</li></ul>
<p id="p67822244614"><a name="p67822244614"></a><a name="p67822244614"></a>以下产品型号不支持该参数：</p>
<a name="ul1878252412613"></a><a name="ul1878252412613"></a><ul id="ul1878252412613"><li><span id="ph57821624968"><a name="ph57821624968"></a><a name="ph57821624968"></a><term id="zh-cn_topic_0000001312391781_term1253731311225_1"><a name="zh-cn_topic_0000001312391781_term1253731311225_1"></a><a name="zh-cn_topic_0000001312391781_term1253731311225_1"></a>Ascend 910C</term></span></li><li><span id="ph478222413615"><a name="ph478222413615"></a><a name="ph478222413615"></a><term id="zh-cn_topic_0000001312391781_term11962195213215_1"><a name="zh-cn_topic_0000001312391781_term11962195213215_1"></a><a name="zh-cn_topic_0000001312391781_term11962195213215_1"></a>Ascend 910B</term></span></li></ul>
</td>
</tr>
<tr id="row17168151211215"><td class="cellrowborder" valign="top" width="20.87%" headers="mcps1.1.3.1.1 "><p id="p141681125216"><a name="p141681125216"></a><a name="p141681125216"></a>isBlockTaskPrefetch</p>
</td>
<td class="cellrowborder" valign="top" width="79.13%" headers="mcps1.1.3.1.2 "><p id="p151771945171415"><a name="p151771945171415"></a><a name="p151771945171415"></a>任务下发时，是否阻止硬件预取本任务的信息<span>。</span></p>
<p id="p19391506148"><a name="p19391506148"></a><a name="p19391506148"></a>取值如下：</p>
<a name="ul331155313140"></a><a name="ul331155313140"></a><ul id="ul331155313140"><li>0：不阻止</li><li>1：阻止</li></ul>
</td>
</tr>
<tr id="row99434182217"><td class="cellrowborder" valign="top" width="20.87%" headers="mcps1.1.3.1.1 "><p id="p49431180217"><a name="p49431180217"></a><a name="p49431180217"></a>isDataDump</p>
</td>
<td class="cellrowborder" valign="top" width="79.13%" headers="mcps1.1.3.1.2 "><p id="p14997156102715"><a name="p14997156102715"></a><a name="p14997156102715"></a>是否开启Dump。</p>
<p id="p158432872814"><a name="p158432872814"></a><a name="p158432872814"></a>取值如下：</p>
<a name="ul1699514932818"></a><a name="ul1699514932818"></a><ul id="ul1699514932818"><li>0：不开启</li><li>1：开启</li></ul>
</td>
</tr>
<tr id="row79711122192112"><td class="cellrowborder" valign="top" width="20.87%" headers="mcps1.1.3.1.1 "><p id="p897116228219"><a name="p897116228219"></a><a name="p897116228219"></a>timeout</p>
</td>
<td class="cellrowborder" valign="top" width="79.13%" headers="mcps1.1.3.1.2 "><p id="p1958601516255"><a name="p1958601516255"></a><a name="p1958601516255"></a>任务调度器等待任务执行的超时时间。<span id="ph5435153719381"><a name="ph5435153719381"></a><a name="ph5435153719381"></a>仅适用于执行AI CPU或AI Core算子的场景。</span></p>
<p id="p14163161111313"><a name="p14163161111313"></a><a name="p14163161111313"></a>取值如下：</p>
<a name="ul589318220132"></a><a name="ul589318220132"></a><ul id="ul589318220132"><li>0：表示永久等待；</li><li>&gt;0：配置具体的超时时间，单位是秒。</li></ul>
</td>
</tr>
<tr id="row021134114718"><td class="cellrowborder" valign="top" width="20.87%" headers="mcps1.1.3.1.1 "><p id="p5228484717"><a name="p5228484717"></a><a name="p5228484717"></a>timeoutUs</p>
</td>
<td class="cellrowborder" valign="top" width="79.13%" headers="mcps1.1.3.1.2 "><p id="p6225414715"><a name="p6225414715"></a><a name="p6225414715"></a>任务调度器等待任务执行的超时时间，单位微秒。</p>
<p id="p83362635220"><a name="p83362635220"></a><a name="p83362635220"></a>若aclrtTimeoutUs结构体中，timeoutLow和timeoutHigh均被配置为0，则表示永久等待。</p>
<p id="p785417176562"><a name="p785417176562"></a><a name="p785417176562"></a>对于同一个Launch Kernel任务，不能同时配置timeoutUs和timeout参数，否则返回报错。</p>
</td>
</tr>
<tr id="zh-cn_topic_0249624707_row194149449133"><td class="cellrowborder" valign="top" width="20.87%" headers="mcps1.1.3.1.1 "><p id="p861112515256"><a name="p861112515256"></a><a name="p861112515256"></a>rsv</p>
</td>
<td class="cellrowborder" valign="top" width="79.13%" headers="mcps1.1.3.1.2 "><p id="p18672145895315"><a name="p18672145895315"></a><a name="p18672145895315"></a>预留参数。当前固定配置为0。</p>
</td>
</tr>
</tbody>
</table>

