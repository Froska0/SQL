-- 2.1.6 Задание

-- Создать таблицу author следующей структуры:
-- Поле 	Тип, описание
-- author_id 	INT PRIMARY KEY AUTO_INCREMENT
-- name_author 	VARCHAR(50)

create table author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name_author VARCHAR(50)
);
select * from author;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.1.7 Задание
-- Заполнить таблицу author. В нее включить следующих авторов:
--     Булгаков М.А.
--     Достоевский Ф.М.
--     Есенин С.А.
 --    Пастернак Б.Л.

insert into author (name_author) values
    ('Булгаков М.А.'),
    ('Достоевский Ф.М.'),
    ('Есенин С.А.'),
    ('Пастернак Б.Л.');
select * from author;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.1.8 Задание
-- Перепишите запрос на создание таблицы book , чтобы ее структура соответствовала структуре, показанной на логической схеме (таблица genre уже создана, порядок следования столбцов - как на логической схеме в таблице book, genre_id  - внешний ключ) . Для genre_id ограничение о недопустимости пустых значений не задавать. В качестве главной таблицы для описания поля  genre_idиспользовать таблицу genre следующей структуры:
-- Поле 		Тип, описание
-- genre_id 	INT PRIMARY KEY AUTO_INCREMENT
-- name_genre 	VARCHAR(30)

CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50), 
    author_id INT NOT NULL, 
    genre_id INT,
    price DECIMAL(8,2), 
    amount INT, 
    FOREIGN KEY (author_id)  REFERENCES author (author_id), 
    FOREIGN KEY (genre_id)  REFERENCES genre (genre_id) 
);
select * from book;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.1.9 Задание
-- Создать таблицу book той же структуры, что и на предыдущем шаге. Будем считать, что при удалении автора из таблицы author, должны удаляться все записи о книгах из таблицы book, написанные этим автором. А при удалении жанра из таблицы genre для соответствующей записи book установить значение Null в столбце genre_id. 

CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50), 
    author_id INT NOT NULL, 
    genre_id INT,
    price DECIMAL(8,2), 
    amount INT, 
    FOREIGN KEY (author_id)  REFERENCES author (author_id) ON DELETE CASCADE, 
    FOREIGN KEY (genre_id)  REFERENCES genre (genre_id) ON DELETE SET NULL
);
select * from book;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.1.11 Задание
-- Добавьте три последние записи (с ключевыми значениями 6, 7, 8) в таблицу book, первые 5 записей уже добавлены:
-- book_id 	title 			author_id 	genre_id 	price 		amount
-- 6 		Стихотворения и поэмы 	3 		2 		650.00 		15
-- 7 		Черный человек 		3 		2 		570.20 		6
-- 8 		Лирика 			4 		2 		518.99 		2

insert into book (title, author_id, genre_id, price, amount) values
('Стихотворения и поэмы', 3, 2, 650.00, 15),
('Черный человек', 3, 2, 570.20, 6),
('Лирика', 4, 2, 518.99, 2);

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.2.2 Задание
-- Вывести название, жанр и цену тех книг, количество которых больше 8, в отсортированном по убыванию цены виде.

select title, name_genre, price
FROM 
    genre INNER JOIN book
    ON genre.genre_id = book.genre_id    
WHERE amount > 8
ORDER BY price DESC;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.2.3 Задание
-- Вывести все жанры, которые не представлены в книгах на складе.

SELECT name_genre
FROM genre LEFT JOIN book
     ON genre.genre_id = book.genre_id
WHERE book.genre_id is NULL
; 

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.2.4 Задание
-- Есть список городов, хранящийся в таблице city:
-- city_id 	name_city
-- 1 		Москва
-- 2 		Санкт-Петербург
-- 3 		Владивосток
-- Необходимо в каждом городе провести выставку книг каждого автора в течение 2020 года. Дату проведения выставки выбрать случайным образом. Создать запрос, который выведет город, автора и дату проведения выставки. Последний столбец назвать Дата. Информацию вывести, отсортировав сначала в алфавитном порядке по названиям городов, а потом по убыванию дат проведения выставок.

SELECT name_city, name_author, DATE_ADD('2020-02-02', INTERVAL FLOOR(RAND() * 365) DAY) AS Дата
FROM 
    city, author
    ORDER BY name_city, Дата DESC
    ;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.2.5 Задание
-- Вывести информацию о книгах (жанр, книга, автор), относящихся к жанру, включающему слово «роман» в отсортированном по названиям книг виде.

