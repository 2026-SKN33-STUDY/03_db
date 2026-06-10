# 1
select
    category_code,
    category_name
from
    tbl_category
where
    ref_category_code is not null
order by
    category_name desc;

# 2
select
    menu_name,
    menu_price
from
    tbl_menu
where
    menu_name like '%밥%'
  and
    menu_price between 20000 and 30000;

# 3
select
    *   # 모든 컬럼 출력
from
    tbl_menu
where
    menu_price < 10000 or menu_name like '%김치%'
order by
    menu_price asc, menu_name desc;

# 4
# 모르겟고
SELECT
    *
FROM
    TBL_MENU
WHERE
    CATEGORY_CODE NOT IN (8, 9, 10)
    AND
    MENU_PRICE = 13000
    AND
    ORDERABLE_STATUS != 'N'
    # ORDERABLE_STATUS = 'Y'












