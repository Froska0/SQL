-- 3.1.2 Задание
--Вывести студентов, которые сдавали дисциплину «Основы баз данных», 
--указать дату попытки и результат. Информацию вывести по убыванию результатов тестирования.

select name_student, date_attempt, result
from attempt
join student using (student_id)
join subject using (subject_id)
where name_subject = 'Основы баз данных'
ORDER BY result DESC;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.1.3 Задание
--Вывести, сколько попыток сделали студенты по каждой дисциплине, 
--а также средний результат попыток, который округлить до 2 знаков после запятой. 
--Под результатом попытки понимается процент правильных ответов на вопросы теста, который занесен в столбец result.  
--В результат включить название дисциплины, а также вычисляемые столбцы Количество и Среднее. 
--Информацию вывести по убыванию средних результатов.

select name_subject, count(attempt_id) AS Количество, round(avg(result), 2) AS Среднее
from subject
left join attempt on subject.subject_id = attempt.subject_id
GROUP BY name_subject
ORDER BY Среднее DESC;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.1.4 Задание
--Вывести студентов (различных студентов), имеющих максимальные результаты попыток. 
--Информацию отсортировать в алфавитном порядке по фамилии студента.
--Максимальный результат не обязательно будет 100%, поэтому явно это значение в запросе не задавать.

select name_student, result
from attempt
join student using(student_id)
where result =
(select max(result) from attempt)
ORDER BY name_student;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.1.5 Задание
--Если студент совершал несколько попыток по одной и той же дисциплине, 
--то вывести разницу в днях между первой и последней попыткой. 
--В результат включить фамилию и имя студента, название дисциплины и вычисляемый столбец Интервал. 
--Информацию вывести по возрастанию разницы. Студентов, сделавших одну попытку по дисциплине, не учитывать. 

select name_student, name_subject, DATEDIFF(max(date_attempt),min(date_attempt)) AS Интервал
from attempt
join student using (student_id)
join subject using (subject_id)
group by student_id, subject_id
HAVING DATEDIFF(max(date_attempt),min(date_attempt)) >0
ORDER BY Интервал;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.1.6 Задание
--Студенты могут тестироваться по одной или нескольким дисциплинам (не обязательно по всем). 
--Вывести дисциплину и количество уникальных студентов (столбец назвать Количество), 
--которые по ней проходили тестирование . 
--Информацию отсортировать сначала по убыванию количества, а потом по названию дисциплины.
--В результат включить и дисциплины, тестирование по которым студенты еще не проходили, 
--в этом случае указать количество студентов 0.

select name_subject, count(distinct student_id) AS Количество
from subject s left join attempt a
on s.subject_id = a.subject_id
group by name_subject
order by Количество desc, name_subject;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.1.7 Задание
--Случайным образом отберите 3 вопроса по дисциплине «Основы баз данных». 
--В результат включите столбцы question_id и name_question.

select question_id, name_question from question
where subject_id =
(select subject_id from subject where name_subject = 'Основы баз данных')
ORDER BY RAND()
limit 3;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.1.8 Задание
--Вывести вопросы, которые были включены в тест для Семенова Ивана по дисциплине «Основы SQL» 2020-05-17  
--(значение attempt_id для этой попытки равно 7). 
--Указать, какой ответ дал студент и правильный он или нет (вывести Верно или Неверно). 
--В результат включить вопрос, ответ и вычисляемый столбец  Результат.

select q.name_question, a.name_answer, 
if (a.is_correct = 0, 'Неверно','Верно') AS Результат
from testing t
    join answer a on t.answer_id = a.answer_id
    join question q on t.question_id = q.question_id
where t.attempt_id = 7

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.1.9 Задание
--Посчитать результаты тестирования. 
--Результат попытки вычислить как количество правильных ответов, деленное на 3 
--(количество вопросов в каждой попытке) и умноженное на 100. 
--Результат округлить до двух знаков после запятой. Вывести фамилию студента, название предмета, дату и результат. 
--Последний столбец назвать Результат. Информацию отсортировать сначала по фамилии студента, 
--потом по убыванию даты попытки.

