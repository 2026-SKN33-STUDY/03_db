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
LIMIT 3;





# 2 join
# 재직 중인 ‘대리’들의 직원명, 직급명, 급여, 사원번호, 이메일, 전화번호, 입사일을 출력하세요.
# job_name = '대리'
# 단, 급여를 기준으로 내림차순 출력하세요.
select
    e.EMP_NAME as 직원명,
    j.JOB_NAME as 직급,
    e.SALARY as 급여,
    e.EMP_ID as 사원번호,
    e.EMAIL,
    e.PHONE as 전화번호,
    e.HIRE_DATE as 입사일
from
    employee e
join
    job j
on
    e.job_code = j.job_code
where
    ENT_YN = 'N'
and
    JOB_NAME = '대리'
order by salary desc;

select
    *
from employee e














