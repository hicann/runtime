# 文件命名与编码规范

## 文件名规范

禁止文件名包含空格（导致 Markdown 链接解析异常）

正确示例：
- `ACLGraph 捕获过程中任务提交限制.md` ✓
- `aclrtMalloc 内存申请失败常见原因.md` ✓

错误示例：
- `ACL Graph 捕获限制.md` ❌（包含空格）

## 文件编码规范

必须使用 UTF-8编码（无 BOM）

检查编码：
```bash
# 检查文件是否包含 BOM
head -c 3 docs/zh/FAQ/xxx.md | xxd
# BOM 文件会输出：efbb bf
# 正常文件不会

# 批量检查
for f in docs/zh/FAQ/*.md; do
 bom=$(head -c 3 "$f" | xxd -p)
 if [ "$bom" = "efbbbf" ]; then
 echo "BOM detected: $f"
 fi
done
```

## Markdown 格式规范

禁止使用 HTML 表格（跨平台兼容性问题）

正确：Markdown 表格
```markdown
| 列1 | 列2 | 列3 |
|-----|-----|------|
| 内容 | 内容 | 内容 |
```

错误：HTML 表格
```html
<table>
 <tr><td>内容</td></tr>
</table>
```

## 尾部空格清理

禁止 md 文件行尾多余空格：

```bash
# 检查行尾空格
grep -rn ' $' docs/zh/FAQ/*.md

# 清理（慎用，需确认后执行）
# sed -i 's/[[:space:]]*$//' docs/zh/FAQ/*.md
```
