#!/usr/bin/env node
/**
 * 自動生成符合 Conventional Commits 格式的 Git Commit 訊息 (Node.js 版本)
 */

const { execSync } = require('child_process');
const fs = require('fs');

class CommitMessageGenerator {
  constructor() {
    this.types = {
      'feat': '✨ 新功能',
      'fix': '🐛 錯誤修正',
      'docs': '📚 文檔',
      'style': '🎨 程式碼風格',
      'refactor': '♻️ 程式碼重構',
      'perf': '⚡ 效能改善',
      'test': '✅ 測試',
      'chore': '🔧 構建/工具',
      'ci': '🚀 CI/CD'
    };
  }

  getStagedChanges() {
    try {
      const added = execSync('git diff --cached --name-only --diff-filter=A', { encoding: 'utf-8' })
        .trim().split('\n').filter(f => f);
      const modified = execSync('git diff --cached --name-only --diff-filter=M', { encoding: 'utf-8' })
        .trim().split('\n').filter(f => f);
      const deleted = execSync('git diff --cached --name-only --diff-filter=D', { encoding: 'utf-8' })
        .trim().split('\n').filter(f => f);
      
      return { added, modified, deleted };
    } catch (e) {
      return { added: [], modified: [], deleted: [] };
    }
  }

  getDiffSummary() {
    try {
      return execSync('git diff --cached --stat', { encoding: 'utf-8' }).trim();
    } catch (e) {
      return '';
    }
  }

  analyzeChanges() {
    const { added, modified, deleted } = this.getStagedChanges();
    return {
      added,
      modified,
      deleted,
      totalFiles: added.length + modified.length + deleted.length
    };
  }

  suggestCommitType(analysis) {
    const files = [...analysis.added, ...analysis.modified];

    if (files.some(f => f.includes('test') || f.endsWith('.test.js') || f.endsWith('.spec.js'))) {
      return 'test';
    } else if (files.some(f => f.endsWith('.md') || f.includes('doc'))) {
      return 'docs';
    } else if (files.some(f => f.includes('config') || f.endsWith('.json') || f.includes('setup'))) {
      return 'chore';
    } else if (analysis.deleted.length > 0 && analysis.added.length === 0) {
      return 'chore';
    } else if (analysis.added.length > 0) {
      return 'feat';
    } else if (analysis.modified.length > 0) {
      return 'fix';
    }
    return 'chore';
  }

  generateMessage(commitType = null, scope = null, subject = null, language = 'zh') {
    const analysis = this.analyzeChanges();

    if (analysis.totalFiles === 0) {
      console.error('❌ 沒有暫存的變更。請使用 "git add" 暫存檔案。');
      return null;
    }

    if (!commitType) {
      commitType = this.suggestCommitType(analysis);
    }

    if (!scope && (analysis.added.length > 0 || analysis.modified.length > 0)) {
      const firstFile = analysis.added[0] || analysis.modified[0];
      scope = firstFile.includes('/') ? firstFile.split('/')[0] : firstFile.split('.')[0];
    }

    if (!subject) {
      subject = language === 'zh' 
        ? this.generateZhSubject(commitType, analysis)
        : this.generateEnSubject(commitType, analysis);
    }

    const message = scope ? `${commitType}(${scope}): ${subject}` : `${commitType}: ${subject}`;
    return message;
  }

  generateZhSubject(commitType, analysis) {
    const { added, modified, deleted } = analysis;
    
    switch(commitType) {
      case 'feat':
        return added.length > 0 ? `新增 ${added.length} 個功能檔案` : '新增功能';
      case 'fix':
        return modified.length > 0 ? `修正 ${modified.length} 個檔案的問題` : '修正問題';
      case 'docs':
        return '更新文檔';
      case 'style':
        return '調整程式碼風格';
      case 'refactor':
        return modified.length > 0 ? `重構 ${modified.length} 個檔案` : '重構程式碼';
      case 'test':
        return '新增測試案例';
      case 'chore':
        return '更新專案配置';
      default:
        return '更新程式碼';
    }
  }

  generateEnSubject(commitType, analysis) {
    const { added, modified } = analysis;
    
    switch(commitType) {
      case 'feat':
        return added.length > 0 ? `Add ${added.length} feature files` : 'Add new features';
      case 'fix':
        return modified.length > 0 ? `Fix ${modified.length} files` : 'Fix bugs';
      case 'docs':
        return 'Update documentation';
      case 'style':
        return 'Adjust code style';
      case 'refactor':
        return modified.length > 0 ? `Refactor ${modified.length} files` : 'Refactor code';
      case 'test':
        return 'Add test cases';
      case 'chore':
        return 'Update project configuration';
      default:
        return 'Update code';
    }
  }

  displayPreview(message) {
    console.log('\n' + '='.repeat(60));
    console.log('📋 建議的 Commit 訊息預覽');
    console.log('='.repeat(60));
    console.log(`\n${message}\n`);
    console.log('-'.repeat(60));
    console.log('變更摘要:');
    console.log(this.getDiffSummary());
    console.log('='.repeat(60) + '\n');
  }
}

function main() {
  const args = process.argv.slice(2);
  const generator = new CommitMessageGenerator();

  if (args[0] === '--help' || args[0] === '-h') {
    console.log('使用方法:');
    console.log('  node generate_commit_message.js                  # 自動生成訊息');
    console.log('  node generate_commit_message.js feat              # 指定類型為 feat');
    console.log('  node generate_commit_message.js fix html          # 指定類型和範圍');
    console.log('  node generate_commit_message.js --lang en         # 生成英文訊息');
    return;
  }

  const commitType = args[0] || null;
  const scope = args[1] || null;
  const language = args.includes('--lang') && args.includes('en') ? 'en' : 'zh';

  const message = generator.generateMessage(commitType, scope, null, language);

  if (message) {
    generator.displayPreview(message);
    console.log(`✅ Commit 訊息已準備好`);
    console.log(`💡 您可以使用以下命令提交:`);
    console.log(`   git commit -m "${message}"\n`);
  }
}

main();
