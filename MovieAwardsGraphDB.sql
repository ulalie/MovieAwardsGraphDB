--ALTER DATABASE MovieAwardsGraphDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
--DROP DATABASE MovieAwardsGraphDB;

USE master
DROP DATABASE IF EXISTS MovieAwardsGraphDB
CREATE DATABASE MovieAwardsGraphDB
USE MovieAwardsGraphDB;

CREATE TABLE Movies
(
id INT NOT NULL PRIMARY KEY,
title NVARCHAR(100) NOT NULL,
country NVARCHAR(50) NOT NULL,
year INT NOT NULL,
genre NVARCHAR(50) NOT NULL
) AS NODE;

CREATE TABLE People
(
id INT NOT NULL PRIMARY KEY,
name NVARCHAR(100) NOT NULL,
country NVARCHAR(50) NOT NULL
) AS NODE;

CREATE TABLE Awards
(
id INT NOT NULL PRIMARY KEY,
category NVARCHAR(100) NOT NULL,
type NVARCHAR(50) NOT NULL
) AS NODE;

CREATE TABLE NominatedFor AS EDGE;

CREATE TABLE Won AS EDGE;

CREATE TABLE ParticipatedIn
(
role NVARCHAR(50) NOT NULL
) AS EDGE;


ALTER TABLE NominatedFor
ADD CONSTRAINT EC_NominatedFor CONNECTION (People TO Awards, Movies TO Awards);

ALTER TABLE Won
ADD CONSTRAINT EC_Won CONNECTION (People TO Awards, Movies TO Awards);

ALTER TABLE ParticipatedIn
ADD CONSTRAINT EC_ParticipatedIn CONNECTION (People TO Movies)

INSERT INTO Movies (id, title, country, year, genre) VALUES
(1, N'Анора', N'США', 2024, N'Драма'),
(2, N'Эмилия Перес', N'Франция', 2024, N'Мюзикл'),
(3, N'Никому не известный', N'США', 2024, N'Биография'),
(4, N'Конклав', N'Великобритания', 2024, N'Триллер'),
(5, N'Мальчишки из «Никеля»', N'США', 2024, N'Драма'),
(6, N'Я всё ещё здесь', N'Бразилия', 2024, N'Драма'),
(7, N'Субстанция', N'Франция', 2024, N'Триллер'),
(8, N'Дюна: Часть вторая', N'США', 2024, N'Фантастика'),
(9, N'Злая: Сказка о ведьме Запада', N'США', 2024, N'Мюзикл'),
(10, N'Бруталист', N'Великобритания', 2024, N'Артхаус'),
(11, N'Настоящая боль', N'США', 2024, N'Драма'),
(12, N'Ученик', N'США', 2024, N'Драма');

INSERT INTO People (id, name, country) VALUES
(1, N'Шон Бэйкер', N'США'),
(2, N'Мэдисон Майки', N'США'),
(3, N'Жак Одиар', N'Франция'),
(4, N'Карла София Гаскон', N'Испания'),
(5, N'Эдриен Броуди', N'США'),
(6, N'Зои Салдана', N'США'),
(7, N'Киран Калкин', N'США'),
(8, N'Лол Кроули', N'Великобритания'),
(9, N'Дэниэл Блумберг', N'США'),
(10, N'Пол Тэйзуэлл', N'США'),
(11, N'Юрий Борисов', N'Россия'),
(12, N'Марк Эйдельштейн', N'Россия');

INSERT INTO Awards (id, category, type) VALUES
(1, N'Лучший фильм', N'Основная'),
(2, N'Лучшая женская роль', N'Актёрская'),
(3, N'Лучшая мужская роль', N'Актёрская'),
(4, N'Лучшая операторская работа', N'Техническая'),
(5, N'Лучшая музыка к фильму', N'Музыка'),
(6, N'Лучшая режиссура', N'Режиссура'),
(7, N'Лучший дизайн костюмов', N'Техническая'),
(8, N'Лучшая роль второго плана', N'Актёрская'),
(9, N'Лучший адаптированный сценарий', N'Сценарий'),
(10, N'Лучший монтаж', N'Техническая');

