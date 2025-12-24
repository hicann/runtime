# aclrtCreateNotify<a name="ZH-CN_TOPIC_0000002305839221"></a>

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

创建Notify。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtCreateNotify(aclrtNotify *notify, uint64_t flag)
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
<tbody><tr id="row229712714517"><td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.1 "><p id="p79081724131910"><a name="p79081724131910"></a><a name="p79081724131910"></a>notify</p>
</td>
<td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.2 "><p id="p8908162411194"><a name="p8908162411194"></a><a name="p8908162411194"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p321016111346"><a name="p321016111346"></a><a name="p321016111346"></a><span>Notify</span>的指针。</p>
</td>
</tr>
<tr id="row12263201915103"><td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.1 "><p id="p1126410198108"><a name="p1126410198108"></a><a name="p1126410198108"></a>flag</p>
</td>
<td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.2 "><p id="p1226431921019"><a name="p1226431921019"></a><a name="p1226431921019"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p10504122634619"><a name="p10504122634619"></a><a name="p10504122634619"></a>Notify指针的flag。</p>
<p id="p3890152611510"><a name="p3890152611510"></a><a name="p3890152611510"></a>当前支持将flag设置为如下宏：</p>
<a name="ul99873501257"></a><a name="ul99873501257"></a><ul id="ul99873501257"><li>ACL_NOTIFY_DEFAULT<div class="p" id="p12112939618"><a name="p12112939618"></a><a name="p12112939618"></a>使能该bit表示创建的Notify默认在Host上调用。<pre class="screen" id="screen1255118112224"><a name="screen1255118112224"></a><a name="screen1255118112224"></a>#define ACL_NOTIFY_DEFAULT 0x00000000U</pre>
</div>
</li></ul>
<a name="ul720216139619"></a><a name="ul720216139619"></a><ul id="ul720216139619"><li>ACL_NOTIFY_DEVICE_USE_ONLY<div class="p" id="p1253914221634"><a name="p1253914221634"></a><a name="p1253914221634"></a>使能该bit表示创建的Notify仅在Device上调用。<pre class="screen" id="screen15520112476"><a name="screen15520112476"></a><a name="screen15520112476"></a>#define ACL_NOTIFY_DEVICE_USE_ONLY 0x00000001U</pre>
</div>
</li></ul>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section9662195117568"></a>

不同型号的硬件支持的Notify数量不同，如下表所示：

<a name="table1082317437127"></a>
<table><thead align="left"><tr id="row58241343151213"><th class="cellrowborder" valign="top" width="50%" id="mcps1.1.3.1.1"><p id="p18824154371214"><a name="p18824154371214"></a><a name="p18824154371214"></a>型号</p>
</th>
<th class="cellrowborder" valign="top" width="50%" id="mcps1.1.3.1.2"><p id="p58241432128"><a name="p58241432128"></a><a name="p58241432128"></a>单个Device支持的Notify最大数</p>
</th>
</tr>
</thead>
<tbody><tr id="row2228105112314"><td class="cellrowborder" valign="top" width="50%" headers="mcps1.1.3.1.1 "><p id="p105101653181512"><a name="p105101653181512"></a><a name="p105101653181512"></a><span id="ph481675312157"><a name="ph481675312157"></a><a name="ph481675312157"></a><term id="zh-cn_topic_0000001312391781_term1253731311225_1"><a name="zh-cn_topic_0000001312391781_term1253731311225_1"></a><a name="zh-cn_topic_0000001312391781_term1253731311225_1"></a>Ascend 910C</term></span></p>
<p id="p14476428158"><a name="p14476428158"></a><a name="p14476428158"></a><span id="ph4772124210154"><a name="ph4772124210154"></a><a name="ph4772124210154"></a><term id="zh-cn_topic_0000001312391781_term11962195213215_1"><a name="zh-cn_topic_0000001312391781_term11962195213215_1"></a><a name="zh-cn_topic_0000001312391781_term11962195213215_1"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" valign="top" width="50%" headers="mcps1.1.3.1.2 "><p id="p1522875118320"><a name="p1522875118320"></a><a name="p1522875118320"></a>8192</p>
</td>
</tr>
</tbody>
</table>

