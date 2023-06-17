SELECT (
        SELECT WANDS.ID
        FROM WANDS
            INNER JOIN WANDS_PROPERTY ON WANDS.CODE = WANDS_PROPERTY.CODE
        WHERE
            WANDS_PROPERTY.AGE = WP.AGE
            AND WANDS.COINS_NEEDED = MIN(WA.COINS_NEEDED)
    ),
    WP.AGE,
    MIN(WA.COINS_NEEDED),
    WA.POWER
FROM WANDS AS WA
    INNER JOIN WANDS_PROPERTY AS WP ON WA.CODE = WP.CODE
WHERE WP.IS_EVIL = 0
GROUP BY WA.POWER DESC, WP.AGE DESC