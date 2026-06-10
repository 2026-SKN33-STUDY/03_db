# 1
select
    EMP_ID,
    EMP_NAME,
    PHONE,
    HIRE_DATE,
    ENT_YN
from
    employee
WHERE
    ENT_YN = 'N'    # 재직중
    AND
    PHONE LIKE '%2'

ORDER BY
    HIRE_DATE DESC
LIMIT 3
