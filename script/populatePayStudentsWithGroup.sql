
---- CREATE FUNCTION payStudentsWithGroup
-- CREATE OR REPLACE FUNCTION "payStudentsWithGroup"
-- (
-- 	"@groupIdToProcess" INTEGER,
-- 	"@periodToProcess" INTEGER,
-- 	"@incomeCategoryName" VARCHAR,
-- 	"@paymentMethodName" VARCHAR,
-- 	"@dateRegistered" DATE,
-- 	"@detail" VARCHAR
-- )

-- RETURNS void AS $$

-- DECLARE

-- 	"@paymentMethodId" INTEGER;
-- 	"@amountPay" INTEGER;
-- 	"@incomeCategoryId" INTEGER;
-- 	"@incomeTempCount" INTEGER;
-- 	"@incomeId" INTEGER;
	
-- BEGIN

-- --CREATE TEMPORARY TABLE groupTemp
-- 		DROP TABLE IF EXISTS "groupTemp";

-- 		CREATE TEMPORARY TABLE "groupTemp" (
-- 		"studentId" bigint not null,
-- 		"groupId" bigint not null,
-- 		"courseId" bigint not null,
-- 		"coursePeriodId" integer not null);
	
	
-- 	--RETRIVE SINGLE GROUPID WITH NO GROUP
-- 		INSERT INTO "groupTemp" ( "studentId", "courseId", "groupId", "coursePeriodId")
-- 		SELECT 
-- 			id, 
-- 			"courseId", 
-- 			"groupId", 
-- 			(
-- 				SELECT id 
-- 				FROM "coursePeriodo"
-- 				WHERE "coursePeriodo"."courseId" = "student"."courseId"
-- 				AND "coursePeriodo"."period" = "@periodToProcess"
-- 			)
-- 		FROM student
-- 		WHERE "groupId" IS NOT NULL AND "groupId" =  "@groupIdToProcess";
	
-- 	--CREATE TEMPORARY TABLE groupTemp
-- 		DROP TABLE IF EXISTS "amountTemp";

-- 		CREATE TEMPORARY TABLE "amountTemp" (
-- 		"amountPay" bigint not null);
	
	
-- 	--RETRIVE SINGLE GROUPID WITH NO GROUP
-- 		SELECT SUM ("amountPay")
-- 		INTO "@amountPay"
-- 		FROM "groupTemp" 
-- 		JOIN "coursePeriodo" ON "groupTemp"."courseId" = "coursePeriodo"."courseId" 
-- 		WHERE "coursePeriodo"."period" = "@periodToProcess";
	
-- 	--RETRIVE incomeCategoryId
-- 		SELECT id
-- 		INTO "@incomeCategoryId"
-- 		FROM "incomeCategory"
-- 		WHERE name = "@incomeCategoryName";
		
-- 	--RETRIVE paymentMethodId
-- 		SELECT id
-- 		INTO "@paymentMethodId"
-- 		FROM "paymentMethod"
-- 		WHERE name = "@paymentMethodName" ;

-- 		RAISE NOTICE '%', "@paymentMethodId";
	
	
-- 	--DROP-CREATE-INSERT INTO TEMPORARY TABLE incomeTemp
-- 		DROP TABLE IF EXISTS "incomeTemp";

-- 		CREATE TEMPORARY TABLE "incomeTemp" (
-- 		id bigint generated by default as identity not null,
-- 		"incomeCategoryId" bigint not null,
-- 		"amount" bigint not null, 
-- 		"dateRegistered" date not null,
-- 		"studentId" integer null,
-- 		"paymentMethodId" integer not null,
-- 		detail text null);
		
-- 		INSERT INTO "incomeTemp" ("incomeCategoryId", amount, "dateRegistered", "studentId", "paymentMethodId", detail ) 
-- 		VALUES(  
-- 			"@incomeCategoryId",
-- 			"@amountPay", 
-- 			"@dateRegistered",
-- 			NULL,
-- 			"@paymentMethodId",
-- 			"@detail");
		
		
-- 		SELECT id
-- 		INTO "@incomeTempCount"
-- 		FROM "incomeTemp"
-- 		ORDER BY id DESC
-- 		LIMIT 1;
		
		
-- 	--INSERT INTO INCOME
-- 		INSERT INTO income ("incomeCategoryId", amount, "dateRegistered","studentId","paymentMethodId",detail)
-- 		SELECT 
-- 			"incomeTemp"."incomeCategoryId",
-- 			"incomeTemp"."amount", 
-- 			"incomeTemp"."dateRegistered",
-- 			"incomeTemp"."studentId",
-- 			"incomeTemp"."paymentMethodId",
-- 			"incomeTemp".detail
-- 		FROM "incomeTemp"
-- 		LIMIT 1
-- 		RETURNING id INTO "@incomeId";

-- 	--DROP-CREATE-INSERT INTO  TEMPORARY TABLE incomeIdAndStudenIdTemp
-- 		DROP TABLE IF EXISTS "incomeIdAndStudenIdTemp";

-- 		CREATE TEMPORARY TABLE "incomeIdAndStudenIdTemp" (
-- 		"incomeId" bigint not null,
-- 		"studentId" bigint not null);
		
-- 		INSERT INTO "incomeIdAndStudenIdTemp" ("incomeId", "studentId")
-- 		SELECT  "@incomeId", "studentId" 
-- 		FROM "groupTemp";
		
	
-- 	--INSERT INTO studentPeriodFeePayment 
-- 		INSERT INTO "studentPeriodFeePayment" ("student", "coursePeriod", "income")
-- 		SELECT
-- 			"groupTemp"."studentId",
-- 			"groupTemp"."coursePeriodId",
-- 			 "@incomeId"
-- 		FROM "groupTemp";
			

-- END ;
-- $$ LANGUAGE plpgsql;



---- CALL FUNCTION payStudentsWithGroup
-- DO $$
-- DECLARE
-- 	"@amountStudentsGroup" INTEGER :=	
-- 	(
-- 		SELECT COUNT(*) 
-- 		FROM "group"
-- 	);
-- BEGIN
	
-- 	PERFORM   "payStudentsWithGroup"(CAST("@amountStudentsGroup" * 1 AS INTEGER), 1, 'Cuotas', 'Efectivo', CURRENT_DATE, '');
-- 	PERFORM   "payStudentsWithGroup"(CAST("@amountStudentsGroup" * 0.8 AS INTEGER), 2, 'Cuotas', 'Efectivo', CURRENT_DATE, '');
-- 	PERFORM   "payStudentsWithGroup"(CAST("@amountStudentsGroup" * 0.6 AS INTEGER), 3, 'Cuotas', 'Efectivo', CURRENT_DATE, '');
-- 	PERFORM   "payStudentsWithGroup"(CAST("@amountStudentsGroup" * 0.5 AS INTEGER), 4, 'Cuotas', 'Efectivo', CURRENT_DATE, '');
-- 	PERFORM   "payStudentsWithGroup"(CAST("@amountStudentsGroup" * 0.2 AS INTEGER), 5, 'Cuotas', 'Efectivo', CURRENT_DATE, '');
-- 	PERFORM   "payStudentsWithGroup"(CAST("@amountStudentsGroup" * 0.1 AS INTEGER), 6, 'Cuotas', 'Efectivo', CURRENT_DATE, '');

-- END $$;
