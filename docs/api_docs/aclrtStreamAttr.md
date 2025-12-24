# aclrtStreamAttr<a name="ZH-CN_TOPIC_0000002271717966"></a>

```
typedef enum { 
    ACL_STREAM_ATTR_FAILURE_MODE         = 1,
    ACL_STREAM_ATTR_FLOAT_OVERFLOW_CHECK = 2,
    ACL_STREAM_ATTR_USER_CUSTOM_TAG      = 3, 
    ACL_STREAM_ATTR_CACHE_OP_INFO        = 4, 
} aclrtStreamAttr;
```

<a name="table154428882117"></a>
<table><thead align="left"><tr id="row15442178172115"><th class="cellrowborder" valign="top" width="31.580000000000002%" id="mcps1.1.3.1.1"><p id="p167348211478"><a name="p167348211478"></a><a name="p167348211478"></a>枚举项</p>
</th>
<th class="cellrowborder" valign="top" width="68.42%" id="mcps1.1.3.1.2"><p id="p84426814219"><a name="p84426814219"></a><a name="p84426814219"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row134425813216"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p94424892111"><a name="p94424892111"></a><a name="p94424892111"></a>ACL_STREAM_ATTR_FAILURE_MODE</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p1631194383615"><a name="p1631194383615"></a><a name="p1631194383615"></a>当Stream上的任务执行出错时，可通过该属性设置Stream的任务调度模式，以便控制某个任务失败后是否继续执行下一个任务</p>
<p id="p19310726195711"><a name="p19310726195711"></a><a name="p19310726195711"></a>默认Stream不支持设置任务调度模式。</p>
<p id="p1440833017542"><a name="p1440833017542"></a><a name="p1440833017542"></a>通过该属性设置任务调度模式，与<a href="aclrtSetStreamFailureMode.md">aclrtSetStreamFailureMode</a>接口的功能一致。</p>
</td>
</tr>
<tr id="row4291121763611"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p2292171723615"><a name="p2292171723615"></a><a name="p2292171723615"></a>ACL_STREAM_ATTR_FLOAT_OVERFLOW_CHECK</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p8292191753616"><a name="p8292191753616"></a><a name="p8292191753616"></a>饱和模式下，当与上层训练框架（例如PyTorch）对接时，针对指定Stream，可通过该属性打开或关闭溢出检测开关。关闭后，将无法通过溢出检测算子获取任务是否溢出。</p>
<p id="p515064317563"><a name="p515064317563"></a><a name="p515064317563"></a>打开或关闭溢出检测开关后，仅对后续新下的任务生效，已下发的任务仍维持原样。</p>
<p id="p7104153915557"><a name="p7104153915557"></a><a name="p7104153915557"></a>通过该属性设置溢出检测开关，与<a href="aclrtSetStreamOverflowSwitch.md">aclrtSetStreamOverflowSwitch</a>接口的功能一致。</p>
</td>
</tr>
<tr id="row57705527362"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p177010525369"><a name="p177010525369"></a><a name="p177010525369"></a>ACL_STREAM_ATTR_USER_CUSTOM_TAG</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p8920101013583"><a name="p8920101013583"></a><a name="p8920101013583"></a>设置Stream上的溢出检测分组标签，以确定溢出发生时检测的粒度。如果不设置分组标签，默认为进程粒度。如果设置了分组标签，则仅检测与发生溢出的Stream具有相同分组标签的Stream。</p>
</td>
</tr>
<tr id="row6139830164915"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p1713993054911"><a name="p1713993054911"></a><a name="p1713993054911"></a>ACL_STREAM_ATTR_CACHE_OP_INFO</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p213912306490"><a name="p213912306490"></a><a name="p213912306490"></a>基于捕获方式构建模型运行实例场景下，通过该属性设置Stream的算子信息缓存开关，以便于控制后续采集性能数据时是否附带算子信息。</p>
<p id="p43861658111815"><a name="p43861658111815"></a><a name="p43861658111815"></a>该属性需与其它接口配合使用，请参见<a href="aclrtCacheLastTaskOpInfo.md">aclrtCacheLastTaskOpInfo</a>中的接口调用流程。</p>
</td>
</tr>
</tbody>
</table>

