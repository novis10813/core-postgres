# Core Postgres

Shared PostgreSQL instance for home server microservices.

## 特點

- **PostgreSQL 17** (Alpine)
- **已安裝插件：** pgvector v0.7.0
- **內建插件：** pg_trgm, uuid-ossp, pg_stat_statements

## 已建立的 Databases

| Database | 使用服務 |
|----------|----------|
| gateway_db | gateway-api |

## 使用方式

### 在服務中啟用插件

```sql
-- 連接到你的 database
\c gateway_db

-- 啟用需要的插件
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgvector";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";
```

### 連接字串範例

```
postgresql://postgres:${POSTGRES_PASSWORD}@core-postgres:5432/gateway_db
```

## 本地開發

```bash
# Build and run
docker-compose -f docker-compose.dev.yml up -d

# Check health
docker exec core-postgres pg_isready -U postgres

# Check available extensions
docker exec core-postgres psql -U postgres -c "SELECT * FROM pg_available_extensions WHERE name IN ('vector', 'pg_trgm', 'uuid-ossp');"
```

## 新增 Database

編輯 `init-databases.sql` 新增：

```sql
CREATE DATABASE new_service_db;
```

然後重新 build image。
