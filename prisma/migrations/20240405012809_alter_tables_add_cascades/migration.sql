-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_check_in" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "attendde_id" INTEGER NOT NULL,
    CONSTRAINT "check_in_attendde_id_fkey" FOREIGN KEY ("attendde_id") REFERENCES "attenddes" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_check_in" ("attendde_id", "createdAt", "id") SELECT "attendde_id", "createdAt", "id" FROM "check_in";
DROP TABLE "check_in";
ALTER TABLE "new_check_in" RENAME TO "check_in";
CREATE UNIQUE INDEX "check_in_attendde_id_key" ON "check_in"("attendde_id");
CREATE TABLE "new_attenddes" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "event_id" TEXT NOT NULL,
    CONSTRAINT "attenddes_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "events" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_attenddes" ("created_at", "email", "event_id", "id", "name") SELECT "created_at", "email", "event_id", "id", "name" FROM "attenddes";
DROP TABLE "attenddes";
ALTER TABLE "new_attenddes" RENAME TO "attenddes";
CREATE UNIQUE INDEX "attenddes_event_id_email_key" ON "attenddes"("event_id", "email");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
