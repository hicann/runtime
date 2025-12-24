# aclmdlSetDump<a name="ZH-CN_TOPIC_0000001312481489"></a>

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

## 功能说明<a name="section259105813316"></a>

设置Dump参数。

[aclmdlInitDump](aclmdlInitDump.md)接口、[aclmdlSetDump](aclmdlSetDump.md)接口、[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口配合使用，用于将Dump数据记录到文件中。一个进程内，可以根据需求多次调用这些接口，基于不同的Dump配置信息，获取Dump数据。场景举例如下：

-   执行两个不同的模型，需要设置不同的Dump配置信息，接口调用顺序：[aclInit](aclInit.md)接口--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>[aclmdlSetDump](aclmdlSetDump.md)接口--\>模型1加载--\>模型1执行--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>模型1卸载--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>[aclmdlSetDump](aclmdlSetDump.md)接口--\>模型2加载--\>模型2执行--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>模型2卸载--\>执行其它任务--\>[aclFinalize](aclFinalize.md)接口
-   同一个模型执行两次，第一次需要Dump，第二次无需Dump，接口调用顺序：[aclInit](aclInit.md)接口--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>[aclmdlSetDump](aclmdlSetDump.md)接口--\>模型加载--\>模型执行--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>模型卸载--\>模型加载--\>模型执行--\>执行其它任务--\>[aclFinalize](aclFinalize.md)接口

## 函数原型<a name="section2067518173415"></a>

```
aclError aclmdlSetDump(const char *dumpCfgPath)
```

## 参数说明<a name="section158061867342"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row1919192774810"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p15161451803"><a name="p15161451803"></a><a name="p15161451803"></a>dumpCfgPath</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p115114513010"><a name="p115114513010"></a><a name="p115114513010"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="zh-cn_topic_0122830089_p19388143103518"><a name="zh-cn_topic_0122830089_p19388143103518"></a><a name="zh-cn_topic_0122830089_p19388143103518"></a>配置文件路径的指针，包含文件名。配置文件格式为json格式。</p>
<div class="p" id="p13536171711208"><a name="p13536171711208"></a><a name="p13536171711208"></a><strong id="b27531691621"><a name="b27531691621"></a><a name="b27531691621"></a>当前支持以下Dump信息配置</strong>（如果算子输入或输出中包含用户的敏感信息，则存在信息泄露风险）<strong id="b1622014306209"><a name="b1622014306209"></a><a name="b1622014306209"></a>：</strong><a name="ul18553134819156"></a><a name="ul18553134819156"></a><ul id="ul18553134819156"><li><strong id="b52425141413"><a name="b52425141413"></a><a name="b52425141413"></a>模型Dump配置</strong>（用于导出模型中每一层算子输入和输出数据）、<strong id="b1985213171616"><a name="b1985213171616"></a><a name="b1985213171616"></a>单算子Dump配置</strong>（用于导出单个算子的输入和输出数据），导出的数据用于与指定模型或算子进行比对，定位精度问题，配置示例、说明及约束请参见<a href="aclInit.md#section197612500567">模型Dump配置、单算子Dump配置示例</a>。默认不启用该Dump配置。</li><li><strong id="b18244627181119"><a name="b18244627181119"></a><a name="b18244627181119"></a>异常算子Dump配置</strong>（用于导出异常算子的输入输出数据、workspace信息、Tiling信息），导出的数据用于分析AI Core Error问题，配置示例请参见<a href="aclInit.md#section1939018362581">异常算子Dump配置示例</a>。默认不启用该Dump配置。</li><li><strong id="b19867182215111"><a name="b19867182215111"></a><a name="b19867182215111"></a>溢出算子Dump配置</strong>（用于导出模型中溢出算子的输入和输出数据），导出的数据用于分析溢出原因，定位模型精度的问题，配置示例、说明及约束请参见<a href="#section348542922116">溢出算子Dump配置示例</a>。默认不启用该Dump配置。</li><li><strong id="b148766481036"><a name="b148766481036"></a><a name="b148766481036"></a>算子Dump Watch模式配置</strong>（用于开启指定算子输出数据的观察模式），在定位部分算子精度问题且已排除算子本身的计算问题后，若怀疑被其它算子踩踏内存导致精度问题，可开启Dump Watch模式，配置示例及约束请参见<a href="#section418234963714">算子Dump Watch模式配置示例</a>。<strong id="b452710553310"><a name="b452710553310"></a><a name="b452710553310"></a>默认不开启Dump Watch模式。</strong></li></ul>
</div>
</td>
</tr>
</tbody>
</table>

## 模型Dump配置、单算子Dump配置示例<a name="section169011356862"></a>

配置模型Dump、单算子Dump后，导出的Dump数据用于与指定模型或算子进行比对，便于定位精度问题，具体比对方法请参见《》。

模型Dump配置示例如下：

```
{                                                                                            
	"dump":{
		"dump_list":[                                                                        
			{	"model_name":"ResNet-101"
			},
			{                                                                                
				"model_name":"ResNet-50",
				"layer":[
				      "conv1conv1_relu",
				      "res2a_branch2ares2a_branch2a_relu",
				      "res2a_branch1",
				      "pool1"
				] 
			}  
		],  
		"dump_path":"/home/output",
                "dump_mode":"output",
		"dump_op_switch":"off",
                "dump_data":"tensor"
	}                                                                                        
}
```

单算子调用场景下，Dump配置示例如下：

```
{
    "dump":{
        "dump_path":"/home/output",
        "dump_list":[], 
	"dump_op_switch":"on",
        "dump_data":"tensor"
    }
}
```

**表 1**  acl.json文件格式说明

<a name="zh-cn_topic_0000001312400361_table2044611711017"></a>
<table><thead align="left"><tr id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_row11302545145113"><th class="cellrowborder" valign="top" width="32.42%" id="mcps1.2.3.1.1"><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p9303114520512"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p9303114520512"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p9303114520512"></a>配置项</p>
</th>
<th class="cellrowborder" valign="top" width="67.58%" id="mcps1.2.3.1.2"><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p6303154545120"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p6303154545120"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p6303154545120"></a>参数说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_row43031545115118"><td class="cellrowborder" valign="top" width="32.42%" headers="mcps1.2.3.1.1 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p17303104513518"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p17303104513518"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p17303104513518"></a>dump_list</p>
</td>
<td class="cellrowborder" valign="top" width="67.58%" headers="mcps1.2.3.1.2 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p177541139275"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p177541139275"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p177541139275"></a>（必选）待dump数据的整网模型列表。</p>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p3490271324"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p3490271324"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p3490271324"></a>创建模型dump配置信息，当存在多个模型需要dump时，需要每个模型之间用英文逗号隔开。</p>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p33240411526"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p33240411526"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p33240411526"></a>在单算子调用场景（包括单算子模型执行和单算子API执行）下，dump_list建议为空。</p>
</td>
</tr>
<tr id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_row530344517517"><td class="cellrowborder" valign="top" width="32.42%" headers="mcps1.2.3.1.1 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p3303154518512"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p3303154518512"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p3303154518512"></a>model_name</p>
</td>
<td class="cellrowborder" valign="top" width="67.58%" headers="mcps1.2.3.1.2 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p1332535816169"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p1332535816169"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p1332535816169"></a>模型名称，各个模型的model_name值须唯一。</p>
<a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul3183132413818"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul3183132413818"></a><ul id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul3183132413818"><li>模型加载方式为文件加载时，填入模型文件的名称，不需要带后缀名；也可以配置为<span id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ph2091083915275"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ph2091083915275"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ph2091083915275"></a>ATC</span>模型文件转换后的json文件里的最外层"name"字段对应值。</li><li>模型加载方式为内存加载时，配置为<span id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ph1939814819182"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ph1939814819182"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ph1939814819182"></a>ATC</span>模型文件转换后的json文件里的最外层"name"字段对应值。</li></ul>
</td>
</tr>
<tr id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_row7303124514510"><td class="cellrowborder" valign="top" width="32.42%" headers="mcps1.2.3.1.1 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p0303114519514"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p0303114519514"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p0303114519514"></a>layer</p>
</td>
<td class="cellrowborder" valign="top" width="67.58%" headers="mcps1.2.3.1.2 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p121821523154216"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p121821523154216"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p121821523154216"></a>IO性能较差时，可能会因为数据量过大而导致执行超时，因此不建议进行全量dump，请指定算子进行dump。通过该字段可以指定需要dump的算子名，支持指定为ATC模型转换后的算子名，也支持指定为转换前的原始算子名，配置时需注意：</p>
<a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul346651019174"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul346651019174"></a><ul id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul346651019174"><li>需按格式配置，每行配置模型中的一个算子名，且每个算子之间用英文逗号隔开。</li><li>用户可以无需设置model_name，此时会默认dump所有model下的相应算子。如果配置了model_name，则dump对应model下的相应算子。</li><li>若指定的算子其输入涉及data算子，会同时将data算子信息dump出来；若需dump data算子，需要一并填写data节点算子的后继节点，才能dump出data节点算子数据。</li><li>当需要dump模型中所有算子时，不需要包含layer字段。</li></ul>
</td>
</tr>
<tr id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_row1240754212258"><td class="cellrowborder" valign="top" width="32.42%" headers="mcps1.2.3.1.1 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p151877477257"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p151877477257"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p151877477257"></a>optype_blacklist</p>
</td>
<td class="cellrowborder" valign="top" width="67.58%" headers="mcps1.2.3.1.2 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p1841012487482"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p1841012487482"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p1841012487482"></a>配置dump数据黑名单，黑名单中的指定类型的算子的输入或输出数据不会进行数据dump，用户可通过该配置控制dump的数据量。</p>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p812595004811"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p812595004811"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p812595004811"></a>该功能仅在执行模型数据dump操作，且dump_level为op时生效，同时支持和opname_blacklist配合使用。</p>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p818714772510"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p818714772510"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p818714772510"></a>配置示例：</p>
<pre class="screen" id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_screen1668105317118"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_screen1668105317118"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_screen1668105317118"></a>{
	"dump":{
		"dump_list":[     
			{                                                                                
				"model_name":"ResNet-50",
				"optype_blacklist":[
				    {
					  "name":"conv"
					  "pos":["input0", "input1"]
					} 
				] 
			}
		],  
		"dump_path":"/home/output",
                "dump_mode":"input",
	}  
}</pre>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p651665910443"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p651665910443"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p651665910443"></a>以上示例表示：不对conv算子的input0数据和input1数据执行dump操作，conv为算子类型。</p>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p13409624716"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p13409624716"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p13409624716"></a>optype_blacklist中包括name和pos字段，配置时需注意：</p>
<a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul1283713371018"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul1283713371018"></a><ul id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul1283713371018"><li>name表示算子类型，支持指定为ATC模型转换后的算子类型，配置为空时该过滤项不生效。</li><li>pos表示算子的输入或输出，仅支持配置为inputn或outputn格式，其中n表示输入输出索引号。配置为空时该过滤项不生效。</li><li>optype_blacklist内最多支持配置100个过滤项。</li><li>如果配置了model_name，则仅对该model下的算子生效。如果不配置model_name，则对所有model下的算子生效。</li></ul>
</td>
</tr>
<tr id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_row11187347122511"><td class="cellrowborder" valign="top" width="32.42%" headers="mcps1.2.3.1.1 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p3955752181319"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p3955752181319"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p3955752181319"></a>opname_blacklist</p>
</td>
<td class="cellrowborder" valign="top" width="67.58%" headers="mcps1.2.3.1.2 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p12292204354815"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p12292204354815"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p12292204354815"></a>配置dump数据黑名单，黑名单中的指定名称的算子的输入或输出数据不会进行数据dump，用户可通过该配置控制dump的数据量。</p>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p1767454517489"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p1767454517489"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p1767454517489"></a>该功能仅在执行模型数据dump操作，且dump_level为op时生效，同时支持和optype_blacklist配合使用。</p>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p10961201116451"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p10961201116451"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p10961201116451"></a>配置示例：</p>
<pre class="screen" id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_screen20961211174515"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_screen20961211174515"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_screen20961211174515"></a>{
	"dump":{
		"dump_list":[     
			{                                                                                
				"model_name":"ResNet-50",
				"opname_blacklist":[
				    {
					  "name":"conv"
					  "pos":["input0", "input1"]
					} 
				] 
			}
		],  
		"dump_path":"/home/output",
                "dump_mode":"input",
	}  
}</pre>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p6961911184519"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p6961911184519"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p6961911184519"></a>以上示例表示：不对conv算子的input0数据和input1数据执行dump操作，conv为算子名称。</p>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p3961141194513"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p3961141194513"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p3961141194513"></a>opname_blacklist中包括name和pos字段，配置时需注意：</p>
<a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul6961131174514"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul6961131174514"></a><ul id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul6961131174514"><li>name表示算子名称，支持指定为ATC模型转换后的算子名称，配置为空时该过滤项不生效。</li><li>pos表示算子的输入或输出，仅支持配置为inputn或outputn格式，其中n表示输入输出索引号。配置为空时该过滤项不生效。</li><li>opname_blacklist内最多支持配置100个过滤项。</li><li>如果配置了model_name，则仅对该model下的算子生效。如果不配置model_name，则对所有model下的算子生效。</li></ul>
</td>
</tr>
<tr id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_row730512348381"><td class="cellrowborder" valign="top" width="32.42%" headers="mcps1.2.3.1.1 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p143057348384"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p143057348384"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p143057348384"></a>opname_range</p>
</td>
<td class="cellrowborder" valign="top" width="67.58%" headers="mcps1.2.3.1.2 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p42861089427"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p42861089427"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p42861089427"></a>配置dump数据范围，对begin到end闭区间内的数据执行dump操作。</p>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p133058348389"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p133058348389"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p133058348389"></a>该功能仅在执行模型数据dump操作，且dump_level为op时生效。</p>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p57163114119"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p57163114119"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p57163114119"></a>配置示例：</p>
<pre class="screen" id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_screen42361378413"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_screen42361378413"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_screen42361378413"></a>{
	"dump":{
		"dump_list":[
			{
				"model_name":"ResNet-50",
				"opname_range":[{"begin":"conv1", "end":"relu1" }, {"begin":"conv2", "end":"pool1"}]
			}
		],
		"dump_mode":"output",
        "dump_level": "op",
        "dump_path":"/home/output"
	}
}</pre>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p2861330438"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p2861330438"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p2861330438"></a>以上示例表示对conv1到relu1、conv2到pool1闭区间内的数据执行dump操作，conv1、relu1、conv2、pool1表示算子名称。</p>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p671681154116"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p671681154116"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p671681154116"></a>配置时需注意：</p>
<a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul774363411502"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul774363411502"></a><ul id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul774363411502"><li>model_name不允许为空。</li><li>begin和end中的参数表示算子名称，支持指定为ATC模型转换后的算子名称。</li><li>begin和end不允许为空，且只能配置为非data算子；若begin和end范围内算子的输入涉及data算子，会同时对data算子信息执行dump操作。</li></ul>
</td>
</tr>
<tr id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_row832233011540"><td class="cellrowborder" valign="top" width="32.42%" headers="mcps1.2.3.1.1 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p732343045414"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p732343045414"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p732343045414"></a>dump_path</p>
</td>
<td class="cellrowborder" valign="top" width="67.58%" headers="mcps1.2.3.1.2 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p59442341629"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p59442341629"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p59442341629"></a>（必选）dump数据文件存储到运行环境的目录，该目录需要提前创建且确保安装时配置的运行用户具有读写权限。</p>
<div class="p" id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p118179189219"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p118179189219"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p118179189219"></a>支持配置绝对路径或相对路径：<a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul463512409500"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul463512409500"></a><ul id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul463512409500"><li>绝对路径配置以<span class="uicontrol" id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_uicontrol6799114615013"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_uicontrol6799114615013"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_uicontrol6799114615013"></a>“/”</span>开头，例如：/home/output。</li><li>相对路径配置直接以目录名开始，例如：output。</li></ul>
</div>
</td>
</tr>
<tr id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_row75941833105412"><td class="cellrowborder" valign="top" width="32.42%" headers="mcps1.2.3.1.1 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p65944331549"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p65944331549"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p65944331549"></a>dump_mode</p>
</td>
<td class="cellrowborder" valign="top" width="67.58%" headers="mcps1.2.3.1.2 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p816922501712"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p816922501712"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p816922501712"></a>dump数据模式。</p>
<a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul15173122561720"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul15173122561720"></a><ul id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul15173122561720"><li>input：dump算子的输入数据。</li><li>output：dump算子的输出数据，默认取值output。</li><li>all：dump算子的输入、输出数据。<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p5705113510441"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p5705113510441"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p5705113510441"></a>注意，配置为all时，由于部分算子在执行过程中会修改输入数据，例如集合通信类算子HcomAllGather、HcomAllReduce等，因此系统在进行dump时，会在算子执行前dump算子输入，在算子执行后dump算子输出，这样，针对同一个算子，算子输入、输出的dump数据是分开落盘，会出现多个dump文件，在解析dump文件后，用户可通过文件内容判断是输入还是输出。</p>
</li></ul>
</td>
</tr>
<tr id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_row1125610377458"><td class="cellrowborder" valign="top" width="32.42%" headers="mcps1.2.3.1.1 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p1125614379455"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p1125614379455"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p1125614379455"></a>dump_level</p>
</td>
<td class="cellrowborder" valign="top" width="67.58%" headers="mcps1.2.3.1.2 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p97008103494"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p97008103494"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p97008103494"></a>dump数据级别，取值：</p>
<a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul203554139495"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul203554139495"></a><ul id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul203554139495"><li>op：按算子级别dump数据。</li><li>kernel：按kernel级别dump数据。</li><li>all：默认值，op和kernel级别的数据都dump。</li></ul>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p122561375459"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p122561375459"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p122561375459"></a>默认配置下，dump数据文件会比较多，例如有一些aclnn开头的dump文件，若用户对dump性能有要求或内存资源有限时，则可以将该参数设置为op级别，以便提升dump性能、精简dump数据文件数量。</p>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p9331838144317"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p9331838144317"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p9331838144317"></a><strong id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_b6504347194311"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_b6504347194311"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_b6504347194311"></a>说明</strong>：算子是一个运算逻辑的表示（如加减乘除运算），kernel是运算逻辑真正进行计算处理的实现，需要分配具体的计算设备完成计算。</p>
</td>
</tr>
<tr id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_row1178413619545"><td class="cellrowborder" valign="top" width="32.42%" headers="mcps1.2.3.1.1 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p13784153619543"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p13784153619543"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p13784153619543"></a>dump_op_switch</p>
</td>
<td class="cellrowborder" valign="top" width="67.58%" headers="mcps1.2.3.1.2 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p33481329176"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p33481329176"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p33481329176"></a>单算子调用场景（包括单算子模型执行和单算子API执行）下，是否开启dump数据采集。</p>
<a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul0351932141719"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul0351932141719"></a><ul id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul0351932141719"><li>on：开启。</li><li>off：关闭，默认取值off。</li></ul>
</td>
</tr>
<tr id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_row264416171415"><td class="cellrowborder" valign="top" width="32.42%" headers="mcps1.2.3.1.1 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p126446610146"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p126446610146"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p126446610146"></a>dump_step</p>
</td>
<td class="cellrowborder" valign="top" width="67.58%" headers="mcps1.2.3.1.2 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p374173918174"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p374173918174"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p374173918174"></a>指定采集哪些迭代的dump数据。推理场景无需配置。</p>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p103835171122"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p103835171122"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p103835171122"></a>不配置该参数，默认所有迭代都会产生dump数据，数据量比较大，建议按需指定迭代。</p>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p11384141717121"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p11384141717121"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p11384141717121"></a>多个迭代用“|”分割，例如：0|5|10；也可以用“-”指定迭代范围，例如：0|3-5|10。</p>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p6788192415319"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p6788192415319"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p6788192415319"></a>配置示例：</p>
<a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_screen1890219341124"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_screen1890219341124"></a><pre class="screen" codetype="Json" id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_screen1890219341124">{
	"dump":{
		"dump_list":[     
			...... 
		],  
		"dump_path":"/home/output",
                "dump_mode":"output",
		"dump_op_switch":"off",
                "dump_step": "0|3-5|10"
	}  
}</pre>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p9198731164415"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p9198731164415"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p9198731164415"></a>训练场景下，若通过acl.json中的dump_step参数指定采集哪些迭代的dump数据，又同时在GEInitialize接口中配置了ge.exec.dumpStep参数（该参数也用于指定采集哪些迭代的dump数据），则以最后配置的参数为准。GEInitialize接口的详细介绍请参见<span id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ph19198143110443"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ph19198143110443"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ph19198143110443"></a>《图模式开发指南》</span>。</p>
</td>
</tr>
<tr id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_row73572029103213"><td class="cellrowborder" valign="top" width="32.42%" headers="mcps1.2.3.1.1 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p635742914325"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p635742914325"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p635742914325"></a>dump_data</p>
</td>
<td class="cellrowborder" valign="top" width="67.58%" headers="mcps1.2.3.1.2 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p159491257142410"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p159491257142410"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p159491257142410"></a>算子dump内容类型，取值：</p>
<a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul847333833517"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul847333833517"></a><ul id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul847333833517"><li>tensor: dump算子数据，默认为tensor。</li><li>stats: dump算子统计数据，结果文件为csv格式，文件中包含算子名称、输入/输出的数据类型、最大值、最小值等。</li></ul>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p137601044155810"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p137601044155810"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p137601044155810"></a>通常dump数据量太大并且耗时长，可以先对算子统计数据进行dump，根据统计数据识别可能异常的算子，然后再dump算子数据。</p>
</td>
</tr>
<tr id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_row73341857115016"><td class="cellrowborder" valign="top" width="32.42%" headers="mcps1.2.3.1.1 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p43345577501"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p43345577501"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p43345577501"></a>dump_stats</p>
</td>
<td class="cellrowborder" valign="top" width="67.58%" headers="mcps1.2.3.1.2 "><p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p1233412576506"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p1233412576506"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p1233412576506"></a>仅<span id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ph9656930104713"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ph9656930104713"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ph9656930104713"></a><term id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span>支持该参数，当dump_data=stats时，可通过本参数设置收集统计数据中的哪一类数据，本参数取值如下（若不指定取值，默认采集Max、Min、Avg、Nan、Negative Inf、Positive Inf数据）：</p>
<a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul14482556175313"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul14482556175313"></a><ul id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_ul14482556175313"><li>Max：dump算子统计数据中的最大值。</li><li>Min：dump算子统计数据中的最小值。</li><li>Avg：dump算子统计数据中的平均值。</li><li>Nan：dump算子统计数据中未定义或不可表示的数值，仅针对浮点类型half、bfloat、float。</li><li>Negative Inf：dump算子统计数据中的负无穷值，仅针对浮点类型half、bfloat、float。</li><li>Positive Inf：dump算子统计数据中的正无穷值，仅针对浮点类型half、bfloat、float。</li><li>L2norm：dump算子统计数据的<span>L2Norm值</span>。</li></ul>
<p id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p1980691761410"><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p1980691761410"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_p1980691761410"></a>配置示例：</p>
<a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_screen03491227131415"></a><a name="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_screen03491227131415"></a><pre class="screen" codetype="Json" id="zh-cn_topic_0000001312400361_zh-cn_topic_0000001565875221_screen03491227131415">{
    "dump":{
	"dump_list":[     
		...... 
	],  
        "dump_path":"/home/output",
        "dump_mode":"output",
        "dump_data":"stats",
        "dump_stats":["Max", "Min"]
    }
}</pre>
</td>
</tr>
</tbody>
</table>