select st.name_student, su.name_subject, att.date_attempt, round(sum(an.is_correct)/3*100,2) AS Результат 
from testing t
    join attempt att on t.attempt_id = att.attempt_id
    join student st on att.student_id = st.student_id
    join subject su on att.subject_id = su.subject_id
    join answer an on t.answer_id = an.answer_id
group by st.name_student, su.name_subject, att.date_attempt
order by st.name_student, att.date_attempt desc;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.1.10 Задание
--Для каждого вопроса вывести процент успешных решений, 
--то есть отношение количества верных ответов к общему количеству ответов, 
--значение округлить до 2-х знаков после запятой. Также вывести название предмета, к которому относится вопрос, 
--и общее количество ответов на этот вопрос. В результат включить название дисциплины, вопросы по ней 
--(столбец назвать Вопрос), а также два вычисляемых столбца Всего_ответов и Успешность. 
--Информацию отсортировать сначала по названию дисциплины, потом по убыванию успешности, 
--а потом по тексту вопроса в алфавитном порядке.
--Поскольку тексты вопросов могут быть длинными, обрезать их 30 символов и добавить многоточие "...".

select name_subject, concat(left(name_question,30),'...') AS Вопрос, count(t.answer_id) AS Всего_ответов, round(sum(is_correct)/count(t.answer_id)*100,2) AS Успешность
from subject su
    join question q on su.subject_id = q.subject_id
    join testing t on q.question_id = t.question_id
    left join answer an on t.answer_id = an.answer_id
group by name_subject, name_question
order by name_subject, Успешность DESC, Вопрос

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.2.2 Задание
--В таблицу attempt включить новую попытку для студента Баранова Павла по дисциплине «Основы баз данных». 
--Установить текущую дату в качестве даты выполнения попытки.

insert into attempt (student_id, subject_id, date_attempt) 
select
(select student_id from student where name_student = 'Баранов Павел'),
(select subject_id from subject where name_subject = 'Основы баз данных'),
now();
select * from attempt;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.2.3 Задание
--Случайным образом выбрать три вопроса (запрос) по дисциплине, тестирование по которой собирается проходить студент, 
--занесенный в таблицу attempt последним, и добавить их в таблицу testing. 
--id последней попытки получить как максимальное значение id из таблицы attempt.

insert into testing (attempt_id, question_id)
select
    (select max(attempt_id) from attempt),
    (select question_id from question where subject_id = 
        (select subject_id from attempt where attempt_id = 
             (select max(attempt_id) from attempt))
    order by rand() limit 1);
    insert into testing (attempt_id, question_id)
select
    (select max(attempt_id) from attempt),
    (select question_id from question where subject_id = 
        (select subject_id from attempt where attempt_id = 
             (select max(attempt_id) from attempt))
    order by rand() limit 1);
    insert into testing (attempt_id, question_id)
select
    (select max(attempt_id) from attempt),
    (select question_id from question where subject_id = 
        (select subject_id from attempt where attempt_id = 
             (select max(attempt_id) from attempt))
    order by rand() limit 1);

select * from testing;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.2.4 Задание
--Студент прошел тестирование (то есть все его ответы занесены в таблицу testing), 
--далее необходимо вычислить результат(запрос) и занести его в таблицу attempt для соответствующей попытки.  
--Результат попытки вычислить как количество правильных ответов, деленное на 3 
--(количество вопросов в каждой попытке) и умноженное на 100. Результат округлить до целого.
-- Будем считать, что мы знаем id попытки,  для которой вычисляется результат, в нашем случае это 8. 

update attempt
set result = 
	(select round(sum(a.is_correct)/3*100,0)
	from testing t left join answer a on t.answer_id = a.answer_id
	where attempt_id = 8)