INSERT INTO NominatedFor ($from_id, $to_id) VALUES
((SELECT $node_id FROM People WHERE id=2), (SELECT $node_id FROM Awards WHERE id=2)), -- Мэдисон Майки на Лучшую женскую роль
((SELECT $node_id FROM People WHERE id=4), (SELECT $node_id FROM Awards WHERE id=2)), -- Карла София Гаскон на Лучшую женскую роль
((SELECT $node_id FROM People WHERE id=5), (SELECT $node_id FROM Awards WHERE id=3)), -- Эдриен Броуди на Лучшую мужскую роль
((SELECT $node_id FROM People WHERE id=6), (SELECT $node_id FROM Awards WHERE id=8)), -- Зои Салдана на роль второго плана
((SELECT $node_id FROM People WHERE id=7), (SELECT $node_id FROM Awards WHERE id=8)), -- Киран Калкин на роль второго плана
((SELECT $node_id FROM People WHERE id=8), (SELECT $node_id FROM Awards WHERE id=4)), -- Лол Кроули на операторскую работу
((SELECT $node_id FROM People WHERE id=9), (SELECT $node_id FROM Awards WHERE id=5)), -- Дэниэл Блумберг на музыку
((SELECT $node_id FROM People WHERE id=10), (SELECT $node_id FROM Awards WHERE id=7)), -- Пол Тэйзуэлл на костюмы
((SELECT $node_id FROM People WHERE id=11), (SELECT $node_id FROM Awards WHERE id=8)), -- Юрий Борисов на роль второго плана
((SELECT $node_id FROM Movies WHERE id=1), (SELECT $node_id FROM Awards WHERE id=1)), -- "Анора" на лучший фильм
((SELECT $node_id FROM Movies WHERE id=10), (SELECT $node_id FROM Awards WHERE id=1)), -- "Бруталист" на лучший фильм
((SELECT $node_id FROM Movies WHERE id=2), (SELECT $node_id FROM Awards WHERE id=1)), -- Эмилия Перес
((SELECT $node_id FROM People WHERE id=3), (SELECT $node_id FROM Awards WHERE id=6)),---- Жак Одиар
((SELECT $node_id FROM Movies WHERE id=5), (SELECT $node_id FROM Awards WHERE id=9)), -- Мальчишки из «Никеля»
((SELECT $node_id FROM Movies WHERE id=4), (SELECT $node_id FROM Awards WHERE id=1)),-- Конклав
((SELECT $node_id FROM Movies WHERE id=10), (SELECT $node_id FROM Awards WHERE id=10));--бруталист


INSERT INTO Won ($from_id, $to_id) VALUES
((SELECT $node_id FROM People WHERE id=2), (SELECT $node_id FROM Awards WHERE id=2)), -- Мэдисон Майки
((SELECT $node_id FROM People WHERE id=5), (SELECT $node_id FROM Awards WHERE id=3)), -- Эдриен Броуди
((SELECT $node_id FROM People WHERE id=6), (SELECT $node_id FROM Awards WHERE id=8)), -- Зои Салдана
((SELECT $node_id FROM People WHERE id=1), (SELECT $node_id FROM Awards WHERE id=6)), -- Шон Бэйкер
((SELECT $node_id FROM People WHERE id=9), (SELECT $node_id FROM Awards WHERE id=5)), -- Дэниэл Блумберг
((SELECT $node_id FROM People WHERE id=10), (SELECT $node_id FROM Awards WHERE id=7)), -- Пол Тэйзуэлл
((SELECT $node_id FROM Movies WHERE id=1), (SELECT $node_id FROM Awards WHERE id=1)),  -- "Анора" - лучший фильм
((SELECT $node_id FROM Movies WHERE id=10),(SELECT $node_id FROM Awards WHERE id=4)),--Лучшая операторская работа
((SELECT $node_id FROM People WHERE id=7),(SELECT $node_id FROM Awards WHERE id=8)),--Лучшая роль второго плана
((SELECT $node_id FROM Movies WHERE id=4), (SELECT $node_id FROM Awards WHERE id=9)),--Лучший адаптированный сценарий
((SELECT $node_id FROM Movies WHERE id=1), (SELECT $node_id FROM Awards WHERE id=10));--лучший монтаж Анора