## 配置文件示例（异常算子Dump配置）<a name="section106352227214"></a>

通过配置dump\_scene参数值开启异常算子Dump功能，配置文件中的示例内容如下，表示开启轻量化的exception dump：

```
{
    "dump":{
        "dump_path":"output",
        "dump_scene":"aic_err_brief_dump"
    }
}
```

详细配置说明及约束如下：

-   dump\_scene参数支持如下取值：
    -   aic\_err\_brief\_dump：表示轻量化exception dump，用于导出AI Core错误算子的输入&输出、workspace数据。
    -   aic\_err\_norm\_dump：表示普通exception dump，在轻量化exception dump基础上，还会导出Shape、Data Type、Format以及属性信息。
    -   aic\_err\_detail\_dump：在轻量化exception dump基础上，还会导出AI Core的内部存储、寄存器以及调用栈信息。

        配置该选项时，有以下注意事项：

        -   该选项仅支持以下型号，且需配套25.0.RC1或更高版本的驱动才可以使用：

            Ascend 910B

            Ascend 910C

            您可以单击[Link](https://www.hiascend.com/hardware/firmware-drivers/commercial)，在“固件与驱动”页面下载Ascend HDK  25.0.RC1或更高版本的驱动安装包，并参考相应版本的文档进行安装、升级。

        -   若设置aic\_err\_detail\_dump选项，则需在[aclrtSetDevice](aclrtSetDevice.md)接口之前调用本接口，且通过[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口无法实现Dump去初始化。
        -   导出dump文件过程中，会暂停问题算子所在的AI Core，因此可能会影响Device上其它业务进程的正常执行，导出dump文件后，会自行恢复AI Core。
        -   导出dump文件后，会强制退出Host侧用户业务进程，强制退出过程中的报错可不作为AI Core问题分析的输入。
        -   如果多个Host侧用户业务进程指定同一个Device、且都配置了aic\_err\_detail\_dump选项，则先执行的进程按aic\_err\_detail\_dump选项导出dump文件，后执行的进程按照aic\_err\_brief\_dump选项导出dump文件。

    -   lite\_exception：表示轻量化exception dump，为了兼容旧版本，效果等同于aic\_err\_brief\_dump。

-   dump\_path是可选参数，表示导出dump文件的存储路径。

    dump文件存储路径的优先级如下：NPU\_COLLECT\_PATH环境变量 \> ASCEND\_WORK\_PATH环境变量 \> 配置文件中的dump\_path \> 应用程序的当前执行目录

    环境变量的详细描述请参见《环境变量参考》。

-   若需查看导出的dump文件内容，先将dump文件转换为numpy格式文件后，再通过Python查看numpy格式文件，详细转换步骤请参见《》。

    若将dump\_scene参数设置为aic\_err\_detail\_dump时，需使用msDebug工具查看导出的dump文件内容，详细方法请参见《算子开发工具用户指南》。

-   异常算子Dump配置，不能与模型Dump配置或单算子Dump配置同时开启。

## 溢出算子Dump配置示例<a name="section348542922116"></a>

将dump\_debug参数设置为on表示开启溢出算子配置，配置文件中的示例内容如下：

```
{
    "dump":{
        "dump_path":"output",
        "dump_debug":"on"
    }
}
```

详细配置说明及约束如下：

-   不配置dump\_debug或将dump\_debug配置为off表示不开启溢出算子配置。
-   若开启溢出算子配置，则dump\_path必须配置，表示导出dump文件的存储路径。

    获取导出的数据文件后，文件的解析请参见《》。

    dump\_path支持配置绝对路径或相对路径：

    -   绝对路径配置以“/“开头，例如：/home。
    -   相对路径配置直接以目录名开始，例如：output。

-   溢出算子Dump配置，不能与模型Dump配置或单算子Dump配置同时开启，否则会返回报错。
-   仅支持采集AI Core算子的溢出数据。

## 算子Dump Watch模式配置示例<a name="section418234963714"></a>

将dump\_scene参数设置为watcher，开启算子Dump Watch模式，配置文件中的示例内容如下，配置效果为：（1）当执行完A算子、B算子时，会把C算子和D算子的输出Dump出来；（2）当执行完C算子、D算子时，也会把C算子和D算子的输出Dump出来。将（1）、（2）中的C算子、D算子的Dump文件进行比较，用于排查A算子、B算子是否会踩踏C算子、D算子的输出内存。

```
{
    "dump":{
        "dump_list":[
            {
                "layer":["A", "B"],
                "watcher_nodes":["C", "D"]
            }
        ],
        "dump_path":"/home/",
        "dump_mode":"output",
        "dump_scene":"watcher"
    }
}
```

详细配置说明及约束如下：

-   若开启算子Dump Watch模式，则不支持同时开启溢出算子Dump（配置dump\_debug参数）或开启单算子模型Dump（配置dump\_op\_switch参数），否则报错。该模式在单算子API Dump场景下不生效。
-   在dump\_list中，通过layer参数配置可能踩踏其它算子内存的算子名称，通过watcher\_nodes参数配置可能被其它算子踩踏输出内存导致精度有问题的算子名称。
    -   若不指定layer，则模型内所有支持Dump的算子在执行后，都会将watcher\_nodes中配置的算子的输出Dump出来。
    -   layer和watcher\_nodes处配置的算子都必须是静态图、静态子图中的算子，否则不生效。
    -   若layer和watcher\_nodes处配置的算子名称相同，或者layer处配置的是集合通信类算子（算子类型以Hcom开头，例如HcomAllReduce），则只导出watcher\_nodes中所配置算子的dump文件。
    -   对于融合算子，watcher\_nodes处配置的算子名称必须是融合后的算子名称，若配置融合前的算子名称，则不导出dump文件。
    -   dump\_list内暂不支持配置model\_name。

-   开启算子Dump Watch模式，则dump\_path必须配置，表示导出dump文件的存储路径。

    此处收集的dump文件无法通过文本工具直接查看其内容，若需查看dump文件内容，先将dump文件转换为numpy格式文件后，再通过Python查看numpy格式文件，详细转换步骤请参见《》。

    dump\_path支持配置绝对路径或相对路径：

    -   绝对路径配置以“/“开头，例如：/home。
    -   相对路径配置直接以目录名开始，例如：output。

-   通过dump\_mode参数控制导出watcher\_nodes中所配置算子的哪部分数据，当前仅支持配置为output。

## 返回值说明<a name="section15770391345"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section45191612389"></a>

-   只有在调用本接口开启Dump之后加载模型，配置的Dump信息有效。在调用本接口之前已经加载的模型不受影响，除非用户在调用本接口后重新加载该模型。

    例如以下接口调用顺序中，加载的模型1不受影响，配置的Dump信息仅对加载的模型2有效：

    [aclmdlInitDump](aclmdlInitDump.md)接口--\>模型1加载--\>aclmdlSetDump接口--\>模型2加载--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口

-   多次调用本接口对同一个模型配置了Dump信息，系统内处理时会采用覆盖策略。

    例如以下接口调用顺序中，第二次调用本接口配置的Dump信息会覆盖第一次配置的Dump信息：

    [aclmdlInitDump](aclmdlInitDump.md)接口--\>aclmdlSetDump接口--\>aclmdlSetDump接口--\>模型1加载--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口

## 参考资源<a name="section124918821117"></a>

当前还提供了[aclInit](aclInit.md)接口，在初始化阶段，通过\*.json文件传入Dump配置信息，运行应用后获取Dump数据的方式。该种方式，一个进程内，只能调用一次[aclInit](aclInit.md)接口，如果要修改Dump配置信息，需修改\*.json文件中的配置。