where attempt_id = 8;
select * from attempt;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.2.5 Задание
--Удалить из таблицы attempt все попытки, выполненные раньше 1 мая 2020 года.

delete from attempt
where datediff(date_attempt, '2020-05-01') < 0;
select * from attempt;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.3.2 Задание
--Вывести абитуриентов, которые хотят поступать на образовательную программу «Мехатроника и робототехника» 
--в отсортированном по фамилиям виде.

select name_enrollee from enrollee where enrollee_id in
    (select enrollee_id from program_enrollee where program_id =
        (select program_id from program where name_program = 'Мехатроника и робототехника'))
order by name_enrollee;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.3.3 Задание
--Вывести образовательные программы, на которые для поступления необходим предмет «Информатика». 
--Программы отсортировать в обратном алфавитном порядке.

select name_program from program where program_id in
    (select program_id from program_subject where subject_id =
        (select subject_id from subject where name_subject = 'Информатика'))
order by name_program desc;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.3.4 Задание
--Выведите количество абитуриентов, сдавших ЕГЭ по каждому предмету, максимальное, минимальное и 
--среднее значение баллов по предмету ЕГЭ. Вычисляемые столбцы назвать Количество, Максимум, Минимум, Среднее. 
--Информацию отсортировать по названию предмета в алфавитном порядке, 
--среднее значение округлить до одного знака после запятой.

select name_subject, count(enrollee_id) AS Количество, 
max(result) AS Максимум, min(result) AS Минимум, round(avg(result),1) AS Среднее from subject
left join enrollee_subject using (subject_id)
group by name_subject
order by name_subject;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.3.5 Задание
--Вывести образовательные программы, для которых минимальный балл ЕГЭ по каждому предмету больше или равен 40 баллам. 
--Программы вывести в отсортированном по алфавиту виде.

select name_program from program where program_id in
    (select program_id from program_subject 
    group by program_id
    having min(min_result) >=40)
order by name_program;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.3.6 Задание
--Вывести образовательные программы, которые имеют самый большой план набора,  вместе с этой величиной.

select name_program, plan from program where plan =
    (select max(plan) from program);

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.3.7 Задание
--Посчитать, сколько дополнительных баллов получит каждый абитуриент. 
--Столбец с дополнительными баллами назвать Бонус. Информацию вывести в отсортированном по фамилиям виде.

select name_enrollee, IF(sum(bonus)is null,0,sum(bonus)) AS Бонус 
from enrollee e
    left join enrollee_achievement ea on e.enrollee_id = ea.enrollee_id
    left join achievement a on ea.achievement_id = a.achievement_id
group by name_enrollee
order by name_enrollee;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.3.8 Задание
--Выведите сколько человек подало заявление на каждую образовательную программу и конкурс на нее 
--(число поданных заявлений деленное на количество мест по плану), округленный до 2-х знаков после запятой. 
--В запросе вывести название факультета, к которому относится образовательная программа, 
--название образовательной программы, план набора абитуриентов на образовательную программу (plan), 
--количество поданных заявлений (Количество) и Конкурс. 
--Информацию отсортировать в порядке убывания конкурса.

select name_department, name_program, plan, count(enrollee_id) AS Количество, round(count(enrollee_id)/plan,2) AS Конкурс
from department d 
    left join program p on d.department_id = p.department_id
    left join program_enrollee pe on p.program_id = pe.program_id
group by name_department, name_program, plan
order by Конкурс desc;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.3.9 Задание
--Вывести образовательные программы, на которые для поступления необходимы предмет «Информатика» и «Математика» 
--в отсортированном по названию программ виде.

select name_program from program where program_id in
    (select program_id from program_subject where subject_id in 
        (select subject_id from subject where name_subject = 'Математика' or name_subject = 'Информатика')
    group by program_id
    having count(subject_id) = 2)
