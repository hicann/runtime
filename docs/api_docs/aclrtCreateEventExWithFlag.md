# aclrtCreateEventExWithFlag<a name="ZH-CN_TOPIC_0000001789247130"></a>

## AI处理器支持情况<a name="section59316553412"></a>

<a name="table14931115524110"></a>
<table><thead align="left"><tr id="row1993118556414"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="p29315553419"><a name="p29315553419"></a><a name="p29315553419"></a><span id="ph59311455164119"><a name="ph59311455164119"></a><a name="ph59311455164119"></a>AI处理器类型</span></p>
</th>
<th class="cellrowborder" align="center" valign="top" width="42%" id="mcps1.1.3.1.2"><p id="p59313557417"><a name="p59313557417"></a><a name="p59313557417"></a>是否支持</p>
</th>
</tr>
</thead>
<tbody><tr id="row1693117553411"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p1493195513412"><a name="p1493195513412"></a><a name="p1493195513412"></a><span id="ph1093110555418"><a name="ph1093110555418"></a><a name="ph1093110555418"></a><term id="zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p20931175524111"><a name="p20931175524111"></a><a name="p20931175524111"></a>√</p>
</td>
</tr>
<tr id="row199312559416"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p0931555144119"><a name="p0931555144119"></a><a name="p0931555144119"></a><span id="ph1693115559411"><a name="ph1693115559411"></a><a name="ph1693115559411"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p129321955154117"><a name="p129321955154117"></a><a name="p129321955154117"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section36583473819"></a>

创建带flag的Event，不同flag的Event用于不同的功能。支持创建Event时携带多个flag（按位进行或操作），从而同时使能对应flag的功能。创建Event时，Event资源不受硬件限制。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtCreateEventExWithFlag(aclrtEvent *event, uint32_t flag)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="72%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p039116593511"><a name="p039116593511"></a><a name="p039116593511"></a>event</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p16390135183518"><a name="p16390135183518"></a><a name="p16390135183518"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p4388859358"><a name="p4388859358"></a><a name="p4388859358"></a>Event的指针。</p>
</td>
</tr>
<tr id="row14343105615119"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p1634495613113"><a name="p1634495613113"></a><a name="p1634495613113"></a>flag</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p934425612118"><a name="p934425612118"></a><a name="p934425612118"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p1434417561716"><a name="p1434417561716"></a><a name="p1434417561716"></a>Event指针的flag。</p>
<p id="p3890152611510"><a name="p3890152611510"></a><a name="p3890152611510"></a>当前支持将flag设置为如下宏：</p>
<a name="ul99873501257"></a><a name="ul99873501257"></a><ul id="ul99873501257"><li>ACL_EVENT_TIME_LINE<div class="p" id="p12112939618"><a name="p12112939618"></a><a name="p12112939618"></a>使能该bit表示创建的Event需要记录时间戳信息。注意：使能时间戳功能会影响Event相关接口的性能。<pre class="screen" id="screen1255118112224"><a name="screen1255118112224"></a><a name="screen1255118112224"></a>#define ACL_EVENT_TIME_LINE 0x00000008U</pre>
</div>
</li></ul>
<a name="ul720216139619"></a><a name="ul720216139619"></a><ul id="ul720216139619"><li>ACL_EVENT_SYNC<div class="p" id="p1253914221634"><a name="p1253914221634"></a><a name="p1253914221634"></a>使能该bit表示创建的Event支持多Stream间的同步。<pre class="screen" id="screen15520112476"><a name="screen15520112476"></a><a name="screen15520112476"></a>#define ACL_EVENT_SYNC 0x00000001U</pre>
</div>
</li><li>ACL_EVENT_CAPTURE_STREAM_PROGRESS<p id="p1431816322185"><a name="p1431816322185"></a><a name="p1431816322185"></a>使能该bit表示创建的Event用于跟踪stream的任务执行进度。</p>
<pre class="screen" id="screen16757135814181"><a name="screen16757135814181"></a><a name="screen16757135814181"></a>#define ACL_EVENT_CAPTURE_STREAM_PROGRESS 0x00000002U </pre>
</li><li>ACL_EVENT_IPC<p id="p1431816322185"><a name="p1431816322185"></a><a name="p1431816322185"></a>使能该bit表示创建的Event用于进程间通信。详细说明请参见<a href="aclrtIpcGetEventHandle.md">aclrtIpcGetEventHandle</a>。注意：该flag不支持与其他flag进行位或操作。</p><p id="p1431816332185"><a name="p1531816322185"></a><a name="p1531816322185"></a>本flag创建出来的Event不支持在以下接口中使用：aclrtResetEvent、aclrtQueryEvent、aclrtQueryEventWaitStatus、aclrtEventElapsedTime、aclrtEventGetTimestamp、aclrtGetEventId，否则返回报错。</p>
<pre class="screen" id="screen16757135814181"><a name="screen16757135814181"></a><a name="screen16757135814181"></a>#define ACL_EVENT_IPC 0x00000040U </pre>
</li></ul>
</td>
</tr>
</tbody>
</table>


## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section1876713251814"></a>

-   采用本API创建的Event，不支持在以下接口中使用：[aclrtResetEvent](aclrtResetEvent.md)、[aclrtQueryEvent](aclrtQueryEvent（废弃）.md)、[aclrtQueryEventWaitStatus](aclrtQueryEventWaitStatus.md)，否则返回报错。
-   调用本接口创建Event时，flag为bitmap，支持将flag设置为单个宏、或者对多个宏进行或操作。
    -   若flag参数值**包含**ACL\_EVENT\_SYNC宏，后续调用[aclrtRecordEvent](aclrtRecordEvent.md)接口时，系统内部才会申请Event资源，因此会受Event数量的限制，Event达到上限后，系统内部会等待资源释放。

        不同型号的硬件支持的Event数量不同，如下表所示：

        <a name="table1082317437127"></a>
        <table><thead align="left"><tr id="zh-cn_topic_0000001265081890_row58241343151213"><th class="cellrowborder" valign="top" width="50%" id="mcps1.1.3.1.1"><p id="zh-cn_topic_0000001265081890_p18824154371214"><a name="zh-cn_topic_0000001265081890_p18824154371214"></a><a name="zh-cn_topic_0000001265081890_p18824154371214"></a>型号</p>
        </th>
        <th class="cellrowborder" valign="top" width="50%" id="mcps1.1.3.1.2"><p id="zh-cn_topic_0000001265081890_p58241432128"><a name="zh-cn_topic_0000001265081890_p58241432128"></a><a name="zh-cn_topic_0000001265081890_p58241432128"></a>单个Device支持的Event最大数</p>
        </th>
        </tr>
        </thead>
        <tbody><tr id="zh-cn_topic_0000001265081890_row178241443121213"><td class="cellrowborder" valign="top" width="50%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0000001265081890_p105101653181512"><a name="zh-cn_topic_0000001265081890_p105101653181512"></a><a name="zh-cn_topic_0000001265081890_p105101653181512"></a><span id="zh-cn_topic_0000001265081890_ph481675312157"><a name="zh-cn_topic_0000001265081890_ph481675312157"></a><a name="zh-cn_topic_0000001265081890_ph481675312157"></a><term id="zh-cn_topic_0000001265081890_zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001265081890_zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001265081890_zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
        <p id="zh-cn_topic_0000001265081890_p14476428158"><a name="zh-cn_topic_0000001265081890_p14476428158"></a><a name="zh-cn_topic_0000001265081890_p14476428158"></a><span id="zh-cn_topic_0000001265081890_ph4772124210154"><a name="zh-cn_topic_0000001265081890_ph4772124210154"></a><a name="zh-cn_topic_0000001265081890_ph4772124210154"></a><term id="zh-cn_topic_0000001265081890_zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001265081890_zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001265081890_zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
        </td>
        <td class="cellrowborder" valign="top" width="50%" headers="mcps1.1.3.1.2 "><p id="zh-cn_topic_0000001265081890_p58241343141210"><a name="zh-cn_topic_0000001265081890_p58241343141210"></a><a name="zh-cn_topic_0000001265081890_p58241343141210"></a>65536</p>
        </td>
        </tr>
        </tbody>
        </table>

    -   若flag参数值**不包含**ACL\_EVENT\_SYNC宏，则不支持在[aclrtStreamWaitEvent](aclrtStreamWaitEvent.md)接口中使用本接口创建的Event。

