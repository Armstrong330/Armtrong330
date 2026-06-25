# 「味蕾無國界」- 前端架構詳細設計

## 📋 目錄
1. [項目結構](#項目結構)
2. [核心技術與庫](#核心技術與庫)
3. [状態管理架構](#状態管理架構)
4. [頁面與路由設計](#頁面與路由設計)
5. [組件架構](#組件架構)
6. [數據獲取策略](#數據獲取策略)
7. [性能優化](#性能優化)
8. [開發工作流](#開發工作流)

---

## 項目結構

```
tastefwb-frontend/
├── public/
│   ├── images/
│   │   ├── logos/
│   │   ├── backgrounds/
│   │   └── icons/
│   ├── locales/
│   │   ├── zh.json
│   │   ├── en.json
│   │   └── ja.json
│   └── sitemap.xml
│
├── src/
│   ├── app/
│   │   ├── layout.tsx              # 根佈局
│   │   ├── page.tsx                # 首頁
│   │   ├── globals.css
│   │   │
│   │   ├── (auth)/
│   │   │   ├── login/page.tsx
│   │   │   ├── register/page.tsx
│   │   │   └── forgot-password/page.tsx
│   │   │
│   │   ├── (main)/
│   │   │   ├── layout.tsx          # 主佈局（導航欄等）
│   │   │   ├── discover/page.tsx
│   │   │   ├── recipes/
│   │   │   │   ├── page.tsx
│   │   │   │   ├── [id]/page.tsx
│   │   │   │   └── create/page.tsx
│   │   │   ├── map/page.tsx
│   │   │   ├── stories/page.tsx
│   │   │   ├── profile/
│   │   │   │   ├── page.tsx
│   │   │   │   └── [id]/page.tsx
│   │   │   ├── collections/page.tsx
│   │   │   └── settings/page.tsx
│   │   │
│   │   └── api/
│   │       ├── auth/[...auth].ts
│   │       └── webhooks/...
│   │
│   ├── components/
│   │   ├── common/
│   │   │   ├── Navigation.tsx
│   │   │   ├── Footer.tsx
│   │   │   ├── Header.tsx
│   │   │   ├── Sidebar.tsx
│   │   │   ├── SearchBar.tsx
│   │   │   └── LanguageSwitcher.tsx
│   │   │
│   │   ├── recipes/
│   │   │   ├── RecipeCard.tsx
│   │   │   ├── RecipeGrid.tsx
│   │   │   ├── RecipeDetail.tsx
│   │   │   ├── RecipeForm.tsx
│   │   │   ├── IngredientsSection.tsx
│   │   │   ├── InstructionsSection.tsx
│   │   │   ├── NutritionInfo.tsx
│   │   │   └── CommentsSection.tsx
│   │   │
│   │   ├── discovery/
│   │   │   ├── FoodMap.tsx
│   │   │   ├── CountryFilter.tsx
│   │   │   ├── CuisineTypeFilter.tsx
│   │   │   └── TrendingCards.tsx
│   │   │
│   │   ├── user/
│   │   │   ├── UserProfile.tsx
│   │   │   ├── UserStats.tsx
│   │   │   ├── FollowButton.tsx
│   │   │   └── DietaryPreferences.tsx
│   │   │
│   │   ├── story/
│   │   │   ├── StoryCard.tsx
│   │   │   ├── StoryDetail.tsx
│   │   │   └── StoryList.tsx
│   │   │
│   │   ├── forms/
│   │   │   ├── LoginForm.tsx
│   │   │   ├── RegisterForm.tsx
│   │   │   └── UploadImageForm.tsx
│   │   │
│   │   └── ui/
│   │       ├── Button.tsx
│   │       ├── Card.tsx
│   │       ├── Modal.tsx
│   │       ├── Toast.tsx
│   │       ├── Spinner.tsx
│   │       ├── Rating.tsx
│   │       ├── Tabs.tsx
│   │       └── Pagination.tsx
│   │
│   ├── hooks/
│   │   ├── useAuth.ts
│   │   ├── useUser.ts
│   │   ├── useRecipe.ts
│   │   ├── useSearch.ts
│   │   ├── useFavorites.ts
│   │   ├── useInfiniteScroll.ts
│   │   └── useLocalStorage.ts
│   │
│   ├── store/
│   │   ├── authStore.ts
│   │   ├── userStore.ts
│   │   ├── recipesStore.ts
│   │   └── uiStore.ts
│   │
│   ├── services/
│   │   ├── api.ts              # API 客戶端配置
│   │   ├── authService.ts
│   │   ├── recipeService.ts
│   │   ├── userService.ts
│   │   ├── searchService.ts
│   │   ├── locationService.ts
│   │   └── fileUploadService.ts
│   │
│   ├── utils/
│   │   ├── validators.ts
│   │   ├── formatters.ts
│   │   ├── constants.ts
│   │   ├── helpers.ts
│   │   ├── imageOptimization.ts
│   │   └── errorHandler.ts
│   │
│   ├── types/
│   │   ├── index.ts
│   │   ├── recipe.ts
│   │   ├── user.ts
│   │   ├── auth.ts
│   │   └── api.ts
│   │
│   ├── middleware/
│   │   ├── auth.ts
│   │   ├── errorBoundary.ts
│   │   └── analytics.ts
│   │
│   ├── lib/
│   │   ├── cn.ts               # 樣式合併工具
│   │   ├── queryClient.ts
│   │   └── i18n.ts
│   │
│   └── styles/
│       ├── globals.css
│       ├── variables.css
│       └── animations.css
│
├── __tests__/
│   ├── components/
│   ├── hooks/
│   ├── services/
│   └── utils/
│
├── .env.local
├── .env.example
├── .eslintrc.json
├── .prettierrc
├── next.config.js
├── tsconfig.json
├── tailwind.config.ts
├── package.json
└── README.md
```

---

## 核心技術與庫

### package.json 推薦依賴
```json
{
  "dependencies": {
    "next": "^14.0.0",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "typescript": "^5.2.0",
    
    "zustand": "^4.4.0",
    "@tanstack/react-query": "^5.0.0",
    "axios": "^1.4.0",
    "swr": "^2.2.0",
    
    "tailwindcss": "^3.3.0",
    "@tailwindcss/forms": "^0.5.3",
    "@tailwindcss/typography": "^0.5.9",
    "shadcn-ui": "^0.2.1",
    "class-variance-authority": "^0.7.0",
    "clsx": "^2.0.0",
    "tailwind-merge": "^1.14.0",
    
    "react-hook-form": "^7.44.0",
    "zod": "^3.22.0",
    "@hookform/resolvers": "^3.1.0",
    
    "react-i18next": "^12.1.4",
    "i18next": "^23.4.4",
    
    "mapbox-gl": "^2.15.0",
    "react-map-gl": "^7.1.0",
    
    "framer-motion": "^10.15.0",
    "react-player": "^2.11.0",
    
    "date-fns": "^2.30.0",
    "lodash-es": "^4.17.21",
    
    "next-auth": "^4.23.0",
    "jsonwebtoken": "^9.0.0",
    
    "next-seo": "^6.2.0",
    
    "react-hot-toast": "^2.4.0",
    "react-toastify": "^9.1.0"
  },
  "devDependencies": {
    "@types/node": "^20.0.0",
    "@types/react": "^18.2.0",
    "@types/react-dom": "^18.2.0",
    
    "eslint": "^8.45.0",
    "eslint-config-next": "^14.0.0",
    "@typescript-eslint/eslint-plugin": "^6.0.0",
    "@typescript-eslint/parser": "^6.0.0",
    
    "prettier": "^3.0.0",
    
    "vitest": "^0.34.0",
    "@testing-library/react": "^14.0.0",
    "@testing-library/jest-dom": "^6.1.0",
    
    "playwright": "^1.38.0",
    "postcss": "^8.4.27",
    "autoprefixer": "^10.4.14"
  }
}
```

---

## 状態管理架構

### Zustand Store 設計

#### authStore.ts
```typescript
import create from 'zustand';
import { persist } from 'zustand/middleware';

interface User {
  id: string;
  email: string;
  username: string;
  profilePicture?: string;
}

interface AuthState {
  user: User | null;
  accessToken: string | null;
  isLoading: boolean;
  error: string | null;
  
  login: (email: string, password: string) => Promise<void>;
  register: (data: RegisterData) => Promise<void>;
  logout: () => void;
  refreshToken: () => Promise<void>;
  setUser: (user: User) => void;
}

export const useAuthStore = create<AuthState>()(
  persist(
    (set, get) => ({
      user: null,
      accessToken: null,
      isLoading: false,
      error: null,
      
      login: async (email, password) => {
        set({ isLoading: true, error: null });
        try {
          const response = await authService.login(email, password);
          set({
            user: response.user,
            accessToken: response.accessToken,
            isLoading: false
          });
        } catch (error) {
          set({ error: error.message, isLoading: false });
        }
      },
      
      logout: () => {
        set({ user: null, accessToken: null });
      },
      
      setUser: (user) => set({ user }),
    }),
    {
      name: 'auth-storage',
      partialize: (state) => ({
        user: state.user,
        accessToken: state.accessToken
      })
    }
  )
);
```

#### recipesStore.ts
```typescript
interface Recipe {
  id: string;
  title: string;
  description: string;
  // ... 其他字段
}

interface RecipesState {
  recipes: Recipe[];
  favorites: Set<string>;
  isLoading: boolean;
  
  fetchRecipes: (filters: RecipeFilters) => Promise<void>;
  addFavorite: (recipeId: string) => void;
  removeFavorite: (recipeId: string) => void;
  clearRecipes: () => void;
}

export const useRecipesStore = create<RecipesState>((set, get) => ({
  recipes: [],
  favorites: new Set(),
  isLoading: false,
  
  fetchRecipes: async (filters) => {
    set({ isLoading: true });
    try {
      const response = await recipeService.search(filters);
      set({ recipes: response.data, isLoading: false });
    } catch (error) {
      set({ isLoading: false });
    }
  },
  
  addFavorite: (recipeId) => {
    set((state) => ({
      favorites: new Set(state.favorites).add(recipeId)
    }));
  },
  
  removeFavorite: (recipeId) => {
    set((state) => {
      const newFavorites = new Set(state.favorites);
      newFavorites.delete(recipeId);
      return { favorites: newFavorites };
    });
  },
  
  clearRecipes: () => set({ recipes: [] })
}));
```

---

## 頁面與路由設計

### 主要路由結構

```
/                          - 首頁 (著陸頁)
├─ /discover               - 發現頁面
│  ├─ ?country=...
│  ├─ ?cuisineType=...
│  └─ ?sort=...
│
├─ /recipes                - 食譜列表
│  ├─ /create             - 建立食譜
│  ├─ /[id]               - 食譜詳情
│  └─ /[id]/edit          - 編輯食譜
│
├─ /map                    - 美食地圖
│  └─ ?country=...
│
├─ /stories                - 文化故事
│  └─ /[id]               - 故事詳情
│
├─ /profile                - 我的檔案
│  ├─ /[id]               - 其他用戶檔案
│  ├─ /recipes            - 我的食譜
│  ├─ /collections        - 我的收藏
│  └─ /settings           - 設置
│
├─ /collections            - 收藏夾
│  └─ /[id]               - 收藏詳情
│
├─ /auth                   - 認證
│  ├─ /login              - 登入
│  ├─ /register           - 註冊
│  └─ /forgot-password    - 忘記密碼
│
└─ /admin                  - 管理後台 (需管理員權限)
   └─ /dashboard          - 儀表板
```

---

## 組件架構

### 原子設計架構

```
Atoms (原子)
├── Button.tsx
├── Input.tsx
├── Label.tsx
├── Icon.tsx
└── Badge.tsx

Molecules (分子)
├── SearchInput.tsx (Input + Icon)
├── Rating.tsx (Stars + Text)
├── FormField.tsx (Label + Input + Error)
└── Card.tsx (Container + Content)

Organisms (有機體)
├── RecipeCard.tsx (包含多個分子)
├── CommentsSection.tsx
├── RecipeForm.tsx
└── Navigation.tsx

Templates (模板)
├── RecipeDetailTemplate.tsx
├── ProfileTemplate.tsx
└── ListingTemplate.tsx

Pages (頁面)
├── RecipesPage.tsx
├── ProfilePage.tsx
└── DiscoverPage.tsx
```

### 常用組件示例

#### RecipeCard.tsx
```typescript
import { Card } from '@/components/ui/Card';
import { Rating } from '@/components/ui/Rating';
import { Badge } from '@/components/ui/Badge';

interface RecipeCardProps {
  recipe: Recipe;
  onCardClick: (recipeId: string) => void;
  showAuthor?: boolean;
}

export const RecipeCard: React.FC<RecipeCardProps> = ({
  recipe,
  onCardClick,
  showAuthor = true
}) => {
  return (
    <Card
      className="cursor-pointer hover:shadow-lg transition-shadow"
      onClick={() => onCardClick(recipe.id)}
    >
      <div className="relative">
        <img
          src={recipe.thumbnail}
          alt={recipe.title}
          className="w-full h-48 object-cover"
        />
        <Badge className="absolute top-2 right-2">
          {recipe.cuisineType}
        </Badge>
      </div>
      
      <div className="p-4">
        <h3 className="font-bold text-lg line-clamp-2">
          {recipe.title}
        </h3>
        
        {showAuthor && (
          <p className="text-sm text-gray-600 mt-1">
            by {recipe.author.username}
          </p>
        )}
        
        <div className="flex justify-between items-center mt-3">
          <Rating
            value={recipe.averageRating}
            reviewCount={recipe.reviewsCount}
          />
          <span className="text-xs text-gray-500">
            {recipe.cookTimeMinutes}min
          </span>
        </div>
      </div>
    </Card>
  );
};
```

---

## 數據獲取策略

### 使用 React Query 的模式

```typescript
// 獲取食譜列表
export function useRecipes(filters: RecipeFilters) {
  return useQuery({
    queryKey: ['recipes', filters],
    queryFn: () => recipeService.search(filters),
    staleTime: 5 * 60 * 1000, // 5 分鐘
    cacheTime: 10 * 60 * 1000, // 10 分鐘
  });
}

// 獲取單個食譜
export function useRecipe(id: string) {
  return useQuery({
    queryKey: ['recipe', id],
    queryFn: () => recipeService.getById(id),
    staleTime: 10 * 60 * 1000, // 10 分鐘
  });
}

// 建立食譜變更
export function useCreateRecipe() {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: (data: CreateRecipeData) => recipeService.create(data),
    onSuccess: () => {
      // 失效相關查詢
      queryClient.invalidateQueries({ queryKey: ['recipes'] });
    },
  });
}
```

### ISR (增量靜態再生成) 策略

```typescript
// next.config.js
module.exports = {
  revalidate: 3600, // 1 小時重新驗證
};

// 使用 getStaticProps 預生成流量大的頁面
export async function getStaticProps(context) {
  const recipes = await fetchRecipes();
  
  return {
    props: { recipes },
    revalidate: 3600 // ISR: 重新驗證間隔
  };
}
```

---

## 性能優化

### 圖片優化
```typescript
import Image from 'next/image';

export const OptimizedImage: React.FC<ImageProps> = (props) => {
  return (
    <Image
      {...props}
      placeholder="blur"
      quality={75}
      sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw"
      priority={props.priority || false}
    />
  );
};
```

### 代碼分割
```typescript
import dynamic from 'next/dynamic';

const RecipeForm = dynamic(() => import('@/components/recipes/RecipeForm'), {
  loading: () => <Spinner />,
  ssr: false
});
```

### SEO 優化
```typescript
import { NextSeo } from 'next-seo';

export default function RecipeDetail({ recipe }) {
  return (
    <>
      <NextSeo
        title={recipe.title}
        description={recipe.description}
        openGraph={{
          type: 'article',
          url: `https://tastewithoutborders.com/recipes/${recipe.id}`,
          title: recipe.title,
          description: recipe.description,
          images: [{ url: recipe.thumbnail }],
        }}
        structuredData={{
          '@context': 'https://schema.org',
          '@type': 'Recipe',
          name: recipe.title,
          description: recipe.description,
          image: recipe.thumbnail,
          author: {
            '@type': 'Person',
            name: recipe.author.username,
          },
        }}
      />
      
      {/* 頁面內容 */}
    </>
  );
}
```

---

## 開發工作流

### Git 工作流
```bash
# 建立特性分支
git checkout -b feature/recipe-detail-page

# 提交變更
git add .
git commit -m "feat(recipes): add recipe detail page with comments"

# 推送並建立 PR
git push origin feature/recipe-detail-page
```

### 本地開發命令
```bash
# 安裝依賴
npm install

# 啟動開發服務器
npm run dev

# 構建和測試
npm run build
npm run test

# Linting
npm run lint
npm run format
```

---

**文檔版本**：1.0  
**最後更新**：2026-06-22