select name_genre, title, name_author
from book
join genre on book.genre_id = genre.genre_id
join author on book.author_id = author.author_id
where name_genre = 'Роман'
order by title;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.2.6 Задание
-- Посчитать количество экземпляров  книг каждого автора из таблицы author.  Вывести тех авторов,  количество книг которых меньше 10, в отсортированном по возрастанию количества виде. Последний столбец назвать Количество.

SELECT name_author, sum(amount) AS Количество
FROM 
    author LEFT JOIN book
    on author.author_id = book.author_id
GROUP BY name_author
HAVING Количество < 10 or COUNT(title) = 0
ORDER BY Количество; 

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.2.7 Задание
-- Вывести в алфавитном порядке всех авторов, которые пишут только в одном жанре. Поскольку у нас в таблицах так занесены данные, что у каждого автора книги только в одном жанре,  для этого запроса внесем изменения в таблицу book. Пусть у нас  книга Есенина «Черный человек» относится к жанру «Роман», а книга Булгакова «Белая гвардия» к «Приключениям» (эти изменения в таблицы уже внесены).

select name_author from book
join author on book.author_id = author.author_id
GROUP BY name_author
HAVING count(DISTINCT genre_id) = 1;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.2.8 Задание
-- Вывести информацию о книгах (название книги, фамилию и инициалы автора, название жанра, цену и количество экземпляров книги), написанных в самых популярных жанрах, в отсортированном в алфавитном порядке по названию книг виде. Самым популярным считать жанр, общее количество экземпляров книг которого на складе максимально.

SELECT title, name_author, name_genre, price, amount
FROM 
    author 
    INNER JOIN book ON author.author_id = book.author_id
    INNER JOIN genre ON  book.genre_id = genre.genre_id
WHERE genre.genre_id IN    
(SELECT query_in_1.genre_id
FROM (
      SELECT genre_id, SUM(amount) AS sum_amount
      FROM book
      GROUP BY genre_id 
    ) query_in_1
    INNER JOIN (
      SELECT genre_id, SUM(amount) AS sum_amount
      FROM book
      GROUP BY genre_id
      ORDER BY sum_amount DESC
      LIMIT 1
     ) query_in_2
     ON query_in_1.sum_amount= query_in_2.sum_amount
)
ORDER BY title;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.2.9 Задание
-- Если в таблицах supply  и book есть одинаковые книги, которые имеют равную цену,  вывести их название и автора, а также посчитать общее количество экземпляров книг в таблицах supply и book,  столбцы назвать Название, Автор  и Количество.

SELECT title AS Название, name_author AS Автор, SUM(book.amount + supply.amount) AS Количество
FROM supply 
INNER JOIN book USING(price,title)
INNER JOIN author ON author.name_author = supply.author
GROUP BY author.name_author, book.title;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.3.2 Задание
-- Для книг, которые уже есть на складе (в таблице book), но по другой цене, чем в поставке (supply),  необходимо в таблице book увеличить количество на значение, указанное в поставке,  и пересчитать цену. А в таблице  supply обнулить количество этих книг. Формула для пересчета цены:
-- price=(p1*k1+p2*k2)/(k1+k2)
-- где  p1, p2 - цена книги в таблицах book и supply; k1, k2 - количество книг в таблицах book и supply.

UPDATE book 
     INNER JOIN author ON author.author_id = book.author_id
     INNER JOIN supply ON book.title = supply.title 
                         and supply.author = author.name_author
SET book.price = (book.price * book.amount + supply.price * supply.amount) / (book.amount + supply.amount),
    book.amount = book.amount + supply.amount, 
    supply.amount = 0   
WHERE book.price <> supply.price;
SELECT * FROM book;
SELECT * FROM supply;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.3.3 Задание
-- Включить новых авторов в таблицу author с помощью запроса на добавление, а затем вывести все данные из таблицы author.  Новыми считаются авторы, которые есть в таблице supply, но нет в таблице author.

INSERT INTO author (name_author) 
SELECT supply.author
FROM author 
    RIGHT JOIN supply on author.name_author = supply.author
WHERE name_author IS Null
;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.3.4 Задание
-- Добавить новые книги из таблицы supply в таблицу book на основе сформированного выше запроса. Затем вывести для просмотра таблицу book.

Insert into book (title, author_id, price, amount)
SELECT title, author_id, price, amount
FROM 
    author 
    INNER JOIN supply ON author.name_author = supply.author