INSERT INTO ParticipatedIn ($from_id, $to_id, role) VALUES
((SELECT $node_id FROM People WHERE id=1), (SELECT $node_id FROM Movies WHERE id=1), N'Режиссёр'),
((SELECT $node_id FROM People WHERE id=2), (SELECT $node_id FROM Movies WHERE id=1), N'Актриса'),
((SELECT $node_id FROM People WHERE id=3), (SELECT $node_id FROM Movies WHERE id=2), N'Режиссёр'),
((SELECT $node_id FROM People WHERE id=4), (SELECT $node_id FROM Movies WHERE id=2), N'Актриса'),
((SELECT $node_id FROM People WHERE id=5), (SELECT $node_id FROM Movies WHERE id=10), N'Актёр'),
((SELECT $node_id FROM People WHERE id=6), (SELECT $node_id FROM Movies WHERE id=2), N'Актриса второго плана'),
((SELECT $node_id FROM People WHERE id=7), (SELECT $node_id FROM Movies WHERE id=11), N'Актёр второго плана'),
((SELECT $node_id FROM People WHERE id=8), (SELECT $node_id FROM Movies WHERE id=10), N'Оператор'),
((SELECT $node_id FROM People WHERE id=9), (SELECT $node_id FROM Movies WHERE id=10), N'Композитор'),
((SELECT $node_id FROM People WHERE id=10), (SELECT $node_id FROM Movies WHERE id=9), N'Костюмер'),
((SELECT $node_id FROM People WHERE id=11), (SELECT $node_id FROM Movies WHERE id=1), N'Актёр второго плана'),
((SELECT $node_id FROM People WHERE id=12), (SELECT $node_id FROM Movies WHERE id=1), N'Продюсер'),
((SELECT $node_id FROM People WHERE id=12), (SELECT $node_id FROM Movies WHERE id=1), N'Актёр');

--MATCH

--Найти всех людей, номинированных на лучшую женскую роль
SELECT p.name [Имя]
FROM People AS P, NominatedFor AS N, Awards AS A
WHERE MATCH(P-(N)->A)
AND A.category = N'Лучшая женская роль';

--Люди с номинациями в Техническая категориях
SELECT P.name [Имя], a.category AS [Техническая номенация]
FROM People AS P, NominatedFor AS N, Awards AS A
WHERE MATCH(P-(N)->A)
AND A.type = N'Техническая';

--Участники фильма "Анора" и их роли
SELECT P.name [Имя], PIn.role [Профессия]
FROM People AS P, ParticipatedIn AS PIn, Movies AS M
WHERE MATCH(P-(PIn)->m)
AND M.title = N'Анора';

--Люди, которые и номинировались в одной категории
SELECT 
    A.category [Категория],
    P1.name [Первый номинант],
    P2.name [Второй номинант]
FROM 
    People P1, 
    People P2, 
    Awards A, 
    NominatedFor N1, 
    NominatedFor N2
WHERE 
    MATCH(P1-(N1)->A<-(N2)-P2)  -- Оба номинированы на одну награду
    AND P1.id < P2.id            -- Исключаем дубликаты (A-B и B-A)
ORDER BY 
    A.category, 
    P1.name, 
    P2.name;

--Режиссеры фильмов, номинированных на "Лучший фильм"
SELECT P.name [Режиссёр], M.title [Фильм]
FROM People AS P, ParticipatedIn AS PIn, Movies AS M, NominatedFor AS N, Awards AS A
WHERE MATCH(P-(PIn)->M-(N)->A)
AND A.category = N'Лучший фильм'
AND  PIn.role = N'Режиссёр'

