# aclrtStreamAttrValue<a name="ZH-CN_TOPIC_0000002306334617"></a>

```
typedef union {
    uint64_t failureMode;
    uint32_t overflowSwitch; 
    uint32_t userCustomTag; 
    uint32_t cacheOpInfoSwitch;
    uint32_t reserve[4];
} aclrtStreamAttrValue;
```

<a name="table154428882117"></a>
<table><thead align="left"><tr id="row15442178172115"><th class="cellrowborder" valign="top" width="31.580000000000002%" id="mcps1.1.3.1.1"><p id="p10442188112114"><a name="p10442188112114"></a><a name="p10442188112114"></a>成员名称</p>
</th>
<th class="cellrowborder" valign="top" width="68.42%" id="mcps1.1.3.1.2"><p id="p84426814219"><a name="p84426814219"></a><a name="p84426814219"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row134425813216"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p94424892111"><a name="p94424892111"></a><a name="p94424892111"></a>failureMode</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p1631194383615"><a name="p1631194383615"></a><a name="p1631194383615"></a>设置aclrtStreamAttr中的ACL_STREAM_ATTR_FAILURE_MODE（表示Stream的任务调度模式）属性时，属性值的取值如下：</p>
<a name="ul34321422185313"></a><a name="ul34321422185313"></a><ul id="ul34321422185313"><li>0：<span>某个任务失败后，继续执行下一个任务。</span>默认值为0。</li><li>1：某个任务失败后，停止执行后续的任务，通常称作遇错即停。触发遇错即停之后，不支持再下发新任务。<p id="p1321742844415"><a name="p1321742844415"></a><a name="p1321742844415"></a>当Stream上设置了遇错即停模式，该Stream所在的Context下的其它Stream也是遇错即停 。该约束适用于以下产品型号：</p>
<p id="p53416558355"><a name="p53416558355"></a><a name="p53416558355"></a><span id="ph123091510412"><a name="ph123091510412"></a><a name="ph123091510412"></a><term id="zh-cn_topic_0000002480016973_term1253731311225"><a name="zh-cn_topic_0000002480016973_term1253731311225"></a><a name="zh-cn_topic_0000002480016973_term1253731311225"></a>Atlas A3 训练系列产品</term>/<term id="zh-cn_topic_0000002480016973_term12835255145414"><a name="zh-cn_topic_0000002480016973_term12835255145414"></a><a name="zh-cn_topic_0000002480016973_term12835255145414"></a>Atlas A3 推理系列产品</term></span></p>
<p id="p06081449364"><a name="p06081449364"></a><a name="p06081449364"></a><span id="ph1543203612414"><a name="ph1543203612414"></a><a name="ph1543203612414"></a><term id="zh-cn_topic_0000002480016973_term11962195213215"><a name="zh-cn_topic_0000002480016973_term11962195213215"></a><a name="zh-cn_topic_0000002480016973_term11962195213215"></a>Atlas A2 训练系列产品</term>/<term id="zh-cn_topic_0000002480016973_term1551319498507"><a name="zh-cn_topic_0000002480016973_term1551319498507"></a><a name="zh-cn_topic_0000002480016973_term1551319498507"></a>Atlas A2 推理系列产品</term></span></p>
</li></ul>
</td>
</tr>
<tr id="row4291121763611"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p2292171723615"><a name="p2292171723615"></a><a name="p2292171723615"></a>overflowSwitch</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p869619417546"><a name="p869619417546"></a><a name="p869619417546"></a>设置aclrtStreamAttr中的ACL_STREAM_ATTR_FLOAT_OVERFLOW_CHECK（表示溢出检测开关）属性时，属性值的取值如下：</p>
<a name="ul175164025420"></a><a name="ul175164025420"></a><ul id="ul175164025420"><li>0：关闭溢出检测。默认值为0。</li><li>1：打开溢出检测。</li></ul>
</td>
</tr>
<tr id="row57705527362"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p177010525369"><a name="p177010525369"></a><a name="p177010525369"></a>userCustomTag</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p477014523361"><a name="p477014523361"></a><a name="p477014523361"></a>设置aclrtStreamAttr中的ACL_STREAM_ATTR_USER_CUSTOM_TAG（表示溢出检测分组标签）属性时，属性值的取值范围：0~uint32_t类型的最大值。</p>
</td>
</tr>
<tr id="row8736436319"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p1973843633"><a name="p1973843633"></a><a name="p1973843633"></a>cacheOpInfoSwitch</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p131372416420"><a name="p131372416420"></a><a name="p131372416420"></a>设置aclrtStreamAttr中的ACL_STREAM_ATTR_CACHE_OP_INFO （表示算子信息缓存开关）属性时，属性值的取值如下：</p>
<a name="ul1813744445"></a><a name="ul1813744445"></a><ul id="ul1813744445"><li>0：关闭算子信息缓存开关。默认值为0。</li><li>1：开启算子信息缓存开关。</li></ul>
</td>
</tr>
<tr id="row77592549554"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p12759115415511"><a name="p12759115415511"></a><a name="p12759115415511"></a>reserve</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p10759125411554"><a name="p10759125411554"></a><a name="p10759125411554"></a>预留值。</p>
</td>
</tr>
</tbody>
</table>