WHERE amount <> 0;
select * from book;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.3.5 Задание
--  Занести для книги «Стихотворения и поэмы» Лермонтова жанр «Поэзия», а для книги «Остров сокровищ» Стивенсона - «Приключения». (Использовать два запроса).

UPDATE book
SET genre_id = (
       SELECT genre_id 
       FROM genre 
       WHERE name_genre = 'Поэзия'
      )
WHERE book_id = 10;

UPDATE book
SET genre_id = (
       SELECT genre_id 
       FROM genre 
       WHERE name_genre = 'Приключения'
      )
WHERE book_id = 11;
SELECT * FROM book;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.3.6 Задание
-- Удалить всех авторов и все их книги, общее количество книг которых меньше 20.

DELETE FROM author WHERE
author_id in (select author_id
from book
GROUP BY author_id
HAVING sum(amount) < 20)
;
SELECT * FROM author;
SELECT * FROM book;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.3.7 Задание
-- Удалить все жанры, к которым относится меньше 4-х книг. В таблице book для этих жанров установить значение Null.

DELETE FROM genre 
WHERE genre_id in (
    select genre_id
from book                  
GROUP BY genre_id
HAVING count(amount) < 4
);
SELECT * FROM genre;
SELECT * FROM book;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.3.8 Задание
-- Удалить всех авторов, которые пишут в жанре "Поэзия". Из таблицы book удалить все книги этих авторов. В запросе для отбора авторов использовать полное название жанра, а не его id.

DELETE FROM author
USING 
    author 
    INNER JOIN book ON author.author_id = book.author_id
WHERE book.genre_id in (
    select book.genre_id
from book
join genre on book.genre_id = genre.genre_id
WHERE name_genre = 'Поэзия'
GROUP BY book.genre_id)
;
SELECT * FROM author;
SELECT * FROM book;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.4.5 Задание
-- Вывести все заказы Баранова Павла (id заказа, какие книги, по какой цене и в каком количестве он заказал) в отсортированном по номеру заказа и названиям книг виде.

select buy.buy_id, book.title, book.price, buy_book.amount
from client
    JOIN buy ON client.client_id = buy.client_id
    JOIN buy_book ON buy_book.buy_id = buy.buy_id
    JOIN book ON buy_book.book_id=book.book_id
WHERE name_client ='Баранов Павел'
ORDER BY buy.buy_id, book.title; 

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.4.6 Задание
-- Посчитать, сколько раз была заказана каждая книга, для книги вывести ее автора (нужно посчитать, в каком количестве заказов фигурирует каждая книга).  Вывести фамилию и инициалы автора, название книги, последний столбец назвать Количество. Результат отсортировать сначала  по фамилиям авторов, а потом по названиям книг.

select name_author, title, count(buy_book.amount) AS Количество
from author
join book on author.author_id = book.author_id
left join buy_book on book.book_id = buy_book.book_id
GROUP BY name_author,title
ORDER BY name_author,title;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.4.7 Задание
-- Вывести города, в которых живут клиенты, оформлявшие заказы в интернет-магазине. Указать количество заказов в каждый город, этот столбец назвать Количество. Информацию вывести по убыванию количества заказов, а затем в алфавитном порядке по названию городов.

select name_city, count(buy.client_id) AS Количество
from city
join client on city.city_id = client.city_id
join buy on buy.client_id = client.client_id
GROUP BY name_city
ORDER BY Количество DESC, name_city;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.4.8 Задание
-- Вывести номера всех оплаченных заказов и даты, когда они были оплачены.

select buy_id, date_step_end
from step
join buy_step on step.step_id = buy_step.step_id
where date_step_beg is not null and date_step_end is not null and name_step = 'Оплата';

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.4.9 Задание
-- Вывести информацию о каждом заказе: его номер, кто его сформировал (фамилия пользователя) и его стоимость (сумма произведений количества заказанных книг и их цены), в отсортированном по номеру заказа виде. Последний столбец назвать Стоимость.

select buy.buy_id, name_client, sum(buy_book.amount * price) AS Стоимость
from buy_book
join buy USING(buy_id)
join book USING(book_id)
join client using (client_id)
GROUP BY buy.buy_id
ORDER BY buy.buy_id

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.4.10 Задание
-- Вывести номера заказов (buy_id) и названия этапов,  на которых они в данный момент находятся. Если заказ доставлен –  информацию о нем не выводить. Информацию отсортировать по возрастанию buy_id.

