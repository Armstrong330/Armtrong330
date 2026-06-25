# 味蕾無國界 (TasteWithoutBorders) - 互動式美食文化平台

> 一個利用美食串聯世界各國文化、歷史和人民的創新型平台

## 📖 快速導航

### 📚 架構規劃文檔
本項目包含完整的前期規劃文檔，涵蓋功能設計、技術棧和部署指南：

| 文檔 | 內容 | 閱讀時間 |
|------|------|---------|
| [**PROJECT_SUMMARY.md**](./PROJECT_SUMMARY.md) | 📋 項目總結與快速開始指南 | 15 分鐘 |
| [**ARCHITECTURE.md**](./ARCHITECTURE.md) | 🏗️ 系統整體架構與數據庫設計 | 30 分鐘 |
| [**API_DESIGN.md**](./API_DESIGN.md) | 🔌 RESTful API 完整規範 | 25 分鐘 |
| [**FRONTEND_ARCHITECTURE.md**](./FRONTEND_ARCHITECTURE.md) | 🎨 前端架構與技術棧詳細設計 | 20 分鐘 |
| [**BACKEND_ARCHITECTURE.md**](./BACKEND_ARCHITECTURE.md) | ⚙️ 後端架構與部署配置 | 25 分鐘 |

### 🛠️ 工具腳本
自動生成 Git Commit 訊息的工具（Python、Node.js、Bash）：

```bash
# 使用 Python 版本
python generate_commit_message.py

# 使用 Node.js 版本
node generate_commit_message.js

# 使用 Bash 版本
./generate_commit_message.sh
```

---

## 🎯 項目概述

### 核心概念
**味蕾無國界** 是一個互動式平台，利用美食作為橋樑連接世界各國的文化、歷史、傳統和人民。用戶可以發現、分享和體驗全球美食文化。

### 主要價值主張
- 🌍 **全球化視角**：展示各國特色美食及其文化背景
- 👥 **社群互動**：用戶可分享食譜、評論、烹飪故事
- 🗺️ **地理探索**：透過美食地圖發現世界各地
- 📚 **文化教育**：學習美食背後的歷史和傳統
- 🔗 **跨境連結**：連接美食愛好者和專業廚師

---

## ✨ 核心功能

### 1️⃣ 美食發現與探索
- 全球美食目錄（按國家/地區/食材分類）
- 美食詳情頁面（圖文並茂、營養信息、難度級別）
- 用戶評分和評論系統

### 2️⃣ 食譜分享與管理
- 用戶食譜上傳和版本控制
- 個人食譜庫管理
- 烹飪筆記和改良記錄

### 3️⃣ 社群互動
- 評論評分系統
- 用戶檔案和粉絲系統
- 社群討論論壇
- 排行榜系統

### 4️⃣ 美食地圖
- 互動地圖展示全球美食
- 地區美食展示
- 美食旅遊路線規劃
- 餐廳推薦

### 5️⃣ 文化故事
- 美食歷史和起源
- 文化背景介紹
- 多媒體內容（紀錄片、訪談、圖文故事）
- 用戶投稿

### 6️⃣ 個人化體驗
- 飲食偏好設置（葷素、過敏、禁忌）
- AI 推薦系統
- 購物清單生成
- 烹飪日程規劃

### 7️⃣ 搜索與發現
- 高級搜索（菜系、食材、難度、時間）
- 智能標籤系統
- 全文搜尋
- AI 推薦引擎

### 8️⃣ 多語言支持
- 10+ 種語言界面
- 文化本地化
- 翻譯社群

---

## 🏗️ 技術架構速覽

### 前端技術棧
```
Next.js 14 + React 18 + TypeScript 5
├── 狀態管理：Zustand + React Query
├── 樣式：Tailwind CSS + Shadcn/ui
├── 地圖：Mapbox GL JS
└── 表單：React Hook Form + Zod
```

### 後端技術棧
```
Node.js 20 + NestJS 10 + TypeScript 5
├── ORM：Prisma 5
├── 認證：JWT + Passport
├── 緩存：Redis 7
├── 搜索：Elasticsearch 8
└── 文件存儲：AWS S3 + CloudFront
```

### 數據庫架構
```
PostgreSQL 15        → 結構化數據（用戶、食譜、評論）
MongoDB 6            → 半結構化內容（食材詳情、步驟）
Redis 7              → 緩存、排行榜、會話
Elasticsearch 8      → 全文搜索、分析
```

---

## 📊 系統架構

### 整體架構圖
```
┌─────────────────────────────────┐
│   Web Frontend (Next.js)        │
│   Mobile App (React Native)     │
└────────────┬────────────────────┘
             │
┌────────────▼────────────────────┐
│    API Gateway / Load Balancer  │
├────────────┬────────────────────┤
│  REST API  │  GraphQL (可選)   │
│  WebSocket │  gRPC (可選)      │
└────────────┬────────────────────┘
             │
┌────────────▼────────────────────────────────┐
│      Microservices / NestJS Modules         │
├────────┬─────────┬────────┬────────┬────────┤
│ Auth   │ Recipes │ Users  │ Search │ Social │
└────────┼─────────┼────────┼────────┼────────┘
         │
    ┌────┴────┬─────────┬─────────┬──────────┐
    │          │         │         │          │
┌───▼──┐  ┌───▼──┐  ┌──▼───┐  ┌──▼───┐  ┌───▼─┐
│ PG   │  │ Mongo│  │Redis │  │  ES  │  │S3   │
└──────┘  └──────┘  └──────┘  └──────┘  └─────┘
```

