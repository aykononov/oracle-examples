/* ОПТИМИЗАЦИЯ - Возможность использовать индекс для доступа к строкам таблицы */

SELECT empno FROM emp WHERE empno >= 7369;

-----------------------------------------------------------------------------
| Id  | Operation          | Name          | Rows | Bytes | Cost | Time     |
-----------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |               |   14 |    56 |    1 | 00:00:01 |
| * 1 |   INDEX RANGE SCAN | SYS_C00171904 |   14 |    56 |    1 | 00:00:01 |
-----------------------------------------------------------------------------

Predicate Information (identified by operation id):
------------------------------------------
* 1 - access("EMPNO">=7369)

--===========================================================================--

SELECT empno FROM emp WHERE empno + 0 >= 7369;

----------------------------------------------------------------------------
| Id  | Operation         | Name          | Rows | Bytes | Cost | Time     |
----------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |               |   14 |    56 |    1 | 00:00:01 |
| * 1 |   INDEX FULL SCAN | SYS_C00171904 |   14 |    56 |    1 | 00:00:01 |
----------------------------------------------------------------------------

Predicate Information (identified by operation id):
------------------------------------------
* 1 - filter("EMPNO"+0>=7369)

--===========================================================================--

SELECT empno FROM emp WHERE empno BETWEEN 7000 AND 8000;

-----------------------------------------------------------------------------
| Id  | Operation          | Name          | Rows | Bytes | Cost | Time     |
-----------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |               |   14 |    56 |    1 | 00:00:01 |
| * 1 |   INDEX RANGE SCAN | SYS_C00171904 |   14 |    56 |    1 | 00:00:01 |
-----------------------------------------------------------------------------

Predicate Information (identified by operation id):
------------------------------------------
* 1 - access("EMPNO">=7000 AND "EMPNO"<=8000)

--===========================================================================--

SELECT empno FROM emp WHERE empno IN ( 7369, 7865, 8888 );

-------------------------------------------------------------------------------
| Id  | Operation            | Name          | Rows | Bytes | Cost | Time     |
-------------------------------------------------------------------------------
|   0 | SELECT STATEMENT     |               |    2 |     8 |    1 | 00:00:01 |
|   1 |   INLIST ITERATOR    |               |      |       |      |          |
| * 2 |    INDEX UNIQUE SCAN | SYS_C00171904 |    2 |     8 |    1 | 00:00:01 |
-------------------------------------------------------------------------------

Predicate Information (identified by operation id):
------------------------------------------
* 2 - access("EMPNO"=7369 OR "EMPNO"=7865 OR "EMPNO"=8888)

--===========================================================================--

SELECT empno FROM emp WHERE empno = ANY ( 7369, 7865, 8888 );

-------------------------------------------------------------------------------
| Id  | Operation            | Name          | Rows | Bytes | Cost | Time     |
-------------------------------------------------------------------------------
|   0 | SELECT STATEMENT     |               |    2 |     8 |    1 | 00:00:01 |
|   1 |   INLIST ITERATOR    |               |      |       |      |          |
| * 2 |    INDEX UNIQUE SCAN | SYS_C00171904 |    2 |     8 |    1 | 00:00:01 |
-------------------------------------------------------------------------------

Predicate Information (identified by operation id):
------------------------------------------
* 2 - access("EMPNO"=7369 OR "EMPNO"=7865 OR "EMPNO"=8888)

--===========================================================================--

SELECT empno FROM emp WHERE empno = ALL ( 7369, 7865, 8888 );

-------------------------------------------------------------------------------
| Id  | Operation            | Name          | Rows | Bytes | Cost | Time     |
-------------------------------------------------------------------------------
|   0 | SELECT STATEMENT     |               |    1 |     4 |    0 |          |
| * 1 |   FILTER             |               |      |       |      |          |
| * 2 |    INDEX UNIQUE SCAN | SYS_C00171904 |    1 |     4 |    0 | 00:00:01 |
-------------------------------------------------------------------------------

Predicate Information (identified by operation id):
------------------------------------------
* 1 - filter(NULL IS NOT NULL AND NULL IS NOT NULL)
* 2 - access("EMPNO"=7369)