select buy_id, name_step
from step
join buy_step using(step_id)
where 
not (buy_step.step_id = 4 and date_step_end is not null)
and (date_step_beg is not null and date_step_end is null)
ORDER BY buy_id;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.4.11 Задание
-- В таблице city для каждого города указано количество дней, за которые заказ может быть доставлен в этот город (рассматривается только этап Транспортировка). Для тех заказов, которые прошли этап транспортировки, вывести количество дней за которое заказ реально доставлен в город. А также, если заказ доставлен с опозданием, указать количество дней задержки, в противном случае вывести 0. В результат включить номер заказа (buy_id), а также вычисляемые столбцы Количество_дней и Опоздание. Информацию вывести в отсортированном по номеру заказа виде.

select buy_step.buy_id, 
DATEDIFF(date_step_end, date_step_beg) AS Количество_дней, 
if(DATEDIFF(date_step_end, date_step_beg) > days_delivery, DATEDIFF(date_step_end, date_step_beg) - days_delivery, 0) AS Опоздание
from city
join client on city.city_id = client.city_id
join buy on client.client_id = buy.client_id
join buy_step on buy.buy_id = buy_step.buy_id
join step on buy_step.step_id = step.step_id
where step.name_step = 'Транспортировка' and date_step_beg is not null and DATEDIFF(date_step_end, date_step_beg) is not null
ORDER BY buy_id;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.4.12 Задание
-- Выбрать всех клиентов, которые заказывали книги Достоевского, информацию вывести в отсортированном по алфавиту виде. В решении используйте фамилию автора, а не его id.

select name_client
from client
join buy using(client_id)
join buy_book using(buy_id)
join book using(book_id)
join author using(author_id)
where name_author = 'Достоевский Ф.М.'
GROUP BY name_client
ORDER BY name_client;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.4.13 Задание
-- Вывести жанр (или жанры), в котором было заказано больше всего экземпляров книг, указать это количество. Последний столбец назвать Количество.

SELECT name_genre, Количество
FROM
    (SELECT name_genre, sum(amount_1) as Количество
        FROM (SELECT book_id, SUM(amount) AS amount_1
        FROM buy_book
        GROUP BY book_id) AS temp
        INNER JOIN book ON temp.book_id = book.book_id
        INNER JOIN genre ON book.genre_id = genre.genre_id
        GROUP BY name_genre) as k
        where k.Количество IN (SELECT MAX(t.Количество) as n
                               FROM( SELECT name_genre, sum(amount_1) as Количество
                               FROM (SELECT book_id, SUM(amount) AS amount_1
                               FROM buy_book
                               GROUP BY book_id) AS temp
                               INNER JOIN book ON temp.book_id = book.book_id
                               INNER JOIN genre ON book.genre_id = genre.genre_id
                               GROUP BY name_genre) as t);

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.4.14 Задание
-- Сравнить ежемесячную выручку от продажи книг за текущий и предыдущий годы. Для этого вывести год, месяц, сумму выручки в отсортированном сначала по возрастанию месяцев, затем по возрастанию лет виде. Название столбцов: Год, Месяц, Сумма.

SELECT YEAR(date_payment) AS Год, MONTHNAME(date_payment)AS Месяц, SUM(price*amount) AS Сумма
FROM buy_archive
GROUP BY Год, Месяц
UNION ALL
SELECT YEAR(date_step_end) AS Год, MONTHNAME(date_step_end)AS Месяц,  SUM(price * buy_book.amount) AS Сумма
FROM buy_step
    INNER JOIN buy_book USING(buy_id)
    INNER JOIN book USING(book_id)
WHERE date_step_end IS NOT NULL AND step_id = 1
GROUP BY Год, Месяц
ORDER BY Месяц ASC, Год ASC;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.4.15 Задание
-- Для каждой отдельной книги необходимо вывести информацию о количестве проданных экземпляров и их стоимости за 2020 и 2019 год . Вычисляемые столбцы назвать Количество и Сумма. Информацию отсортировать по убыванию стоимости.

