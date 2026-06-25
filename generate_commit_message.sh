#!/bin/bash
# 自動生成符合 Conventional Commits 格式的 Git Commit 訊息 (Bash 版本)

set -e

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 函數：獲取已暫存的變更檔案
get_staged_changes() {
    local added=$(git diff --cached --name-only --diff-filter=A 2>/dev/null | wc -l)
    local modified=$(git diff --cached --name-only --diff-filter=M 2>/dev/null | wc -l)
    local deleted=$(git diff --cached --name-only --diff-filter=D 2>/dev/null | wc -l)
    
    echo "$added|$modified|$deleted"
}

# 函數：獲取第一個變更的檔案
get_first_changed_file() {
    git diff --cached --name-only 2>/dev/null | head -1
}

# 函數：獲取變更摘要
get_diff_summary() {
    git diff --cached --stat 2>/dev/null
}

# 函數：檢查暫存的變更
check_staged_changes() {
    local changes=$(get_staged_changes)
    local added=$(echo "$changes" | cut -d'|' -f1)
    local modified=$(echo "$changes" | cut -d'|' -f2)
    local deleted=$(echo "$changes" | cut -d'|' -f3)
    local total=$((added + modified + deleted))
    
    if [ $total -eq 0 ]; then
        echo -e "${RED}❌ 沒有暫存的變更。請使用 'git add' 暫存檔案。${NC}"
        exit 1
    fi
}

# 函數：建議 commit 類型
suggest_commit_type() {
    local first_file=$(get_first_changed_file)
    
    if [[ $first_file == *"test"* ]] || [[ $first_file == *.test.js ]] || [[ $first_file == *.spec.js ]]; then
        echo "test"
    elif [[ $first_file == *.md ]] || [[ $first_file == *"doc"* ]]; then
        echo "docs"
    elif [[ $first_file == *"config"* ]] || [[ $first_file == *.json ]] || [[ $first_file == *"setup"* ]]; then
        echo "chore"
    else
        echo "fix"
    fi
}

# 函數：生成中文主題
generate_zh_subject() {
    local type=$1
    local changes=$2
    local added=$(echo "$changes" | cut -d'|' -f1)
    local modified=$(echo "$changes" | cut -d'|' -f2)
    
    case $type in
        feat)
            if [ $added -gt 0 ]; then
                echo "新增 $added 個功能檔案"
            else
                echo "新增功能"
            fi
            ;;
        fix)
            if [ $modified -gt 0 ]; then
                echo "修正 $modified 個檔案的問題"
            else
                echo "修正問題"
            fi
            ;;
        docs)
            echo "更新文檔"
            ;;
        style)
            echo "調整程式碼風格"
            ;;
        refactor)
            if [ $modified -gt 0 ]; then
                echo "重構 $modified 個檔案"
            else
                echo "重構程式碼"
            fi
            ;;
        test)
            echo "新增測試案例"
            ;;
        chore)
            echo "更新專案配置"
            ;;
        *)
            echo "更新程式碼"
            ;;
    esac
}

# 函數：生成英文主題
generate_en_subject() {
    local type=$1
    local changes=$2
    local added=$(echo "$changes" | cut -d'|' -f1)
    local modified=$(echo "$changes" | cut -d'|' -f2)
    
    case $type in
        feat)
            if [ $added -gt 0 ]; then
                echo "Add $added feature files"
            else
                echo "Add new features"
            fi
            ;;
        fix)
            if [ $modified -gt 0 ]; then
                echo "Fix $modified files"
            else
                echo "Fix bugs"
            fi
            ;;
        docs)
            echo "Update documentation"
            ;;
        style)
            echo "Adjust code style"
            ;;
        refactor)
            if [ $modified -gt 0 ]; then
                echo "Refactor $modified files"
            else
                echo "Refactor code"
            fi
            ;;
        test)
            echo "Add test cases"
            ;;
        chore)
            echo "Update project configuration"
            ;;
        *)
            echo "Update code"
            ;;
    esac
}

# 函數：獲取範圍 (scope)
get_scope() {
    local first_file=$(get_first_changed_file)
    if [[ $first_file == *"/"* ]]; then
        echo "$first_file" | cut -d'/' -f1
    else
        echo "$first_file" | cut -d'.' -f1
    fi
}

# 函數：顯示幫助信息
show_help() {
    echo "自動生成 Git Commit 訊息"
    echo ""
    echo "使用方法:"
    echo "  ./generate_commit_message.sh                  # 自動生成訊息"
    echo "  ./generate_commit_message.sh feat              # 指定類型為 feat"
    echo "  ./generate_commit_message.sh fix html          # 指定類型和範圍"
    echo "  ./generate_commit_message.sh --lang en         # 生成英文訊息"
    echo ""
    echo "Commit 類型:"
    echo "  feat       - ✨ 新功能"
    echo "  fix        - 🐛 錯誤修正"
    echo "  docs       - 📚 文檔"
    echo "  style      - 🎨 程式碼風格"
    echo "  refactor   - ♻️ 程式碼重構"
    echo "  perf       - ⚡ 效能改善"
    echo "  test       - ✅ 測試"
    echo "  chore      - 🔧 構建/工具"
}

# 主函數
main() {
    # 檢查是否在 git 倉庫中
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo -e "${RED}❌ 不在 Git 倉庫中${NC}"
        exit 1
    fi
    
    # 顯示幫助信息
    if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
        show_help
        exit 0
    fi
    
    # 檢查暫存的變更
    check_staged_changes
    
    # 獲取 commit 類型、範圍和語言
    local commit_type="${1:-$(suggest_commit_type)}"
    local scope="${2:-$(get_scope)}"
    local language="zh"
    
    # 檢查語言參數
    if [[ "$@" == *"--lang"* ]] && [[ "$@" == *"en"* ]]; then
        language="en"
    fi
    
    # 獲取變更信息
    local changes=$(get_staged_changes)
    
    # 生成主題
    local subject
    if [ "$language" = "en" ]; then
        subject=$(generate_en_subject "$commit_type" "$changes")
    else
        subject=$(generate_zh_subject "$commit_type" "$changes")
    fi
    
    # 組合 commit 訊息
    local message="$commit_type($scope): $subject"
    
    # 顯示預覽
    echo ""
    echo -e "${BLUE}$(printf '=%.0s' {1..60})${NC}"
    echo -e "${BLUE}📋 建議的 Commit 訊息預覽${NC}"
    echo -e "${BLUE}$(printf '=%.0s' {1..60})${NC}"
    echo ""
    echo -e "${GREEN}$message${NC}"
    echo ""
    echo -e "${BLUE}$(printf '-%.0s' {1..60})${NC}"
    echo "變更摘要:"
    get_diff_summary
    echo -e "${BLUE}$(printf '=%.0s' {1..60})${NC}"
    echo ""
    
    echo -e "${GREEN}✅ Commit 訊息已準備好${NC}"
    echo "💡 您可以使用以下命令提交:"
    echo -e "${YELLOW}   git commit -m \"$message\"${NC}"
    echo ""
    
    # 可選：自動複製到剪貼板（如果有 xclip 或 pbcopy）
    if command -v xclip &> /dev/null; then
        echo "$message" | xclip -selection clipboard
        echo -e "${GREEN}📋 訊息已複製到剪貼板${NC}"
    elif command -v pbcopy &> /dev/null; then
        echo "$message" | pbcopy
        echo -e "${GREEN}📋 訊息已複製到剪貼板${NC}"
    fi
}

main "$@"
