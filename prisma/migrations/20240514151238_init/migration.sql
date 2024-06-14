/*
  Warnings:

  - You are about to drop the column `tripsID` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Trips` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Trips" DROP CONSTRAINT "Trips_busTicketId_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_tripsID_fkey";

-- DropIndex
DROP INDEX "User_id_cart_key";

-- DropIndex
DROP INDEX "User_phone_number_key";

-- AlterTable
ALTER TABLE "User" DROP COLUMN "tripsID",
ALTER COLUMN "id_cart" DROP NOT NULL,
ALTER COLUMN "id_cart" DROP DEFAULT,
ALTER COLUMN "phone_number" DROP NOT NULL,
ALTER COLUMN "phone_number" DROP DEFAULT;

-- DropTable
DROP TABLE "Trips";

-- CreateTable
CREATE TABLE "Trip" (
    "id" SERIAL NOT NULL,
    "busTicketId" INTEGER,

    CONSTRAINT "Trip_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_TripToUser" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_TripToUser_AB_unique" ON "_TripToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_TripToUser_B_index" ON "_TripToUser"("B");

-- AddForeignKey
ALTER TABLE "Trip" ADD CONSTRAINT "Trip_busTicketId_fkey" FOREIGN KEY ("busTicketId") REFERENCES "BusTicket"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_TripToUser" ADD CONSTRAINT "_TripToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "Trip"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_TripToUser" ADD CONSTRAINT "_TripToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