select title, sum(query_in.sum_amount) as Количество, sum(query_in.sum_price) as Сумма
from (
    select title, sum(buy_archive.amount) as sum_amount, sum(buy_archive.amount * buy_archive.price) as sum_price
    from buy_archive
         inner join book using(book_id)
    group by title
    union all
    select title, sum(buy_book.amount) as sum_amount, sum(buy_book.amount * book.price) as sum_price
    from book
         inner join buy_book using(book_id)
         inner join buy_step using(buy_id)
    where step_id = 1 and date_step_end is not null
    group by title
) as query_in 
group by title
order by Сумма desc;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.5.2 Задание
-- Включить нового человека в таблицу с клиентами. Его имя Попов Илья, его email popov@test, проживает он в Москве.

INSERT INTO client (name_client, city_id, email)
SELECT 'Попов Илья', city.city_id, 'popov@test'
FROM city
where name_city = 'Москва';
SELECT * FROM client;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.5.3 Задание
-- Создать новый заказ для Попова Ильи. Его комментарий для заказа: «Связаться со мной по вопросу доставки».

insert into buy (buy_description, client_id)
SELECT 'Связаться со мной по вопросу доставки', client.client_id
from client
where name_client = 'Попов Илья';
select * from buy;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.5.4 Задание
-- В таблицу buy_book добавить заказ с номером 5. Этот заказ должен содержать книгу Пастернака «Лирика» в количестве двух экземпляров и книгу Булгакова «Белая гвардия» в одном экземпляре.

insert into buy_book (buy_id, book_id, amount)
select 
    5, book.book_id, 2     
from book, author 
where name_author LIKE 'Пастернак %' and title = 'Лирика'
;
insert into buy_book (buy_id, book_id, amount)
select 
    5, book.book_id, 1     
from book, author 
where name_author LIKE 'Булгаков %' and title = 'Белая гвардия'
;
select * from buy_book;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.5.5 Задание
-- Количество тех книг на складе, которые были включены в заказ с номером 5, уменьшить на то количество, которое в заказе с номером 5  указано.

UPDATE book, buy_book 
SET book.amount = book.amount - buy_book.amount
WHERE buy_id = 5 and book.book_id = buy_book.book_id
;
SELECT * FROM book;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.5.6 Задание
-- Создать счет (таблицу buy_pay) на оплату заказа с номером 5, в который включить название книг, их автора, цену, количество заказанных книг и  стоимость. Последний столбец назвать Стоимость. Информацию в таблицу занести в отсортированном по названиям книг виде.

create table buy_pay AS
select title, name_author, price, buy_book.amount,
price * buy_book.amount AS Стоимость
from buy_book
join book using (book_id)
join author using (author_id)
where buy_book.buy_id = 5
order by title;
SELECT * FROM buy_pay;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.5.7 Задание

create table buy_pay AS
select DISTINCT buy_id, 
(select sum(buy_book.amount)
from buy_book
join book using (book_id)
join author using (author_id)
where buy_book.buy_id = 5) AS Количество,
(select 
sum(price * buy_book.amount) AS Стоимость
from buy_book
join book using (book_id)
join author using (author_id)
where buy_book.buy_id = 5) AS Итого
from buy_book
where buy_id = 5
;
select * from buy_pay;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.5.8 Задание
-- В таблицу buy_step для заказа с номером 5 включить все этапы из таблицы step, которые должен пройти этот заказ. В столбцы date_step_beg и date_step_end всех записей занести Null.

insert into buy_step(buy_id, step_id)
select 5, buy_step.step_id
from buy join buy_step using(buy_id)
cross join step
group by step_id;
select * from buy_step;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.5.9 Задание
-- В таблицу buy_step занести дату 12.04.2020 выставления счета на оплату заказа с номером 5.

update buy_step 
set date_step_beg = '2020-04-12'
where buy_id = 5 and step_id = 1;

select * from buy_step where buy_id = 5;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.5.10 Задание
-- Завершить этап «Оплата» для заказа с номером 5, вставив в столбец date_step_end дату 13.04.2020, и начать следующий этап («Упаковка»), задав в столбце date_step_beg для этого этапа ту же дату.
-- Реализовать два запроса для завершения этапа и начала следующего. Они должны быть записаны в общем виде, чтобы его можно было применять для любых этапов, изменив только текущий этап. Для примера пусть это будет этап «Оплата».

update buy_step
join step using (step_id)
set date_step_end = '2020-04-13'
where buy_step.buy_id = 5 and name_step = 'Оплата';
update buy_step
join step using (step_id)
set date_step_beg = '2020-04-13'
where buy_step.buy_id = 5 and buy_step.step_id = 
(SELECT step_id + 1 
FROM step
WHERE name_step = 'Оплата');
select * from buy_step where buy_id = 5;



