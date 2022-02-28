/*
  Warnings:

  - You are about to drop the column `create_at` on the `solutions` table. All the data in the column will be lost.
  - You are about to drop the column `create_at` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `is_solved` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `create_at` on the `equipments` table. All the data in the column will be lost.
  - You are about to drop the column `create_at` on the `incidents` table. All the data in the column will be lost.
  - Added the required column `email` to the `users` table without a default value. This is not possible if the table is not empty.
  - Added the required column `password_hash` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_solutions" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "descripton" TEXT NOT NULL,
    "solver_id" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "solutions_solver_id_fkey" FOREIGN KEY ("solver_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_solutions" ("descripton", "id", "solver_id") SELECT "descripton", "id", "solver_id" FROM "solutions";
DROP TABLE "solutions";
ALTER TABLE "new_solutions" RENAME TO "solutions";
CREATE TABLE "new_users" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password_hash" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT false,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_users" ("id", "name") SELECT "id", "name" FROM "users";
DROP TABLE "users";
ALTER TABLE "new_users" RENAME TO "users";
CREATE TABLE "new_equipments" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "department" TEXT,
    "area" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_equipments" ("area", "department", "description", "id", "name") SELECT "area", "department", "description", "id", "name" FROM "equipments";
DROP TABLE "equipments";
ALTER TABLE "new_equipments" RENAME TO "equipments";
CREATE TABLE "new_incidents" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "action" TEXT NOT NULL,
    "date_solution" DATETIME NOT NULL,
    "equipment_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "solution_id" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "incidents_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "incidents_equipment_id_fkey" FOREIGN KEY ("equipment_id") REFERENCES "equipments" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "incidents_solution_id_fkey" FOREIGN KEY ("solution_id") REFERENCES "solutions" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);
INSERT INTO "new_incidents" ("action", "date_solution", "equipment_id", "id", "solution_id", "user_id") SELECT "action", "date_solution", "equipment_id", "id", "solution_id", "user_id" FROM "incidents";
DROP TABLE "incidents";
ALTER TABLE "new_incidents" RENAME TO "incidents";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
