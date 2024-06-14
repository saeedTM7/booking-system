/*
  Warnings:

  - A unique constraint covering the columns `[phone_number]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id_cart]` on the table `User` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "User" ADD COLUMN     "id_cart" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "phone_number" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "tripsID" INTEGER NOT NULL DEFAULT 0;

-- CreateTable
CREATE TABLE "Trips" (
    "id" SERIAL NOT NULL,
    "busTicketId" INTEGER NOT NULL,

    CONSTRAINT "Trips_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BusTicket" (
    "id" SERIAL NOT NULL,
    "origin" TEXT NOT NULL,
    "destination" TEXT NOT NULL,
    "departureDateTime" TIMESTAMP(3) NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "BusTicket_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_phone_number_key" ON "User"("phone_number");

-- CreateIndex
CREATE UNIQUE INDEX "User_id_cart_key" ON "User"("id_cart");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_tripsID_fkey" FOREIGN KEY ("tripsID") REFERENCES "Trips"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Trips" ADD CONSTRAINT "Trips_busTicketId_fkey" FOREIGN KEY ("busTicketId") REFERENCES "BusTicket"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
