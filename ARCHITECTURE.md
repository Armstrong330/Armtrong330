# 「味蕾無國界」(TasteWithoutBorders) - 項目架構規劃文檔

## 📋 目錄
1. [項目概述](#項目概述)
2. [核心功能設計](#核心功能設計)
3. [用戶角色與用例](#用戶角色與用例)
4. [系統架構](#系統架構)
5. [數據庫設計](#數據庫設計)
6. [技術棧推薦](#技術棧推薦)
7. [開發路線圖](#開發路線圖)
8. [安全性考慮](#安全性考慮)

---

## 項目概述

### 項目名稱
**味蕾無國界** (TasteWithoutBorders)

### 核心概念
利用美食作為橋樑，連接世界各國的文化、歷史、傳統和人民。打造一個互動式平台，讓用戶發現、分享和體驗全球美食文化。

### 主要價值主張
- 🌍 **全球化視角**：展示各國特色美食及其文化背景
- 👥 **社群互動**：用戶可分享食譜、評論、烹飪故事
- 🗺️ **地理探索**：透過美食地圖發現世界各地
- 📚 **文化教育**：學習美食背後的歷史和傳統
- 🔗 **跨境連結**：連接美食愛好者和廚師

---

## 核心功能設計

### 1. 美食發現與探索 (Food Discovery)
- **全球美食目錄**：按國家/地區/食材分類
- **美食詳情頁面**：
  - 菜品信息、文化背景、歷史故事
  - 多媒體內容（高質量圖片、視頻教程）
  - 營養信息、食材清單、難度級別
  - 用戶評分和評論

### 2. 食譜分享與管理 (Recipe Sharing)
- **用戶食譜上傳**：支持圖文並茂的食譜
- **版本控制**：追蹤食譜修改歷史
- **食譜收藏**：個人食譜庫管理
- **烹飪筆記**：記錄烹飪經驗和改良

### 3. 社群互動 (Community)
- **評論和評分系統**：用戶反饋機制
- **用戶檔案**：展示廚師背景和特長
- **粉絲系統**：關注感興趣的廚師
- **社群討論**：按美食/地區/主題的論壇
- **排行榜**：最受歡迎的食譜、廚師

### 4. 美食地圖 (Food Map)
- **互動地圖**：顯示各國代表性美食
- **地區美食展示**：點擊地區查看特色美食
- **美食路線**：規劃美食旅遊路線
- **餐廳推薦**：關聯地區餐廳

### 5. 文化故事 (Cultural Stories)
- **美食歷史**：各菜系的起源和演變
- **文化背景**：食材、節日、傳統習俗
- **多媒體內容**：紀錄片、訪談、圖文故事
- **用戶投稿**：分享個人美食故事

### 6. 個人化體驗 (Personalization)
- **飲食偏好設置**：記錄用戶偏好（葷素、過敏、飲食禁忌）
- **推薦系統**：基於偏好和歷史的個性化推薦
- **購物清單**：根據食譜生成食材購物清單
- **烹飪日程**：規劃周度或月度烹飪計畫

### 7. 搜索與過濾 (Search & Discovery)
- **高級搜索**：按菜系、食材、難度、烹飪時間搜尋
- **智能標籤系統**：自動分類和推薦
- **全文搜尋**：食譜名稱、說明、食材名
- **AI 推薦**：基於用戶行為的推薦引擎

### 8. 多語言支持 (Internationalization)
- **多語言界面**：至少支持 10+ 種語言
- **文化本地化**：適應不同地區的習慣
- **翻譯社群**：用戶協作翻譯內容

---

## 用戶角色與用例

### 用戶角色

#### 1. **美食探險家 (Food Explorer)**
- **特徵**：對各國美食感興趣，喜歡學習新菜系
- **主要活動**：瀏覽、搜尋、收藏食譜，留下評論
- **常用功能**：發現模組、美食地圖、推薦系統

#### 2. **家庭廚師 (Home Chef)**
- **特徵**：在家烹飪，希望改進廚藝
- **主要活動**：查看食譜、分享自己的做法、參與社群
- **常用功能**：詳細食譜、烹飪筆記、購物清單

#### 3. **專業廚師/內容創作者 (Professional/Creator)**
- **特徵**：有豐富廚藝經驗，想分享知識
- **主要活動**：上傳高品質食譜、創建教程視頻、建立粉絲群
- **常用功能**：食譜管理、內容上傳、分析工具

#### 4. **文化愛好者 (Culture Enthusiast)**
- **特徵**：對美食文化和歷史感興趣
- **主要活動**：閱讀故事、了解背景、參與討論
- **常用功能**：文化故事、美食地圖、社群論壇

#### 5. **美食旅遊者 (Food Tourist)**
- **特徵**：計劃美食相關旅行
- **主要活動**：探索地區美食、查看餐廳、規劃路線
- **常用功能**：地圖、餐廳推薦、美食路線

---

## 系統架構

### 整體架構圖
```
┌─────────────────────────────────────────────────────┐
│                    用戶界面層 (Presentation)          │
│  Web (React/Next.js) │ Mobile (React Native/Flutter) │
└────────────────┬────────────────────────────────────┘
                 │
┌─────────────────▼────────────────────────────────────┐
│                 API 層 (API Gateway)                  │
│    REST API / GraphQL / WebSocket                     │
└────────────────┬────────────────────────────────────┘
                 │
┌─────────────────▼────────────────────────────────────┐
│              業務邏輯層 (Business Logic)              │
│  ┌──────────────┬──────────────┬──────────────────┐  │
│  │   用戶服務   │   食譜服務   │   社群服務       │  │
│  ├──────────────┼──────────────┼──────────────────┤  │
│  │  地圖服務    │   推薦引擎   │   搜索服務       │  │
│  └──────────────┴──────────────┴──────────────────┘  │
└────────────────┬────────────────────────────────────┘
                 │
┌─────────────────▼────────────────────────────────────┐
│              數據訪問層 (Data Access)                 │
│  ORM (TypeORM/Prisma) │ Query Builder              │
└────────────────┬────────────────────────────────────┘
                 │
    ┌────────────┼────────────┬──────────────┐
    │            │            │              │
┌───▼────┐  ┌───▼────┐  ┌───▼────┐  ┌────▼────┐
│PostgreSQL  │ MongoDB │ Redis   │ Elasticsearch
│(主數據庫) │(內容)  │(緩存)   │(全文搜尋)
└────────┘  └────────┘  └────────┘  └─────────┘

                 │
┌─────────────────▼────────────────────────────────────┐
│          外部服務與中間件                              │
│  ┌────────┬─────────────┬────────┬──────────────┐   │
│  │圖片存儲 │   郵件服務  │認證    │分析追蹤      │   │
│  │(S3/CDN)│(SendGrid)   │(Auth0) │(Segment)     │   │
│  └────────┴─────────────┴────────┴──────────────┘   │
└─────────────────────────────────────────────────────┘
```

### 微服務設計選項 (可選)
```
┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│  用戶服務    │  │  食譜服務    │  │  社群服務    │
│  微服務      │  │  微服務      │  │  微服務      │
└──────────────┘  └──────────────┘  └──────────────┘
       │                 │                 │
       │     ┌───────────┼───────────┐     │
       │     │                       │     │
       └────▶│  服務網格 (Service Mesh - Istio) │
       └────▶│       + API Gateway  │
             └───────────────────────┘
                       │
          ┌────────────┼────────────┐
          │            │            │
    ┌─────▼────┐  ┌───▼────┐  ┌──▼──────┐
    │PostgreSQL │  │MongoDB │  │Redis    │
    └──────────┘  └────────┘  └─────────┘
```

---

## 數據庫設計

### 核心 Entity 與關係

#### 1. Users (用戶)
```sql
CREATE TABLE users (
  id UUID PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  username VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(255),
  profile_picture_url VARCHAR(500),
  bio TEXT,
  country VARCHAR(100),
  dietary_preferences JSONB,  -- 飲食偏好
  account_type ENUM('individual', 'professional', 'admin'),
  is_verified BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP  -- 軟刪除
);
```

#### 2. Recipes (食譜)
```sql
CREATE TABLE recipes (
  id UUID PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  author_id UUID NOT NULL,
  country VARCHAR(100),
  region VARCHAR(100),
  cuisine_type VARCHAR(100),
  
  -- 烹飪信息
  difficulty_level ENUM('easy', 'medium', 'hard'),
  prep_time_minutes INT,
  cook_time_minutes INT,
  total_time_minutes INT,
  servings INT,
  
  -- 內容
  ingredients JSONB,  -- [{name, quantity, unit, notes}]
  instructions JSONB, -- [{step, description, image_url}]
  
  -- 多媒體
  thumbnail_url VARCHAR(500),
  images_urls TEXT[],
  video_url VARCHAR(500),
  
  -- 元信息
  is_published BOOLEAN DEFAULT false,
  view_count INT DEFAULT 0,
  average_rating DECIMAL(3, 2),
  tags TEXT[],
  cultural_story TEXT,  -- 美食背景故事
  
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP,
  
  FOREIGN KEY (author_id) REFERENCES users(id)
);

-- 索引優化
CREATE INDEX idx_recipes_country ON recipes(country);
CREATE INDEX idx_recipes_author_id ON recipes(author_id);
CREATE INDEX idx_recipes_cuisine_type ON recipes(cuisine_type);
CREATE INDEX idx_recipes_is_published ON recipes(is_published);
```

#### 3. Ingredients (食材)
```sql
CREATE TABLE ingredients (
  id UUID PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  english_name VARCHAR(255),
  description TEXT,
  country_of_origin VARCHAR(100),
  nutritional_info JSONB,  -- {calories, protein, fat, carbs, fiber}
  
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 食譜與食材的多對多關係
CREATE TABLE recipe_ingredients (
  id UUID PRIMARY KEY,
  recipe_id UUID NOT NULL,
  ingredient_id UUID NOT NULL,
  quantity DECIMAL(10, 2),
  unit VARCHAR(50),
  notes TEXT,
  
  FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
  FOREIGN KEY (ingredient_id) REFERENCES ingredients(id),
  UNIQUE(recipe_id, ingredient_id)
);
```

#### 4. Comments & Ratings (評論和評分)
```sql
CREATE TABLE comments (
  id UUID PRIMARY KEY,
  recipe_id UUID NOT NULL,
  author_id UUID NOT NULL,
  parent_comment_id UUID,  -- 用於支持嵌套評論
  
  content TEXT NOT NULL,
  rating INT CHECK (rating >= 1 AND rating <= 5),
  helpful_count INT DEFAULT 0,
  
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP,
  
  FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
  FOREIGN KEY (author_id) REFERENCES users(id),
  FOREIGN KEY (parent_comment_id) REFERENCES comments(id) ON DELETE CASCADE
);

CREATE INDEX idx_comments_recipe_id ON comments(recipe_id);
CREATE INDEX idx_comments_author_id ON comments(author_id);
```

#### 5. Recipe Collections (食譜收藏)
```sql
CREATE TABLE recipe_collections (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  is_public BOOLEAN DEFAULT false,
  
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE collection_recipes (
  id UUID PRIMARY KEY,
  collection_id UUID NOT NULL,
  recipe_id UUID NOT NULL,
  added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (collection_id) REFERENCES recipe_collections(id) ON DELETE CASCADE,
  FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
  UNIQUE(collection_id, recipe_id)
);
```

#### 6. Following/Followers (粉絲系統)
```sql
CREATE TABLE user_follows (
  id UUID PRIMARY KEY,
  follower_id UUID NOT NULL,
  following_id UUID NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (follower_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (following_id) REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE(follower_id, following_id),
  CHECK (follower_id != following_id)
);
```

#### 7. Cultural Stories (文化故事)
```sql
CREATE TABLE cultural_stories (
  id UUID PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  author_id UUID NOT NULL,
  
  country VARCHAR(100),
  related_recipe_ids UUID[],
  tags TEXT[],
  
  cover_image_url VARCHAR(500),
  media_urls TEXT[],  -- 視頻、圖片
  
  is_published BOOLEAN DEFAULT false,
  view_count INT DEFAULT 0,
  
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP,
  
  FOREIGN KEY (author_id) REFERENCES users(id)
);
```

#### 8. Food Locations (美食地點)
```sql
CREATE TABLE food_locations (
  id UUID PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  country VARCHAR(100) NOT NULL,
  region VARCHAR(100),
  latitude DECIMAL(10, 8),
  longitude DECIMAL(11, 8),
  
  description TEXT,
  cuisine_type VARCHAR(100),
  related_recipe_ids UUID[],
  
  created_by UUID,  -- 可選的用戶關聯
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (created_by) REFERENCES users(id)
);

-- 地理位置索引
CREATE INDEX idx_food_locations_country ON food_locations(country);
CREATE INDEX idx_food_locations_geo ON food_locations USING GIST(
  ll_to_earth(latitude, longitude)
);
```

#### 9. Shopping List (購物清單)
```sql
CREATE TABLE shopping_lists (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL,
  name VARCHAR(255) NOT NULL,
  recipe_id UUID,  -- 可選：基於特定食譜
  
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (recipe_id) REFERENCES recipes(id)
);

CREATE TABLE shopping_list_items (
  id UUID PRIMARY KEY,
  shopping_list_id UUID NOT NULL,
  ingredient_id UUID NOT NULL,
  quantity DECIMAL(10, 2),
  unit VARCHAR(50),
  is_checked BOOLEAN DEFAULT false,
  
  FOREIGN KEY (shopping_list_id) REFERENCES shopping_lists(id) ON DELETE CASCADE,
  FOREIGN KEY (ingredient_id) REFERENCES ingredients(id)
);
```

#### 10. Activity Feed / Notifications (活動日誌)
```sql
CREATE TABLE user_activities (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL,
  activity_type ENUM(
    'recipe_published',
    'comment_created',
    'recipe_liked',
    'user_followed',
    'story_published'
  ),
  
  target_id UUID,  -- 相關資源的 ID (recipe_id, comment_id 等)
  target_type VARCHAR(100),
  
  description TEXT,
  metadata JSONB,
  
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
```

### 數據庫設計說明

**為什麼選擇 PostgreSQL + MongoDB + Redis 的組合？**

| 數據庫 | 用途 | 優勢 |
|--------|------|------|
| **PostgreSQL** | 結構化數據（用戶、食譜、評論等）| ACID 事務、複雜查詢、強一致性 |
| **MongoDB** | 半結構化內容（食材詳情、步驟說明）| 靈活 Schema、易於擴展、嵌套數據 |
| **Redis** | 緩存、實時排行榜、會話存儲 | 超高性能、支持各種數據結構 |
| **Elasticsearch** | 全文搜索、日誌分析 | 快速搜索、聚合分析能力強 |

---

## 技術棧推薦

### 前端技術棧

#### Web 前端
```
框架層：
├─ Next.js 14+ (App Router)
│  ├─ 服務端渲染 (SSR)
│  ├─ 靜態生成 (SSG)
│  ├─ 增量靜態再生成 (ISR)
│  └─ API Routes

狀態管理：
├─ Zustand (輕量級) 或 Redux Toolkit (複雜場景)
├─ React Query (服務器狀態)
├─ SWR (數據獲取)

UI 組件庫：
├─ Shadcn/ui + Radix UI (無頭組件)
├─ Tailwind CSS (樣式)
├─ Framer Motion (動畫)

表格與列表：
├─ TanStack Table (數據表格)
├─ React Virtual (虛擬滾動)

文件上傳與媒體：
├─ Dropzone.js
├─ React Cropper (圖片裁剪)
├─ React Player (視頻播放)

表單管理：
├─ React Hook Form
├─ Zod (Schema 驗證)

地圖與地理：
├─ Mapbox GL JS 或 Leaflet
├─ Geospatial 查詢

多語言：
├─ i18next
├─ next-i18next

SEO 和元數據：
├─ next-seo
├─ Schema.org 結構化數據

測試：
├─ Vitest (單元測試)
├─ Playwright (E2E 測試)
├─ React Testing Library (組件測試)
```

#### 移動應用
```
跨平台方案：
├─ React Native (JS/TS)
└─ Expo (開發工具)

或

├─ Flutter (推薦用於高性能)
└─ Dart
```

### 後端技術棧

```
框架與運行時：
├─ Node.js 20+ LTS
├─ TypeScript 5.x
├─ Fastify 或 Express
   └─ 推薦 Fastify (性能更優)

ORM / 數據庫交互：
├─ Prisma (推薦)
│  ├─ 自動遷移
│  ├─ Type-safe 查詢
│  └─ 內置 Admin UI
├─ TypeORM (替代方案)
└─ Sequelize (傳統 ORM)

API 設計：
├─ REST API (主要)
├─ GraphQL (可選，用於複雜查詢)
│  ├─ Apollo Server
│  └─ GraphQL Codegen
├─ WebSocket (實時通知)
│  └─ Socket.io 或 ws

認證與授權：
├─ JWT (Token 認證)
├─ Passport.js (多策略認證)
├─ bcryptjs (密碼加密)
├─ Redis (Session 存儲)

文件存儲與媒體：
├─ AWS S3 / MinIO
├─ CloudFront (CDN)
├─ Sharp (圖片處理)

搜索引擎：
├─ Elasticsearch 7.x+
├─ Meilisearch (輕量級替代)

緩存：
├─ Redis 6.x+
├─ Redis 集群支持

消息隊列 (異步任務)：
├─ Bull (基於 Redis)
├─ RabbitMQ (大規模)
├─ Apache Kafka (流式處理)

日誌與監控：
├─ Winston (日誌)
├─ Pino (高性能日誌)
├─ ELK Stack (日誌聚合)
├─ Prometheus (指標)
├─ Grafana (可視化)
├─ Sentry (錯誤追蹤)

郵件服務：
├─ SendGrid
├─ Nodemailer

環境配置：
├─ dotenv
├─ joi (配置驗證)

驗證與中間件：
├─ joi / yup (數據驗證)
├─ helmet (安全頭)
├─ cors
├─ rate-limiter-flexible (速率限制)

測試：
├─ Jest (單元測試)
├─ Supertest (API 測試)
├─ testcontainers (集成測試)

文檔：
├─ Swagger / OpenAPI
├─ Redoc (API 文檔)
```

### 基礎設施與部署

```
容器化：
├─ Docker
├─ Docker Compose (本地開發)

編排：
├─ Kubernetes (K8s)
├─ Docker Swarm (輕量級)
├─ Helm (K8s 包管理)

雲平台：
├─ AWS
│  ├─ EC2 / ECS (計算)
│  ├─ RDS (PostgreSQL)
│  ├─ ElastiCache (Redis)
│  ├─ S3 (存儲)
│  └─ CloudFront (CDN)
├─ Google Cloud
├─ Azure
└─ DigitalOcean (中小型)

CI/CD：
├─ GitHub Actions
├─ GitLab CI
├─ Jenkins

監控與日誌：
├─ DataDog
├─ New Relic
├─ ELK Stack 自建
```

### 推薦的技術棧組合

#### **最現代化方案 (推薦)**
```
前端：
- Next.js 14 + React 18 + TypeScript
- Tailwind CSS + Shadcn/ui
- Zustand + React Query
- Mapbox GL JS

後端：
- Node.js + TypeScript
- Fastify (或 Express)
- Prisma ORM
- PostgreSQL + MongoDB + Redis
- Elasticsearch

部署：
- Docker + Kubernetes
- GitHub Actions
- AWS (or similar)
```

#### **平衡方案**
```
前端：
- Next.js 14 + React 18
- TailwindCSS
- Redux Toolkit (複雜場景)

後端：
- Express + TypeScript
- Prisma ORM
- PostgreSQL + Redis
- Meilisearch (簡化搜索)

部署：
- Docker Compose
- DigitalOcean 或 AWS
- GitHub Actions
```

---

## 開發路線圖

### Phase 1: MVP (2-3 個月)
- [x] 項目架構設計
- [ ] 用戶認證與授權系統
- [ ] 基本食譜 CRUD
- [ ] 搜索和過濾功能
- [ ] 評論和評分系統
- [ ] 基礎用戶檔案

### Phase 2: 核心功能 (3-4 個月)
- [ ] 社群功能 (粉絲系統、活動日誌)
- [ ] 食譜收藏
- [ ] 多語言支持
- [ ] 高級推薦系統
- [ ] 文化故事模塊

### Phase 3: 增強功能 (2-3 個月)
- [ ] 美食地圖
- [ ] 購物清單生成
- [ ] 視頻教程上傳
- [ ] 移動應用
- [ ] 實時通知系統

### Phase 4: 優化與擴展 (持續)
- [ ] 性能優化
- [ ] SEO 優化
- [ ] A/B 測試
- [ ] 用戶分析
- [ ] 高級推薦算法

---

## 安全性考慮

### 認證與授權
- ✅ JWT Token + Refresh Token
- ✅ OAuth 2.0 (Google, Facebook, GitHub)
- ✅ 雙因素認證 (2FA)
- ✅ 密碼加密存儲 (bcryptjs, argon2)

### 數據保護
- ✅ HTTPS/TLS
- ✅ SQL 注入防護 (使用 Parameterized Queries)
- ✅ CORS 配置
- ✅ 速率限制
- ✅ CSRF 防護

### 內容安全
- ✅ XSS 防護 (Content Security Policy)
- ✅ 文件上傳驗證
- ✅ 內容審核系統
- ✅ 舉報與禁言機制

### 基礎設施安全
- ✅ DDoS 防護
- ✅ 環境變數管理
- ✅ 定期安全審計
- ✅ 備份與災難恢復

---

## 相關文件

- [API 設計文檔](./API_DESIGN.md) (待建立)
- [前端架構詳細](./FRONTEND_ARCHITECTURE.md) (待建立)
- [後端架構詳細](./BACKEND_ARCHITECTURE.md) (待建立)
- [數據庫遷移策略](./DATABASE_MIGRATIONS.md) (待建立)
- [部署指南](./DEPLOYMENT.md) (待建立)

---

**文檔版本**：1.0  
**最後更新**：2026-06-22  
**作者**：架構設計團隊
