#!/bin/bash

# 脚本功能：安装项目必备的 skills
# 默认技能技能列表
DEFAULT_SKILLS=("gitcode-pr" "gitcode-issue")

# 超时时间（秒）
CONNECT_TIMEOUT=5
CLONE_TIMEOUT=20

# 仓库 URL
REPO_URL="https://gitcode.com/cann-agent/skills.git"

# 脚本所在目录的上上级目录为 .claude/skills/
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# 创建临时目录
if command -v mktemp &> /dev/null; then
    TEMP_DIR=$(mktemp -d)
else
    # Git Bash 或其他环境没有 mktemp，使用备用方案
    TEMP_DIR="/tmp/skills_install_$$"
    mkdir -p "$TEMP_DIR"
fi
trap 'rm -rf "$TEMP_DIR"' EXIT

# 检查网络连通性（快速检测是否可以访问仓库）
echo "Checking repository accessibility..."
check_connectivity() {
    if command -v curl &> /dev/null; then
        http_code=$(curl --connect-timeout $CONNECT_TIMEOUT --max-time $CONNECT_TIMEOUT -s -o /dev/null -w "%{http_code}" "https://gitcode.com" 2>/dev/null)
        if [ "$http_code" = "200" ] || [ "$http_code" = "301" ] || [ "$http_code" = "302" ]; then
            return 0
        fi
        return 1
    elif command -v wget &> /dev/null; then
        wget --timeout=$CONNECT_TIMEOUT -q --spider "https://gitcode.com" 2>/dev/null
        return $?
    else
        # 如果 curl 和 wget 都不存在，尝试使用 git 的低级探测
        GIT_HTTP_LOW_SPEED_LIMIT=1 GIT_HTTP_LOW_SPEED_TIME=$CONNECT_TIMEOUT \
            git ls-remote "$REPO_URL" HEAD &>/dev/null
        return $?
    fi
}

if ! check_connectivity; then
    echo "Error: Cannot access gitcode.com, please check network connectivity"
    exit 1
fi

# 克隆 skills 仓库
echo "Cloning skills repository..."
if command -v timeout &> /dev/null; then
    timeout $CLONE_TIMEOUT git clone --depth 1 "$REPO_URL" "$TEMP_DIR/skills" 2>&1
    if [ $? -ne 0 ]; then
        echo "Error: Failed to clone skills repository"
        exit 1
    fi
else
    GIT_HTTP_LOW_SPEED_LIMIT=1000
    GIT_HTTP_LOW_SPEED_TIME=$CLONE_TIMEOUT
    export GIT_HTTP_LOW_SPEED_LIMIT GIT_HTTP_LOW_SPEED_TIME
    git clone --depth 1 "$REPO_URL" "$TEMP_DIR/skills" 2>&1
    if [ $? -ne 0 ]; then
        echo "Error: Failed to clone skills repository"
        exit 1
    fi
fi

# 检查 skills 目录是否存在
if [ ! -d "$TEMP_DIR/skills/skills" ]; then
    echo "Error: skills directory not found in repository"
    exit 1
fi

# 拷贝技能到 .claude/skills/ 目录
echo "Installing skills..."
for skill in "${DEFAULT_SKILLS[@]}"; do
    if [ -d "$TEMP_DIR/skills/skills/$skill" ]; then
        cp -r "$TEMP_DIR/skills/skills/$skill" "$SKILLS_DIR/"
        echo "Installed skill: $skill"
    else
        echo "Warning: Skill '$skill' not found in repository"
    fi
done

echo "All skills installed successfully."

# 注入项目规则文件引用
PROJECT_ROOT="$(cd "$SKILLS_DIR/.." && pwd)"
RULES_FILE="$PROJECT_ROOT/.claude/runtime-code-review-rules.md"

if [ -f "$RULES_FILE" ]; then
    echo "Injecting project rules reference to gitcode-pr..."
    
    # 在 review.md 的步骤 2 后添加规则文件引用
    REVIEW_MD="$SKILLS_DIR/gitcode-pr/commands/review.md"
    
    if [ -f "$REVIEW_MD" ]; then
        # 创建临时文件，插入规则引用
        sed -i '/^### 步骤 2: 获取项目规范上下文$/a\
\
**项目审查规则文件**：\
- `.claude/runtime-code-review-rules.md` - Runtime 代码审查规则，包含功能正确性、格式规范、日志合理性、安全性、公共 API 兼容性、文档、软件架构、构建规范、UT 规范等维度' "$REVIEW_MD"
        echo "Injected rules reference to review.md"
    fi
fi

echo "Installation complete."
