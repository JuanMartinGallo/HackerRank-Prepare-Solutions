SELECT Name
FROM Students
WHERE Marks > 75
ORDER BY
    SUBSTR(Name, - 3),
    ID ASC;