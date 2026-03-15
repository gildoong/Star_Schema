# Star Schema Analytics with dbt on Databricks

StackExchange 데이터를 Databricks와 dbt로 모델링하고, 스타 스키마와 분석용 SQL을 구성한 프로젝트입니다.

`Bronze`와 `Silver` 레이어의 적재 및 정제는 Databricks 환경에서 수행했고, 이 저장소에는 주로 `Gold` 레이어의 dbt 모델링과 분석 SQL을 정리했습니다.

<img width="4128" height="992" alt="image" src="https://github.com/user-attachments/assets/303aae34-30b8-4767-9a6b-aef863b14581" />

## Overview

- Raw StackExchange 데이터를 Databricks에서 수집 및 정제
- dbt를 사용해 `staging -> mart(core / metrics)` 구조의 Gold 모델 구성
- 스타 스키마 기반 차원/사실 테이블 설계
- 지표형 mart와 별도 분석 SQL을 통해 사용자 활동, 태그 성과, 질문 패턴 분석

## Architecture

### Medallion Layers

- Bronze
  - 원천 데이터를 Databricks에 적재한 레이어
  - 본 저장소에는 포함하지 않음
- Silver
  - Databricks에서 정제한 중간 레이어
  - `my_workspace.silver.*` 테이블을 dbt staging의 입력으로 사용
- Gold
  - dbt로 모델링한 분석용 레이어
  - 스타 스키마와 metric mart 포함

### Data Flow

```text
StackExchange Raw Data
    -> Databricks Bronze
    -> Databricks Silver
    -> dbt Staging
    -> dbt Mart Core
    -> dbt Mart Metrics / Analysis SQL
```

### Diagram

아래 영역에 아키텍처 다이어그램 또는 Medallion 흐름 이미지를 추가하면 됩니다.

```text
[ Architecture Diagram Placeholder ]
```

## Tech Stack

- Databricks
- dbt Core 1.11.x
- dbt-databricks
- Python 3.11+
- uv

## Project Structure

```text
dbt_bricks_project/
├── README.md
├── pyproject.toml
├── uv.lock
└── stackexchange_dwh/
    ├── dbt_project.yml
    ├── models/
    │   ├── staging/
    │   └── mart/
    │       ├── core/
    │       └── metrics/
    ├── analyses/
    ├── macros/
    ├── seeds/
    ├── snapshots/
    └── tests/
```

## Data Modeling

### Staging Models

Silver 테이블을 dbt 모델링에 맞게 정리한 레이어입니다.

- `stg_posts`
- `stg_users`
- `stg_comments`
- `stg_votes`
- `stg_tags`
- `stg_post_tags`

### Core Mart

스타 스키마의 중심이 되는 차원/사실 테이블입니다.

- Dimension
  - `dim_user`
  - `dim_tags`
  - `dim_date`
- Fact / Bridge
  - `fact_posts`
  - `fact_comments`
  - `fact_votes`
  - `bridge_post_tags`

### Metrics Mart

분석 목적의 집계 및 지표 테이블입니다.

- `mart_daily_questions`
- `mart_user_activity`
- `mart_top_tags`
- `mart_tag_answer_time`
- `mart_fastest_answer_tag`
- `mart_answer_view_ratio`
- `mart_expert_answer_score`
- `mart_question_hour_pattern`

## Analysis SQL

dbt mart와는 별도로, 탐색적 분석 및 리포트 작성용 SQL을 `stackexchange_dwh/analyses/`에 관리했습니다.

- `new_vs_old_post.sql`
- `user_answer_question_ratio.sql`
- `accepted_answer_tag.sql`
- `answer_time.sql`
- `many_question_user.sql`
- `top_answer_tag.sql`
- `top_comment_question.sql`
- `top_view_question.sql`
- `top_vote_answer.sql`
- `montly_question.sql`

## Key Insights Focus

이 프로젝트는 아래와 같은 질문에 답할 수 있도록 모델링했습니다.

- 어떤 태그가 가장 많이 질문되는가?
- 어떤 태그가 가장 빠르게 답변을 받는가?
- 조회수가 높은 질문은 답변도 많이 달리는가?
- 고평판 사용자의 답변 품질은 어떤가?
- 사용자는 질문보다 답변에 더 많이 참여하는가?
- 질문은 어떤 시간대에 많이 생성되는가?

## dbt Tests

주요 테스트는 `schema.yml` 기준으로 구성했습니다.

- `not_null`
- `unique`
- `relationships`
- `accepted_values`

검증 대상 예시:

- 사용자 키 무결성
- 게시글 키 중복 여부
- 태그 참조 무결성
- 질문 시간대 값 범위
- 게시글 타입 값 검증

## How to Run

### 1. Move into the dbt project

```bash
cd stackexchange_dwh
```

### 2. Install and run with uv

```bash
uv run dbt debug
uv run dbt run
uv run dbt test
```

### 3. Generate docs

```bash
uv run dbt docs generate
uv run dbt docs serve
```

참고:

- `dbt`가 로컬 셸에 직접 잡히지 않을 수 있어 `uv run dbt ...` 형태로 실행하는 방식을 사용했습니다.
- `docs generate`는 Databricks 연결이 정상이어야 `catalog.json`이 생성됩니다.

## Branch Strategy

- `main`
  - 초기 기준 브랜치
- `feature/dbt-star-schema`
  - dbt 모델링 브랜치
- `feature/sql-analysis`
  - 분석 SQL 브랜치


## Notes

- Bronze / Silver 구현은 Databricks에서 별도로 진행했습니다.
- 이 저장소는 Gold 레이어 모델링과 분석 SQL 관리에 초점을 두고 있습니다.
- 향후에는 source 정의, exposure, 문서화 확장, dashboard 연결까지 확장할 수 있습니다.