--Все актёры из США, участвовавшие в фильмах 2024 года
SELECT P.name [Имя], M.title [Фильм]
FROM People AS P, ParticipatedIn AS PIn, Movies AS M
WHERE MATCH(P-(PIn)->M)
AND P.country = N'США'
AND M.year = 2024
AND (PIn.role = N'Актёр' OR PIn.role = N'Актриса');


----SHORTEST_PATH

--Найти все награды/номинации для "Мэдисон Майки" — лично и через фильмы
-- Личные номинации
SELECT 
    p.name AS StartPerson,
    NULL AS MoviePath,
    STRING_AGG(a.category, ' -> ') WITHIN GROUP (GRAPH PATH) AS AwardPath,
    N'Номинация' AS AwardType
FROM
    People AS p,
    NominatedFor FOR PATH AS nf,
    Awards FOR PATH AS a
WHERE MATCH(
    SHORTEST_PATH(
        p (-(nf)-> a)+
    )
)
AND p.name = N'Мэдисон Майки'

UNION ALL
-- Личные победы
SELECT 
    p.name AS StartPerson,
    NULL AS MoviePath,
    STRING_AGG(a.category, ' -> ') WITHIN GROUP (GRAPH PATH) AS AwardPath,
    N'Победа' AS AwardType
FROM
    People AS p,
    Won FOR PATH AS w,
    Awards FOR PATH AS a
WHERE MATCH(
    SHORTEST_PATH(
        p (-(w)-> a)+
    )
)
AND p.name = N'Мэдисон Майки'

UNION ALL
-- Через фильмы: номинации
SELECT 
    p.name AS StartPerson,
    STRING_AGG(m.title, ' -> ') WITHIN GROUP (GRAPH PATH) AS MoviePath,
    STRING_AGG(a.category, ' -> ') WITHIN GROUP (GRAPH PATH) AS AwardPath,
    N'Номинация' AS AwardType
FROM
    People AS p,
    ParticipatedIn FOR PATH AS pi,
    Movies FOR PATH AS m,
    NominatedFor FOR PATH AS nf,
    Awards FOR PATH AS a
WHERE MATCH(
    SHORTEST_PATH(
        p (-(pi)-> m - (nf)-> a)+
    )
)
AND p.name = N'Мэдисон Майки'

UNION ALL
-- Через фильмы: победы
SELECT 
    p.name AS StartPerson,
    STRING_AGG(m.title, ' -> ') WITHIN GROUP (GRAPH PATH) AS MoviePath,
    STRING_AGG(a.category, ' -> ') WITHIN GROUP (GRAPH PATH) AS AwardPath,
    N'Победа' AS AwardType
FROM
    People AS p,
    ParticipatedIn FOR PATH AS pi,
    Movies FOR PATH AS m,
    Won FOR PATH AS w,
    Awards FOR PATH AS a
WHERE MATCH(
    SHORTEST_PATH(
        p (-(pi)-> m - (w)-> a)+
    )
)
AND p.name = N'Мэдисон Майки'



--Здесь используется шаблон {1,2} — путь длиной 1 или 2, то есть:
--Фильм может сам получить награду напрямую (например, как лучший фильм — шаг 1)
--Или через промежуточного участника (например, фильм → актёр → награда — шаг 2, но в вашей модели это не реализовано; если нужно, можно дописать).
SELECT
    m.title AS Movie,
    STRING_AGG(a.category, ' -> ') WITHIN GROUP (GRAPH PATH) AS AwardPath
FROM
    Movies AS m,
    Won FOR PATH AS w,
    Awards FOR PATH AS a
WHERE MATCH(
    SHORTEST_PATH(
      m (-(w)-> a){1,2}
    )
)
AND m.title = N'Анора'
