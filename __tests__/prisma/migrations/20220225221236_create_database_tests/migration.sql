-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "is_solved" BOOLEAN NOT NULL DEFAULT false,
    "create_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "equipments" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "department" TEXT,
    "area" TEXT,
    "create_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "solutions" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "descripton" TEXT NOT NULL,
    "solver_id" TEXT NOT NULL,
    "create_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "solutions_solver_id_fkey" FOREIGN KEY ("solver_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "incidents" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "action" TEXT NOT NULL,
    "date_solution" DATETIME NOT NULL,
    "equipment_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "solution_id" TEXT,
    "create_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "incidents_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "incidents_equipment_id_fkey" FOREIGN KEY ("equipment_id") REFERENCES "equipments" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "incidents_solution_id_fkey" FOREIGN KEY ("solution_id") REFERENCES "solutions" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);
