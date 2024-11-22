BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "task" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text NOT NULL,
    "done" boolean NOT NULL
);


--
-- MIGRATION VERSION FOR template
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('template', '20241119103830423', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20241119103830423', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
