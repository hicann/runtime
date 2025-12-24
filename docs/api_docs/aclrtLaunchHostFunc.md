# aclrtLaunchHostFunc<a name="ZH-CN_TOPIC_0000002461505701"></a>

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

## 功能说明<a name="section93499471063"></a>

在Stream的任务队列中下发一个Host回调任务，系统内部在执行到该回调任务时，会在Stream上注册的线程（该线程在本接口内部创建并注册）中执行回调函数，并且回调任务默认阻塞本Stream上后续任务的执行。异步接口。

本接口可用于实现异步场景下的callback功能，与另一套实现异步场景下的callback功能接口（[aclrtLaunchCallback](aclrtLaunchCallback.md)、[aclrtSubscribeReport](aclrtSubscribeReport.md)、[aclrtProcessReport](aclrtProcessReport.md)、[aclrtUnSubscribeReport](aclrtUnSubscribeReport.md)）的差别在于：使用aclrtLaunchCallback等接口时，Stream上注册的线程需由用户自行创建并通过[aclrtSubscribeReport](aclrtSubscribeReport.md)接口注册，另外也可以指定回调任务是否阻塞本Stream上后续任务的执行。

对于同一个Stream，两套实现异步场景下的callback功能的接口不能混用，否则可能出现异常。

## 函数原型<a name="section14885205814615"></a>

```
aclError aclrtLaunchHostFunc(aclrtStream stream, aclrtHostFunc fn, void *args)
```

## 参数说明<a name="section31916522610"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="16%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="70%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="16%" headers="mcps1.1.4.1.1 "><p id="p163819129515"><a name="p163819129515"></a><a name="p163819129515"></a>stream</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1838021217514"><a name="p1838021217514"></a><a name="p1838021217514"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p1438010121556"><a name="p1438010121556"></a><a name="p1438010121556"></a>指定执行回调任务的Stream。</p>
</td>
</tr>
<tr id="row164541114112"><td class="cellrowborder" valign="top" width="16%" headers="mcps1.1.4.1.1 "><p id="p193789121855"><a name="p193789121855"></a><a name="p193789121855"></a>fn</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p14377161215519"><a name="p14377161215519"></a><a name="p14377161215519"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p13400843181812"><a name="p13400843181812"></a><a name="p13400843181812"></a>指定要增加的回调函数。</p>
<p id="p68622955911"><a name="p68622955911"></a><a name="p68622955911"></a>回调函数的函数原型为：</p>
<pre class="screen" id="screen78036408397"><a name="screen78036408397"></a><a name="screen78036408397"></a>typedef void (*aclrtHostFunc)(void *args)</pre>
</td>
</tr>
<tr id="row151357285561"><td class="cellrowborder" valign="top" width="16%" headers="mcps1.1.4.1.1 "><p id="p137521219513"><a name="p137521219513"></a><a name="p137521219513"></a>args</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p537416121552"><a name="p537416121552"></a><a name="p537416121552"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p1437217122514"><a name="p1437217122514"></a><a name="p1437217122514"></a>待传递给回调函数的用户数据。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section17970231879"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section159352025016"></a>

回调函数涉及共享资源（例如锁），因此在使用回调函数需慎重，不应该调用资源申请、资源释放、Stream同步、Device同步、任务下发、任务终止等接口，否则可能导致错误或死锁。