---

## 🎓 用戶角色

| 角色 | 特徵 | 主要活動 |
|------|------|---------|
| 🔍 美食探險家 | 對各國美食感興趣 | 瀏覽、搜尋、收藏 |
| 👨‍🍳 家庭廚師 | 在家烹飪、改進廚藝 | 查看食譜、分享、參與 |
| ⭐ 專業廚師 | 豐富經驗、知識分享 | 上傳高質量內容、教學 |
| 📚 文化愛好者 | 對美食文化感興趣 | 閱讀故事、了解背景 |
| ✈️ 美食旅遊者 | 規劃美食相關旅行 | 探索地區美食、查看餐廳 |

---

## 🚀 開發路線圖

### Phase 1: MVP (2-3 個月)
- ✅ 用戶認證與授權
- ✅ 基本食譜 CRUD
- ✅ 搜索和過濾
- ✅ 評論和評分
- ✅ 用戶檔案

### Phase 2: 核心功能 (3-4 個月)
- 社群功能（粉絲系統）
- 食譜收藏
- 多語言支持
- 高級推薦系統
- 文化故事模塊

### Phase 3: 增強功能 (2-3 個月)
- 美食地圖
- 購物清單生成
- 視頻教程上傳
- 移動應用
- 實時通知系統

### Phase 4: 優化與擴展 (持續)
- 性能優化
- SEO 優化
- A/B 測試
- 用戶分析
- 高級推薦算法

---

## 📈 核心指標

| 指標 | 目標 | 說明 |
|------|------|------|
| 頁面加載時間 | < 2s | 首屏加載時間 |
| API 響應時間 | < 200ms | p95 延遲 |
| 搜索延遲 | < 100ms | 全文搜索響應 |
| 可用性 | > 99.9% | 年度 SLA |
| 測試覆蓋率 | > 80% | 後端業務邏輯 |

---

## 🔒 安全性

- ✅ JWT + OAuth 2.0 認證
- ✅ HTTPS/TLS 加密
- ✅ SQL 注入防護
- ✅ XSS 和 CSRF 防護
- ✅ 速率限制
- ✅ 內容審核系統
- ✅ 數據備份和恢復

---

## 📦 部署架構

### 本地開發
```bash
# 使用 Docker Compose
docker-compose up -d
```

### 生產環境
```
Kubernetes Cluster
├── Frontend Pod (Next.js)
├── Backend Pods (NestJS)
├── Database Services
├── Cache Services
└── Search Services
```

---

## 💡 推薦閱讀順序

1. **首先讀這個** → [PROJECT_SUMMARY.md](./PROJECT_SUMMARY.md)
   - 快速了解項目概要

2. **然後讀系統設計** → [ARCHITECTURE.md](./ARCHITECTURE.md)
   - 理解整體架構和功能設計

3. **根據角色選擇**：
   - 🎨 **前端開發** → [FRONTEND_ARCHITECTURE.md](./FRONTEND_ARCHITECTURE.md)
   - ⚙️ **後端開發** → [BACKEND_ARCHITECTURE.md](./BACKEND_ARCHITECTURE.md)
   - 🔌 **全棧/API 對接** → [API_DESIGN.md](./API_DESIGN.md)

4. **部署與運維** → [BACKEND_ARCHITECTURE.md](./BACKEND_ARCHITECTURE.md) 部署章節

---

## 🎨 設計特色

### 用戶中心設計
- 直觀的導航和搜索
- 個性化推薦
- 社群參與激勵機制

### 高性能架構
- 大規模並發支持
- 分佈式緩存
- 異步任務處理
- CDN 加速

### 全球化考慮
- 多語言支持
- 文化敏感性考慮
- 地理位置服務
- 時區管理

---

## 📞 常見問題

### Q: 為什麼選擇 Next.js？
A: 提供 SSR、SSG、ISR 等多種渲染模式，優化 SEO 和性能。

### Q: 為什麼用 Prisma？
A: Type-safe ORM，自動遷移，開發體驗優異。

### Q: 為什麼需要 Elasticsearch？
A: 支持全文搜索、複雜聚合分析、實時索引。

### Q: 如何處理大規模用戶？
A: 使用 Kubernetes 自動擴展、Redis 緩存、消息隊列非同步處理。

---

## 🚨 部署檢查清單

在上線前，請確保：
- [ ] 環境變數配置完成
- [ ] SSL 證書有效
- [ ] 數據庫備份策略就位
- [ ] 監控告警規則配置
- [ ] 安全漏洞掃描通過
- [ ] 性能測試達標
- [ ] 文檔完整更新

---

## 📞 聯繫與支持

### 文檔維護
- **版本**：1.0
- **最後更新**：2026-06-22
- **維護者**：架構設計團隊

### 提交反饋
在 Issues 或 Discussions 中提交反饋和建議。

---

## 📄 許可證

本項目架構規劃文檔採用 Creative Commons Attribution 4.0 International License。

---

<div align="center">

**利用美食串聯世界各國**

Made with ❤️ by Architecture Team

</div>