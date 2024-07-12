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
DO $$
DECLARE
estudantes INT;
contador INT := 0;
sozinho INT := 1;
falhou INT := 0;
cur_estudante_sozinho_aprovado CURSOR(sozinho INT, falhou INT) FOR
SELECT * FROM prova WHERE prep_study = sozinho AND grade > falhou;
BEGIN
OPEN cur_estudante_sozinho_aprovado(sozinho := sozinho,falhou := falhou);
LOOP
FETCH cur_estudante_sozinho_aprovado INTO estudantes;
EXIT WHEN NOT FOUND;
contador := contador + 1;
END LOOP;
IF contador = 0 THEN contador := -1;
END IF;
RAISE NOTICE '%', contador;
CLOSE cur_estudante_sozinho_aprovado;
END; $$

-- ----------------------------------------------------------------
-- 5. Limpeza de valores NULL
--escreva a sua solução aqui
DO $$
DECLARE
cur_deletar REFCURSOR;
tupla RECORD;
BEGIN
OPEN cur_deletar SCROLL FOR 
SELECT * FROM prova;
LOOP
FETCH cur_deletar INTO tupla;
EXIT WHEN NOT FOUND;
IF tupla.studentid ISNULL OR tupla.salary ISNULL OR tupla.mother_edu ISNULL OR tupla.father_edu ISNULL
OR tupla.prep_study ISNULL OR tupla.prep_exam ISNULL OR tupla.grade ISNULL THEN DELETE FROM prova WHERE CURRENT OF cur_deletar;
END IF;
END LOOP;
LOOP
FETCH BACKWARD FROM cur_deletar INTO tupla;
EXIT WHEN NOT FOUND;
RAISE NOTICE '%', tupla;
END LOOP;
CLOSE cur_deletar;
END; $$
-- ----------------------------------------------------------------
