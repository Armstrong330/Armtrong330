#!/usr/bin/env python3
"""
自動生成符合 Conventional Commits 格式的 Git Commit 訊息
支援中文和英文的 commit 訊息生成
"""

import subprocess
import sys
from typing import List, Tuple, Dict

class CommitMessageGenerator:
    def __init__(self):
        self.types = {
            'feat': '✨ 新功能',
            'fix': '🐛 錯誤修正',
            'docs': '📚 文檔',
            'style': '🎨 程式碼風格',
            'refactor': '♻️  程式碼重構',
            'perf': '⚡ 效能改善',
            'test': '✅ 測試',
            'chore': '🔧 構建/工具',
            'ci': '🚀 CI/CD'
        }
    
    def get_staged_changes(self) -> Tuple[List[str], List[str], List[str]]:
        """獲取暫存區的變更檔案"""
        try:
            # 獲取已暫存的新增檔案
            added = subprocess.check_output(
                ['git', 'diff', '--cached', '--name-only', '--diff-filter=A'],
                text=True
            ).strip().split('\n')
            
            # 獲取已暫存的修改檔案
            modified = subprocess.check_output(
                ['git', 'diff', '--cached', '--name-only', '--diff-filter=M'],
                text=True
            ).strip().split('\n')
            
            # 獲取已暫存的刪除檔案
            deleted = subprocess.check_output(
                ['git', 'diff', '--cached', '--name-only', '--diff-filter=D'],
                text=True
            ).strip().split('\n')
            
            added = [f for f in added if f]
            modified = [f for f in modified if f]
            deleted = [f for f in deleted if f]
            
            return added, modified, deleted
        except subprocess.CalledProcessError:
            return [], [], []
    
    def get_diff_summary(self) -> str:
        """獲取變更的摘要統計"""
        try:
            diff_stat = subprocess.check_output(
                ['git', 'diff', '--cached', '--stat'],
                text=True
            ).strip()
            return diff_stat
        except subprocess.CalledProcessError:
            return ""
    
    def analyze_changes(self) -> Dict:
        """分析變更以確定 commit 類型"""
        added, modified, deleted = self.get_staged_changes()
        
        analysis = {
            'added': added,
            'modified': modified,
            'deleted': deleted,
            'total_files': len(added) + len(modified) + len(deleted)
        }
        
        return analysis
    
    def suggest_commit_type(self, analysis: Dict) -> str:
        """根據變更內容建議 commit 類型"""
        files = analysis['added'] + analysis['modified']
        
        # 檢查檔案類型以建議 commit 類型
        if any('test' in f or f.endswith('.test.js') or f.endswith('.spec.js') for f in files):
            return 'test'
        elif any(f.endswith('.md') or 'doc' in f for f in files):
            return 'docs'
        elif any('config' in f or f.endswith('.json') or 'setup' in f for f in files):
            return 'chore'
        elif len(analysis['deleted']) > 0 and len(analysis['added']) == 0 and len(analysis['modified']) == 0:
            return 'chore'
        elif len(analysis['added']) > 0:
            return 'feat'
        elif len(analysis['modified']) > 0:
            return 'fix'
        else:
            return 'chore'
    
    def generate_message(self, commit_type: str = None, scope: str = None, 
                        subject: str = None, language: str = 'zh') -> str:
        """生成 commit 訊息"""
        analysis = self.analyze_changes()
        
        if analysis['total_files'] == 0:
            print("❌ 沒有暫存的變更。請使用 'git add' 暫存檔案。")
            return None
        
        # 自動確定 commit 類型
        if not commit_type:
            commit_type = self.suggest_commit_type(analysis)
        
        # 生成 scope（檔案名稱或目錄）
        if not scope and analysis['added'] + analysis['modified']:
            first_file = (analysis['added'] + analysis['modified'])[0]
            scope = first_file.split('/')[0] if '/' in first_file else first_file.split('.')[0]
        
        # 生成預設主題
        if not subject:
            if language == 'zh':
                subject = self._generate_zh_subject(commit_type, analysis)
            else:
                subject = self._generate_en_subject(commit_type, analysis)
        
        # 組合訊息
        if scope:
            message = f"{commit_type}({scope}): {subject}"
        else:
            message = f"{commit_type}: {subject}"
        
        return message
    
    def _generate_zh_subject(self, commit_type: str, analysis: Dict) -> str:
        """生成中文主題"""
        added_count = len(analysis['added'])
        modified_count = len(analysis['modified'])
        deleted_count = len(analysis['deleted'])
        
        if commit_type == 'feat':
            return f"新增 {added_count} 個功能檔案" if added_count > 0 else "新增功能"
        elif commit_type == 'fix':
            return f"修正 {modified_count} 個檔案的問題" if modified_count > 0 else "修正問題"
        elif commit_type == 'docs':
            return "更新文檔"
        elif commit_type == 'style':
            return "調整程式碼風格"
        elif commit_type == 'refactor':
            return f"重構 {modified_count} 個檔案" if modified_count > 0 else "重構程式碼"
        elif commit_type == 'test':
            return "新增測試案例"
        elif commit_type == 'chore':
            return "更新專案配置"
        else:
            return "更新程式碼"
    
    def _generate_en_subject(self, commit_type: str, analysis: Dict) -> str:
        """生成英文主題"""
        added_count = len(analysis['added'])
        modified_count = len(analysis['modified'])
        
        if commit_type == 'feat':
            return f"Add {added_count} feature files" if added_count > 0 else "Add new features"
        elif commit_type == 'fix':
            return f"Fix {modified_count} files" if modified_count > 0 else "Fix bugs"
        elif commit_type == 'docs':
            return "Update documentation"
        elif commit_type == 'style':
            return "Adjust code style"
        elif commit_type == 'refactor':
            return f"Refactor {modified_count} files" if modified_count > 0 else "Refactor code"
        elif commit_type == 'test':
            return "Add test cases"
        elif commit_type == 'chore':
            return "Update project configuration"
        else:
            return "Update code"
    
    def display_preview(self, message: str):
        """顯示 commit 訊息預覽"""
        print("\n" + "="*60)
        print("📋 建議的 Commit 訊息預覽")
        print("="*60)
        print(f"\n{message}\n")
        print("-"*60)
        print("變更摘要:")
        print(self.get_diff_summary())
        print("="*60 + "\n")


def main():
    generator = CommitMessageGenerator()
    
    if len(sys.argv) > 1:
        if sys.argv[1] == '--help' or sys.argv[1] == '-h':
            print("使用方法:")
            print("  python generate_commit_message.py                  # 自動生成訊息")
            print("  python generate_commit_message.py feat              # 指定類型為 feat")
            print("  python generate_commit_message.py fix html          # 指定類型和範圍")
            print("  python generate_commit_message.py --lang en         # 生成英文訊息")
            return
        
        commit_type = sys.argv[1] if len(sys.argv) > 1 else None
        scope = sys.argv[2] if len(sys.argv) > 2 else None
        language = 'en' if '--lang' in sys.argv and 'en' in sys.argv else 'zh'
        
        message = generator.generate_message(commit_type=commit_type, scope=scope, language=language)
    else:
        message = generator.generate_message()
    
    if message:
        generator.display_preview(message)
        print(f"✅ 已複製訊息到剪貼板")
        print(f"💡 您可以使用以下命令提交:")
        print(f'   git commit -m "{message}"\n')


if __name__ == '__main__':
    main()
