# 그룹 함수
# - 그룹의 통계를 반환하는 함수
# - sum(), avg(), count(), Min(), Max()

# sum(컬럼)
# - null (빈칸 상태)이 아닌 컬럼의 합
select
    sum(menu_price)
from
    tbl_menu;



# avg(컬럼)
# - null (빈칸 상태)이 아닌 컬럼의 평균
select
    avg(menu_price)
from
    tbl_menu;


# 카테고리 코드가 10인 메뉴의 평균 가격
select
    avg(menu_price)
from
    tbl_menu
where
    category_code = 10;

# 메뉴 가격 최대값, 최소값
select
    max(menu_price) as 최대값,
    min(menu_price) as 최소값
from
    tbl_menu;


# null 과 연산을 수행하면 모든 결과가 null
select 1 + null;

# 합계, 평균 -> 숫자 데이터 컬럼에만 적용 가능
# 최대, 최소 -> 숫자, 문자(아스키코드), 날짜 모두 사용 가능

select
    max(menu_name),
    min(menu_name)
from
    tbl_menu;


# count(* | 컬럼명): 행의 개수를 조회
# count(*) : 모든 행(null 포함) 개수
# count(컬럼명): 지정된 컬럼 값 중 null인 컬럼을 제외한 행의 개수
select * from tbl_category;

select
    count(*),    # 전체 행 개수
    count(ref_category_code)    # null(1, 2, 3) 제외
from
    tbl_category;


# =============================================
# GROUP BY 절
# - 지정된 컬럼 값이 일치하는 행을 그룹화(grouping) 시키는 구문
SELECT
    TBL_MENU.CATEGORY_CODE
FROM
    TBL_MENU;



select

    category_code,
    count(*),   # 각 그룹의 모든 행의 개수
    sum(menu_price),    # 각 그룹의 가격 합계
    avg(menu_price),    # 각 그룹의 가격 평균
    min(menu_price),    # 각 그룹의 메뉴 최소
    max(menu_price)     # 각 그룹의 메뉴 최대
from
    tbl_menu
group by
    # category_code 컬럼 값이 같은 행을 그룹화
    category_code;




# group by 사용 시 주의 사항
# 1. null도 별도 그룹으로 묶임
select
    ref_category_code
    # categoty_name
    # 2. select 절에는 group by 기준이 된 컬럼 + 그룹함수만 작성 가능
from
    tbl_category
group by
    ref_category_code;  # null도 별개로 묶임.

### 그룹 내 하위 그룹 구성 가능
select * from tbl_menu;

# category_code로 1차 그룹화 후
# 각 그룹에서 orderable _status가 같은 행끼리 2차 그룹화
select
    category_code,
    orderable_status,
    count(*)    # 2차 그루화된 orderable_status 카운트
from
    tbl_menu
group by
    category_code,
    orderable_status
order by
    category_code asc;



### where + group by: 필터링된 행 중 컬럼값이 같은 행 그룹화
# - where: 지정된 테이블에서 행을 필터링
# - group by: 컬럼 값이 같은 행을 그룹화


# 메뉴 테이블에서 카테고리별 개수, 합계 구하기
# 단, 메뉴 가격이 10,000원 이상인 메뉴만
select
    category_code,
    count(*),
    sum(menu_price)
from
    tbl_menu
where
    menu_price >= 10000
group by
    category_code
# 초콜릿덮밥이 두 개 있음


# 메뉴 테이블에서
# 주문이 가능한 메뉴 중 카테고리 코드가 4, 10인 메뉴의
# 카테고리별 개수 조회
select
    c.category_name, count(*)
from
    tbl_menu m
join
    tbl_category c
on
    m.category_code = c.category_code
where
    m.orderable_status = 'Y'
and
    m.category_code in (4, 10)
group by
    c.category_code;


# ========================================================
# HAVING 절
# - group by 를 통해 만들어진 그룹에 대한 조건을 작성하는 구문
# - having 절 작성 시 항상 그룹함수가 포함된다

# 메뉴 테이블에서
# 카테고리 별 메뉴 개수가 2개 이상인 카테고리의
# 카테고리 번호, 개수 출력

select
    category_code,
    count(*)
from
    tbl_menu m

group by
    m.category_code
HAVING
    count(*) >= 2;


# 카테고리 테이블에서
# 부모 카테고리(ref_category_code) 별로 개수가 3개 이상인
# 부모 카테고리 번호, 개수 조회
# 부모 카테고리 오름차순으로 조회
select
    ref_category_code,
    count(*)
from
    tbl_category
group by
    ref_category_code   # 카테고리별 개수
having
    count(*) >= 3
order by
    ref_category_code asc;

#
# 위 쿼리 결과에서 null 제외
select
    ref_category_code,
    count(*)
from
    tbl_category
where
    ref_category_code is not null
group by
    ref_category_code   # 카테고리별 개수
having
    count(*) >= 3
# and
#     ref_category_code is not null # where절에서 걸러내는 걸 권장
order by
    #ref_category_code asc;
    #
    count(*) asc    # 개수가 가장 적은 거부터 큰 거까지
limit 1;            # 중에 하나만 고른 거

