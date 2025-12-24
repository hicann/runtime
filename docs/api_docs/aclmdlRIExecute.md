# aclmdlRIExecute<a name="ZH-CN_TOPIC_0000002271062698"></a>

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

执行模型推理。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclmdlRIExecute(aclmdlRI modelRI, int32_t timeout)
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
<tbody><tr id="row229712714517"><td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.1 "><p id="p732720321134"><a name="p732720321134"></a><a name="p732720321134"></a>modelRI</p>
</td>
<td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.2 "><p id="p832616321312"><a name="p832616321312"></a><a name="p832616321312"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p17323153215313"><a name="p17323153215313"></a><a name="p17323153215313"></a>模型运行实例。</p>
<p id="p97621336135213"><a name="p97621336135213"></a><a name="p97621336135213"></a>modelRI支持通过以下方式获取：</p>
<a name="ul1954046205319"></a><a name="ul1954046205319"></a><ul id="ul1954046205319"><li>调用<a href="aclmdlRICaptureBegin.md">aclmdlRICaptureBegin</a>接口捕获Stream上下发的任务后，可通过<a href="aclmdlRICaptureGetInfo.md">aclmdlRICaptureGetInfo</a>接口获取模型运行实例，再传入本接口。</li><li>调用<a href="aclmdlRIBuildBegin.md">aclmdlRIBuildBegin</a>、<a href="aclmdlRIBuildEnd.md">aclmdlRIBuildEnd</a>等接口构建模型运行实例，再传入本接口。</li></ul>
</td>
</tr>
<tr id="row1180074920111"><td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.1 "><p id="p7800134941116"><a name="p7800134941116"></a><a name="p7800134941116"></a>timeout</p>
</td>
<td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.2 "><p id="p1180018490113"><a name="p1180018490113"></a><a name="p1180018490113"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p1958601516255"><a name="p1958601516255"></a><a name="p1958601516255"></a>超时时间。</p>
<p id="p14163161111313"><a name="p14163161111313"></a><a name="p14163161111313"></a>取值说明如下：</p>
<a name="ul589318220132"></a><a name="ul589318220132"></a><ul id="ul589318220132"><li>-1：表示永久等待；</li><li>&gt;0：配置具体的超时时间，单位是毫秒。</li></ul>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

