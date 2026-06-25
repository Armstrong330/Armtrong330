# 「味蕾無國界」- API 設計文檔

## 📋 目錄
1. [API 概述](#api-概述)
2. [認證 API](#認證-api)
3. [用戶管理 API](#用戶管理-api)
4. [食譜管理 API](#食譜管理-api)
5. [社群互動 API](#社群互動-api)
6. [搜索與發現 API](#搜索與發現-api)
7. [地圖與地理 API](#地圖與地理-api)
8. [文化故事 API](#文化故事-api)
9. [錯誤處理](#錯誤處理)
10. [速率限制](#速率限制)

---

## API 概述

### 基本信息
- **基礎 URL**：`https://api.tastewithoutborders.com/v1`
- **認證方式**：JWT Bearer Token
- **請求格式**：JSON
- **響應格式**：JSON
- **版本控制**：REST API v1

### API 版本控制策略
```
v1/  - 初始版本
v2/  - 後續重要更新（保持向後兼容）
```

---

## 認證 API

### 用戶註冊
```http
POST /auth/register
Content-Type: application/json

{
  "email": "user@example.com",
  "username": "john_chef",
  "password": "SecurePassword123!",
  "country": "Taiwan",
  "language": "zh"
}

Response 201 Created:
{
  "success": true,
  "data": {
    "id": "uuid",
    "email": "user@example.com",
    "username": "john_chef",
    "createdAt": "2026-06-22T10:00:00Z"
  },
  "message": "註冊成功，請檢查郵件驗證"
}
```

### 用戶登入
```http
POST /auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "SecurePassword123!"
}

Response 200 OK:
{
  "success": true,
  "data": {
    "accessToken": "eyJhbGc...",
    "refreshToken": "eyJhbGc...",
    "expiresIn": 3600,
    "user": {
      "id": "uuid",
      "email": "user@example.com",
      "username": "john_chef",
      "role": "individual"
    }
  }
}
```

### 刷新 Token
```http
POST /auth/refresh
Content-Type: application/json

{
  "refreshToken": "eyJhbGc..."
}

Response 200 OK:
{
  "success": true,
  "data": {
    "accessToken": "eyJhbGc...",
    "expiresIn": 3600
  }
}
```

### 登出
```http
POST /auth/logout
Authorization: Bearer {accessToken}

Response 200 OK:
{
  "success": true,
  "message": "已登出"
}
```

### 發送密碼重置郵件
```http
POST /auth/forgot-password
Content-Type: application/json

{
  "email": "user@example.com"
}

Response 200 OK:
{
  "success": true,
  "message": "已發送密碼重置連結到郵箱"
}
```

### 重置密碼
```http
POST /auth/reset-password
Content-Type: application/json

{
  "token": "reset_token_from_email",
  "newPassword": "NewSecurePassword123!"
}

Response 200 OK:
{
  "success": true,
  "message": "密碼已重置"
}
```

---

## 用戶管理 API

### 獲取用戶檔案
```http
GET /users/{userId}
Authorization: Bearer {accessToken}

Response 200 OK:
{
  "success": true,
  "data": {
    "id": "uuid",
    "email": "user@example.com",
    "username": "john_chef",
    "bio": "家庭廚師，喜歡亞洲美食",
    "profilePicture": "https://cdn.example.com/...",
    "country": "Taiwan",
    "accountType": "individual",
    "isVerified": true,
    "dietaryPreferences": {
      "vegetarian": false,
      "vegan": false,
      "glutenFree": false,
      "allergies": ["shellfish"]
    },
    "stats": {
      "recipesCount": 42,
      "followersCount": 156,
      "followingCount": 89,
      "collectionsCount": 12
    },
    "joinedAt": "2024-01-15T08:00:00Z"
  }
}
```

### 更新用戶檔案
```http
PUT /users/{userId}
Authorization: Bearer {accessToken}
Content-Type: application/json

{
  "bio": "更新的個人介紹",
  "country": "Taiwan",
  "dietaryPreferences": {
    "vegetarian": true,
    "allergies": ["shellfish", "peanuts"]
  }
}

Response 200 OK:
{
  "success": true,
  "data": { /* 更新後的用戶信息 */ }
}
```

### 上傳個人頭像
```http
POST /users/{userId}/avatar
Authorization: Bearer {accessToken}
Content-Type: multipart/form-data

formData:
  file: <binary image data>
  size: <max 5MB>

Response 200 OK:
{
  "success": true,
  "data": {
    "url": "https://cdn.example.com/avatars/...",
    "uploadedAt": "2026-06-22T10:00:00Z"
  }
}
```

### 獲取用戶的食譜列表
```http
GET /users/{userId}/recipes
Query Parameters:
  - page: 1
  - limit: 20
  - sort: newest|popular|rating
  - filter: published|draft|all

Response 200 OK:
{
  "success": true,
  "data": {
    "recipes": [
      {
        "id": "uuid",
        "title": "紅燒肉",
        "thumbnail": "https://...",
        "rating": 4.8,
        "viewCount": 1250,
        "createdAt": "2026-06-20T10:00:00Z"
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 42,
      "pages": 3
    }
  }
}
```

---

## 食譜管理 API

### 建立新食譜 (草稿)
```http
POST /recipes
Authorization: Bearer {accessToken}
Content-Type: application/json

{
  "title": "宮保雞丁",
  "description": "經典川菜",
  "country": "China",
  "region": "Sichuan",
  "cuisineType": "Sichuan Cuisine",
  "difficultyLevel": "medium",
  "prepTimeMinutes": 20,
  "cookTimeMinutes": 15,
  "servings": 4,
  "culturalStory": "這道菜源自晚清四川...",
  "ingredients": [
    {
      "name": "雞胸肉",
      "quantity": 500,
      "unit": "克",
      "notes": "切成丁"
    },
    {
      "name": "花生",
      "quantity": 100,
      "unit": "克",
      "notes": "去皮"
    }
  ],
  "instructions": [
    {
      "step": 1,
      "description": "將雞胸肉切成丁，用少許鹽和澱粉醃製",
      "imageUrl": null
    },
    {
      "step": 2,
      "description": "熱油鍋，爆香豆瓣醬和乾辣椒",
      "imageUrl": null
    }
  ],
  "tags": ["四川菜", "雞肉", "快手菜"],
  "isDraft": true
}

Response 201 Created:
{
  "success": true,
  "data": {
    "id": "uuid",
    "title": "宮保雞丁",
    "authorId": "uuid",
    "isDraft": true,
    "createdAt": "2026-06-22T10:00:00Z"
  }
}
```

### 獲取食譜詳情
```http
GET /recipes/{recipeId}
Authorization: Bearer {accessToken} (可選)

Response 200 OK:
{
  "success": true,
  "data": {
    "id": "uuid",
    "title": "宮保雞丁",
    "description": "經典川菜",
    "author": {
      "id": "uuid",
      "username": "chef_wang",
      "profilePicture": "https://...",
      "isFollowed": false
    },
    "country": "China",
    "region": "Sichuan",
    "cuisineType": "Sichuan Cuisine",
    "difficultyLevel": "medium",
    "prepTimeMinutes": 20,
    "cookTimeMinutes": 15,
    "totalTimeMinutes": 35,
    "servings": 4,
    "ingredients": [...],
    "instructions": [...],
    "culturalStory": "這道菜源自晚清四川...",
    "images": [
      {
        "url": "https://...",
        "alt": "成品圖"
      }
    ],
    "videoUrl": "https://youtube.com/...",
    "averageRating": 4.8,
    "reviewsCount": 156,
    "viewCount": 2500,
    "tags": ["四川菜", "雞肉"],
    "isBookmarked": false,
    "userRating": null,
    "createdAt": "2026-06-20T10:00:00Z",
    "updatedAt": "2026-06-21T15:30:00Z"
  }
}
```

### 更新食譜
```http
PUT /recipes/{recipeId}
Authorization: Bearer {accessToken}
Content-Type: application/json

{
  "title": "宮保雞丁 (更新版)",
  "description": "改進的川菜配方",
  "instructions": [
    /* 更新的步驟 */
  ],
  /* 其他要更新的字段 */
}

Response 200 OK:
{
  "success": true,
  "data": { /* 更新後的食譜 */ }
}
```

### 發布食譜
```http
POST /recipes/{recipeId}/publish
Authorization: Bearer {accessToken}

Response 200 OK:
{
  "success": true,
  "data": {
    "id": "uuid",
    "isDraft": false,
    "isPublished": true,
    "publishedAt": "2026-06-22T10:00:00Z"
  }
}
```

### 刪除食譜
```http
DELETE /recipes/{recipeId}
Authorization: Bearer {accessToken}

Response 204 No Content
```

### 上傳食譜圖片
```http
POST /recipes/{recipeId}/images
Authorization: Bearer {accessToken}
Content-Type: multipart/form-data

formData:
  file: <binary image data>
  alt: "成品圖"
  position: 1

Response 200 OK:
{
  "success": true,
  "data": {
    "url": "https://cdn.example.com/recipes/...",
    "alt": "成品圖",
    "position": 1
  }
}
```

---

## 社群互動 API

### 發表評論
```http
POST /recipes/{recipeId}/comments
Authorization: Bearer {accessToken}
Content-Type: application/json

{
  "content": "這道菜做得真棒！我加了一點蜂蜜味道更好",
  "rating": 5,
  "parentCommentId": null  // 用於回覆評論
}

Response 201 Created:
{
  "success": true,
  "data": {
    "id": "uuid",
    "content": "這道菜做得真棒！...",
    "author": {
      "id": "uuid",
      "username": "cook_lily",
      "profilePicture": "https://..."
    },
    "rating": 5,
    "helpfulCount": 0,
    "createdAt": "2026-06-22T10:00:00Z"
  }
}
```

### 獲取食譜評論
```http
GET /recipes/{recipeId}/comments
Query Parameters:
  - page: 1
  - limit: 20
  - sort: newest|helpful|rating

Response 200 OK:
{
  "success": true,
  "data": {
    "comments": [
      {
        "id": "uuid",
        "content": "...",
        "author": {...},
        "rating": 5,
        "helpfulCount": 42,
        "replies": [
          {
            "id": "uuid",
            "content": "...",
            "author": {...}
          }
        ],
        "createdAt": "2026-06-22T10:00:00Z"
      }
    ],
    "pagination": {...}
  }
}
```

### 標記評論有幫助
```http
POST /comments/{commentId}/helpful
Authorization: Bearer {accessToken}

Response 200 OK:
{
  "success": true,
  "data": {
    "id": "uuid",
    "helpfulCount": 43
  }
}
```

### 取消標記
```http
DELETE /comments/{commentId}/helpful
Authorization: Bearer {accessToken}

Response 200 OK:
```

### 關注用戶
```http
POST /users/{userId}/follow
Authorization: Bearer {accessToken}

Response 200 OK:
{
  "success": true,
  "data": {
    "isFollowing": true,
    "followerCount": 157
  }
}
```

### 取消關注
```http
DELETE /users/{userId}/follow
Authorization: Bearer {accessToken}

Response 200 OK:
{
  "success": true,
  "data": {
    "isFollowing": false,
    "followerCount": 156
  }
}
```

### 獲取粉絲列表
```http
GET /users/{userId}/followers
Query Parameters:
  - page: 1
  - limit: 20

Response 200 OK:
{
  "success": true,
  "data": {
    "followers": [
      {
        "id": "uuid",
        "username": "cook_lily",
        "profilePicture": "https://...",
        "isFollowed": false
      }
    ],
    "pagination": {...}
  }
}
```

### 加入收藏
```http
POST /recipes/{recipeId}/bookmark
Authorization: Bearer {accessToken}

Response 200 OK:
{
  "success": true,
  "data": {
    "id": "uuid",
    "isBookmarked": true
  }
}
```

### 取消收藏
```http
DELETE /recipes/{recipeId}/bookmark
Authorization: Bearer {accessToken}

Response 200 OK:
```

---

## 搜索與發現 API

### 高級搜索
```http
GET /recipes/search
Query Parameters:
  - q: 搜尋關鍵字
  - country: 國家代碼
  - cuisineType: 菜系
  - difficultyLevel: easy|medium|hard
  - cookTimeMax: 60 (分鐘)
  - ingredients: 食材1,食材2
  - tags: 標籤1,標籤2
  - sortBy: newest|popular|rating|relevance
  - page: 1
  - limit: 20

Response 200 OK:
{
  "success": true,
  "data": {
    "recipes": [
      {
        "id": "uuid",
        "title": "宮保雞丁",
        "description": "...",
        "thumbnail": "https://...",
        "author": {...},
        "country": "China",
        "cuisineType": "Sichuan",
        "difficultyLevel": "medium",
        "cookTimeMinutes": 15,
        "averageRating": 4.8,
        "viewCount": 2500
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 850,
      "pages": 43
    },
    "filters": {
      "countries": ["China", "Japan", "Thailand"],
      "cuisineTypes": ["Sichuan", "Cantonese", "Hunan"],
      "difficultyLevels": ["easy", "medium", "hard"]
    }
  }
}
```

### 獲取推薦食譜
```http
GET /recipes/recommendations
Query Parameters:
  - limit: 20
  - type: personalized|trending|new

Authorization: Bearer {accessToken} (用於個性化推薦)

Response 200 OK:
{
  "success": true,
  "data": {
    "recipes": [
      {
        "id": "uuid",
        "title": "...",
        "reason": "基於您的飲食偏好推薦",
        /* 其他字段 */
      }
    ]
  }
}
```

### 獲取趨勢食譜
```http
GET /recipes/trending
Query Parameters:
  - timeRange: day|week|month
  - country: 國家篩選 (可選)
  - limit: 20

Response 200 OK:
{
  "success": true,
  "data": {
    "recipes": [...],
    "timeRange": "week",
    "generatedAt": "2026-06-22T10:00:00Z"
  }
}
```

### 食材自動完成
```http
GET /ingredients/autocomplete
Query Parameters:
  - q: 搜尋文字
  - language: zh|en

Response 200 OK:
{
  "success": true,
  "data": {
    "suggestions": [
      {
        "id": "uuid",
        "name": "雞胸肉",
        "englishName": "Chicken Breast",
        "icon": "🍗"
      }
    ]
  }
}
```

---

## 地圖與地理 API

### 獲取美食地點列表
```http
GET /locations
Query Parameters:
  - country: 國家代碼
  - region: 地區
  - cuisineType: 菜系
  - bounds: minLat,maxLat,minLng,maxLng (地圖邊界)
  - limit: 50

Response 200 OK:
{
  "success": true,
  "data": {
    "locations": [
      {
        "id": "uuid",
        "name": "四川菜館",
        "country": "China",
        "region": "Sichuan",
        "latitude": 30.5728,
        "longitude": 104.0666,
        "cuisineType": "Sichuan Cuisine",
        "description": "正宗川菜館",
        "relatedRecipes": [
          {
            "id": "uuid",
            "title": "宮保雞丁"
          }
        ]
      }
    ]
  }
}
```

### 建立新地點
```http
POST /locations
Authorization: Bearer {accessToken}
Content-Type: application/json

{
  "name": "四川菜館",
  "country": "China",
  "region": "Sichuan",
  "latitude": 30.5728,
  "longitude": 104.0666,
  "cuisineType": "Sichuan Cuisine",
  "description": "正宗川菜館"
}

Response 201 Created:
{
  "success": true,
  "data": {
    "id": "uuid",
    "name": "四川菜館",
    /* 其他字段 */
  }
}
```

---

## 文化故事 API

### 建立文化故事
```http
POST /stories
Authorization: Bearer {accessToken}
Content-Type: application/json

{
  "title": "紅燒肉的故事",
  "content": "紅燒肉是中國菜系中最經典的菜肴之一...",
  "country": "China",
  "coverImage": "https://...",
  "mediaUrls": ["https://...video"],
  "relatedRecipeIds": ["uuid1", "uuid2"],
  "tags": ["四川菜", "歷史", "傳統"]
}

Response 201 Created:
{
  "success": true,
  "data": {
    "id": "uuid",
    "title": "紅燒肉的故事",
    /* 其他字段 */
  }
}
```

### 獲取故事列表
```http
GET /stories
Query Parameters:
  - country: 國家篩選
  - tags: 標籤篩選
  - sort: newest|popular
  - page: 1
  - limit: 20

Response 200 OK:
{
  "success": true,
  "data": {
    "stories": [
      {
        "id": "uuid",
        "title": "...",
        "excerpt": "前 200 字...",
        "country": "China",
        "coverImage": "https://...",
        "author": {...},
        "viewCount": 1250,
        "createdAt": "2026-06-20T10:00:00Z"
      }
    ],
    "pagination": {...}
  }
}
```

### 獲取故事詳情
```http
GET /stories/{storyId}

Response 200 OK:
{
  "success": true,
  "data": {
    "id": "uuid",
    "title": "紅燒肉的故事",
    "content": "...",
    "author": {...},
    "viewCount": 1250,
    "relatedRecipes": [...],
    "createdAt": "2026-06-20T10:00:00Z"
  }
}
```

---

## 錯誤處理

### 標準錯誤響應格式
```json
{
  "success": false,
  "error": {
    "code": "RECIPE_NOT_FOUND",
    "message": "食譜不存在",
    "details": "未找到 ID 為 'uuid' 的食譜",
    "timestamp": "2026-06-22T10:00:00Z",
    "path": "/v1/recipes/uuid"
  }
}
```

### 常見錯誤碼

| HTTP Status | Error Code | 說明 |
|-------------|-----------|------|
| 400 | INVALID_REQUEST | 請求參數無效 |
| 401 | UNAUTHORIZED | 未授權，需要登入 |
| 403 | FORBIDDEN | 禁止訪問 |
| 404 | NOT_FOUND | 資源不存在 |
| 409 | CONFLICT | 資源衝突（如重複用戶名） |
| 422 | VALIDATION_ERROR | 數據驗證失敗 |
| 429 | RATE_LIMIT_EXCEEDED | 請求過於頻繁 |
| 500 | INTERNAL_SERVER_ERROR | 服務器內部錯誤 |

---

## 速率限制

### 限制規則

| 端點類型 | 限制 | 時間窗口 |
|---------|------|---------|
| 認證端點 | 5 次 | 5 分鐘 |
| 搜尋端點 | 60 次 | 1 分鐘 |
| 寫入端點 (POST/PUT) | 30 次 | 1 分鐘 |
| 一般端點 | 100 次 | 1 分鐘 |
| 刪除端點 | 10 次 | 1 小時 |

### 速率限制響應頭
```
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1687419600
```

---

**文檔版本**：1.0  
**最後更新**：2026-06-22
