# 「味蕾無國界」- 後端架構與部署指南

## 📋 目錄
1. [後端項目結構](#後端項目結構)
2. [核心技術棧](#核心技術棧)
3. [服務架構](#服務架構)
4. [數據庫層設計](#數據庫層設計)
5. [認證與授權](#認證與授權)
6. [緩存策略](#緩存策略)
7. [搜索實現](#搜索實現)
8. [文件上傳與CDN](#文件上傳與cdn)
9. [監控與日誌](#監控與日誌)
10. [部署指南](#部署指南)

---

## 後端項目結構

```
tastefwb-backend/
├── src/
│   ├── main.ts                    # 應用入口
│   ├── app.module.ts              # 根模塊
│   ├── app.service.ts
│   └── app.controller.ts
│   │
│   ├── config/
│   │   ├── database.config.ts      # 數據庫配置
│   │   ├── redis.config.ts         # Redis 配置
│   │   ├── environment.ts          # 環境配置
│   │   ├── swagger.config.ts       # Swagger/OpenAPI 配置
│   │   └── constants.ts
│   │
│   ├── modules/
│   │   ├── auth/
│   │   │   ├── auth.module.ts
│   │   │   ├── auth.controller.ts
│   │   │   ├── auth.service.ts
│   │   │   ├── auth.guard.ts
│   │   │   ├── jwt.strategy.ts
│   │   │   ├── local.strategy.ts
│   │   │   └── dto/
│   │   │       ├── login.dto.ts
│   │   │       └── register.dto.ts
│   │   │
│   │   ├── users/
│   │   │   ├── users.module.ts
│   │   │   ├── users.controller.ts
│   │   │   ├── users.service.ts
│   │   │   ├── user.entity.ts
│   │   │   ├── users.repository.ts
│   │   │   └── dto/
│   │   │       ├── create-user.dto.ts
│   │   │       └── update-user.dto.ts
│   │   │
│   │   ├── recipes/
│   │   │   ├── recipes.module.ts
│   │   │   ├── recipes.controller.ts
│   │   │   ├── recipes.service.ts
│   │   │   ├── recipe.entity.ts
│   │   │   ├── recipes.repository.ts
│   │   │   ├── comments/
│   │   │   │   ├── comment.entity.ts
│   │   │   │   └── comment.service.ts
│   │   │   └── dto/
│   │   │       ├── create-recipe.dto.ts
│   │   │       └── update-recipe.dto.ts
│   │   │
│   │   ├── ingredients/
│   │   │   ├── ingredients.module.ts
│   │   │   ├── ingredients.controller.ts
│   │   │   ├── ingredients.service.ts
│   │   │   ├── ingredient.entity.ts
│   │   │   └── ingredients.repository.ts
│   │   │
│   │   ├── search/
│   │   │   ├── search.module.ts
│   │   │   ├── search.service.ts
│   │   │   ├── search.controller.ts
│   │   │   └── elasticsearch.service.ts
│   │   │
│   │   ├── locations/
│   │   │   ├── locations.module.ts
│   │   │   ├── locations.controller.ts
│   │   │   ├── locations.service.ts
│   │   │   ├── location.entity.ts
│   │   │   └── locations.repository.ts
│   │   │
│   │   ├── stories/
│   │   │   ├── stories.module.ts
│   │   │   ├── stories.controller.ts
│   │   │   ├── stories.service.ts
│   │   │   ├── story.entity.ts
│   │   │   └── stories.repository.ts
│   │   │
│   │   ├── recommendations/
│   │   │   ├── recommendations.module.ts
│   │   │   ├── recommendations.service.ts
│   │   │   ├── recommendation.controller.ts
│   │   │   └── recommendation.engine.ts
│   │   │
│   │   ├── notifications/
│   │   │   ├── notifications.module.ts
│   │   │   ├── notifications.service.ts
│   │   │   ├── notifications.gateway.ts   # WebSocket
│   │   │   └── notification.entity.ts
│   │   │
│   │   ├── files/
│   │   │   ├── files.module.ts
│   │   │   ├── files.service.ts
│   │   │   ├── s3.service.ts
│   │   │   └── files.controller.ts
│   │   │
│   │   └── admin/
│   │       ├── admin.module.ts
│   │       ├── admin.controller.ts
│   │       ├── admin.service.ts
│   │       └── moderation/
│   │           └── content-moderation.service.ts
│   │
│   ├── common/
│   │   ├── decorators/
│   │   │   ├── current-user.decorator.ts
│   │   │   ├── roles.decorator.ts
│   │   │   └── rate-limit.decorator.ts
│   │   │
│   │   ├── filters/
│   │   │   ├── http-exception.filter.ts
│   │   │   └── all-exceptions.filter.ts
│   │   │
│   │   ├── interceptors/
│   │   │   ├── logging.interceptor.ts
│   │   │   ├── transform.interceptor.ts
│   │   │   └── error.interceptor.ts
│   │   │
│   │   ├── middleware/
│   │   │   ├── logging.middleware.ts
│   │   │   ├── cors.middleware.ts
│   │   │   └── rate-limiter.middleware.ts
│   │   │
│   │   ├── guards/
│   │   │   ├── jwt.guard.ts
│   │   │   ├── roles.guard.ts
│   │   │   └── rate-limit.guard.ts
│   │   │
│   │   ├── pipes/
│   │   │   ├── validation.pipe.ts
│   │   │   └── parse-uuid.pipe.ts
│   │   │
│   │   └── utils/
│   │       ├── logger.ts
│   │       ├── exception-factory.ts
│   │       └── helpers.ts
│   │
│   ├── database/
│   │   ├── migrations/
│   │   │   ├── 001_create_users_table.ts
│   │   │   ├── 002_create_recipes_table.ts
│   │   │   └── ...
│   │   │
│   │   ├── seeders/
│   │   │   ├── users.seeder.ts
│   │   │   ├── recipes.seeder.ts
│   │   │   └── ingredients.seeder.ts
│   │   │
│   │   └── factories/
│   │       ├── user.factory.ts
│   │       └── recipe.factory.ts
│   │
│   ├── queue/
│   │   ├── email.queue.ts
│   │   ├── image-processing.queue.ts
│   │   └── analytics.queue.ts
│   │
│   └── tests/
│       ├── unit/
│       ├── integration/
│       └── e2e/
│
├── docker/
│   ├── Dockerfile
│   ├── Dockerfile.prod
│   └── docker-compose.yml
│
├── .env.example
├── .env.local
├── .eslintrc.json
├── .prettierrc
├── tsconfig.json
├── nest-cli.json
├── package.json
└── README.md
```

---

## 核心技術棧

### 推薦的後端框架與庫

```
Node.js 運行時：
- Node.js 20+ LTS
- TypeScript 5.x

框架與核心庫：
├─ NestJS 10.x (推薦)
│  ├─ @nestjs/core
│  ├─ @nestjs/common
│  └─ @nestjs/platform-fastify (使用 Fastify 而非 Express)
│
├─ 或 Express.js + ts-node (輕量級替代)
│  └─ express-async-errors

ORM：
├─ Prisma 5.x (推薦)
│  ├─ @prisma/client
│  └─ prisma (CLI)

數據庫驅動：
├─ pg (PostgreSQL)
├─ mongodb (MongoDB 驅動)
├─ redis (Redis 驅動)

API 和驗證：
├─ @nestjs/jwt
├─ @nestjs/passport
├─ passport-jwt
├─ bcryptjs
├─ joi (數據驗證)

搜索引擎：
├─ @nestjs/elasticsearch
├─ @elastic/elasticsearch

緩存：
├─ redis
├─ ioredis (推薦)
├─ @nestjs/cache-manager

消息隊列：
├─ bull
├─ @nestjs/bull
├─ bullmq (下一代)

文件上傳：
├─ aws-sdk / @aws-sdk/client-s3
├─ sharp (圖片處理)
├─ multer

實時通信：
├─ socket.io
├─ @nestjs/websockets

監控與日誌：
├─ winston
├─ @nestjs/common Logger
├─ pino
├─ datadog-api-client

測試：
├─ jest
├─ @nestjs/testing
├─ supertest

文檔：
├─ @nestjs/swagger
├─ swagger-ui-express

環境配置：
├─ @nestjs/config
├─ dotenv

其他工具：
├─ class-validator
├─ class-transformer
├─ uuid
├─ date-fns
├─ lodash
```

---

## 服務架構

### 分層架構 (Layered Architecture)

```
┌────────────────────────────────────────┐
│         API Layer (Controller)          │
│  - HTTP 請求/響應處理                   │
│  - 輸入驗證                             │
│  - 響應序列化                           │
└────────────┬─────────────────────────────┘
             │
┌────────────▼─────────────────────────────┐
│       Business Logic Layer (Service)     │
│  - 業務規則實現                          │
│  - 事務管理                             │
│  - 數據編排                             │
└────────────┬─────────────────────────────┘
             │
┌────────────▼─────────────────────────────┐
│       Data Access Layer (Repository)     │
│  - 數據查詢                              │
│  - 數據持久化                           │
│  - ORM 交互                             │
└────────────┬─────────────────────────────┘
             │
    ┌────────┼────────┬──────────┐
    │        │        │          │
┌───▼──┐ ┌──▼───┐ ┌─▼────┐ ┌───▼────┐
│ PG   │ │ Mongo│ │ Redis│ │ES/Kafka│
└──────┘ └──────┘ └──────┘ └────────┘
```

### 服務示例 - RecipeService

```typescript
import { Injectable, NotFoundException } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { RecipesRepository } from './recipes.repository';
import { SearchService } from '../search/search.service';
import { CreateRecipeDto, UpdateRecipeDto } from './dto';

@Injectable()
export class RecipesService {
  constructor(
    private readonly recipesRepository: RecipesRepository,
    private readonly searchService: SearchService,
  ) {}

  async createRecipe(
    authorId: string,
    createRecipeDto: CreateRecipeDto,
  ): Promise<Recipe> {
    const recipe = await this.recipesRepository.create({
      ...createRecipeDto,
      authorId,
      isDraft: true,
    });

    return recipe;
  }

  async updateRecipe(
    recipeId: string,
    userId: string,
    updateRecipeDto: UpdateRecipeDto,
  ): Promise<Recipe> {
    const recipe = await this.recipesRepository.findById(recipeId);
    
    if (!recipe) {
      throw new NotFoundException('Recipe not found');
    }
    
    if (recipe.authorId !== userId) {
      throw new ForbiddenException('Not authorized to update this recipe');
    }

    return this.recipesRepository.update(recipeId, updateRecipeDto);
  }

  async publishRecipe(recipeId: string, userId: string): Promise<Recipe> {
    const recipe = await this.recipesRepository.findById(recipeId);
    
    if (recipe.authorId !== userId) {
      throw new ForbiddenException();
    }

    const updated = await this.recipesRepository.update(recipeId, {
      isDraft: false,
      isPublished: true,
      publishedAt: new Date(),
    });

    // 索引到搜索引擎
    await this.searchService.indexRecipe(updated);

    return updated;
  }

  async searchRecipes(
    filters: RecipeSearchFilters,
    pagination: PaginationParams,
  ): Promise<PaginatedResponse<Recipe>> {
    return this.searchService.searchRecipes(filters, pagination);
  }

  async getRecipeById(id: string): Promise<Recipe> {
    const recipe = await this.recipesRepository.findById(id);
    
    if (!recipe) {
      throw new NotFoundException();
    }

    // 增加瀏覽次數
    await this.recipesRepository.incrementViewCount(id);

    return recipe;
  }

  async deleteRecipe(recipeId: string, userId: string): Promise<void> {
    const recipe = await this.recipesRepository.findById(recipeId);
    
    if (recipe.authorId !== userId) {
      throw new ForbiddenException();
    }

    await this.recipesRepository.softDelete(recipeId);
    
    // 從搜索引擎移除
    await this.searchService.removeRecipe(recipeId);
  }
}
```

---

## 數據庫層設計

### Prisma Schema 核心部分

```prisma
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

generator client {
  provider = "prisma-client-js"
}

model User {
  id                    String     @id @default(uuid())
  email                 String     @unique
  username              String     @unique
  passwordHash          String
  profilePictureUrl     String?
  bio                   String?
  country               String?
  dietaryPreferences    Json?      // {vegetarian, vegan, allergies[]}
  accountType           String     @default("individual")
  isVerified            Boolean    @default(false)
  
  recipes               Recipe[]
  comments              Comment[]
  followers             UserFollow[] @relation("followers")
  following             UserFollow[] @relation("following")
  collections           RecipeCollection[]
  
  createdAt             DateTime   @default(now())
  updatedAt             DateTime   @updatedAt
  deletedAt             DateTime?
  
  @@index([email])
  @@index([username])
}

model Recipe {
  id                    String     @id @default(uuid())
  title                 String     @db.VarChar(255)
  description           String?
  authorId              String
  author                User       @relation(fields: [authorId], references: [id])
  
  country               String?
  region                String?
  cuisineType           String?
  
  difficultyLevel       String     @default("medium")
  prepTimeMinutes       Int?
  cookTimeMinutes       Int?
  totalTimeMinutes      Int?
  servings              Int        @default(4)
  
  ingredients           RecipeIngredient[]
  instructions          Json?      // [{step, description, imageUrl}]
  
  thumbnailUrl          String?
  imagesUrls            String[]
  videoUrl              String?
  
  isPublished           Boolean    @default(false)
  isDraft               Boolean    @default(true)
  viewCount             Int        @default(0)
  averageRating         Decimal    @db.Decimal(3, 2) @default(0)
  
  tags                  String[]
  culturalStory         String?
  
  comments              Comment[]
  
  createdAt             DateTime   @default(now())
  updatedAt             DateTime   @updatedAt
  publishedAt           DateTime?
  deletedAt             DateTime?
  
  @@index([authorId])
  @@index([country])
  @@index([cuisineType])
  @@index([isPublished])
  @@index([createdAt])
  @@fulltext([title, description, tags]) // 全文搜索
}

model Comment {
  id                    String     @id @default(uuid())
  recipeId              String
  recipe                Recipe     @relation(fields: [recipeId], references: [id])
  authorId              String
  author                User       @relation(fields: [authorId], references: [id])
  parentCommentId       String?
  parent                Comment?   @relation("replies", fields: [parentCommentId], references: [id])
  replies               Comment[]  @relation("replies")
  
  content               String     @db.Text
  rating                Int?       @db.SmallInt
  helpfulCount          Int        @default(0)
  
  createdAt             DateTime   @default(now())
  updatedAt             DateTime   @updatedAt
  deletedAt             DateTime?
  
  @@index([recipeId])
  @@index([authorId])
  @@index([parentCommentId])
}

model UserFollow {
  id                    String     @id @default(uuid())
  followerId            String
  follower              User       @relation("followers", fields: [followerId], references: [id])
  followingId           String
  following             User       @relation("following", fields: [followingId], references: [id])
  
  createdAt             DateTime   @default(now())
  
  @@unique([followerId, followingId])
  @@index([followerId])
  @@index([followingId])
}

model RecipeCollection {
  id                    String     @id @default(uuid())
  userId                String
  user                  User       @relation(fields: [userId], references: [id])
  name                  String
  description           String?
  isPublic              Boolean    @default(false)
  
  recipes               CollectionRecipe[]
  
  createdAt             DateTime   @default(now())
  updatedAt             DateTime   @updatedAt
  
  @@index([userId])
}

model CollectionRecipe {
  id                    String     @id @default(uuid())
  collectionId          String
  collection            RecipeCollection @relation(fields: [collectionId], references: [id])
  recipeId              String
  addedAt               DateTime   @default(now())
  
  @@unique([collectionId, recipeId])
}

model Ingredient {
  id                    String     @id @default(uuid())
  name                  String     @unique
  englishName           String?
  description           String?
  countryOfOrigin       String?
  nutritionalInfo       Json?
  
  recipes               RecipeIngredient[]
  
  createdAt             DateTime   @default(now())
  updatedAt             DateTime   @updatedAt
}

model RecipeIngredient {
  id                    String     @id @default(uuid())
  recipeId              String
  recipe                Recipe     @relation(fields: [recipeId], references: [id])
  ingredientId          String
  ingredient            Ingredient @relation(fields: [ingredientId], references: [id])
  
  quantity              Decimal    @db.Decimal(10, 2)
  unit                  String
  notes                 String?
  
  @@unique([recipeId, ingredientId])
  @@index([recipeId])
  @@index([ingredientId])
}
```

---

## 認證與授權

### JWT 認證流程

```typescript
import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { UsersService } from '../users/users.service';
import * as bcrypt from 'bcryptjs';

@Injectable()
export class AuthService {
  constructor(
    private usersService: UsersService,
    private jwtService: JwtService,
  ) {}

  async validateUser(email: string, password: string): Promise<any> {
    const user = await this.usersService.findByEmail(email);
    
    if (user && await bcrypt.compare(password, user.passwordHash)) {
      const { passwordHash, ...result } = user;
      return result;
    }
    
    return null;
  }

  async login(user: any) {
    const payload = {
      sub: user.id,
      email: user.email,
      username: user.username,
      role: user.accountType,
    };

    return {
      accessToken: this.jwtService.sign(payload, {
        expiresIn: '15m',
      }),
      refreshToken: this.jwtService.sign(payload, {
        expiresIn: '7d',
      }),
      user,
    };
  }

  async refreshAccessToken(refreshToken: string) {
    try {
      const payload = this.jwtService.verify(refreshToken);
      const newAccessToken = this.jwtService.sign(
        {
          sub: payload.sub,
          email: payload.email,
          username: payload.username,
          role: payload.role,
        },
        { expiresIn: '15m' },
      );

      return { accessToken: newAccessToken };
    } catch (error) {
      throw new UnauthorizedException('Invalid refresh token');
    }
  }
}
```

### JWT Guard

```typescript
import { Injectable } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';

@Injectable()
export class JwtAuthGuard extends AuthGuard('jwt') {}

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(private reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    const requiredRoles = this.reflector.get<string[]>(
      'roles',
      context.getHandler(),
    );

    if (!requiredRoles) {
      return true;
    }

    const request = context.switchToHttp().getRequest();
    const user = request.user;

    return requiredRoles.some((role) => user.role === role);
  }
}
```

---

## 緩存策略

### Redis 緩存實現

```typescript
import { Injectable } from '@nestjs/common';
import { RedisService } from '@nestjs-modules/ioredis';

@Injectable()
export class CacheService {
  constructor(private readonly redisService: RedisService) {}

  async get<T>(key: string): Promise<T | null> {
    const value = await this.redisService.get(key);
    return value ? JSON.parse(value) : null;
  }

  async set<T>(key: string, value: T, ttl?: number): Promise<void> {
    if (ttl) {
      await this.redisService.setex(
        key,
        ttl,
        JSON.stringify(value),
      );
    } else {
      await this.redisService.set(key, JSON.stringify(value));
    }
  }

  async delete(key: string): Promise<void> {
    await this.redisService.del(key);
  }

  async invalidatePattern(pattern: string): Promise<void> {
    const keys = await this.redisService.keys(pattern);
    if (keys.length > 0) {
      await this.redisService.del(...keys);
    }
  }
}

// 使用示例 - 在 Service 中
@Injectable()
export class RecipesService {
  constructor(
    private readonly cacheService: CacheService,
    private readonly recipesRepository: RecipesRepository,
  ) {}

  async getRecipeById(id: string): Promise<Recipe> {
    const cacheKey = `recipe:${id}`;
    
    // 嘗試從緩存獲取
    let recipe = await this.cacheService.get<Recipe>(cacheKey);
    
    if (!recipe) {
      // 從數據庫獲取
      recipe = await this.recipesRepository.findById(id);
      
      if (recipe) {
        // 存入緩存 (24小時)
        await this.cacheService.set(cacheKey, recipe, 86400);
      }
    }
    
    return recipe;
  }

  async updateRecipe(id: string, updateDto: UpdateRecipeDto): Promise<Recipe> {
    const recipe = await this.recipesRepository.update(id, updateDto);
    
    // 失效緩存
    await this.cacheService.delete(`recipe:${id}`);
    
    // 失效相關的列表緩存
    await this.cacheService.invalidatePattern('recipes:*');
    
    return recipe;
  }
}
```

---

## 搜索實現

### Elasticsearch 集成

```typescript
import { Injectable } from '@nestjs/common';
import { ElasticsearchService } from '@nestjs/elasticsearch';

@Injectable()
export class SearchService {
  constructor(private readonly elasticsearchService: ElasticsearchService) {}

  async indexRecipe(recipe: Recipe): Promise<void> {
    await this.elasticsearchService.index({
      index: 'recipes',
      id: recipe.id,
      body: {
        title: recipe.title,
        description: recipe.description,
        country: recipe.country,
        cuisineType: recipe.cuisineType,
        tags: recipe.tags,
        author: recipe.author.username,
        ingredients: recipe.ingredients.map(i => i.ingredient.name),
        averageRating: recipe.averageRating,
        createdAt: recipe.createdAt,
      },
    });
  }

  async searchRecipes(
    filters: RecipeSearchFilters,
    pagination: PaginationParams,
  ): Promise<PaginatedResponse<Recipe>> {
    const must: any[] = [];
    const should: any[] = [];

    // 全文搜索
    if (filters.q) {
      must.push({
        multi_match: {
          query: filters.q,
          fields: ['title^2', 'description', 'tags', 'ingredients'],
        },
      });
    }

    // 過濾條件
    if (filters.country) {
      must.push({ term: { country: filters.country } });
    }

    if (filters.cuisineType) {
      must.push({ term: { cuisineType: filters.cuisineType } });
    }

    if (filters.ingredients?.length) {
      must.push({
        bool: {
          must: filters.ingredients.map(ing => ({
            term: { ingredients: ing },
          })),
        },
      });
    }

    // 評分排序
    if (filters.sortBy === 'rating') {
      should.push({ range: { averageRating: { gte: 4 } } });
    }

    const result = await this.elasticsearchService.search({
      index: 'recipes',
      body: {
        query: {
          bool: {
            must: must.length > 0 ? must : undefined,
            should: should.length > 0 ? should : undefined,
            minimum_should_match: should.length > 0 ? 1 : undefined,
          },
        },
        sort: [
          this.getSortOption(filters.sortBy),
        ],
        from: (pagination.page - 1) * pagination.limit,
        size: pagination.limit,
      },
    });

    return {
      data: result.body.hits.hits.map(hit => hit._source),
      pagination: {
        page: pagination.page,
        limit: pagination.limit,
        total: result.body.hits.total.value,
      },
    };
  }

  private getSortOption(sortBy?: string): any {
    switch (sortBy) {
      case 'rating':
        return { averageRating: 'desc' };
      case 'newest':
        return { createdAt: 'desc' };
      case 'popular':
        return { viewCount: 'desc' };
      default:
        return { createdAt: 'desc' };
    }
  }
}
```

---

## 文件上傳與 CDN

### AWS S3 + CloudFront 配置

```typescript
import { Injectable } from '@nestjs/common';
import { S3Client, PutObjectCommand } from '@aws-sdk/client-s3';
import { sharp } from 'sharp';

@Injectable()
export class FileUploadService {
  private s3Client: S3Client;
  private cloudFrontUrl = process.env.CLOUDFRONT_URL;

  constructor() {
    this.s3Client = new S3Client({
      region: process.env.AWS_REGION,
      credentials: {
        accessKeyId: process.env.AWS_ACCESS_KEY_ID!,
        secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY!,
      },
    });
  }

  async uploadRecipeImage(
    file: Express.Multer.File,
    recipeId: string,
  ): Promise<string> {
    // 圖片優化
    const optimizedBuffer = await sharp(file.buffer)
      .resize(1200, 800, { fit: 'cover' })
      .webp({ quality: 80 })
      .toBuffer();

    const key = `recipes/${recipeId}/${Date.now()}.webp`;

    const command = new PutObjectCommand({
      Bucket: process.env.AWS_S3_BUCKET!,
      Key: key,
      Body: optimizedBuffer,
      ContentType: 'image/webp',
      CacheControl: 'max-age=31536000', // 1 年
    });

    await this.s3Client.send(command);

    // 返回 CloudFront URL
    return `${this.cloudFrontUrl}/${key}`;
  }

  async uploadAvatar(
    file: Express.Multer.File,
    userId: string,
  ): Promise<string> {
    const optimizedBuffer = await sharp(file.buffer)
      .resize(400, 400, { fit: 'cover' })
      .webp({ quality: 85 })
      .toBuffer();

    const key = `avatars/${userId}.webp`;

    const command = new PutObjectCommand({
      Bucket: process.env.AWS_S3_BUCKET!,
      Key: key,
      Body: optimizedBuffer,
      ContentType: 'image/webp',
      CacheControl: 'max-age=2592000', // 30 天
    });

    await this.s3Client.send(command);

    return `${this.cloudFrontUrl}/${key}`;
  }

  async deleteFile(key: string): Promise<void> {
    const command = new DeleteObjectCommand({
      Bucket: process.env.AWS_S3_BUCKET!,
      Key: key,
    });

    await this.s3Client.send(command);
  }
}
```

---

## 監控與日誌

### Winston 日誌配置

```typescript
import { Module } from '@nestjs/common';
import { WinstonModule } from 'nest-winston';
import * as winston from 'winston';

const loggerConfig = WinstonModule.createLogger({
  transports: [
    // Console 日誌
    new winston.transports.Console({
      format: winston.format.combine(
        winston.format.colorize(),
        winston.format.simple(),
      ),
    }),
    
    // 文件日誌 - 錯誤
    new winston.transports.File({
      filename: 'logs/error.log',
      level: 'error',
      format: winston.format.json(),
    }),
    
    // 文件日誌 - 全部
    new winston.transports.File({
      filename: 'logs/combined.log',
      format: winston.format.json(),
    }),
  ],
});

@Module({
  providers: [
    {
      provide: 'LOGGER',
      useValue: loggerConfig,
    },
  ],
})
export class LoggerModule {}
```

### Prometheus 監控

```typescript
import { Injectable } from '@nestjs/common';
import { Registry, Counter, Histogram } from 'prom-client';

@Injectable()
export class MetricsService {
  private readonly registry = new Registry();

  private readonly httpRequestDuration = new Histogram({
    name: 'http_request_duration_seconds',
    help: 'Duration of HTTP requests in seconds',
    labelNames: ['method', 'route', 'status_code'],
  });

  private readonly recipesCreated = new Counter({
    name: 'recipes_created_total',
    help: 'Total number of recipes created',
  });

  private readonly usersRegistered = new Counter({
    name: 'users_registered_total',
    help: 'Total number of users registered',
  });

  constructor() {
    this.registry.registerMetric(this.httpRequestDuration);
    this.registry.registerMetric(this.recipesCreated);
    this.registry.registerMetric(this.usersRegistered);
  }

  recordHttpRequestDuration(
    method: string,
    route: string,
    statusCode: number,
    duration: number,
  ): void {
    this.httpRequestDuration
      .labels(method, route, statusCode.toString())
      .observe(duration);
  }

  incrementRecipesCreated(): void {
    this.recipesCreated.inc();
  }

  incrementUsersRegistered(): void {
    this.usersRegistered.inc();
  }

  getMetrics(): string {
    return this.registry.metrics();
  }
}
```

---

## 部署指南

### Docker 配置

#### Dockerfile
```dockerfile
# 構建階段
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# 運行階段
FROM node:20-alpine

WORKDIR /app

ENV NODE_ENV=production

COPY package*.json ./
RUN npm ci --only=production

COPY --from=builder /app/dist ./dist

EXPOSE 3000

CMD ["node", "dist/main.js"]
```

#### docker-compose.yml
```yaml
version: '3.9'

services:
  backend:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=development
      - DATABASE_URL=postgresql://user:password@postgres:5432/tastefwb
      - REDIS_URL=redis://redis:6379
      - ELASTICSEARCH_URL=http://elasticsearch:9200
    depends_on:
      - postgres
      - redis
      - elasticsearch
    volumes:
      - .:/app
      - /app/node_modules

  postgres:
    image: postgres:15-alpine
    environment:
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=tastefwb
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"

  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.8.0
    environment:
      - discovery.type=single-node
      - xpack.security.enabled=false
    ports:
      - "9200:9200"
    volumes:
      - elasticsearch_data:/usr/share/elasticsearch/data

volumes:
  postgres_data:
  elasticsearch_data:
```

### Kubernetes 部署

#### deployment.yaml
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tastefwb-backend
  labels:
    app: tastefwb-backend

spec:
  replicas: 3
  
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0

  selector:
    matchLabels:
      app: tastefwb-backend

  template:
    metadata:
      labels:
        app: tastefwb-backend

    spec:
      containers:
      - name: backend
        image: registry.example.com/tastefwb-backend:latest
        imagePullPolicy: Always
        
        ports:
        - containerPort: 3000
          name: http

        env:
        - name: NODE_ENV
          value: "production"
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: tastefwb-secrets
              key: database-url
        - name: REDIS_URL
          valueFrom:
            secretKeyRef:
              name: tastefwb-secrets
              key: redis-url

        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"

        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
          periodSeconds: 10

        readinessProbe:
          httpGet:
            path: /ready
            port: 3000
          initialDelaySeconds: 10
          periodSeconds: 5

---
apiVersion: v1
kind: Service
metadata:
  name: tastefwb-backend-service

spec:
  type: LoadBalancer
  selector:
    app: tastefwb-backend
  ports:
  - port: 80
    targetPort: 3000
```

### CI/CD Pipeline (GitHub Actions)

```yaml
name: Deploy Backend

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    services:
      postgres:
        image: postgres:15-alpine
        env:
          POSTGRES_PASSWORD: postgres
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5

    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '20'
        cache: 'npm'
    
    - name: Install dependencies
      run: npm ci
    
    - name: Run linter
      run: npm run lint
    
    - name: Run tests
      run: npm run test:cov
    
    - name: Build application
      run: npm run build

  deploy:
    needs: test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'

    steps:
    - uses: actions/checkout@v3
    
    - name: Build Docker image
      run: |
        docker build -t registry.example.com/tastefwb-backend:${{ github.sha }} .
        docker tag registry.example.com/tastefwb-backend:${{ github.sha }} registry.example.com/tastefwb-backend:latest
    
    - name: Push to registry
      run: |
        echo ${{ secrets.REGISTRY_PASSWORD }} | docker login -u ${{ secrets.REGISTRY_USER }} --password-stdin
        docker push registry.example.com/tastefwb-backend:${{ github.sha }}
        docker push registry.example.com/tastefwb-backend:latest
    
    - name: Deploy to Kubernetes
      run: |
        kubectl set image deployment/tastefwb-backend backend=registry.example.com/tastefwb-backend:${{ github.sha }}
```

---

**文檔版本**：1.0  
**最後更新**：2026-06-22
