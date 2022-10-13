select deptno, job, count(*), max(sal), min(sal), sum(sal), round(avg(sal))
from emp
group by deptno, job
order by deptno, job;

-- rollup
select deptno, job, count(*), max(sal), min(sal), sum(sal), round(avg(sal))
from emp
group by rollup(deptno, job);

-- cube
select deptno, job, count(*), max(sal), min(sal), sum(sal), round(avg(sal))
from emp
group by cube(deptno, job)
order by deptno, job;

-- rollup one column
select deptno, job, count(*), max(sal), min(sal), sum(sal), round(avg(sal))
from emp
group by deptno, rollup(job);

select deptno, job, count(*), max(sal), min(sal), sum(sal), round(avg(sal))
from emp
group by job, rollup(deptno);

-- grouping sets
select deptno, job, count(*), max(sal), min(sal), sum(sal), round(avg(sal))
from emp
group by grouping sets (deptno, job)
order by deptno, job;

-- grouping() with decode
select decode(grouping(deptno), 1, 'ALL_DEPT', deptno) deptno,
       decode(grouping(job), 1, 'ALL_JOB', job) job,
       count(*), max(sal), min(sal), sum(sal), round(avg(sal))
from emp
group by cube (deptno, job)
order by deptno, job;

-- grouping_id
select decode(grouping(deptno), 1, 'ALL_DEPT', deptno) deptno,
       decode(grouping(job), 1, 'ALL_JOB', job) job,
       count(*), sum(sal), grouping_id(deptno, job) gid
from emp
group by cube(deptno, job)
order by deptno, job desc;

-- listagg
select deptno,
       listagg(ename, ', ')
       within group (order by sal desc) enames
from emp
group by deptno;

-- pivot
select *
from (select deptno, job, sal from emp)
     pivot(max(sal) for deptno in (10, 20, 30))
order by job;

select *
from (select deptno, job, sal from emp)
     pivot(max(sal) for job in ('CLERK' CLERK, 'SALESMAN' SALESMAN, 'PRESIDENT' PRESIDENT, 'MANAGER' MANAGER, 'ANALYST' ANALYST))
order by deptno;

-- pivot ¾øÀÌ decode·Î
select deptno,
    max(decode(job, 'CLERK', SAL)) "CLERK",
    max(decode(job, 'SALESMAN', SAL)) SALESMAN,
    max(decode(job, 'PRESIDENT', SAL)) PRESIDENT,
    max(decode(job, 'MANAGER', SAL)) MANAGER,
    max(decode(job, 'ANALYST', SAL)) ANALYST
from emp
group by deptno
order by deptno;

-- unpivot
select *
from (select deptno,
    max(decode(job, 'CLERK', SAL)) "CLERK",
    max(decode(job, 'SALESMAN', SAL)) SALESMAN,
    max(decode(job, 'PRESIDENT', SAL)) PRESIDENT,
    max(decode(job, 'MANAGER', SAL)) MANAGER,
    max(decode(job, 'ANALYST', SAL)) ANALYST
    from emp
    group by deptno
    order by deptno)
unpivot(sal for job in (CLERK, SALESMAN, PRESIDENT, MANAGER, ANALYST))
order by deptno, job;