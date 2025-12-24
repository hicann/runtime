# aclError<a name="ZH-CN_TOPIC_0000001265081614"></a>

```
typedef int aclError;
```

返回码定义规则：

-   规则1：开发人员的环境异常或者代码逻辑错误，可以通过优化环境或代码逻辑的方式解决问题，此时返回码定义为1XXXXX。
-   规则2：资源不足（Stream、内存等）、开发人员编程时使用的接口或参数与当前硬件不匹配，可以通过在编程时合理使用资源的方式解决，此时返回码定义为2XXXXX。
-   规则3：业务功能异常，比如队列满、队列空等，此时返回码定义为3XXXXX。
-   规则4：软硬件内部异常，包括软件内部错误、Device执行失败等，用户无法解决问题，需要将问题反馈给技术支持，此时返回码定义为5XXXXX。您可以获取日志后单击[Link](https://www.hiascend.com/support)联系技术支持。
-   规则5：无法识别的错误，当前都映射为500000。您可以获取日志后单击[Link](https://www.hiascend.com/support)联系技术支持。

**表 1**  acl返回码列表

<a name="table1323834101720"></a>
<table><thead align="left"><tr id="row1032493451715"><th class="cellrowborder" valign="top" width="33.333333333333336%" id="mcps1.2.4.1.1"><p id="p13324143410179"><a name="p13324143410179"></a><a name="p13324143410179"></a>返回码</p>
</th>
<th class="cellrowborder" valign="top" width="33.283328332833285%" id="mcps1.2.4.1.2"><p id="p1324173418171"><a name="p1324173418171"></a><a name="p1324173418171"></a>含义</p>
</th>
<th class="cellrowborder" valign="top" width="33.383338333833386%" id="mcps1.2.4.1.3"><p id="p183241534121716"><a name="p183241534121716"></a><a name="p183241534121716"></a>可能原因及解决方法</p>
</th>
</tr>
</thead>
<tbody><tr id="row973918812519"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p1373918813511"><a name="p1373918813511"></a><a name="p1373918813511"></a>static const int ACL_SUCCESS = 0;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p12739682518"><a name="p12739682518"></a><a name="p12739682518"></a>执行成功。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p1673911815511"><a name="p1673911815511"></a><a name="p1673911815511"></a>-</p>
</td>
</tr>
<tr id="row33247349178"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p992212105318"><a name="p992212105318"></a><a name="p992212105318"></a>static const int ACL_ERROR_NONE = 0;</p>
<p id="p4701540174416"><a name="p4701540174416"></a><a name="p4701540174416"></a><strong id="b14329123894513"><a name="b14329123894513"></a><a name="b14329123894513"></a>须知：此返回码后续版本会废弃，请使用ACL_SUCCESS返回码。</strong></p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p182291015318"><a name="p182291015318"></a><a name="p182291015318"></a>执行成功。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p193241234201710"><a name="p193241234201710"></a><a name="p193241234201710"></a>-</p>
</td>
</tr>
<tr id="row1332443416172"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p792212113539"><a name="p792212113539"></a><a name="p792212113539"></a>static const int ACL_ERROR_INVALID_PARAM = 100000;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p2022181045319"><a name="p2022181045319"></a><a name="p2022181045319"></a>参数校验失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p163241834151718"><a name="p163241834151718"></a><a name="p163241834151718"></a>请检查接口的入参值是否正确。</p>
</td>
</tr>
<tr id="row432417346176"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p17922918534"><a name="p17922918534"></a><a name="p17922918534"></a>static const int ACL_ERROR_UNINITIALIZE = 100001;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p1332493481720"><a name="p1332493481720"></a><a name="p1332493481720"></a>未初始化。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><a name="ul8468615581"></a><a name="ul8468615581"></a><ul id="ul8468615581"><li>请检查是否已调用<a href="aclInit.md">aclInit</a>接口进行初始化，请确保已调用<a href="aclInit.md">aclInit</a>接口，且在其它acl接口之前调用。</li><li>请检查是否已调用对应功能的初始化接口，例如初始化Dump的<a href="aclmdlInitDump.md">aclmdlInitDump</a>接口、初始化Profiling的<a href="aclprofInit.md">aclprofInit</a>接口。</li></ul>
</td>
</tr>
<tr id="row9324113411714"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p19237195313"><a name="p19237195313"></a><a name="p19237195313"></a>static const int ACL_ERROR_REPEAT_INITIALIZE = 100002;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p113249343171"><a name="p113249343171"></a><a name="p113249343171"></a>重复初始化或重复加载。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p13246346171"><a name="p13246346171"></a><a name="p13246346171"></a>请检查是否调用对应的接口重复初始化或重复加载。</p>
</td>
</tr>
<tr id="row132413344178"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p2092391195316"><a name="p2092391195316"></a><a name="p2092391195316"></a>static const int ACL_ERROR_INVALID_FILE = 100003;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p13324153414177"><a name="p13324153414177"></a><a name="p13324153414177"></a>无效的文件。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p15324153418171"><a name="p15324153418171"></a><a name="p15324153418171"></a>请检查文件是否存在、文件是否能被访问等。</p>
</td>
</tr>
<tr id="row161001954121916"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p199231212531"><a name="p199231212531"></a><a name="p199231212531"></a>static const int ACL_ERROR_WRITE_FILE = 100004;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p41001654201910"><a name="p41001654201910"></a><a name="p41001654201910"></a>写文件失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p710014548199"><a name="p710014548199"></a><a name="p710014548199"></a>请检查文件路径是否存在、文件是否有写权限等。</p>
</td>
</tr>
<tr id="row1431195681916"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p792351185310"><a name="p792351185310"></a><a name="p792351185310"></a>static const int ACL_ERROR_INVALID_FILE_SIZE = 100005;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p1943145611912"><a name="p1943145611912"></a><a name="p1943145611912"></a>无效的文件大小。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p12115421513"><a name="p12115421513"></a><a name="p12115421513"></a>请检查文件大小是否符合接口要求。</p>
</td>
</tr>
<tr id="row18211958131910"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p692315135320"><a name="p692315135320"></a><a name="p692315135320"></a>static const int ACL_ERROR_PARSE_FILE = 100006;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p982185881912"><a name="p982185881912"></a><a name="p982185881912"></a>解析文件失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p9821175815195"><a name="p9821175815195"></a><a name="p9821175815195"></a>请检查文件内容是否合法。</p>
</td>
</tr>
<tr id="row1218211113209"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p6923115536"><a name="p6923115536"></a><a name="p6923115536"></a>static const int ACL_ERROR_FILE_MISSING_ATTR = 100007;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p018215117209"><a name="p018215117209"></a><a name="p018215117209"></a>文件缺失参数。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p6182151152015"><a name="p6182151152015"></a><a name="p6182151152015"></a>请检查文件内容是否完整。</p>
</td>
</tr>
<tr id="row145144392019"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p992351125316"><a name="p992351125316"></a><a name="p992351125316"></a>static const int ACL_ERROR_FILE_ATTR_INVALID = 100008;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p15514133172012"><a name="p15514133172012"></a><a name="p15514133172012"></a>文件参数无效。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p75141311209"><a name="p75141311209"></a><a name="p75141311209"></a>请检查文件中参数值是否正确。</p>
</td>
</tr>
<tr id="row154201652209"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p109235195315"><a name="p109235195315"></a><a name="p109235195315"></a>static const int ACL_ERROR_INVALID_DUMP_CONFIG = 100009;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p242013582012"><a name="p242013582012"></a><a name="p242013582012"></a>无效的Dump配置。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p104200517209"><a name="p104200517209"></a><a name="p104200517209"></a>请检查Dump配置是否正确，详细配置请参见<span id="ph87551651806"><a name="ph87551651806"></a><a name="ph87551651806"></a>《》</span>。</p>
</td>
</tr>
<tr id="row6226127182017"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p109231118532"><a name="p109231118532"></a><a name="p109231118532"></a>static const int ACL_ERROR_INVALID_PROFILING_CONFIG = 100010;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p722617742012"><a name="p722617742012"></a><a name="p722617742012"></a>无效的Profiling配置。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p1122614716208"><a name="p1122614716208"></a><a name="p1122614716208"></a>请检查Profiling配置是否正确。</p>
</td>
</tr>
<tr id="row514101219202"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p49231912538"><a name="p49231912538"></a><a name="p49231912538"></a>static const int ACL_ERROR_INVALID_MODEL_ID = 100011;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p81421212201"><a name="p81421212201"></a><a name="p81421212201"></a>无效的模型ID。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p111411292018"><a name="p111411292018"></a><a name="p111411292018"></a>请检查模型ID是否正确、模型是否正确加载。</p>
</td>
</tr>
<tr id="row5240151492015"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p10923618539"><a name="p10923618539"></a><a name="p10923618539"></a>static const int ACL_ERROR_DESERIALIZE_MODEL = 100012;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p5240814122012"><a name="p5240814122012"></a><a name="p5240814122012"></a>反序列化模型失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p1240131410204"><a name="p1240131410204"></a><a name="p1240131410204"></a>模型可能与当前版本不匹配，请重新构建模型。</p>
</td>
</tr>
<tr id="row221431816207"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p4923121165310"><a name="p4923121165310"></a><a name="p4923121165310"></a>static const int ACL_ERROR_PARSE_MODEL = 100013;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p52146185202"><a name="p52146185202"></a><a name="p52146185202"></a>解析模型失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p132148186209"><a name="p132148186209"></a><a name="p132148186209"></a>模型可能与当前版本不匹配，请重新构建模型。</p>
</td>
</tr>
<tr id="row0964181062415"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p2923171145312"><a name="p2923171145312"></a><a name="p2923171145312"></a>static const int ACL_ERROR_READ_MODEL_FAILURE = 100014;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p0964810132412"><a name="p0964810132412"></a><a name="p0964810132412"></a>读取模型失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p14964201062412"><a name="p14964201062412"></a><a name="p14964201062412"></a>请检查模型文件是否存在、模型文件是否能被访问等。</p>
</td>
</tr>
<tr id="row14047135243"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p169234117539"><a name="p169234117539"></a><a name="p169234117539"></a>static const int ACL_ERROR_MODEL_SIZE_INVALID = 100015;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p19404613112417"><a name="p19404613112417"></a><a name="p19404613112417"></a>无效的模型大小。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p15404413122411"><a name="p15404413122411"></a><a name="p15404413122411"></a>模型文件无效，请重新构建模型。</p>
</td>
</tr>
<tr id="row2064581710248"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p1692312115533"><a name="p1692312115533"></a><a name="p1692312115533"></a>static const int ACL_ERROR_MODEL_MISSING_ATTR = 100016;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p166451117132414"><a name="p166451117132414"></a><a name="p166451117132414"></a>模型缺少参数。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p106455179240"><a name="p106455179240"></a><a name="p106455179240"></a>模型可能与当前版本不匹配，请重新构建模型。</p>
</td>
</tr>
<tr id="row1956941932419"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p19235114531"><a name="p19235114531"></a><a name="p19235114531"></a>static const int ACL_ERROR_MODEL_INPUT_NOT_MATCH = 100017;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p2569161972413"><a name="p2569161972413"></a><a name="p2569161972413"></a>模型的输入不匹配。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p195691197248"><a name="p195691197248"></a><a name="p195691197248"></a>请检查模型的输入是否正确。</p>
</td>
</tr>
<tr id="row19661192110240"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p092331135311"><a name="p092331135311"></a><a name="p092331135311"></a>static const int ACL_ERROR_MODEL_OUTPUT_NOT_MATCH = 100018;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p966122113245"><a name="p966122113245"></a><a name="p966122113245"></a>模型的输出不匹配。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p19661142122414"><a name="p19661142122414"></a><a name="p19661142122414"></a>请检查模型的输出是否正确。</p>
</td>
</tr>
<tr id="row1445866102517"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p3923212534"><a name="p3923212534"></a><a name="p3923212534"></a>static const int ACL_ERROR_MODEL_NOT_DYNAMIC = 100019;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p1045812617258"><a name="p1045812617258"></a><a name="p1045812617258"></a>非动态模型。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p19458261259"><a name="p19458261259"></a><a name="p19458261259"></a>请检查当前模型是否支持动态场景，如不支持，请重新构建模型。</p>
</td>
</tr>
<tr id="row35301187258"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p39231419534"><a name="p39231419534"></a><a name="p39231419534"></a>static const int ACL_ERROR_OP_TYPE_NOT_MATCH = 100020;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p145316802519"><a name="p145316802519"></a><a name="p145316802519"></a>单算子类型不匹配。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p7531482258"><a name="p7531482258"></a><a name="p7531482258"></a>请检查算子类型是否正确。</p>
</td>
</tr>
<tr id="row1458791011259"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p11923191145313"><a name="p11923191145313"></a><a name="p11923191145313"></a>static const int ACL_ERROR_OP_INPUT_NOT_MATCH = 100021;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p146779223328"><a name="p146779223328"></a><a name="p146779223328"></a>单算子的输入不匹配。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p145886104255"><a name="p145886104255"></a><a name="p145886104255"></a>请检查算子的输入是否正确。</p>
</td>
</tr>
<tr id="row4626171213259"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p59234125315"><a name="p59234125315"></a><a name="p59234125315"></a>static const int ACL_ERROR_OP_OUTPUT_NOT_MATCH = 100022;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p134152573213"><a name="p134152573213"></a><a name="p134152573213"></a>单算子的输出不匹配。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p196261512192516"><a name="p196261512192516"></a><a name="p196261512192516"></a>请检查算子的输出是否正确。</p>
</td>
</tr>
<tr id="row67967157256"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p1192319155320"><a name="p1192319155320"></a><a name="p1192319155320"></a>static const int ACL_ERROR_OP_ATTR_NOT_MATCH = 100023;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p166102683217"><a name="p166102683217"></a><a name="p166102683217"></a>单算子的属性不匹配。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p1579741552518"><a name="p1579741552518"></a><a name="p1579741552518"></a>请检查算子的属性是否正确。</p>
</td>
</tr>
<tr id="row3743101762512"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p1292311125312"><a name="p1292311125312"></a><a name="p1292311125312"></a>static const int ACL_ERROR_OP_NOT_FOUND = 100024;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p1192881645319"><a name="p1192881645319"></a><a name="p1192881645319"></a>单算子未找到。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p12743171792511"><a name="p12743171792511"></a><a name="p12743171792511"></a>请检查算子类型是否支持。</p>
</td>
</tr>
<tr id="row754919195256"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p7923181145317"><a name="p7923181145317"></a><a name="p7923181145317"></a>static const int ACL_ERROR_OP_LOAD_FAILED = 100025;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p19927111625320"><a name="p19927111625320"></a><a name="p19927111625320"></a>单算子加载失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p51451231157"><a name="p51451231157"></a><a name="p51451231157"></a>模型可能与当前版本不匹配，请重新构建单算子模型。</p>
</td>
</tr>
<tr id="row2950172716264"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p092311125316"><a name="p092311125316"></a><a name="p092311125316"></a>static const int ACL_ERROR_UNSUPPORTED_DATA_TYPE = 100026;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p16927171685311"><a name="p16927171685311"></a><a name="p16927171685311"></a>不支持的数据类型。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p169502027122618"><a name="p169502027122618"></a><a name="p169502027122618"></a>请检查数据类型是否存在或当前是否支持。</p>
</td>
</tr>
<tr id="row316883014262"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p4923812533"><a name="p4923812533"></a><a name="p4923812533"></a>static const int ACL_ERROR_FORMAT_NOT_MATCH = 100027;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p1592691620530"><a name="p1592691620530"></a><a name="p1592691620530"></a>Format不匹配。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p191691630102610"><a name="p191691630102610"></a><a name="p191691630102610"></a>请检查Format是否正确。</p>
</td>
</tr>
<tr id="row33041832102610"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p19231612534"><a name="p19231612534"></a><a name="p19231612534"></a>static const int ACL_ERROR_BIN_SELECTOR_NOT_REGISTERED = 100028;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p49267161534"><a name="p49267161534"></a><a name="p49267161534"></a>使用二进制选择方式编译算子接口时，算子未注册选择器。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p14304133292615"><a name="p14304133292615"></a><a name="p14304133292615"></a>请检查是否调用<span id="ph17684434121320"><a name="ph17684434121320"></a><a name="ph17684434121320"></a>aclopRegisterSelectKernelFunc</span>接口注册算子选择器。</p>
</td>
</tr>
<tr id="row71645341265"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p392331115314"><a name="p392331115314"></a><a name="p392331115314"></a>static const int ACL_ERROR_KERNEL_NOT_FOUND = 100029;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p1092531695317"><a name="p1092531695317"></a><a name="p1092531695317"></a>编译算子时，算子Kernel未注册。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p11164334182615"><a name="p11164334182615"></a><a name="p11164334182615"></a>请检查是否调用<span id="ph3734165110145"><a name="ph3734165110145"></a><a name="ph3734165110145"></a>aclopCreateKernel</span>接口注册算子Kernel。</p>
</td>
</tr>
<tr id="row491963519263"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p1692311175316"><a name="p1692311175316"></a><a name="p1692311175316"></a>static const int ACL_ERROR_BIN_SELECTOR_ALREADY_REGISTERED = 100030;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p39251116115318"><a name="p39251116115318"></a><a name="p39251116115318"></a>使用二进制选择方式编译算子接口时，算子重复注册。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p19199353266"><a name="p19199353266"></a><a name="p19199353266"></a>请检查是否重复调用<span id="ph68595414145"><a name="ph68595414145"></a><a name="ph68595414145"></a>aclopRegisterSelectKernelFunc</span>接口注册算子选择器。</p>
</td>
</tr>
<tr id="row18806837122618"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p14923411536"><a name="p14923411536"></a><a name="p14923411536"></a>static const int ACL_ERROR_KERNEL_ALREADY_REGISTERED = 100031;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p1925121618535"><a name="p1925121618535"></a><a name="p1925121618535"></a>编译算子时，算子Kernel重复注册。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p108065378265"><a name="p108065378265"></a><a name="p108065378265"></a>请检查是否重复调用<span id="ph15763814191514"><a name="ph15763814191514"></a><a name="ph15763814191514"></a>aclopCreateKernel</span>接口注册算子Kernel。</p>
</td>
</tr>
<tr id="row48071839202614"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p6923912534"><a name="p6923912534"></a><a name="p6923912534"></a>static const int ACL_ERROR_INVALID_QUEUE_ID = 100032;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p13924101675319"><a name="p13924101675319"></a><a name="p13924101675319"></a>无效的队列ID。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p1280716396264"><a name="p1280716396264"></a><a name="p1280716396264"></a>请检查队列ID是否正确。</p>
</td>
</tr>
<tr id="row957414812714"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p1192318114532"><a name="p1192318114532"></a><a name="p1192318114532"></a>static const int ACL_ERROR_REPEAT_SUBSCRIBE = 100033;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p7924111611537"><a name="p7924111611537"></a><a name="p7924111611537"></a>重复订阅。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p4995153311181"><a name="p4995153311181"></a><a name="p4995153311181"></a>请检查针对同一个Stream，是否重复调用<a href="aclrtSubscribeReport.md">aclrtSubscribeReport</a>接口。</p>
</td>
</tr>
<tr id="row104291250142710"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p39233105310"><a name="p39233105310"></a><a name="p39233105310"></a>static const int ACL_ERROR_STREAM_NOT_SUBSCRIBE = 100034;</p>
<p id="p7146175715576"><a name="p7146175715576"></a><a name="p7146175715576"></a><strong id="b162591058580"><a name="b162591058580"></a><a name="b162591058580"></a>须知：此返回码后续版本会废弃，请使用<a href="#table1089051917356">ACL_ERROR_RT_STREAM_NO_CB_REG</a>返回码。</strong></p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p1492381665312"><a name="p1492381665312"></a><a name="p1492381665312"></a>Stream未订阅。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p18978597185"><a name="p18978597185"></a><a name="p18978597185"></a>请检查是否已调用<a href="aclrtSubscribeReport.md">aclrtSubscribeReport</a>接口。</p>
</td>
</tr>
<tr id="row240317529277"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p139239117531"><a name="p139239117531"></a><a name="p139239117531"></a>static const int ACL_ERROR_THREAD_NOT_SUBSCRIBE = 100035;</p>
<p id="p60191010582"><a name="p60191010582"></a><a name="p60191010582"></a><strong id="b167813161585"><a name="b167813161585"></a><a name="b167813161585"></a>须知：此返回码后续版本会废弃，请使用<a href="#table1089051917356">ACL_ERROR_RT_THREAD_SUBSCRIBE</a>返回码。</strong></p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p3921116135314"><a name="p3921116135314"></a><a name="p3921116135314"></a>线程未订阅。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p5778122717205"><a name="p5778122717205"></a><a name="p5778122717205"></a>请检查是否已调用<a href="aclrtSubscribeReport.md">aclrtSubscribeReport</a>接口。</p>
</td>
</tr>
<tr id="row19225954162717"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p1924161195311"><a name="p1924161195311"></a><a name="p1924161195311"></a>static const int ACL_ERROR_WAIT_CALLBACK_TIMEOUT = 100036;</p>
<p id="p415522385811"><a name="p415522385811"></a><a name="p415522385811"></a><strong id="b63111831105820"><a name="b63111831105820"></a><a name="b63111831105820"></a>须知：此返回码后续版本会废弃，请使用<a href="#table1089051917356">ACL_ERROR_RT_REPORT_TIMEOUT</a>返回码。</strong></p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p1646151385310"><a name="p1646151385310"></a><a name="p1646151385310"></a>等待callback超时。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p62252547271"><a name="p62252547271"></a><a name="p62252547271"></a>请检查是否已调用<a href="aclrtLaunchCallback.md">aclrtLaunchCallback</a>接口下发callback任务；</p>
<p id="p991117920244"><a name="p991117920244"></a><a name="p991117920244"></a>请检查<a href="aclrtProcessReport.md">aclrtProcessReport</a>接口中超时时间是否合理；</p>
<p id="p18962331243"><a name="p18962331243"></a><a name="p18962331243"></a>请检查callback任务是否已经处理完成，如果已处理完成，但还调用<a href="aclrtProcessReport.md">aclrtProcessReport</a>接口，则需优化代码逻辑。</p>
</td>
</tr>
<tr id="row2025565682719"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p69247118531"><a name="p69247118531"></a><a name="p69247118531"></a>static const int ACL_ERROR_REPEAT_FINALIZE = 100037;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p13464132538"><a name="p13464132538"></a><a name="p13464132538"></a>重复去初始化。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p13255165620275"><a name="p13255165620275"></a><a name="p13255165620275"></a>请检查是否重复调用<a href="aclFinalize.md">aclFinalize</a>接口或重复调用<a href="aclFinalizeReference.md">aclFinalizeReference</a>接口进行去初始化。</p>
</td>
</tr>
<tr id="row89837531465"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p139838538468"><a name="p139838538468"></a><a name="p139838538468"></a>static const int ACL_ERROR_NOT_STATIC_AIPP = 100038;</p>
<p id="p1545417392583"><a name="p1545417392583"></a><a name="p1545417392583"></a><strong id="b12925204613589"><a name="b12925204613589"></a><a name="b12925204613589"></a>须知：此返回码后续版本会废弃，请使用<a href="#table153902340461">ACL_ERROR_GE_AIPP_NOT_EXIST</a>返回码。</strong></p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p1598319532466"><a name="p1598319532466"></a><a name="p1598319532466"></a>静态AIPP配置信息不存在。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p16983195344617"><a name="p16983195344617"></a><a name="p16983195344617"></a>调用<span id="ph14457137101618"><a name="ph14457137101618"></a><a name="ph14457137101618"></a>aclmdlGetFirstAippInfo</span>接口时，请传入正确的index值。</p>
</td>
</tr>
<tr id="row429061325511"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p9614153364517"><a name="p9614153364517"></a><a name="p9614153364517"></a>static const int ACL_ERROR_COMPILING_STUB_MODE = 100039;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p20614183314458"><a name="p20614183314458"></a><a name="p20614183314458"></a>运行应用前配置的动态库路径是编译桩的路径，不是正确的动态库路径。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p1661433384517"><a name="p1661433384517"></a><a name="p1661433384517"></a>请检查动态库路径的配置，确保使用运行模式的动态库。</p>
</td>
</tr>
<tr id="row338910120583"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p141301078580"><a name="p141301078580"></a><a name="p141301078580"></a>static const int ACL_ERROR_GROUP_NOT_SET = 100040;</p>
<p id="p2072065019583"><a name="p2072065019583"></a><a name="p2072065019583"></a><strong id="b3712115919"><a name="b3712115919"></a><a name="b3712115919"></a>须知：此返回码后续版本会废弃，请使用<a href="#table1089051917356">ACL_ERROR_RT_GROUP_NOT_SET</a>返回码。</strong></p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p5390919582"><a name="p5390919582"></a><a name="p5390919582"></a>未设置Group。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p43901717583"><a name="p43901717583"></a><a name="p43901717583"></a>请检查是否已调用<a href="aclrtSetGroup.md">aclrtSetGroup</a>接口。</p>
</td>
</tr>
<tr id="row816517518588"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p13165175155813"><a name="p13165175155813"></a><a name="p13165175155813"></a>static const int  ACL_ERROR_GROUP_NOT_CREATE = 100041;</p>
<p id="p8555156175919"><a name="p8555156175919"></a><a name="p8555156175919"></a><strong id="b04441618155914"><a name="b04441618155914"></a><a name="b04441618155914"></a>须知：此返回码后续版本会废弃，请使用<a href="#table1089051917356">ACL_ERROR_RT_GROUP_NOT_CREATE</a>返回码。</strong></p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p1016515515815"><a name="p1016515515815"></a><a name="p1016515515815"></a>未创建对应的Group。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p1416513575812"><a name="p1416513575812"></a><a name="p1416513575812"></a>请检查调用接口时设置的Group ID是否在支持的范围内，Group ID的取值范围：[0, (Group数量-1)]，用户可调用<a href="aclrtGetGroupCount.md">aclrtGetGroupCount</a>接口获取Group数量。</p>
</td>
</tr>
<tr id="row418351418598"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p4351033106"><a name="p4351033106"></a><a name="p4351033106"></a>static const int ACL_ERROR_PROF_ALREADY_RUN = 100042;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p163533317012"><a name="p163533317012"></a><a name="p163533317012"></a>已存在采集Profiling数据的任务。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><a name="ul16351233202"></a><a name="ul16351233202"></a><ul id="ul16351233202"><li>请检查代码逻辑，“通过调用AscendCL API方式采集Profiling数据”的配置不能与其它方式的Profiling配置并存，只能保留一种，各种方式的Profiling采集配置请参见<span id="ph11234355205112"><a name="ph11234355205112"></a><a name="ph11234355205112"></a>《》</span>。</li><li>请检查是否对同一个Device重复下发了多次Profiling配置。</li></ul>
</td>
</tr>
<tr id="row5499141810599"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p19499718175919"><a name="p19499718175919"></a><a name="p19499718175919"></a>static const int ACL_ERROR_PROF_NOT_RUN = 100043;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p17499151855911"><a name="p17499151855911"></a><a name="p17499151855911"></a>未使用<a href="aclprofInit.md">aclprofInit</a>接口先进行Profiling初始化。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p184991618175912"><a name="p184991618175912"></a><a name="p184991618175912"></a>请检查接口调用顺序。</p>
</td>
</tr>
<tr id="row128721314068"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p787321413614"><a name="p787321413614"></a><a name="p787321413614"></a>static const int ACL_ERROR_DUMP_ALREADY_RUN = 100044;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p13873121418610"><a name="p13873121418610"></a><a name="p13873121418610"></a>已存在获取Dump数据的任务。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p1583123618492"><a name="p1583123618492"></a><a name="p1583123618492"></a>请检查在调用<a href="aclmdlInitDump.md">aclmdlInitDump</a>接口、<a href="aclmdlSetDump.md">aclmdlSetDump</a>接口、<a href="aclmdlFinalizeDump.md">aclmdlFinalizeDump</a>接口配置Dump信息前，是否已调用<a href="aclInit.md">aclInit</a>接口配置Dump信息，如是，请调整代码逻辑，保留一种方式配置Dump信息即可。</p>
</td>
</tr>
<tr id="row114481340561"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p1544916347568"><a name="p1544916347568"></a><a name="p1544916347568"></a>static const int ACL_ERROR_DUMP_NOT_RUN = 100045;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p34494348564"><a name="p34494348564"></a><a name="p34494348564"></a>未使用<a href="aclmdlInitDump.md">aclmdlInitDump</a>接口先进行Dump初始化。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p1129318261571"><a name="p1129318261571"></a><a name="p1129318261571"></a>请检查获取Dump数据的接口调用顺序，参考<a href="aclmdlInitDump.md">aclmdlInitDump</a>接口处的说明。</p>
</td>
</tr>
<tr id="row1052673412455"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p165271234144514"><a name="p165271234144514"></a><a name="p165271234144514"></a>static const int ACL_ERROR_PROF_REPEAT_SUBSCRIBE = 148046;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p1552713424514"><a name="p1552713424514"></a><a name="p1552713424514"></a>重复订阅同一个模型。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p3542115619115"><a name="p3542115619115"></a><a name="p3542115619115"></a>请检查接口调用顺序。</p>
</td>
</tr>
<tr id="row7994536174515"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p1899518369453"><a name="p1899518369453"></a><a name="p1899518369453"></a>static const int ACL_ERROR_PROF_API_CONFLICT = 148047;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p11995183684511"><a name="p11995183684511"></a><a name="p11995183684511"></a>采集性能数据的接口调用冲突。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p14995736144515"><a name="p14995736144515"></a><a name="p14995736144515"></a>两种方式的Profiling性能数据采集接口不能交叉调用，<a href="aclprofInit.md">aclprofInit</a>接口和<a href="aclprofFinalize.md">aclprofFinalize</a>接口之间不能调用<a href="aclprofModelSubscribe.md">aclprofModelSubscribe</a>接口、aclprofGet*接口、<a href="aclprofModelUnSubscribe.md">aclprofModelUnSubscribe</a>接口，<a href="aclprofModelSubscribe.md">aclprofModelSubscribe</a>接口和<a href="aclprofModelUnSubscribe.md">aclprofModelUnSubscribe</a>接口之间不能调用<a href="aclprofInit.md">aclprofInit</a>接口、<a href="aclprofStart.md">aclprofStart</a>接口、<a href="aclprofStop.md">aclprofStop</a>接口、<a href="aclprofFinalize.md">aclprofFinalize</a>。</p>
</td>
</tr>
<tr id="row8507240293"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p125077405911"><a name="p125077405911"></a><a name="p125077405911"></a>static const int ACL_ERROR_INVALID_MAX_OPQUEUE_NUM_CONFIG = 148048;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p850794020915"><a name="p850794020915"></a><a name="p850794020915"></a>无效的算子缓存信息老化配置。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p155089402093"><a name="p155089402093"></a><a name="p155089402093"></a>请检查算子缓存信息老化配置，参考<a href="aclInit.md">aclInit</a>处的配置说明及示例。</p>
</td>
</tr>
<tr id="row1951194613499"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p1938610552454"><a name="p1938610552454"></a><a name="p1938610552454"></a>static const int ACL_ERROR_INVALID_OPP_PATH = 148049;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p83861955124516"><a name="p83861955124516"></a><a name="p83861955124516"></a>没有设置ASCEND_OPP_PATH环境变量，或该环境变量的值设置错误。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p163862551453"><a name="p163862551453"></a><a name="p163862551453"></a>请检查是否设置ASCEND_OPP_PATH环境变量，且该环境变量的值是否为opp软件包的安装路径。</p>
</td>
</tr>
<tr id="row31486502713"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p1014919512275"><a name="p1014919512275"></a><a name="p1014919512275"></a>static const int ACL_ERROR_OP_UNSUPPORTED_DYNAMIC = 148050;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p8149854274"><a name="p8149854274"></a><a name="p8149854274"></a>算子不支持动态Shape。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><a name="ul1506114319322"></a><a name="ul1506114319322"></a><ul id="ul1506114319322"><li>请检查单算子模型文件中该算子的Shape是否为动态，如果是动态的，需要修改为固定Shape。</li><li>请检查编译算子时，aclTensorDesc的Shape是否为动态，如果是动态的，需要按照固定Shape重新创建aclTensorDesc。</li></ul>
</td>
</tr>
<tr id="row5527134392114"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p45276431217"><a name="p45276431217"></a><a name="p45276431217"></a>static const int ACL_ERROR_RELATIVE_RESOURCE_NOT_CLEARED = 148051;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p7528134320217"><a name="p7528134320217"></a><a name="p7528134320217"></a>相关的资源尚未释放。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p16528144315212"><a name="p16528144315212"></a><a name="p16528144315212"></a>在销毁通道描述信息时，如果相关的通道尚未销毁则返回此错误码。请检查与此通道描述信息相关联的通道是否被销毁。</p>
</td>
</tr>
<tr id="row7162154613716"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p1416213461878"><a name="p1416213461878"></a><a name="p1416213461878"></a>static const int ACL_ERROR_UNSUPPORTED_JPEG = 148052;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p1116294613715"><a name="p1116294613715"></a><a name="p1116294613715"></a>JPEGD功能不支持的输入图片编码格式（例如算术编码、渐进式编码等）。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p16162114618719"><a name="p16162114618719"></a><a name="p16162114618719"></a>实现JPEGD图片解码功能时，仅支持Huffman编码，压缩前的原图像色彩空间为YUV，像素的各分量比例为4:4:4或4:2:2或4:2:0或4:0:0或4:4:0，不支持算术编码、不支持渐进JPEG格式、不支持JPEG2000格式。</p>
</td>
</tr>
<tr id="row13753113782112"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p197531537122110"><a name="p197531537122110"></a><a name="p197531537122110"></a>static const int ACL_ERROR_INVALID_BUNDLE_MODEL_ID = 148053;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p52311313414"><a name="p52311313414"></a><a name="p52311313414"></a>无效的模型ID。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p523413163418"><a name="p523413163418"></a><a name="p523413163418"></a>请检查模型ID是否正确、模型是否正确加载。</p>
</td>
</tr>
<tr id="row13714258162712"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p792420105314"><a name="p792420105314"></a><a name="p792420105314"></a>static const int ACL_ERROR_BAD_ALLOC = 200000;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p124561312533"><a name="p124561312533"></a><a name="p124561312533"></a>申请内存失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p1771411585278"><a name="p1771411585278"></a><a name="p1771411585278"></a>请检查硬件环境上的内存剩余情况。</p>
</td>
</tr>
<tr id="row985655113286"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p19924101165317"><a name="p19924101165317"></a><a name="p19924101165317"></a>static const int ACL_ERROR_API_NOT_SUPPORT = 200001;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p44541318532"><a name="p44541318532"></a><a name="p44541318532"></a>接口不支持。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p14856051202811"><a name="p14856051202811"></a><a name="p14856051202811"></a>请检查调用的接口当前是否支持。</p>
</td>
</tr>
<tr id="row1111175410284"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p492411145312"><a name="p492411145312"></a><a name="p492411145312"></a>static const int ACL_ERROR_INVALID_DEVICE = 200002;</p>
<p id="p1585126105911"><a name="p1585126105911"></a><a name="p1585126105911"></a><strong id="b16400135105911"><a name="b16400135105911"></a><a name="b16400135105911"></a>须知：此返回码后续版本会废弃，请使用<a href="#table1089051917356">ACL_ERROR_RT_INVALID_DEVICEID</a>返回码。</strong></p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p19440133538"><a name="p19440133538"></a><a name="p19440133538"></a>无效的Device。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p81115414284"><a name="p81115414284"></a><a name="p81115414284"></a>请检查Device是否存在。</p>
</td>
</tr>
<tr id="row10672145513285"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p592419114534"><a name="p592419114534"></a><a name="p592419114534"></a>static const int ACL_ERROR_MEMORY_ADDRESS_UNALIGNED = 200003;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p1044513145310"><a name="p1044513145310"></a><a name="p1044513145310"></a>内存地址未对齐。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p166721255172815"><a name="p166721255172815"></a><a name="p166721255172815"></a>请检查内存地址是否符合接口要求。</p>
</td>
</tr>
<tr id="row84705813287"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p89240135317"><a name="p89240135317"></a><a name="p89240135317"></a>static const int ACL_ERROR_RESOURCE_NOT_MATCH = 200004;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p194341319531"><a name="p194341319531"></a><a name="p194341319531"></a>资源不匹配。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p144825818284"><a name="p144825818284"></a><a name="p144825818284"></a>请检查调用接口时，是否传入正确的Stream、Context等资源。</p>
</td>
</tr>
<tr id="row672414018291"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p179243165319"><a name="p179243165319"></a><a name="p179243165319"></a>static const int ACL_ERROR_INVALID_RESOURCE_HANDLE = 200005;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p124371319533"><a name="p124371319533"></a><a name="p124371319533"></a>无效的资源句柄。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p16724100102913"><a name="p16724100102913"></a><a name="p16724100102913"></a>请检查调用接口时，传入的Stream、Context等资源是否已被销毁或占用。</p>
</td>
</tr>
<tr id="row195523320528"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p126652010133216"><a name="p126652010133216"></a><a name="p126652010133216"></a>static const int ACL_ERROR_FEATURE_UNSUPPORTED = 200006;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p14665141014324"><a name="p14665141014324"></a><a name="p14665141014324"></a>特性不支持。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p20123713401"><a name="p20123713401"></a><a name="p20123713401"></a><span id="ph310182175019"><a name="ph310182175019"></a><a name="ph310182175019"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row1757213191337"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p1157231919337"><a name="p1157231919337"></a><a name="p1157231919337"></a>static ACL_ERROR_PROF_MODULES_UNSUPPORTED = 200007;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p55721819193319"><a name="p55721819193319"></a><a name="p55721819193319"></a>下发了不支持的Profiling配置。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p35720199335"><a name="p35720199335"></a><a name="p35720199335"></a>请参见<a href="aclprofCreateConfig.md">aclprofCreateConfig</a>中的说明检查Profiling的配置是否正确。</p>
</td>
</tr>
<tr id="row1362013532292"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p12924151115312"><a name="p12924151115312"></a><a name="p12924151115312"></a>static const int ACL_ERROR_STORAGE_OVER_LIMIT = 300000;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p1842213135318"><a name="p1842213135318"></a><a name="p1842213135318"></a>超出存储上限。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p196201853142917"><a name="p196201853142917"></a><a name="p196201853142917"></a>请检查硬件环境上的存储剩余情况。</p>
</td>
</tr>
<tr id="row37201255132917"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p1924314531"><a name="p1924314531"></a><a name="p1924314531"></a>static const int ACL_ERROR_INTERNAL_ERROR = 500000;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p642141345315"><a name="p642141345315"></a><a name="p642141345315"></a>未知内部错误。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p177217555295"><a name="p177217555295"></a><a name="p177217555295"></a><span id="ph310182175019_1"><a name="ph310182175019_1"></a><a name="ph310182175019_1"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row1886115812294"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p1292421185319"><a name="p1292421185319"></a><a name="p1292421185319"></a>static const int ACL_ERROR_FAILURE = 500001;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p16411613135317"><a name="p16411613135317"></a><a name="p16411613135317"></a>内部错误。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p112478438192"><a name="p112478438192"></a><a name="p112478438192"></a><span id="ph310182175019_2"><a name="ph310182175019_2"></a><a name="ph310182175019_2"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row174225003010"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p7924181115318"><a name="p7924181115318"></a><a name="p7924181115318"></a>static const int ACL_ERROR_GE_FAILURE = 500002;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p140191315314"><a name="p140191315314"></a><a name="p140191315314"></a>GE（Graph Engine）模块的错误。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p93001250151913"><a name="p93001250151913"></a><a name="p93001250151913"></a><span id="ph310182175019_3"><a name="ph310182175019_3"></a><a name="ph310182175019_3"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row71033416305"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p109240112532"><a name="p109240112532"></a><a name="p109240112532"></a>static const int ACL_ERROR_RT_FAILURE = 500003;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p144061335314"><a name="p144061335314"></a><a name="p144061335314"></a>RUNTIME模块的错误。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p9451195481914"><a name="p9451195481914"></a><a name="p9451195481914"></a><span id="ph310182175019_4"><a name="ph310182175019_4"></a><a name="ph310182175019_4"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row14390204411303"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p10924515530"><a name="p10924515530"></a><a name="p10924515530"></a>static const int ACL_ERROR_DRV_FAILURE = 500004;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p1139141317536"><a name="p1139141317536"></a><a name="p1139141317536"></a>Driver模块的错误。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p1588745816197"><a name="p1588745816197"></a><a name="p1588745816197"></a><span id="ph310182175019_5"><a name="ph310182175019_5"></a><a name="ph310182175019_5"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row12693145719577"><td class="cellrowborder" valign="top" width="33.333333333333336%" headers="mcps1.2.4.1.1 "><p id="p869317576575"><a name="p869317576575"></a><a name="p869317576575"></a>static const int ACL_ERROR_PROFILING_FAILURE = 500005;</p>
</td>
<td class="cellrowborder" valign="top" width="33.283328332833285%" headers="mcps1.2.4.1.2 "><p id="p96931257105716"><a name="p96931257105716"></a><a name="p96931257105716"></a>Profiling模块的错误。</p>
</td>
<td class="cellrowborder" valign="top" width="33.383338333833386%" headers="mcps1.2.4.1.3 "><p id="p13737333206"><a name="p13737333206"></a><a name="p13737333206"></a><span id="ph310182175019_6"><a name="ph310182175019_6"></a><a name="ph310182175019_6"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
</tbody>
</table>

**表 2**  透传RUNTIME的返回码列表

<a name="table1089051917356"></a>
<table><thead align="left"><tr id="row119502010356"><th class="cellrowborder" valign="top" width="33.34%" id="mcps1.2.4.1.1"><p id="p1319552012357"><a name="p1319552012357"></a><a name="p1319552012357"></a>返回码</p>
</th>
<th class="cellrowborder" valign="top" width="33.28%" id="mcps1.2.4.1.2"><p id="p1519502063513"><a name="p1519502063513"></a><a name="p1519502063513"></a>含义</p>
</th>
<th class="cellrowborder" valign="top" width="33.38%" id="mcps1.2.4.1.3"><p id="p61956209359"><a name="p61956209359"></a><a name="p61956209359"></a>可能原因及解决方法</p>
</th>
</tr>
</thead>
<tbody><tr id="row14196132016359"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p9196152033513"><a name="p9196152033513"></a><a name="p9196152033513"></a>static const int32_t ACL_ERROR_RT_PARAM_INVALID = 107000;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p4196172033512"><a name="p4196172033512"></a><a name="p4196172033512"></a>参数校验失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1196172017355"><a name="p1196172017355"></a><a name="p1196172017355"></a>请检查接口入参是否正确。</p>
</td>
</tr>
<tr id="row619652010353"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1819622011354"><a name="p1819622011354"></a><a name="p1819622011354"></a>static const int32_t ACL_ERROR_RT_INVALID_DEVICEID = 107001;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p9196162063513"><a name="p9196162063513"></a><a name="p9196162063513"></a>无效的Device ID。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p14196420163512"><a name="p14196420163512"></a><a name="p14196420163512"></a>请检查Device ID是否合法。</p>
</td>
</tr>
<tr id="row719612020350"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p11961420103515"><a name="p11961420103515"></a><a name="p11961420103515"></a>static const int32_t ACL_ERROR_RT_CONTEXT_NULL = 107002;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p15196162013359"><a name="p15196162013359"></a><a name="p15196162013359"></a>context为空。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p16196120173517"><a name="p16196120173517"></a><a name="p16196120173517"></a>请检查是否调用<a href="aclrtSetCurrentContext.md">aclrtSetCurrentContext</a>或<a href="aclrtSetDevice.md">aclrtSetDevice</a>。</p>
</td>
</tr>
<tr id="row219613202358"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p3196132093518"><a name="p3196132093518"></a><a name="p3196132093518"></a>static const int32_t ACL_ERROR_RT_STREAM_CONTEXT = 107003;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p51961620113519"><a name="p51961620113519"></a><a name="p51961620113519"></a>stream不在当前context内。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p719612014357"><a name="p719612014357"></a><a name="p719612014357"></a>请检查stream所在的context与当前context是否一致。</p>
</td>
</tr>
<tr id="row2019652073516"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p11967200356"><a name="p11967200356"></a><a name="p11967200356"></a>static const int32_t ACL_ERROR_RT_MODEL_CONTEXT = 107004;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p18196192003516"><a name="p18196192003516"></a><a name="p18196192003516"></a>model不在当前context内。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1319616201350"><a name="p1319616201350"></a><a name="p1319616201350"></a>请检查加载的模型与当前context是否一致。</p>
</td>
</tr>
<tr id="row161962203356"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p619612033513"><a name="p619612033513"></a><a name="p619612033513"></a>static const int32_t ACL_ERROR_RT_STREAM_MODEL = 107005;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p3196420193513"><a name="p3196420193513"></a><a name="p3196420193513"></a>stream不在当前model内。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p11196120203515"><a name="p11196120203515"></a><a name="p11196120203515"></a>请检查stream是否绑定过该模型。</p>
</td>
</tr>
<tr id="row12196172053512"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p141961420183518"><a name="p141961420183518"></a><a name="p141961420183518"></a>static const int32_t ACL_ERROR_RT_EVENT_TIMESTAMP_INVALID = 107006;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p20196122033514"><a name="p20196122033514"></a><a name="p20196122033514"></a>event时间戳无效。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p6197172053512"><a name="p6197172053512"></a><a name="p6197172053512"></a>请检查event是否创建。</p>
</td>
</tr>
<tr id="row15197102015356"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p419710207353"><a name="p419710207353"></a><a name="p419710207353"></a>static const int32_t ACL_ERROR_RT_EVENT_TIMESTAMP_REVERSAL = 107007;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1719722016356"><a name="p1719722016356"></a><a name="p1719722016356"></a>event时间戳反转。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1419712011357"><a name="p1419712011357"></a><a name="p1419712011357"></a>请检查event是否创建。</p>
</td>
</tr>
<tr id="row1197020103512"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p21971720143516"><a name="p21971720143516"></a><a name="p21971720143516"></a>static const int32_t ACL_ERROR_RT_ADDR_UNALIGNED = 107008;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1197172033512"><a name="p1197172033512"></a><a name="p1197172033512"></a>内存地址未对齐。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p7197122003514"><a name="p7197122003514"></a><a name="p7197122003514"></a>请检查所申请的内存地址是否对齐，详细内存申请接口的约束请参见<a href="内存管理.md">内存管理</a>。</p>
</td>
</tr>
<tr id="row20197142083518"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1619711205357"><a name="p1619711205357"></a><a name="p1619711205357"></a>static const int32_t ACL_ERROR_RT_FILE_OPEN = 107009;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p20197112018357"><a name="p20197112018357"></a><a name="p20197112018357"></a>打开文件失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p819732010353"><a name="p819732010353"></a><a name="p819732010353"></a>请检查文件是否存在。</p>
</td>
</tr>
<tr id="row1619742013355"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p19197122083518"><a name="p19197122083518"></a><a name="p19197122083518"></a>static const int32_t ACL_ERROR_RT_FILE_WRITE = 107010;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p4197920173519"><a name="p4197920173519"></a><a name="p4197920173519"></a>写文件失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1019782093512"><a name="p1019782093512"></a><a name="p1019782093512"></a>请检查文件是否存在或者是否具备写权限。</p>
</td>
</tr>
<tr id="row9197220153517"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p141977205358"><a name="p141977205358"></a><a name="p141977205358"></a>static const int32_t ACL_ERROR_RT_STREAM_SUBSCRIBE = 107011;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p61972205356"><a name="p61972205356"></a><a name="p61972205356"></a>stream未订阅或重复订阅。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p11197172010359"><a name="p11197172010359"></a><a name="p11197172010359"></a>请检查当前stream是否订阅或重复订阅。</p>
</td>
</tr>
<tr id="row4197220103515"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p16197520143514"><a name="p16197520143514"></a><a name="p16197520143514"></a>static const int32_t ACL_ERROR_RT_THREAD_SUBSCRIBE = 107012;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1319782013354"><a name="p1319782013354"></a><a name="p1319782013354"></a>线程未订阅或重复订阅。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p15197182014352"><a name="p15197182014352"></a><a name="p15197182014352"></a>请检查当前线程是否订阅或重复订阅。</p>
</td>
</tr>
<tr id="row51971220193513"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p5197192016351"><a name="p5197192016351"></a><a name="p5197192016351"></a>static const int32_t ACL_ERROR_RT_GROUP_NOT_SET = 107013;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p219732013358"><a name="p219732013358"></a><a name="p219732013358"></a>未设置Group。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p51971220183517"><a name="p51971220183517"></a><a name="p51971220183517"></a>请检查是否已调用<a href="aclrtSetGroup.md">aclrtSetGroup</a>接口。</p>
</td>
</tr>
<tr id="row12197182043513"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1419712019359"><a name="p1419712019359"></a><a name="p1419712019359"></a>static const int32_t ACL_ERROR_RT_GROUP_NOT_CREATE = 107014;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p14197112063518"><a name="p14197112063518"></a><a name="p14197112063518"></a>未创建对应的Group。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p91970208351"><a name="p91970208351"></a><a name="p91970208351"></a>请检查调用接口时设置的Group ID是否在支持的范围内，Group ID的取值范围：[0, (Group数量-1)]，用户可调用<a href="aclrtGetGroupCount.md">aclrtGetGroupCount</a>接口获取Group数量。</p>
</td>
</tr>
<tr id="row13198520203518"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p2198820173515"><a name="p2198820173515"></a><a name="p2198820173515"></a>static const int32_t ACL_ERROR_RT_STREAM_NO_CB_REG = 107015;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p151980205358"><a name="p151980205358"></a><a name="p151980205358"></a>该callback对应的stream未注册到线程。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p419816205358"><a name="p419816205358"></a><a name="p419816205358"></a>请检查stream是否已经注册到线程，检查是否调用<a href="aclrtSubscribeReport.md">aclrtSubscribeReport</a>接口。</p>
</td>
</tr>
<tr id="row13198132043519"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p119822023514"><a name="p119822023514"></a><a name="p119822023514"></a>static const int32_t ACL_ERROR_RT_INVALID_MEMORY_TYPE = 107016;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p9198920193511"><a name="p9198920193511"></a><a name="p9198920193511"></a>无效的内存类型。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p9198132053513"><a name="p9198132053513"></a><a name="p9198132053513"></a>请检查内存类型是否合法。</p>
</td>
</tr>
<tr id="row9565142495512"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1556582435510"><a name="p1556582435510"></a><a name="p1556582435510"></a>static const int32_t ACL_ERROR_RT_INVALID_HANDLE = 107017;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p58926521820"><a name="p58926521820"></a><a name="p58926521820"></a>无效的资源句柄。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p9566224165510"><a name="p9566224165510"></a><a name="p9566224165510"></a>检查对应输入和使用的参数是否正确.</p>
</td>
</tr>
<tr id="row1712627105517"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p571202755516"><a name="p571202755516"></a><a name="p571202755516"></a>static const int32_t ACL_ERROR_RT_INVALID_MALLOC_TYPE = 107018;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1061316401415"><a name="p1061316401415"></a><a name="p1061316401415"></a>申请使用的内存类型不正确。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p14712327115515"><a name="p14712327115515"></a><a name="p14712327115515"></a>检查对应输入和使用的内存类型是否正确。</p>
</td>
</tr>
<tr id="row93012519255"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p4301258255"><a name="p4301258255"></a><a name="p4301258255"></a>static const int32_t ACL_ERROR_RT_WAIT_TIMEOUT = 107019;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1830113552514"><a name="p1830113552514"></a><a name="p1830113552514"></a>等待超时。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p430116518258"><a name="p430116518258"></a><a name="p430116518258"></a>请尝试重新执行下发任务的接口。</p>
</td>
</tr>
<tr id="row44221131173911"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1642243163917"><a name="p1642243163917"></a><a name="p1642243163917"></a>static const int32_t ACL_ERROR_RT_TASK_TIMEOUT = 107020;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p94221831193911"><a name="p94221831193911"></a><a name="p94221831193911"></a>执行任务超时。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p8422431113913"><a name="p8422431113913"></a><a name="p8422431113913"></a>请排查业务编排是否合理或者设置合理的超时时间。</p>
</td>
</tr>
<tr id="row61488273251"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p896584582510"><a name="p896584582510"></a><a name="p896584582510"></a>static const int32_t ACL_ERROR_RT_SYSPARAMOPT_NOT_SET = 107021;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p5148112722512"><a name="p5148112722512"></a><a name="p5148112722512"></a>获取当前Context中的系统参数值失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p5148182792514"><a name="p5148182792514"></a><a name="p5148182792514"></a>未设置当前Context中的系统参数值，请参见<a href="aclrtCtxSetSysParamOpt.md">aclrtCtxSetSysParamOpt</a>。</p>
</td>
</tr>
<tr id="row18186330205311"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p8186730195312"><a name="p8186730195312"></a><a name="p8186730195312"></a>static const int32_t ACL_ERROR_RT_DEVICE_TASK_ABORT = 107022;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p14326181675610"><a name="p14326181675610"></a><a name="p14326181675610"></a>Device上的任务丢弃操作与其它操作冲突。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p0186173015315"><a name="p0186173015315"></a><a name="p0186173015315"></a>该错误码是由于调用<a href="aclrtDeviceTaskAbort.md">aclrtDeviceTaskAbort</a>接口停止Device上的任务与其它接口操作冲突，用户需排查代码逻辑，等待aclrtDeviceTaskAbort接口执行完成后，才执行其它操作。</p>
</td>
</tr>
<tr id="row1871263675119"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p5386117125816"><a name="p5386117125816"></a><a name="p5386117125816"></a>static const int32_t ACL_ERROR_RT_STREAM_ABORT = 107023;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p471313365513"><a name="p471313365513"></a><a name="p471313365513"></a>正在清除Stream上的任务。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1713133617515"><a name="p1713133617515"></a><a name="p1713133617515"></a>正在清除指定Stream上的任务，不支持同步等待该Stream上的任务执行。</p>
</td>
</tr>
<tr id="row627833915299"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p14107711183013"><a name="p14107711183013"></a><a name="p14107711183013"></a>static const int32_t ACL_ERROR_RT_CAPTURE_DEPENDENCY = 107024;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p2027913912910"><a name="p2027913912910"></a><a name="p2027913912910"></a>基于捕获方式构建模型运行实例时，event wait任务没有对应的event record任务。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p5279133919297"><a name="p5279133919297"></a><a name="p5279133919297"></a>调用<a href="aclrtRecordEvent.md">aclrtRecordEvent</a>接口增加event record任务。</p>
</td>
</tr>
<tr id="row3480188834"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p022210441135"><a name="p022210441135"></a><a name="p022210441135"></a>static const int32_t  ACL_ERROR_RT_STREAM_UNJOINED = 107025;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p533552717285"><a name="p533552717285"></a><a name="p533552717285"></a>跨流依赖场景下，由于捕获模型包含未合并到原始Stream的其它Stream，导致其它Stream报错。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><a name="ul157079331476"></a><a name="ul157079331476"></a><ul id="ul157079331476"><li>报错的Stream中最后一个任务不是event record任务。在报错Stream的最后插入一个可以合并到原始Stream的event record任务（调用<a href="aclrtRecordEvent.md">aclrtRecordEvent</a>接口）。</li><li>最后一个event record任务没有对应的event wait任务。在非报错的Stream上插入一个event wait任务（调用<a href="aclrtStreamWaitEvent.md">aclrtStreamWaitEvent</a>接口），确保该event wait任务可以使其它Stream合并到原始Stream上。</li></ul>
</td>
</tr>
<tr id="row1413813114316"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1716311377410"><a name="p1716311377410"></a><a name="p1716311377410"></a>static const int32_t  ACL_ERROR_RT_MODEL_CAPTURED = 107026;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1588214374289"><a name="p1588214374289"></a><a name="p1588214374289"></a>模型已经处于捕获状态。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1513815115319"><a name="p1513815115319"></a><a name="p1513815115319"></a>先调用<a href="aclmdlRICaptureEnd.md">aclmdlCaptureEnd</a>接口结束捕获，再执行对应的操作。</p>
</td>
</tr>
<tr id="row1578417131333"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1660938547"><a name="p1660938547"></a><a name="p1660938547"></a>static const int32_t  ACL_ERROR_RT_STREAM_CAPTURED = 107027;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1178418131733"><a name="p1178418131733"></a><a name="p1178418131733"></a>Stream已经处于捕获状态。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p728019352215"><a name="p728019352215"></a><a name="p728019352215"></a>先调用<a href="aclmdlRICaptureEnd.md">aclmdlCaptureEnd</a>接口结束捕获，再执行对应的操作。</p>
</td>
</tr>
<tr id="row136125151845"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1521118401549"><a name="p1521118401549"></a><a name="p1521118401549"></a>static const int32_t  ACL_ERROR_RT_EVENT_CAPTURED = 107028;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p45631627132915"><a name="p45631627132915"></a><a name="p45631627132915"></a>Event已经处于捕获状态。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p11721142313224"><a name="p11721142313224"></a><a name="p11721142313224"></a>先调用<a href="aclmdlRICaptureEnd.md">aclmdlCaptureEnd</a>接口结束捕获，再执行对应的操作。</p>
</td>
</tr>
<tr id="row293914176310"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1576574117415"><a name="p1576574117415"></a><a name="p1576574117415"></a>static const int32_t  ACL_ERROR_RT_STREAM_NOT_CAPTURED = 107029;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p96921245162918"><a name="p96921245162918"></a><a name="p96921245162918"></a>Stream不在捕获状态。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p7939121714315"><a name="p7939121714315"></a><a name="p7939121714315"></a>请检查是否已调用<a href="aclmdlRICaptureBegin.md">aclmdlCaptureBegin</a>开始捕获Stream上下发的任务。</p>
</td>
</tr>
<tr id="row1983317133410"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p94746436412"><a name="p94746436412"></a><a name="p94746436412"></a>static const int32_t  ACL_ERROR_RT_CAPTURE_MODE_NOT_SUPPORT = 107030;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p35261228153011"><a name="p35261228153011"></a><a name="p35261228153011"></a>当前的捕获模式不支持该操作。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p17404193594816"><a name="p17404193594816"></a><a name="p17404193594816"></a>不同捕获模式支持的操作范围不同，请参见<a href="aclmdlRICaptureThreadExchangeMode.md">aclmdlRICaptureThreadExchangeMode</a>接口中的说明，并切换到正确的捕获模式。</p>
</td>
</tr>
<tr id="row141815160315"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p15921217281"><a name="p15921217281"></a><a name="p15921217281"></a>static const int32_t  ACL_ERROR_RT_STREAM_CAPTURE_IMPLICIT = 107031;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p81817166316"><a name="p81817166316"></a><a name="p81817166316"></a>捕获场景下不允许使用默认Stream。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p31811166316"><a name="p31811166316"></a><a name="p31811166316"></a>请尝试使用其他Stream替代默认Stream。</p>
</td>
</tr>
<tr id="row999810422813"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p3273163344319"><a name="p3273163344319"></a><a name="p3273163344319"></a>static const int32_t  ACL_ERROR_STREAM_CAPTURE_CONFLICT = 107032;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p2930152674320"><a name="p2930152674320"></a><a name="p2930152674320"></a>Event与Stream所在的模型运行实例不一致。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1930162610439"><a name="p1930162610439"></a><a name="p1930162610439"></a>请检查同时在调用<a href="aclmdlRICaptureBegin.md">aclmdlRICaptureBegin</a>操作的多个Stream是否通过Event建立关联关系。</p>
</td>
</tr>
<tr id="row1444163122914"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p12556017192413"><a name="p12556017192413"></a><a name="p12556017192413"></a>static const int32_t  ACL_ERROR_STREAM_TASK_GROUP_STATUS = 107033;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1355641719249"><a name="p1355641719249"></a><a name="p1355641719249"></a>任务组状态异常。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p558134615272"><a name="p558134615272"></a><a name="p558134615272"></a>造成该错误的原因可能如下，请排查。</p>
<a name="ul37141299282"></a><a name="ul37141299282"></a><ul id="ul37141299282"><li>调用<a href="aclmdlRICaptureTaskGrpBegin.md">aclmdlRICaptureTaskGrpBegin</a>对同一Stream重复开启任务组记录；</li><li>调用<a href="aclmdlRICaptureTaskUpdateBegin.md">aclmdlRICaptureTaskUpdateBegin</a>对同一任务组同时进行更新；</li><li><a href="aclmdlRICaptureTaskGrpBegin.md">aclmdlRICaptureTaskGrpBegin</a>未与<a href="aclmdlRICaptureTaskGrpEnd.md">aclmdlRICaptureTaskGrpEnd</a>配对使用；</li><li><a href="aclmdlRICaptureTaskUpdateBegin.md">aclmdlRICaptureTaskUpdateBegin</a>未与<a href="aclmdlRICaptureTaskUpdateEnd.md">aclmdlRICaptureTaskUpdateEnd</a>配对使用；</li><li>使用同一Stream同时进行记录和更新任务组操作。</li></ul>
</td>
</tr>
<tr id="row192791616298"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p20674426163812"><a name="p20674426163812"></a><a name="p20674426163812"></a>static const int32_t  ACL_ERROR_STREAM_TASK_GROUP_INTR = 107034;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p467412643817"><a name="p467412643817"></a><a name="p467412643817"></a>任务组记录过程中断。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p48981647174313"><a name="p48981647174313"></a><a name="p48981647174313"></a>该错误的原因是记录任务组时将任务提交到了未开启任务组记录的捕获流上。</p>
<p id="p6675142643814"><a name="p6675142643814"></a><a name="p6675142643814"></a>建议先<a href="aclmdlRICaptureTaskGrpBegin.md">aclmdlRICaptureTaskGrpBegin</a>接口开启了任务组记录，再提交任务。</p>
</td>
</tr>
<tr id="row111981020103512"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p10198820193511"><a name="p10198820193511"></a><a name="p10198820193511"></a>static const int32_t ACL_ERROR_RT_FEATURE_NOT_SUPPORT = 207000;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p2019872093517"><a name="p2019872093517"></a><a name="p2019872093517"></a>特性不支持。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p638511443201"><a name="p638511443201"></a><a name="p638511443201"></a><span id="ph310182175019_7"><a name="ph310182175019_7"></a><a name="ph310182175019_7"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row12198122013512"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1719842033516"><a name="p1719842033516"></a><a name="p1719842033516"></a>static const int32_t ACL_ERROR_RT_MEMORY_ALLOCATION = 207001;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p719892093514"><a name="p719892093514"></a><a name="p719892093514"></a>内存申请失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p8198142010351"><a name="p8198142010351"></a><a name="p8198142010351"></a>请检查硬件环境上的存储剩余情况。</p>
</td>
</tr>
<tr id="row201981920203515"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1719872073513"><a name="p1719872073513"></a><a name="p1719872073513"></a>static const int32_t ACL_ERROR_RT_MEMORY_FREE = 207002;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1619822016352"><a name="p1619822016352"></a><a name="p1619822016352"></a>内存释放失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1338919544205"><a name="p1338919544205"></a><a name="p1338919544205"></a><span id="ph310182175019_8"><a name="ph310182175019_8"></a><a name="ph310182175019_8"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row1995520374544"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p169551237105417"><a name="p169551237105417"></a><a name="p169551237105417"></a>static const int32_t ACL_ERROR_RT_AICORE_OVER_FLOW = 207003;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p149563371549"><a name="p149563371549"></a><a name="p149563371549"></a>AI Core算子运算溢出。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p0956143710540"><a name="p0956143710540"></a><a name="p0956143710540"></a>请检查对应的AI Core算子运算是否有溢出，可以根据dump数据找到对应溢出的算子，再定位具体的算子问题。</p>
</td>
</tr>
<tr id="row82316543131"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p10231154191316"><a name="p10231154191316"></a><a name="p10231154191316"></a>static const int32_t ACL_ERROR_RT_NO_DEVICE = 207004;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p197521447201118"><a name="p197521447201118"></a><a name="p197521447201118"></a>Device不可用。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p13231175481312"><a name="p13231175481312"></a><a name="p13231175481312"></a>请检查Device是否正常运行。</p>
</td>
</tr>
<tr id="row127461657161312"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p974645710130"><a name="p974645710130"></a><a name="p974645710130"></a>static const int32_t ACL_ERROR_RT_RESOURCE_ALLOC_FAIL = 207005;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p15256133361212"><a name="p15256133361212"></a><a name="p15256133361212"></a>资源申请失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p774635711319"><a name="p774635711319"></a><a name="p774635711319"></a>请检查Stream等资源的使用情况，及时释放不用的资源。</p>
</td>
</tr>
<tr id="row3881231188"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p094253618911"><a name="p094253618911"></a><a name="p094253618911"></a>static const int32_t ACL_ERROR_RT_NO_PERMISSION = 207006;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p632715917135"><a name="p632715917135"></a><a name="p632715917135"></a>没有操作权限。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1884912515142"><a name="p1884912515142"></a><a name="p1884912515142"></a>请检查运行应用的用户权限是否正确。</p>
</td>
</tr>
<tr id="row10123140788"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1399118811013"><a name="p1399118811013"></a><a name="p1399118811013"></a>static const int32_t ACL_ERROR_RT_NO_EVENT_RESOURCE = 207007;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p912413010817"><a name="p912413010817"></a><a name="p912413010817"></a>Event资源不足。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p512417016812"><a name="p512417016812"></a><a name="p512417016812"></a>请参考<a href="aclrtCreateEvent.md">aclrtCreateEvent</a>接口处的说明检查Event数量是否符合要求。</p>
</td>
</tr>
<tr id="row05412171016"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p7548210104"><a name="p7548210104"></a><a name="p7548210104"></a>static const int32_t ACL_ERROR_RT_NO_STREAM_RESOURCE = 207008;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p16541625106"><a name="p16541625106"></a><a name="p16541625106"></a>Stream资源不足。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p654172151011"><a name="p654172151011"></a><a name="p654172151011"></a>请参考<a href="aclrtCreateStream.md">aclrtCreateStream</a>接口处的说明检查Stream数量是否符合要求。</p>
</td>
</tr>
<tr id="row61821355106"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p3718753191015"><a name="p3718753191015"></a><a name="p3718753191015"></a>static const int32_t ACL_ERROR_RT_NO_NOTIFY_RESOURCE = 207009;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p36381171188"><a name="p36381171188"></a><a name="p36381171188"></a>系统内部Notify资源不足。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p518235191016"><a name="p518235191016"></a><a name="p518235191016"></a>媒体数据处理的并发任务太多或模型推理时消耗资源太多，建议尝试减少并发任务或卸载部分模型。</p>
</td>
</tr>
<tr id="row106206581493"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1512227151119"><a name="p1512227151119"></a><a name="p1512227151119"></a>static const int32_t ACL_ERROR_RT_NO_MODEL_RESOURCE = 207010;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p12620195811911"><a name="p12620195811911"></a><a name="p12620195811911"></a>模型资源不足。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1462014581699"><a name="p1462014581699"></a><a name="p1462014581699"></a>建议卸载部分模型。</p>
</td>
</tr>
<tr id="row1112402762712"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p712492711279"><a name="p712492711279"></a><a name="p712492711279"></a>static const int32_t ACL_ERROR_RT_NO_CDQ_RESOURCE = 207011;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p312472712712"><a name="p312472712712"></a><a name="p312472712712"></a>Runtime内部资源不足。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p138913642116"><a name="p138913642116"></a><a name="p138913642116"></a><span id="ph310182175019_9"><a name="ph310182175019_9"></a><a name="ph310182175019_9"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row141351922185318"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p234019477537"><a name="p234019477537"></a><a name="p234019477537"></a>static const int32_t ACL_ERROR_RT_OVER_LIMIT  = 207012;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p913582212539"><a name="p913582212539"></a><a name="p913582212539"></a>队列数目超出上限。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p15135182285311"><a name="p15135182285311"></a><a name="p15135182285311"></a>请销毁不需要的队列之后再创建新的队列。</p>
</td>
</tr>
<tr id="row133628247537"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p834114795317"><a name="p834114795317"></a><a name="p834114795317"></a>static const int32_t ACL_ERROR_RT_QUEUE_EMPTY = 207013;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p8363624165319"><a name="p8363624165319"></a><a name="p8363624165319"></a>队列为空。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1363172465310"><a name="p1363172465310"></a><a name="p1363172465310"></a>不能从空队列中获取数据，请先向队列中添加数据，再获取。</p>
</td>
</tr>
<tr id="row534752613537"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p12341847105313"><a name="p12341847105313"></a><a name="p12341847105313"></a>static const int32_t ACL_ERROR_RT_QUEUE_FULL  = 207014;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p17347182625311"><a name="p17347182625311"></a><a name="p17347182625311"></a>队列已满。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p11347226125310"><a name="p11347226125310"></a><a name="p11347226125310"></a>不能向已满的队列中添加数据，请先从队列中获取数据，再添加。</p>
</td>
</tr>
<tr id="row172191212559"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p7220162135511"><a name="p7220162135511"></a><a name="p7220162135511"></a>static const int32_t ACL_ERROR_RT_REPEATED_INIT = 207015;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p0220182185516"><a name="p0220182185516"></a><a name="p0220182185516"></a>队列重复初始化。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1576191175610"><a name="p1576191175610"></a><a name="p1576191175610"></a>建议初始化一次队列即可，不要重复初始化。</p>
</td>
</tr>
<tr id="row617554918015"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p11175549305"><a name="p11175549305"></a><a name="p11175549305"></a>static const int32_t ACL_ERROR_RT_DEVIDE_OOM = 207018;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p317510494013"><a name="p317510494013"></a><a name="p317510494013"></a>Device侧内存耗尽。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p0633172010218"><a name="p0633172010218"></a><a name="p0633172010218"></a>排查Device上的内存使用情况，并根据Device上的内存规格合理规划内存的使用。</p>
</td>
</tr>
<tr id="row113611411382"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p4961112891"><a name="p4961112891"></a><a name="p4961112891"></a>static const int32_t ACL_ERROR_RT_FEATURE_NOT_SUPPORT_UPDATE_OP = 207019;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p15361101882"><a name="p15361101882"></a><a name="p15361101882"></a>当前驱动版本不支持更新该算子。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p2676143081219"><a name="p2676143081219"></a><a name="p2676143081219"></a>请检查驱动版本。</p>
<p id="p722704114106"><a name="p722704114106"></a><a name="p722704114106"></a>您可以单击<a href="https://www.hiascend.com/hardware/firmware-drivers/commercial" target="_blank" rel="noopener noreferrer">Link</a>，在“固件与驱动”页面下载<span id="ph1468615771418"><a name="ph1468615771418"></a><a name="ph1468615771418"></a>Ascend HDK</span> 25.0.RC1或更高版本的驱动安装包，并参考相应版本的文档进行安装、升级。</p>
</td>
</tr>
<tr id="row119872073510"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p3198192063510"><a name="p3198192063510"></a><a name="p3198192063510"></a>static const int32_t ACL_ERROR_RT_INTERNAL_ERROR = 507000;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p4198132003515"><a name="p4198132003515"></a><a name="p4198132003515"></a>runtime模块内部错误。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p114801325192113"><a name="p114801325192113"></a><a name="p114801325192113"></a><span id="ph310182175019_10"><a name="ph310182175019_10"></a><a name="ph310182175019_10"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row181998206356"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p19199102093516"><a name="p19199102093516"></a><a name="p19199102093516"></a>static const int32_t ACL_ERROR_RT_TS_ERROR = 507001;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p11199182015359"><a name="p11199182015359"></a><a name="p11199182015359"></a>Device上的task scheduler模块内部错误。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p3850335162115"><a name="p3850335162115"></a><a name="p3850335162115"></a><span id="ph310182175019_11"><a name="ph310182175019_11"></a><a name="ph310182175019_11"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row7199182033515"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p519972043518"><a name="p519972043518"></a><a name="p519972043518"></a>static const int32_t ACL_ERROR_RT_STREAM_TASK_FULL = 507002;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1519914204358"><a name="p1519914204358"></a><a name="p1519914204358"></a>stream上的task数量满。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p159516424218"><a name="p159516424218"></a><a name="p159516424218"></a><span id="ph310182175019_12"><a name="ph310182175019_12"></a><a name="ph310182175019_12"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row01991320123515"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p519942012354"><a name="p519942012354"></a><a name="p519942012354"></a>static const int32_t ACL_ERROR_RT_STREAM_TASK_EMPTY = 507003;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p20199152063512"><a name="p20199152063512"></a><a name="p20199152063512"></a>stream上的task数量为空。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1624115418216"><a name="p1624115418216"></a><a name="p1624115418216"></a><span id="ph310182175019_13"><a name="ph310182175019_13"></a><a name="ph310182175019_13"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row17199132043511"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p819922018355"><a name="p819922018355"></a><a name="p819922018355"></a>static const int32_t ACL_ERROR_RT_STREAM_NOT_COMPLETE = 507004;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p919942014351"><a name="p919942014351"></a><a name="p919942014351"></a>stream上的task未全部执行完成。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1796017514223"><a name="p1796017514223"></a><a name="p1796017514223"></a><span id="ph310182175019_14"><a name="ph310182175019_14"></a><a name="ph310182175019_14"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row1199152083514"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p10199112023513"><a name="p10199112023513"></a><a name="p10199112023513"></a>static const int32_t ACL_ERROR_RT_END_OF_SEQUENCE = 507005;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p18199152043515"><a name="p18199152043515"></a><a name="p18199152043515"></a>AI CPU上的task执行完成。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p12899131962215"><a name="p12899131962215"></a><a name="p12899131962215"></a><span id="ph310182175019_15"><a name="ph310182175019_15"></a><a name="ph310182175019_15"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row7199220113511"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p181991020173519"><a name="p181991020173519"></a><a name="p181991020173519"></a>static const int32_t ACL_ERROR_RT_EVENT_NOT_COMPLETE = 507006;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p0199620113515"><a name="p0199620113515"></a><a name="p0199620113515"></a>event未完成。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p196391429112215"><a name="p196391429112215"></a><a name="p196391429112215"></a><span id="ph310182175019_16"><a name="ph310182175019_16"></a><a name="ph310182175019_16"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row1719913209351"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p10199182013516"><a name="p10199182013516"></a><a name="p10199182013516"></a>static const int32_t ACL_ERROR_RT_CONTEXT_RELEASE_ERROR = 507007;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1319992093518"><a name="p1319992093518"></a><a name="p1319992093518"></a>context释放失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p18571183718226"><a name="p18571183718226"></a><a name="p18571183718226"></a><span id="ph310182175019_17"><a name="ph310182175019_17"></a><a name="ph310182175019_17"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row71999202355"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p519982012356"><a name="p519982012356"></a><a name="p519982012356"></a>static const int32_t ACL_ERROR_RT_SOC_VERSION = 507008;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1319912063510"><a name="p1319912063510"></a><a name="p1319912063510"></a>获取soc version失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p162374602211"><a name="p162374602211"></a><a name="p162374602211"></a><span id="ph310182175019_18"><a name="ph310182175019_18"></a><a name="ph310182175019_18"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row15199120133512"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1419911209358"><a name="p1419911209358"></a><a name="p1419911209358"></a>static const int32_t ACL_ERROR_RT_TASK_TYPE_NOT_SUPPORT = 507009;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1820032014355"><a name="p1820032014355"></a><a name="p1820032014355"></a>不支持的task类型。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p162325592220"><a name="p162325592220"></a><a name="p162325592220"></a><span id="ph310182175019_19"><a name="ph310182175019_19"></a><a name="ph310182175019_19"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row92001920203511"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p112001220123513"><a name="p112001220123513"></a><a name="p112001220123513"></a>static const int32_t ACL_ERROR_RT_LOST_HEARTBEAT = 507010;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1920072013518"><a name="p1920072013518"></a><a name="p1920072013518"></a>task scheduler丢失心跳。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p128829111237"><a name="p128829111237"></a><a name="p128829111237"></a><span id="ph310182175019_20"><a name="ph310182175019_20"></a><a name="ph310182175019_20"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row720072023516"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p12006204358"><a name="p12006204358"></a><a name="p12006204358"></a>static const int32_t ACL_ERROR_RT_MODEL_EXECUTE = 507011;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p18200520143515"><a name="p18200520143515"></a><a name="p18200520143515"></a>模型执行失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p85721611172316"><a name="p85721611172316"></a><a name="p85721611172316"></a><span id="ph310182175019_21"><a name="ph310182175019_21"></a><a name="ph310182175019_21"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row820062033510"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p19200122017355"><a name="p19200122017355"></a><a name="p19200122017355"></a>static const int32_t ACL_ERROR_RT_REPORT_TIMEOUT = 507012;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p6200132016352"><a name="p6200132016352"></a><a name="p6200132016352"></a>获取task scheduler的消息失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p07251715133311"><a name="p07251715133311"></a><a name="p07251715133311"></a>排查接口的超时时间设置是否过短，适当增长超时时间。如果增长超时时间后，依然有超时报错，再排查日志。</p>
<p id="p54120222235"><a name="p54120222235"></a><a name="p54120222235"></a><span id="ph310182175019_22"><a name="ph310182175019_22"></a><a name="ph310182175019_22"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row10200182015357"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p920032083519"><a name="p920032083519"></a><a name="p920032083519"></a>static const int32_t ACL_ERROR_RT_SYS_DMA = 507013;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p15200220183513"><a name="p15200220183513"></a><a name="p15200220183513"></a>system dma（Direct Memory Access）硬件执行错误。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1045814298233"><a name="p1045814298233"></a><a name="p1045814298233"></a><span id="ph310182175019_23"><a name="ph310182175019_23"></a><a name="ph310182175019_23"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row1420062017353"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1620012018357"><a name="p1620012018357"></a><a name="p1620012018357"></a>static const int32_t ACL_ERROR_RT_AICORE_TIMEOUT = 507014;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1820010202353"><a name="p1820010202353"></a><a name="p1820010202353"></a>AI Core执行超时。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p98431535152313"><a name="p98431535152313"></a><a name="p98431535152313"></a><span id="ph310182175019_24"><a name="ph310182175019_24"></a><a name="ph310182175019_24"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
<p id="p1200162023513"><a name="p1200162023513"></a><a name="p1200162023513"></a>日志的详细介绍，请参见<span id="ph538053154016"><a name="ph538053154016"></a><a name="ph538053154016"></a>《日志参考》</span>。</p>
</td>
</tr>
<tr id="row52001420103518"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p820082073515"><a name="p820082073515"></a><a name="p820082073515"></a>static const int32_t ACL_ERROR_RT_AICORE_EXCEPTION = 507015;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1420062013516"><a name="p1420062013516"></a><a name="p1420062013516"></a>AI Core执行异常。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p20891149202316"><a name="p20891149202316"></a><a name="p20891149202316"></a><span id="ph310182175019_25"><a name="ph310182175019_25"></a><a name="ph310182175019_25"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row1720012019357"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p320042083516"><a name="p320042083516"></a><a name="p320042083516"></a>static const int32_t ACL_ERROR_RT_AICORE_TRAP_EXCEPTION = 507016;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p17200192013518"><a name="p17200192013518"></a><a name="p17200192013518"></a>AI Core trap执行异常。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1611291316244"><a name="p1611291316244"></a><a name="p1611291316244"></a><span id="ph310182175019_26"><a name="ph310182175019_26"></a><a name="ph310182175019_26"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row12003201359"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p5200182093513"><a name="p5200182093513"></a><a name="p5200182093513"></a>static const int32_t ACL_ERROR_RT_AICPU_TIMEOUT = 507017;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p6200202019355"><a name="p6200202019355"></a><a name="p6200202019355"></a>AI CPU执行超时。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p197871220162411"><a name="p197871220162411"></a><a name="p197871220162411"></a><span id="ph310182175019_27"><a name="ph310182175019_27"></a><a name="ph310182175019_27"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row142018207357"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p9201020183513"><a name="p9201020183513"></a><a name="p9201020183513"></a>static const int32_t ACL_ERROR_RT_AICPU_EXCEPTION = 507018;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p8201102013514"><a name="p8201102013514"></a><a name="p8201102013514"></a>AI CPU执行异常。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1611214285243"><a name="p1611214285243"></a><a name="p1611214285243"></a><span id="ph310182175019_28"><a name="ph310182175019_28"></a><a name="ph310182175019_28"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row8201102010359"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1120110200351"><a name="p1120110200351"></a><a name="p1120110200351"></a>static const int32_t ACL_ERROR_RT_AICPU_DATADUMP_RSP_ERR = 507019;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1120118207350"><a name="p1120118207350"></a><a name="p1120118207350"></a>AI CPU执行数据dump后未给task scheduler返回响应。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p4770335132411"><a name="p4770335132411"></a><a name="p4770335132411"></a><span id="ph310182175019_29"><a name="ph310182175019_29"></a><a name="ph310182175019_29"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row0201102083512"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p720122017350"><a name="p720122017350"></a><a name="p720122017350"></a>static const int32_t ACL_ERROR_RT_AICPU_MODEL_RSP_ERR = 507020;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p3201520133513"><a name="p3201520133513"></a><a name="p3201520133513"></a>AI CPU执行模型后未给task scheduler返回响应。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p11713445246"><a name="p11713445246"></a><a name="p11713445246"></a><span id="ph310182175019_30"><a name="ph310182175019_30"></a><a name="ph310182175019_30"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row420152033518"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p10201102015354"><a name="p10201102015354"></a><a name="p10201102015354"></a>static const int32_t ACL_ERROR_RT_PROFILING_ERROR = 507021;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p5201152053515"><a name="p5201152053515"></a><a name="p5201152053515"></a>profiling功能执行异常。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p722515014241"><a name="p722515014241"></a><a name="p722515014241"></a><span id="ph310182175019_31"><a name="ph310182175019_31"></a><a name="ph310182175019_31"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row7201720133513"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p4201132063520"><a name="p4201132063520"></a><a name="p4201132063520"></a>static const int32_t ACL_ERROR_RT_IPC_ERROR = 507022;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p11201132015358"><a name="p11201132015358"></a><a name="p11201132015358"></a>进程间通信异常。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p2393115812249"><a name="p2393115812249"></a><a name="p2393115812249"></a><span id="ph310182175019_32"><a name="ph310182175019_32"></a><a name="ph310182175019_32"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row620113201356"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p2201152019358"><a name="p2201152019358"></a><a name="p2201152019358"></a>static const int32_t ACL_ERROR_RT_MODEL_ABORT_NORMAL = 507023;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1720112033514"><a name="p1720112033514"></a><a name="p1720112033514"></a>模型退出。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p16359196112520"><a name="p16359196112520"></a><a name="p16359196112520"></a><span id="ph310182175019_33"><a name="ph310182175019_33"></a><a name="ph310182175019_33"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row8201420163515"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p6201172093519"><a name="p6201172093519"></a><a name="p6201172093519"></a>static const int32_t ACL_ERROR_RT_KERNEL_UNREGISTERING = 507024;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1320182017359"><a name="p1320182017359"></a><a name="p1320182017359"></a>算子正在去注册。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p12243101432519"><a name="p12243101432519"></a><a name="p12243101432519"></a><span id="ph310182175019_34"><a name="ph310182175019_34"></a><a name="ph310182175019_34"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row18201102014355"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p4201120133519"><a name="p4201120133519"></a><a name="p4201120133519"></a>static const int32_t ACL_ERROR_RT_RINGBUFFER_NOT_INIT = 507025;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p3201720163510"><a name="p3201720163510"></a><a name="p3201720163510"></a>ringbuffer（环形缓冲区）功能未初始化。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p572992114251"><a name="p572992114251"></a><a name="p572992114251"></a><span id="ph310182175019_35"><a name="ph310182175019_35"></a><a name="ph310182175019_35"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row2020162011351"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p15202132017357"><a name="p15202132017357"></a><a name="p15202132017357"></a>static const int32_t ACL_ERROR_RT_RINGBUFFER_NO_DATA = 507026;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p16202920143514"><a name="p16202920143514"></a><a name="p16202920143514"></a>ringbuffer（环形缓冲区）没有数据。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p57575285254"><a name="p57575285254"></a><a name="p57575285254"></a><span id="ph310182175019_36"><a name="ph310182175019_36"></a><a name="ph310182175019_36"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row6202152073513"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p120292015354"><a name="p120292015354"></a><a name="p120292015354"></a>static const int32_t ACL_ERROR_RT_KERNEL_LOOKUP = 507027;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p10202112053518"><a name="p10202112053518"></a><a name="p10202112053518"></a>RUNTIME内部的kernel未注册。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p824963802511"><a name="p824963802511"></a><a name="p824963802511"></a><span id="ph310182175019_37"><a name="ph310182175019_37"></a><a name="ph310182175019_37"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row142021220173517"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p9202132053514"><a name="p9202132053514"></a><a name="p9202132053514"></a>static const int32_t ACL_ERROR_RT_KERNEL_DUPLICATE = 507028;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p192021320133514"><a name="p192021320133514"></a><a name="p192021320133514"></a>重复注册RUNTIME内部的kernel。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p34172509253"><a name="p34172509253"></a><a name="p34172509253"></a><span id="ph310182175019_38"><a name="ph310182175019_38"></a><a name="ph310182175019_38"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row14202182013359"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1520219200357"><a name="p1520219200357"></a><a name="p1520219200357"></a>static const int32_t ACL_ERROR_RT_DEBUG_REGISTER_FAIL = 507029;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p820219200358"><a name="p820219200358"></a><a name="p820219200358"></a>debug功能注册失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p99458132518"><a name="p99458132518"></a><a name="p99458132518"></a><span id="ph310182175019_39"><a name="ph310182175019_39"></a><a name="ph310182175019_39"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row1420216203352"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p52021320193520"><a name="p52021320193520"></a><a name="p52021320193520"></a>static const int32_t ACL_ERROR_RT_DEBUG_UNREGISTER_FAIL = 507030;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p13202520193513"><a name="p13202520193513"></a><a name="p13202520193513"></a>debug功能去注册失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p65550819264"><a name="p65550819264"></a><a name="p65550819264"></a><span id="ph310182175019_40"><a name="ph310182175019_40"></a><a name="ph310182175019_40"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row11202172012358"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1920272053510"><a name="p1920272053510"></a><a name="p1920272053510"></a>static const int32_t ACL_ERROR_RT_LABEL_CONTEXT = 507031;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p420222063514"><a name="p420222063514"></a><a name="p420222063514"></a>标签不在当前context内。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1836131516265"><a name="p1836131516265"></a><a name="p1836131516265"></a><span id="ph310182175019_41"><a name="ph310182175019_41"></a><a name="ph310182175019_41"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row82028208356"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p19202720123519"><a name="p19202720123519"></a><a name="p19202720123519"></a>static const int32_t ACL_ERROR_RT_PROGRAM_USE_OUT = 507032;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1202142015357"><a name="p1202142015357"></a><a name="p1202142015357"></a>注册的program数量超过限制。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p13546322132611"><a name="p13546322132611"></a><a name="p13546322132611"></a><span id="ph310182175019_42"><a name="ph310182175019_42"></a><a name="ph310182175019_42"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row12202122017354"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p3202152013513"><a name="p3202152013513"></a><a name="p3202152013513"></a>static const int32_t ACL_ERROR_RT_DEV_SETUP_ERROR = 507033;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p112021820113518"><a name="p112021820113518"></a><a name="p112021820113518"></a>Device启动失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1689733017262"><a name="p1689733017262"></a><a name="p1689733017262"></a><span id="ph310182175019_43"><a name="ph310182175019_43"></a><a name="ph310182175019_43"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row16129184094715"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p8739124184812"><a name="p8739124184812"></a><a name="p8739124184812"></a>static const int32_t ACL_ERROR_RT_VECTOR_CORE_TIMEOUT        = 507034;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p167162456483"><a name="p167162456483"></a><a name="p167162456483"></a>vector core执行超时。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p128541739122612"><a name="p128541739122612"></a><a name="p128541739122612"></a><span id="ph310182175019_44"><a name="ph310182175019_44"></a><a name="ph310182175019_44"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row898543194717"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p398194317472"><a name="p398194317472"></a><a name="p398194317472"></a>static const int32_t ACL_ERROR_RT_VECTOR_CORE_EXCEPTION      = 507035;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p671620459482"><a name="p671620459482"></a><a name="p671620459482"></a>vector core执行异常。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p17112104818268"><a name="p17112104818268"></a><a name="p17112104818268"></a><span id="ph310182175019_45"><a name="ph310182175019_45"></a><a name="ph310182175019_45"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row885212459473"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p14852144574716"><a name="p14852144574716"></a><a name="p14852144574716"></a>static const int32_t ACL_ERROR_RT_VECTOR_CORE_TRAP_EXCEPTION = 507036;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p771711459486"><a name="p771711459486"></a><a name="p771711459486"></a>vector  core trap执行异常。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p637875582615"><a name="p637875582615"></a><a name="p637875582615"></a><span id="ph310182175019_46"><a name="ph310182175019_46"></a><a name="ph310182175019_46"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row112354972917"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p912314919299"><a name="p912314919299"></a><a name="p912314919299"></a>static const int32_t ACL_ERROR_RT_CDQ_BATCH_ABNORMAL = 507037;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p112384932916"><a name="p112384932916"></a><a name="p112384932916"></a>Runtime内部资源申请异常。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p12481617270"><a name="p12481617270"></a><a name="p12481617270"></a><span id="ph310182175019_47"><a name="ph310182175019_47"></a><a name="ph310182175019_47"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row192421541193211"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p3280649193212"><a name="p3280649193212"></a><a name="p3280649193212"></a>static const int32_t ACL_ERROR_RT_DIE_MODE_CHANGE_ERROR = 507038;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p824224114328"><a name="p824224114328"></a><a name="p824224114328"></a>die模式修改异常，不能修改die模式。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p15654111202713"><a name="p15654111202713"></a><a name="p15654111202713"></a><span id="ph310182175019_48"><a name="ph310182175019_48"></a><a name="ph310182175019_48"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row4645643153219"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p2280144953215"><a name="p2280144953215"></a><a name="p2280144953215"></a>static const int32_t ACL_ERROR_RT_DIE_SET_ERROR = 507039;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1645114353216"><a name="p1645114353216"></a><a name="p1645114353216"></a>单die模式不能指定die。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1634219192716"><a name="p1634219192716"></a><a name="p1634219192716"></a><span id="ph310182175019_49"><a name="ph310182175019_49"></a><a name="ph310182175019_49"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row859574711323"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p42801249153212"><a name="p42801249153212"></a><a name="p42801249153212"></a>static const int32_t ACL_ERROR_RT_INVALID_DIEID = 507040;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1959510472324"><a name="p1959510472324"></a><a name="p1959510472324"></a>指定die id错误。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1832810268279"><a name="p1832810268279"></a><a name="p1832810268279"></a><span id="ph310182175019_50"><a name="ph310182175019_50"></a><a name="ph310182175019_50"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row77703454329"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p62801849163212"><a name="p62801849163212"></a><a name="p62801849163212"></a>static const int32_t ACL_ERROR_RT_DIE_MODE_NOT_SET = 507041;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p2062241415354"><a name="p2062241415354"></a><a name="p2062241415354"></a>die模式没有设置。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p2210133311275"><a name="p2210133311275"></a><a name="p2210133311275"></a><span id="ph310182175019_51"><a name="ph310182175019_51"></a><a name="ph310182175019_51"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row183971813184016"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1397191374011"><a name="p1397191374011"></a><a name="p1397191374011"></a>static const int32_t ACL_ERROR_RT_AICORE_TRAP_READ_OVERFLOW = 507042;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p15397713154013"><a name="p15397713154013"></a><a name="p15397713154013"></a>AI Core trap读越界异常。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p17138941132720"><a name="p17138941132720"></a><a name="p17138941132720"></a><span id="ph310182175019_52"><a name="ph310182175019_52"></a><a name="ph310182175019_52"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row77361441164215"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p67361541114212"><a name="p67361541114212"></a><a name="p67361541114212"></a>static const int32_t ACL_ERROR_RT_AICORE_TRAP_WRITE_OVERFLOW = 507043;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p137361141124216"><a name="p137361141124216"></a><a name="p137361141124216"></a>AI Core trap写越界异常。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p529834952717"><a name="p529834952717"></a><a name="p529834952717"></a><span id="ph310182175019_53"><a name="ph310182175019_53"></a><a name="ph310182175019_53"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row198428316433"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1284217315436"><a name="p1284217315436"></a><a name="p1284217315436"></a>static const int32_t ACL_ERROR_RT_VECTOR_CORE_TRAP_READ_OVERFLOW  = 507044;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p12842163144316"><a name="p12842163144316"></a><a name="p12842163144316"></a>Vector Core trap读越界异常。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p636865722712"><a name="p636865722712"></a><a name="p636865722712"></a><span id="ph310182175019_54"><a name="ph310182175019_54"></a><a name="ph310182175019_54"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row1485219489434"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p185218487434"><a name="p185218487434"></a><a name="p185218487434"></a>static const int32_t ACL_ERROR_RT_VECTOR_CORE_TRAP_WRITE_OVERFLOW = 507045;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p885234824310"><a name="p885234824310"></a><a name="p885234824310"></a>Vector Core trap写越界异常。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p113441367283"><a name="p113441367283"></a><a name="p113441367283"></a><span id="ph310182175019_55"><a name="ph310182175019_55"></a><a name="ph310182175019_55"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row1533371115715"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p03333113576"><a name="p03333113576"></a><a name="p03333113576"></a>static const int32_t ACL_ERROR_RT_STREAM_SYNC_TIMEOUT = 507046;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p53332111571"><a name="p53332111571"></a><a name="p53332111571"></a>在指定的超时等待事件中，指定的stream中所有任务还没有执行完成。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p176791520257"><a name="p176791520257"></a><a name="p176791520257"></a><span id="ph310182175019_56"><a name="ph310182175019_56"></a><a name="ph310182175019_56"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row173271734575"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1832819318574"><a name="p1832819318574"></a><a name="p1832819318574"></a>static const int32_t ACL_ERROR_RT_EVENT_SYNC_TIMEOUT = 507047;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p532815385718"><a name="p532815385718"></a><a name="p532815385718"></a>在指定的Event同步等待中，超过指定时间，该Event还有没有执行完。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1768017510255"><a name="p1768017510255"></a><a name="p1768017510255"></a><span id="ph310182175019_57"><a name="ph310182175019_57"></a><a name="ph310182175019_57"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row63791412135715"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p10379141214577"><a name="p10379141214577"></a><a name="p10379141214577"></a>static const int32_t ACL_ERROR_RT_FFTS_PLUS_TIMEOUT = 507048;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p9379181212576"><a name="p9379181212576"></a><a name="p9379181212576"></a>内部任务执行超时。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1340763432313"><a name="p1340763432313"></a><a name="p1340763432313"></a><span id="ph310182175019_58"><a name="ph310182175019_58"></a><a name="ph310182175019_58"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row14889192717574"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p13889152765714"><a name="p13889152765714"></a><a name="p13889152765714"></a>static const int32_t ACL_ERROR_RT_FFTS_PLUS_EXCEPTION = 507049;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p1588932713573"><a name="p1588932713573"></a><a name="p1588932713573"></a>内部任务执行异常。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p9408334122314"><a name="p9408334122314"></a><a name="p9408334122314"></a><span id="ph310182175019_59"><a name="ph310182175019_59"></a><a name="ph310182175019_59"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row5412716175717"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p74121616165711"><a name="p74121616165711"></a><a name="p74121616165711"></a>static const int32_t ACL_ERROR_RT_FFTS_PLUS_TRAP_EXCEPTION = 507050;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p13413101618575"><a name="p13413101618575"></a><a name="p13413101618575"></a>内部任务trap异常。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p840915340239"><a name="p840915340239"></a><a name="p840915340239"></a><span id="ph310182175019_60"><a name="ph310182175019_60"></a><a name="ph310182175019_60"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row1674617521259"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1218718581353"><a name="p1218718581353"></a><a name="p1218718581353"></a>static const int32_t ACL_ERROR_RT_SEND_MSG = 507051;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p218716581457"><a name="p218716581457"></a><a name="p218716581457"></a>数据入队过程中消息发送失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p518717581256"><a name="p518717581256"></a><a name="p518717581256"></a><span id="ph310182175019_61"><a name="ph310182175019_61"></a><a name="ph310182175019_61"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row1622812121248"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1715113179413"><a name="p1715113179413"></a><a name="p1715113179413"></a>static const int32_t ACL_ERROR_RT_COPY_DATA = 507052;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p122815123416"><a name="p122815123416"></a><a name="p122815123416"></a>数据入队过程中内存拷贝失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p5184134450"><a name="p5184134450"></a><a name="p5184134450"></a><span id="ph310182175019_62"><a name="ph310182175019_62"></a><a name="ph310182175019_62"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row1858382785012"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p174781935145012"><a name="p174781935145012"></a><a name="p174781935145012"></a>static const int32_t ACL_ERROR_RT_DEVICE_MEM_ERROR = 507053;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p11312162716514"><a name="p11312162716514"></a><a name="p11312162716514"></a><span>出现内存UCE（uncorrect error，指系统硬件不能直接处理恢复内存错误）</span><span>的错误虚拟地址</span>。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p089743619"><a name="p089743619"></a><a name="p089743619"></a><span>请参见</span><a href="aclrtGetMemUceInfo.md">aclrtGetMemUceInfo</a><span>接口中的说明获取并修复内存UCE</span><span>的错误虚拟地址</span>。</p>
</td>
</tr>
<tr id="row158551353162811"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p376915120202"><a name="p376915120202"></a><a name="p376915120202"></a>static const int32_t ACL_ERROR_RT_HBM_MULTI_BIT_ECC_ERROR = 507054;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p94631018191710"><a name="p94631018191710"></a><a name="p94631018191710"></a>HBM比特ECC故障。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p712419346302"><a name="p712419346302"></a><a name="p712419346302"></a><span id="ph310182175019_63"><a name="ph310182175019_63"></a><a name="ph310182175019_63"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row165422714152"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p85414277152"><a name="p85414277152"></a><a name="p85414277152"></a>static const int32_t ACL_ERROR_RT_SUSPECT_DEVICE_MEM_ERROR = 507055;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p145412716153"><a name="p145412716153"></a><a name="p145412716153"></a>多进程、多Device场景下，可能出现内存UCE错误。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p16541627191511"><a name="p16541627191511"></a><a name="p16541627191511"></a>由于当前Device访问的对端Device内存发生故障，用户需排查对端Device进程的错误信息。</p>
</td>
</tr>
<tr id="row85141910131617"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p226651518164"><a name="p226651518164"></a><a name="p226651518164"></a>static const int32_t ACL_ERROR_RT_LINK_ERROR = 507056;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p851431021616"><a name="p851431021616"></a><a name="p851431021616"></a>多Device场景下，两个Device之间的通信断链。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p10514111014169"><a name="p10514111014169"></a><a name="p10514111014169"></a>建议重试，若依然报错，则需检查两个Device之间的通信链路。</p>
</td>
</tr>
<tr id="row14166203521618"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p73711540181618"><a name="p73711540181618"></a><a name="p73711540181618"></a>static const int32_t ACL_ERROR_RT_SUSPECT_REMOTE_ERROR = 507057;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p15122422218"><a name="p15122422218"></a><a name="p15122422218"></a>多进程、多Device场景下，对端Device内存可能出现故障，或者当前Device内存访问越界。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p17122132102112"><a name="p17122132102112"></a><a name="p17122132102112"></a>用户需排查对端Device进程的错误信息或当前Device的内存访问情况。</p>
</td>
</tr>
<tr id="row1920272014354"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p120242010353"><a name="p120242010353"></a><a name="p120242010353"></a>static const int32_t ACL_ERROR_RT_DRV_INTERNAL_ERROR = 507899;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p72031206351"><a name="p72031206351"></a><a name="p72031206351"></a>Driver模块内部错误。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p079871352818"><a name="p079871352818"></a><a name="p079871352818"></a><span id="ph310182175019_64"><a name="ph310182175019_64"></a><a name="ph310182175019_64"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row112112812387"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p610810733715"><a name="p610810733715"></a><a name="p610810733715"></a>static const int32_t ACL_ERROR_RT_AICPU_INTERNAL_ERROR = 507900;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p0108177143718"><a name="p0108177143718"></a><a name="p0108177143718"></a>AI CPU模块内部错误。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p1379617218283"><a name="p1379617218283"></a><a name="p1379617218283"></a><span id="ph310182175019_65"><a name="ph310182175019_65"></a><a name="ph310182175019_65"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row1739817321590"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p1639883295920"><a name="p1639883295920"></a><a name="p1639883295920"></a>static const int32_t ACL_ERROR_RT_SOCKET_CLOSE = 507901;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p44254819915"><a name="p44254819915"></a><a name="p44254819915"></a>内部HDC（Host Device Communication）会话链接断开。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p106261289287"><a name="p106261289287"></a><a name="p106261289287"></a><span id="ph310182175019_66"><a name="ph310182175019_66"></a><a name="ph310182175019_66"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row145691824161914"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p46241158161913"><a name="p46241158161913"></a><a name="p46241158161913"></a>static const int32_t ACL_ERROR_RT_AICPU_INFO_LOAD_RSP_ERR = 507902;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p8569162413198"><a name="p8569162413198"></a><a name="p8569162413198"></a>AI CPU调度处理失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p158524267202"><a name="p158524267202"></a><a name="p158524267202"></a><span id="ph310182175019_67"><a name="ph310182175019_67"></a><a name="ph310182175019_67"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row754414442072"><td class="cellrowborder" valign="top" width="33.34%" headers="mcps1.2.4.1.1 "><p id="p2720650778"><a name="p2720650778"></a><a name="p2720650778"></a>static const int32_t ACL_ERROR_RT_STREAM_CAPTURE_INVALIDATED = 507903;</p>
</td>
<td class="cellrowborder" valign="top" width="33.28%" headers="mcps1.2.4.1.2 "><p id="p55441544572"><a name="p55441544572"></a><a name="p55441544572"></a>模型捕获异常。</p>
</td>
<td class="cellrowborder" valign="top" width="33.38%" headers="mcps1.2.4.1.3 "><p id="p145573214810"><a name="p145573214810"></a><a name="p145573214810"></a><span id="ph310182175019_68"><a name="ph310182175019_68"></a><a name="ph310182175019_68"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
</tbody>
</table>

**表 3**  透传GE的返回码列表

<a name="table153902340461"></a>
<table><thead align="left"><tr id="row06094349464"><th class="cellrowborder" valign="top" width="33.379999999999995%" id="mcps1.2.4.1.1"><p id="p26098342461"><a name="p26098342461"></a><a name="p26098342461"></a>返回码</p>
</th>
<th class="cellrowborder" valign="top" width="33.17%" id="mcps1.2.4.1.2"><p id="p460973464611"><a name="p460973464611"></a><a name="p460973464611"></a>含义</p>
</th>
<th class="cellrowborder" valign="top" width="33.45%" id="mcps1.2.4.1.3"><p id="p361063414461"><a name="p361063414461"></a><a name="p361063414461"></a>可能原因及解决方法</p>
</th>
</tr>
</thead>
<tbody><tr id="row18610103412464"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p13610434164612"><a name="p13610434164612"></a><a name="p13610434164612"></a>uint32_t ACL_ERROR_GE_PARAM_INVALID = 145000;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p14610153484619"><a name="p14610153484619"></a><a name="p14610153484619"></a>参数校验失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p10610153474614"><a name="p10610153474614"></a><a name="p10610153474614"></a>请检查接口的入参值是否正确。</p>
</td>
</tr>
<tr id="row7610134174611"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p156103346466"><a name="p156103346466"></a><a name="p156103346466"></a>uint32_t ACL_ERROR_GE_EXEC_NOT_INIT = 145001;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p1861053434618"><a name="p1861053434618"></a><a name="p1861053434618"></a>未初始化。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><a name="ul1520614595016"></a><a name="ul1520614595016"></a><ul id="ul1520614595016"><li>请检查是否已调用<a href="aclInit.md">aclInit</a>接口进行初始化，请确保已调用<a href="aclInit.md">aclInit</a>接口，且在其它acl接口之前调用。</li><li>请检查是否已调用对应功能的初始化接口，例如初始化Dump的<a href="aclmdlInitDump.md">aclmdlInitDump</a>接口、初始化Profiling的<a href="aclprofInit.md">aclprofInit</a>接口。</li></ul>
</td>
</tr>
<tr id="row961012341466"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p1461033417468"><a name="p1461033417468"></a><a name="p1461033417468"></a>uint32_t ACL_ERROR_GE_EXEC_MODEL_PATH_INVALID = 145002;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p161043420460"><a name="p161043420460"></a><a name="p161043420460"></a>无效的模型路径。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p17610534164619"><a name="p17610534164619"></a><a name="p17610534164619"></a>请检查模型路径是否正确。</p>
</td>
</tr>
<tr id="row1861016348462"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p1061023415463"><a name="p1061023415463"></a><a name="p1061023415463"></a>uint32_t ACL_ERROR_GE_EXEC_MODEL_ID_INVALID = 145003;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p9610534164614"><a name="p9610534164614"></a><a name="p9610534164614"></a>无效的模型ID。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p1261083419460"><a name="p1261083419460"></a><a name="p1261083419460"></a>请检查模型ID是否正确、模型是否正确加载。</p>
</td>
</tr>
<tr id="row17610834164619"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p3610634134614"><a name="p3610634134614"></a><a name="p3610634134614"></a>uint32_t ACL_ERROR_GE_EXEC_MODEL_DATA_SIZE_INVALID = 145006;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p061014349462"><a name="p061014349462"></a><a name="p061014349462"></a>无效的模型大小。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p1293616427286"><a name="p1293616427286"></a><a name="p1293616427286"></a>模型文件无效，请重新构建模型。</p>
</td>
</tr>
<tr id="row126111034114615"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p261112342462"><a name="p261112342462"></a><a name="p261112342462"></a>uint32_t ACL_ERROR_GE_EXEC_MODEL_ADDR_INVALID = 145007;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p1661153415462"><a name="p1661153415462"></a><a name="p1661153415462"></a>无效的模型内存地址。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p0611113418468"><a name="p0611113418468"></a><a name="p0611113418468"></a>请检查模型地址是否有效。</p>
</td>
</tr>
<tr id="row1261183494619"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p461183418464"><a name="p461183418464"></a><a name="p461183418464"></a>uint32_t ACL_ERROR_GE_EXEC_MODEL_QUEUE_ID_INVALID = 145008;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p15611034124618"><a name="p15611034124618"></a><a name="p15611034124618"></a>无效的队列ID。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p1061103444613"><a name="p1061103444613"></a><a name="p1061103444613"></a>请检查队列ID是否正确。</p>
</td>
</tr>
<tr id="row7611193444611"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p10611133416469"><a name="p10611133416469"></a><a name="p10611133416469"></a>uint32_t ACL_ERROR_GE_EXEC_LOAD_MODEL_REPEATED = 145009;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p4611834114612"><a name="p4611834114612"></a><a name="p4611834114612"></a>重复初始化或重复加载。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p4611173417464"><a name="p4611173417464"></a><a name="p4611173417464"></a>请检查是否调用对应的接口重复初始化或重复加载。</p>
</td>
</tr>
<tr id="row761119344460"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p1961183416469"><a name="p1961183416469"></a><a name="p1961183416469"></a>uint32_t ACL_ERROR_GE_DYNAMIC_INPUT_ADDR_INVALID = 145011;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p7611134114614"><a name="p7611134114614"></a><a name="p7611134114614"></a>无效的动态分档输入地址。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p16114346463"><a name="p16114346463"></a><a name="p16114346463"></a>请检查动态分档输入地址。</p>
</td>
</tr>
<tr id="row1361112348461"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p126111934184611"><a name="p126111934184611"></a><a name="p126111934184611"></a>uint32_t ACL_ERROR_GE_DYNAMIC_INPUT_LENGTH_INVALID = 145012;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p18611034144616"><a name="p18611034144616"></a><a name="p18611034144616"></a>无效的动态分档输入长度。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p116111234194616"><a name="p116111234194616"></a><a name="p116111234194616"></a>请检查动态分档输入长度。</p>
</td>
</tr>
<tr id="row2061123418468"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p1761153464612"><a name="p1761153464612"></a><a name="p1761153464612"></a>uint32_t ACL_ERROR_GE_DYNAMIC_BATCH_SIZE_INVALID = 145013;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p17611103410467"><a name="p17611103410467"></a><a name="p17611103410467"></a>无效的动态分档Batch大小。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p1361116341463"><a name="p1361116341463"></a><a name="p1361116341463"></a>请检查动态分档Batch大小。</p>
</td>
</tr>
<tr id="row17611534114619"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p761153415466"><a name="p761153415466"></a><a name="p761153415466"></a>uint32_t ACL_ERROR_GE_AIPP_BATCH_EMPTY = 145014;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p1961123419465"><a name="p1961123419465"></a><a name="p1961123419465"></a>无效的AIPP batch size。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p156121634194614"><a name="p156121634194614"></a><a name="p156121634194614"></a>请检查AIPP batch size是否正确。</p>
</td>
</tr>
<tr id="row1361293494619"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p166128340461"><a name="p166128340461"></a><a name="p166128340461"></a>uint32_t ACL_ERROR_GE_AIPP_NOT_EXIST = 145015;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p19612234114612"><a name="p19612234114612"></a><a name="p19612234114612"></a>AIPP配置不存在。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p061219347467"><a name="p061219347467"></a><a name="p061219347467"></a>请检查AIPP是否配置。</p>
</td>
</tr>
<tr id="row156127348463"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p12612183416469"><a name="p12612183416469"></a><a name="p12612183416469"></a>uint32_t ACL_ERROR_GE_AIPP_MODE_INVALID = 145016;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p196121434124611"><a name="p196121434124611"></a><a name="p196121434124611"></a>无效的AIPP模式。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p1612123416466"><a name="p1612123416466"></a><a name="p1612123416466"></a>请检查模型转换时配置的AIPP模式是否正确。</p>
</td>
</tr>
<tr id="row146121034204612"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p06127348468"><a name="p06127348468"></a><a name="p06127348468"></a>uint32_t ACL_ERROR_GE_OP_TASK_TYPE_INVALID = 145017;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p2061210349467"><a name="p2061210349467"></a><a name="p2061210349467"></a>无效的任务类型。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p11612163420467"><a name="p11612163420467"></a><a name="p11612163420467"></a>请检查算子类型是否正确。</p>
</td>
</tr>
<tr id="row10612234114610"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p12612334194614"><a name="p12612334194614"></a><a name="p12612334194614"></a>uint32_t ACL_ERROR_GE_OP_KERNEL_TYPE_INVALID = 145018;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p461220341462"><a name="p461220341462"></a><a name="p461220341462"></a>无效的算子类型。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p1761212344461"><a name="p1761212344461"></a><a name="p1761212344461"></a>请检查算子类型是否正确。</p>
</td>
</tr>
<tr id="row17238025120"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p2642192611619"><a name="p2642192611619"></a><a name="p2642192611619"></a>uint32_t ACL_ERROR_GE_PLGMGR_PATH_INVALID = 145019;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p115797260169"><a name="p115797260169"></a><a name="p115797260169"></a>无效的so文件，包括so文件的路径层级太深、so文件被误删除等情况。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p134562171466"><a name="p134562171466"></a><a name="p134562171466"></a>请检查运行应用前配置的环境变量LD_LIBRARY_PATH是否正确，详细描述请参见编译运行处的操作指导。</p>
</td>
</tr>
<tr id="row12108558145016"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p1364310267168"><a name="p1364310267168"></a><a name="p1364310267168"></a>uint32_t ACL_ERROR_GE_FORMAT_INVALID = 145020;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p6643626201616"><a name="p6643626201616"></a><a name="p6643626201616"></a>无效的format。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p16643826171619"><a name="p16643826171619"></a><a name="p16643826171619"></a>请检查Tensor数据的format是否有效。</p>
</td>
</tr>
<tr id="row16472375116"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p14643726121619"><a name="p14643726121619"></a><a name="p14643726121619"></a>uint32_t ACL_ERROR_GE_SHAPE_INVALID = 145021;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p15643172691615"><a name="p15643172691615"></a><a name="p15643172691615"></a>无效的shape。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p1164342681611"><a name="p1164342681611"></a><a name="p1164342681611"></a>请检查Tensor数据的shape是否有效。</p>
</td>
</tr>
<tr id="row26804445113"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p9643826161616"><a name="p9643826161616"></a><a name="p9643826161616"></a>uint32_t ACL_ERROR_GE_DATATYPE_INVALID = 145022;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p2643112601611"><a name="p2643112601611"></a><a name="p2643112601611"></a>无效的数据类型。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p464310264162"><a name="p464310264162"></a><a name="p464310264162"></a>请检查Tensor数据的数据类型是否有效。</p>
</td>
</tr>
<tr id="row2061283444618"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p19612634114615"><a name="p19612634114615"></a><a name="p19612634114615"></a>uint32_t ACL_ERROR_GE_MEMORY_ALLOCATION = 245000;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p116121234104616"><a name="p116121234104616"></a><a name="p116121234104616"></a>申请内存失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p461253414468"><a name="p461253414468"></a><a name="p461253414468"></a>请检查硬件环境上的内存剩余情况。</p>
</td>
</tr>
<tr id="row09981940195111"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p65501559186"><a name="p65501559186"></a><a name="p65501559186"></a>uint32_t ACL_ERROR_GE_MEMORY_OPERATE_FAILED = 245001;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p1776081253718"><a name="p1776081253718"></a><a name="p1776081253718"></a>内存初始化、内存复制操作失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p144433542372"><a name="p144433542372"></a><a name="p144433542372"></a>请检查内存地址是否正确、硬件环境上的内存是否足够等。</p>
</td>
</tr>
<tr id="row728216599435"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p928285944314"><a name="p928285944314"></a><a name="p928285944314"></a>uint32_t ACL_ERROR_GE_DEVICE_MEMORY_ALLOCATION_FAILED = 245002;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p17282155944315"><a name="p17282155944315"></a><a name="p17282155944315"></a>申请Device内存失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p236693974418"><a name="p236693974418"></a><a name="p236693974418"></a>Device内存已用完，无法继续申请，请释放部分Device内存，再重新尝试。</p>
</td>
</tr>
<tr id="row146311153115112"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p133681854175117"><a name="p133681854175117"></a><a name="p133681854175117"></a>uint32_t  ACL_ERROR_GE_SUBHEALTHY = 345102;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p336935416514"><a name="p336935416514"></a><a name="p336935416514"></a>亚健康状态。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p16369165418512"><a name="p16369165418512"></a><a name="p16369165418512"></a>设备或进程异常触发的重部署动作完成后的状态为亚健康状态，亚健康状态下可以正常调用相关接口。</p>
</td>
</tr>
<tr id="row85602012211"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p194514306213"><a name="p194514306213"></a><a name="p194514306213"></a>static const uint32_t ACL_ERROR_GE_USER_RAISE_EXCEPTION = 345103;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p15611201426"><a name="p15611201426"></a><a name="p15611201426"></a>用户自定义函数主动抛异常。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p18561401828"><a name="p18561401828"></a><a name="p18561401828"></a>用户可根据DataFlowInfo中设置的UserData识别出来哪个输入的数据执行报错了，再根据报错排查问题。</p>
</td>
</tr>
<tr id="row162709418218"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p162701941822"><a name="p162701941822"></a><a name="p162701941822"></a>static const uint32_t ACL_ERROR_GE_DATA_NOT_ALIGNED = 345104;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p1327012410215"><a name="p1327012410215"></a><a name="p1327012410215"></a>数据未对齐。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p1815431881011"><a name="p1815431881011"></a><a name="p1815431881011"></a>若用户自定义函数存在多个输出时，需排查用户代码中是否少设置输出，缺少输出可能会导致数据对齐异常。</p>
</td>
</tr>
<tr id="row96127342466"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p66121234134612"><a name="p66121234134612"></a><a name="p66121234134612"></a>uint32_t ACL_ERROR_GE_INTERNAL_ERROR = 545000;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p561211344463"><a name="p561211344463"></a><a name="p561211344463"></a>未知内部错误。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p14823154215285"><a name="p14823154215285"></a><a name="p14823154215285"></a><span id="ph310182175019_69"><a name="ph310182175019_69"></a><a name="ph310182175019_69"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row46121834204615"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p1561263494615"><a name="p1561263494615"></a><a name="p1561263494615"></a>uint32_t ACL_ERROR_GE_LOAD_MODEL = 545001;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p1261212344463"><a name="p1261212344463"></a><a name="p1261212344463"></a>系统内部加载模型失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p19259125112285"><a name="p19259125112285"></a><a name="p19259125112285"></a><span id="ph310182175019_70"><a name="ph310182175019_70"></a><a name="ph310182175019_70"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row46121341463"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p3612334104611"><a name="p3612334104611"></a><a name="p3612334104611"></a>uint32_t ACL_ERROR_GE_EXEC_LOAD_MODEL_PARTITION_FAILED = 545002;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p1561233411461"><a name="p1561233411461"></a><a name="p1561233411461"></a>系统内部加载模型失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p95814122917"><a name="p95814122917"></a><a name="p95814122917"></a><span id="ph310182175019_71"><a name="ph310182175019_71"></a><a name="ph310182175019_71"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row18613143464615"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p20613193464619"><a name="p20613193464619"></a><a name="p20613193464619"></a>uint32_t ACL_ERROR_GE_EXEC_LOAD_WEIGHT_PARTITION_FAILED = 545003;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p1361393484615"><a name="p1361393484615"></a><a name="p1361393484615"></a>系统内部加载模型权值失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p8802012152918"><a name="p8802012152918"></a><a name="p8802012152918"></a><span id="ph310182175019_72"><a name="ph310182175019_72"></a><a name="ph310182175019_72"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row36131334184615"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p561353484618"><a name="p561353484618"></a><a name="p561353484618"></a>uint32_t ACL_ERROR_GE_EXEC_LOAD_TASK_PARTITION_FAILED = 545004;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p1761323424611"><a name="p1761323424611"></a><a name="p1761323424611"></a>系统内部加载模型任务失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p1346911914296"><a name="p1346911914296"></a><a name="p1346911914296"></a><span id="ph310182175019_73"><a name="ph310182175019_73"></a><a name="ph310182175019_73"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row56139345465"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p176132345469"><a name="p176132345469"></a><a name="p176132345469"></a>uint32_t ACL_ERROR_GE_EXEC_LOAD_KERNEL_PARTITION_FAILED = 545005;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p136139349463"><a name="p136139349463"></a><a name="p136139349463"></a>系统内部加载模型算子失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p194301427132918"><a name="p194301427132918"></a><a name="p194301427132918"></a><span id="ph310182175019_74"><a name="ph310182175019_74"></a><a name="ph310182175019_74"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row1461383420465"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p1613934184618"><a name="p1613934184618"></a><a name="p1613934184618"></a>uint32_t ACL_ERROR_GE_EXEC_RELEASE_MODEL_DATA = 545006;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p661363415469"><a name="p661363415469"></a><a name="p661363415469"></a>系统内释放模型空间失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p173611353291"><a name="p173611353291"></a><a name="p173611353291"></a><span id="ph310182175019_75"><a name="ph310182175019_75"></a><a name="ph310182175019_75"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row17613334124615"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p10613934124616"><a name="p10613934124616"></a><a name="p10613934124616"></a>uint32_t ACL_ERROR_GE_COMMAND_HANDLE = 545007;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p46138343465"><a name="p46138343465"></a><a name="p46138343465"></a>系统内命令操作失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p10819164312919"><a name="p10819164312919"></a><a name="p10819164312919"></a><span id="ph310182175019_76"><a name="ph310182175019_76"></a><a name="ph310182175019_76"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row6613123414612"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p261363404616"><a name="p261363404616"></a><a name="p261363404616"></a>uint32_t ACL_ERROR_GE_GET_TENSOR_INFO = 545008;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p1461373411468"><a name="p1461373411468"></a><a name="p1461373411468"></a>系统内获取张量数据失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p1040313502295"><a name="p1040313502295"></a><a name="p1040313502295"></a><span id="ph310182175019_77"><a name="ph310182175019_77"></a><a name="ph310182175019_77"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row136131634134612"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p96131734124619"><a name="p96131734124619"></a><a name="p96131734124619"></a>uint32_t ACL_ERROR_GE_UNLOAD_MODEL = 545009;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p16613153444611"><a name="p16613153444611"></a><a name="p16613153444611"></a>系统内卸载模型空间失败。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p1982145811294"><a name="p1982145811294"></a><a name="p1982145811294"></a><span id="ph310182175019_78"><a name="ph310182175019_78"></a><a name="ph310182175019_78"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row14887143711187"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p138878371184"><a name="p138878371184"></a><a name="p138878371184"></a>uint32_t ACL_ERROR_GE_MODEL_EXECUTE_TIMEOUT = 545601;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p2887163771818"><a name="p2887163771818"></a><a name="p2887163771818"></a>模型执行超时</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p2156175781812"><a name="p2156175781812"></a><a name="p2156175781812"></a><span id="ph310182175019_79"><a name="ph310182175019_79"></a><a name="ph310182175019_79"></a>您可以获取日志后单击<a href="https://www.hiascend.com/support" target="_blank" rel="noopener noreferrer">Link</a>联系技术支持。</span></p>
</td>
</tr>
<tr id="row9221181975217"><td class="cellrowborder" valign="top" width="33.379999999999995%" headers="mcps1.2.4.1.1 "><p id="p2221181965211"><a name="p2221181965211"></a><a name="p2221181965211"></a>uint32_t ACL_ERROR_GE_REDEPLOYING = 545602;</p>
</td>
<td class="cellrowborder" valign="top" width="33.17%" headers="mcps1.2.4.1.2 "><p id="p19221161915527"><a name="p19221161915527"></a><a name="p19221161915527"></a>正在重部署。</p>
</td>
<td class="cellrowborder" valign="top" width="33.45%" headers="mcps1.2.4.1.3 "><p id="p522181975211"><a name="p522181975211"></a><a name="p522181975211"></a>等待重部署动作完成后重新调用相关接口。</p>
</td>
</tr>
</tbody>
</table>

