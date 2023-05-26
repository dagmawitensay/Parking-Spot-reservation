/*
  Warnings:

  - A unique constraint covering the columns `[email]` on the table `compound_owner` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[email]` on the table `spot_user` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `compound_owner_email_key` ON `compound_owner`(`email`);

-- CreateIndex
CREATE UNIQUE INDEX `spot_user_email_key` ON `spot_user`(`email`);
