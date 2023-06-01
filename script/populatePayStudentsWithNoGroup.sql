---- CREATE FUNCTION payStudentsWithNoGroup
-- CREATE OR REPLACE FUNCTION "payStudentsWithNoGroup"
-- (
--   "@amountOfStudentsToProcess" INTEGER,
--   "@periodToProcess" INTEGER,
--   "@incomeCategoryName" VARCHAR,
--   "@paymentMethodName" VARCHAR,
--   "@dateRegistered" DATE,
--   "@detail" VARCHAR
-- )
-- RETURNS void AS $$

-- DECLARE
--   "@studentId" INTEGER;
--   "@courseId" INTEGER;
--   "@coursePeriodId" INTEGER;
--   "@paymentAmount" INTEGER;
--   "@incomeId" INTEGER;
--   "@incomeCategoryId" INTEGER;
--   "@paymentMethodId" INTEGER;
--   "@incomeTempCount" INTEGER;
-- BEGIN

-- -- CREATE TEMPORARY TABLE studentsTemp
--   DROP TABLE IF EXISTS "studentsTemp";
--   CREATE TEMPORARY TABLE "studentsTemp" (
--     "studentId" bigint not null,
--     "courseId" bigint not null
--   );

-- -- RETRIEVE SINGLE STUDENTID WITH NO GROUP
--   INSERT INTO "studentsTemp" ("studentId", "courseId")
--   SELECT id, "courseId"
--   FROM student
--   WHERE "groupId" IS NULL
--   LIMIT "@amountOfStudentsToProcess";

-- -- RETRIEVE incomeCategoryId
--   SELECT id INTO "@incomeCategoryId"
--   FROM "incomeCategory"
--   WHERE name = "@incomeCategoryName";

-- -- RETRIEVE paymentMethodId
--   SELECT id INTO "@paymentMethodId"
--   FROM "paymentMethod"
--   WHERE name = "@paymentMethodName";

--   RAISE NOTICE '%', "@paymentMethodId";

--   BEGIN
--   -- DROP-CREATE-INSERT INTO TEMPORARY TABLE incomeTemp
--     DROP TABLE IF EXISTS "incomeTemp";
--     CREATE TEMPORARY TABLE "incomeTemp" (
--       id bigint generated by default as identity not null,
--       "incomeCategoryId" bigint not null,
--       "amount" bigint not null,
--       "dateRegistered" date not null,
--       "studentId" integer null,
--       "paymentMethodId" integer not null,
--       detail text null,
--       "coursePeriodId" integer not null
--     );

--     INSERT INTO "incomeTemp" ("incomeCategoryId", amount, "dateRegistered", "studentId", "paymentMethodId", detail, "coursePeriodId")
--     SELECT
--       "@incomeCategoryId",
--       (
--         SELECT "amountPay"
--         FROM "coursePeriodo"
--      	WHERE "coursePeriodo"."courseId" = "studentsTemp"."courseId" 
-- 		AND "coursePeriodo"."period" = "@periodToProcess"
--       ),
--       "@dateRegistered",
--       "studentId",
--       "@paymentMethodId",
--       "@detail",
--       (
-- 		SELECT "id" 
-- 		FROM "coursePeriodo"
-- 		WHERE "coursePeriodo"."courseId" = "studentsTemp"."courseId" 
-- 		AND "coursePeriodo"."period" = "@periodToProcess"
--       )
--    	FROM "studentsTemp";

-- 	SELECT id
-- 	INTO "@incomeTempCount"
-- 	FROM "incomeTemp"
-- 	ORDER BY id DESC
-- 	LIMIT 1;

--     RAISE NOTICE '%', "@incomeTempCount";

--     -- INSERT INTO INCOME
--     INSERT INTO income ("incomeCategoryId", amount, "dateRegistered", "studentId", "paymentMethodId", detail)
--     SELECT
--       "incomeTemp"."incomeCategoryId",
--       "incomeTemp"."amount",
--       "incomeTemp"."dateRegistered",
--       "incomeTemp"."studentId",
--       "incomeTemp"."paymentMethodId",
--       "incomeTemp".detail
--     FROM "incomeTemp";

--     -- DROP-CREATE-INSERT INTO TEMPORARY TABLE incomeIdAndStudenIdTemp
--     DROP TABLE IF EXISTS "incomeIdAndStudenIdTemp";
--     CREATE TEMPORARY TABLE "incomeIdAndStudenIdTemp" (
--       "incomeId" bigint not null,
--       "studentId" bigint not null
--     );

--     INSERT INTO "incomeIdAndStudenIdTemp" ("incomeId", "studentId")
--     SELECT id, "studentId"
--     FROM "income"
--     ORDER BY id DESC
--     LIMIT "@incomeTempCount";

--     -- INSERT INTO studentPeriodFeePayment period 1
--     INSERT INTO "studentPeriodFeePayment" ("student", "coursePeriod", "income")
--     SELECT
--       "incomeIdAndStudenIdTemp"."studentId",
--       "incomeTemp"."coursePeriodId",
--       "incomeIdAndStudenIdTemp"."incomeId"
--     FROM "incomeIdAndStudenIdTemp"
--     JOIN "incomeTemp" ON "incomeIdAndStudenIdTemp"."studentId" = "incomeTemp"."studentId";
--   END;
-- END;
-- $$ LANGUAGE plpgsql;

---- CALL FUNCTION amountStudentsNoGroup
-- DO $$
-- DECLARE
-- 	"@amountStudentsNoGroup" INTEGER :=	
-- 	(
-- 		SELECT COUNT(*) 
-- 		FROM student
-- 		WHERE "groupId" IS NULL
-- 	);
-- BEGIN
	
-- 	PERFORM  "payStudentsWithNoGroup"(CAST("@amountStudentsNoGroup" * 1 AS INTEGER), 1, 'Cuotas', 'Efectivo', CURRENT_DATE, '');
-- 	PERFORM  "payStudentsWithNoGroup"(CAST("@amountStudentsNoGroup" * 0.8 AS INTEGER), 2, 'Cuotas', 'Efectivo', CURRENT_DATE, '');
-- 	PERFORM  "payStudentsWithNoGroup"(CAST("@amountStudentsNoGroup" * 0.6 AS INTEGER), 3, 'Cuotas', 'Efectivo', CURRENT_DATE, '');
-- 	PERFORM  "payStudentsWithNoGroup"(CAST("@amountStudentsNoGroup" * 0.5 AS INTEGER), 4, 'Cuotas', 'Efectivo', CURRENT_DATE, '');
-- 	PERFORM  "payStudentsWithNoGroup"(CAST("@amountStudentsNoGroup" * 0.2 AS INTEGER), 5, 'Cuotas', 'Efectivo', CURRENT_DATE, '');
-- 	PERFORM  "payStudentsWithNoGroup"(CAST("@amountStudentsNoGroup" * 0.1 AS INTEGER), 6, 'Cuotas', 'Efectivo', CURRENT_DATE, '');

-- END $$;