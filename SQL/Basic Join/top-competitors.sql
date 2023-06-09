SELECT H.HACKER_ID, H.NAME
FROM SUBMISSIONS S
    INNER JOIN CHALLENGES C ON S.CHALLENGE_ID = C.CHALLENGE_ID
    INNER JOIN HACKERS H ON S.HACKER_ID = H.HACKER_ID
    INNER JOIN DIFFICULTY D ON C.DIFFICULTY_LEVEL = D.DIFFICULTY_LEVEL
WHERE S.SCORE = D.SCORE
GROUP BY H.HACKER_ID, H.NAME
HAVING COUNT(H.HACKER_ID) > 1
ORDER BY
    COUNT(H.HACKER_ID) DESC,
    H.HACKER_ID ASC;