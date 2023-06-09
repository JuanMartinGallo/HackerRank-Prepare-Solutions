SELECT
    S.CONTEST_ID,
    S.HACKER_ID,
    S.NAME,
    COALESCE(S.SUM_TOTAL_SUBMISSIONS, 0) AS TOTAL_SUBMISSIONS,
    COALESCE(
        S.SUM_TOTAL_ACCEPTED_SUBMISSIONS,
        0
    ) AS TOTAL_ACCEPTED_SUBMISSIONS,
    COALESCE(V.SUM_TOTAL_VIEWS, 0) AS TOTAL_VIEWS,
    COALESCE(V.SUM_TOTAL_UNIQUE_VIEWS, 0) AS TOTAL_UNIQUE_VIEWS
FROM (
        SELECT
            CON.CONTEST_ID,
            CON.HACKER_ID,
            CON.NAME,
            SUM(SS.TOTAL_SUBMISSIONS) AS SUM_TOTAL_SUBMISSIONS,
            SUM(
                SS.TOTAL_ACCEPTED_SUBMISSIONS
            ) AS SUM_TOTAL_ACCEPTED_SUBMISSIONS
        FROM CONTESTS CON
            INNER JOIN COLLEGES COL USING (CONTEST_ID)
            INNER JOIN CHALLENGES CHAL USING (COLLEGE_ID)
            LEFT JOIN SUBMISSION_STATS SS USING (CHALLENGE_ID)
        GROUP BY
            CON.CONTEST_ID,
            CON.HACKER_ID,
            CON.NAME
    ) S
    INNER JOIN (
        SELECT
            CON.CONTEST_ID,
            CON.HACKER_ID,
            CON.NAME,
            SUM(VS.TOTAL_VIEWS) AS SUM_TOTAL_VIEWS,
            SUM(VS.TOTAL_UNIQUE_VIEWS) AS SUM_TOTAL_UNIQUE_VIEWS
        FROM CONTESTS CON
            INNER JOIN COLLEGES COL USING (CONTEST_ID)
            INNER JOIN CHALLENGES CHAL USING (COLLEGE_ID)
            LEFT JOIN VIEW_STATS VS USING (CHALLENGE_ID)
        GROUP BY
            CON.CONTEST_ID,
            CON.HACKER_ID,
            CON.NAME
    ) V ON S.CONTEST_ID = V.CONTEST_ID
    AND S.HACKER_ID = V.HACKER_ID
    AND S.NAME = V.NAME
WHERE
    COALESCE(S.SUM_TOTAL_SUBMISSIONS, 0) + COALESCE(
        S.SUM_TOTAL_ACCEPTED_SUBMISSIONS,
        0
    ) + COALESCE(V.SUM_TOTAL_VIEWS, 0) + COALESCE(V.SUM_TOTAL_UNIQUE_VIEWS, 0) > 0
ORDER BY S.CONTEST_ID ASC;