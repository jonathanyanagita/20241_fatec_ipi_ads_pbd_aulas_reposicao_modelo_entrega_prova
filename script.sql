-- ----------------------------------------------------------------
-- 1 Base de dados e criação de tabela
--escreva a sua solução aqui
create table prova(

	STUDENTID serial primary key,
	AGE int,
	GENDER int,
	HS_TYPE int,
	SCHOLARSHIP int,
	WORK int,
	ACTIVITY int,
	PARTNER int,
	SALARY int,
	TRANSPORT int,
	LIVING int,
	MOTHER_EDU int,
	FATHER_EDU int,
	SIBLINGS int,
	KIDS int,
	MOTHER_JOB int,
	FATHER_JOB int,
	STUDY_HRS int,
	READ_FREQ int,
	READ_FREQ_SCI int,
	ATTEND_DEPT int,
	IMPACT int,
	ATTEND int,
	PREP_STUDY int,
	PREP_EXAM int,
	NOTES int,
	LISTENS int,
	LIKES_DISCUSS int,
	CLASSROOM int,
	CUML_GPA int,
	EXP_GPA int,
	COURSE_ID int,
	GRADE int
);

-- ----------------------------------------------------------------
-- 2 Resultado em função da formação dos pais
--escreva a sua solução aqui
DO $$
DECLARE
cur_aprovados_pai_ph REFCURSOR;
contador INT;
BEGIN
OPEN cur_aprovados_pai_ph FOR EXECUTE
'select count(*) FROM prova WHERE grade != 0 AND (mother_edu = 6 OR father_edu = 6)';
LOOP
FETCH cur_aprovados_pai_ph INTO contador;
exit WHEN NOT FOUND;
RAISE NOTICE '%', contador;
END LOOP;
CLOSE cur_aprovados_pai_ph;
END; $$

-- ----------------------------------------------------------------
-- 3 Resultado em função dos estudos
--escreva a sua solução aqui
DO $$
DECLARE
    cur_sozinho_aprovado REFCURSOR;
    contador int;
BEGIN
    OPEN cur_sozinho_aprovado FOR EXECUTE
    format('select count(*) FROM prova WHERE partner =2 AND grade != 0');
LOOP
FETCH cur_sozinho_aprovado INTO contador;
exit WHEN NOT FOUND;
-- If contador = 0 THEN
--  contador = -1;
RAISE NOTICE '%', contador;
END LOOP;
CLOSE cur_sozinho_aprovado;
END; $$

-- ----------------------------------------------------------------
-- 4 Salário versus estudos
--escreva a sua solução aqui


-- ----------------------------------------------------------------
-- 5. Limpeza de valores NULL
--escreva a sua solução aqui

-- ----------------------------------------------------------------