order by name_program;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.3.10 Задание
--Посчитать количество баллов каждого абитуриента на каждую образовательную программу, на которую он подал заявление, 
--по результатам ЕГЭ. В результат включить название образовательной программы, фамилию и имя абитуриента, 
--а также столбец с суммой баллов, который назвать itog. Информацию вывести в отсортированном сначала 
--по образовательной программе, а потом по убыванию суммы баллов виде.

select name_program, name_enrollee, SUM(result) AS itog from enrollee e
    join program_enrollee pe on e.enrollee_id = pe.enrollee_id
    join program p on p.program_id = pe.program_id
    join program_subject ps on p.program_id = ps.program_id
    join enrollee_subject es on ps.subject_id = es.subject_id  and es.enrollee_id = e.enrollee_id
group by name_program, name_enrollee
order by name_program, itog desc;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.4.2 Задание
--Создать вспомогательную таблицу applicant,  куда включить id образовательной программы, id абитуриента, 
--сумму баллов абитуриентов (столбец itog) в отсортированном сначала по id образовательной программы, 
--а потом по убыванию суммы баллов виде.

create table applicant AS
select program_id, es.enrollee_id, SUM(result) AS itog
from program_enrollee pe
    join program_subject ps using(program_id)
    join enrollee_subject es on ps.subject_id = es.subject_id and es.enrollee_id = pe.enrollee_id
group by program_id, es.enrollee_id
order by program_id, itog desc;
select * from applicant;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.4.3 Задание
--Из таблицы applicant, созданной на предыдущем шаге, удалить записи, 
--если абитуриент на выбранную образовательную программу не набрал минимального балла хотя бы по одному предмету.

delete from applicant using applicant 
    join program_subject using (program_id)
    join enrollee_subject using (enrollee_id, subject_id)
where result < min_result;
select * from applicant;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.4.4 Задание
--Повысить итоговые баллы абитуриентов в таблице applicant на значения дополнительных баллов.

update applicant 
    join (select enrollee_id, sum(bonus) AS Бонус from enrollee_achievement
         left join achievement using(achievement_id)
         group by enrollee_id) AS bonuses using (enrollee_id)
    set itog = itog + Бонус;
select * from applicant;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.4.5 Задание
--Поскольку при добавлении дополнительных баллов, абитуриенты по каждой образовательной программе могут следовать 
--не в порядке убывания суммарных баллов, необходимо создать новую таблицу applicant_order на основе таблицы applicant. 
--При создании таблицы данные нужно отсортировать сначала по id образовательной программы, 
--потом по убыванию итогового балла. А таблицу applicant, которая была создана как вспомогательная, необходимо удалить.

create table applicant_order AS
select program_id, enrollee_id, itog from applicant
order by program_id, itog desc;
select * from applicant_order;
drop table applicant;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.4.6 Задание
--Включить в таблицу applicant_order новый столбец str_id целого типа , расположить его перед первым.

alter table applicant_order add str_id int first;
select * from applicant_order;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.4.7 Задание
--Занести в столбец str_id таблицы applicant_order нумерацию абитуриентов, 
--которая начинается с 1 для каждой образовательной программы. Использовать переменные, а не оконные функции.

SET @num_pr := 0;
SET @row_num := 1;
update applicant_order 
    SET str_id = 
     if (program_id = @num_pr, @row_num := @row_num + 1, @row_num := 1 and @num_pr := @num_pr + 1);
select * from applicant_order;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.4.7 Задание
--Создать таблицу student,  в которую включить абитуриентов, которые могут быть рекомендованы к зачислению  
--в соответствии с планом набора. Информацию отсортировать сначала в алфавитном порядке по названию программ, 
--а потом по убыванию итогового балла.

create table student AS
    select name_program, name_enrollee, itog from applicant_order ao
        join enrollee e using (enrollee_id)
        join program p using (program_id)
where str_id <= plan
order by name_program, itog desc;   
select * from student;
