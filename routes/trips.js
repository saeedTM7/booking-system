const express = require('express');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const router = express.Router();
router.use(express.json());
// POST method to create a new trip 
router.post('/trips', async (req, res) => {
    const { name, date, bustickets } = req.body;
    try {
        const newTrip = await prisma.trip.create({
            data: {
                name, date, bustickets: {
                    create: bustickets,
                    //  Assuming bustickets is an array of busticket objects 
                },
            }, include: { bustickets: true, },
        });

        res.status(201).json(newTrip);
    } catch (error) { res.status(500).json({ error: error.message }); }
});

// GET method to retrieve all trips 
router.get('/trips', async (req, res) => {
    try {
        const trips = await prisma.trip.findMany({ include: { bustickets: true, }, });

        res.json(trips);
    } catch (error) { res.status(500).json({ error: error.message }); }
});

// GET method to retrieve a trip by ID

router.get('/trips/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const trip = await prisma.trip.findUnique({
            where: { id: parseInt(id) },
            include: { bustickets: true, },
        }); if (trip) { res.json(trip); }
        else { res.status(404).json({ message: 'Trip not found' }); }
    }

    catch (error) { res.status(500).json({ error: error.message }); }
});

// DELETE method to delete a trip by ID 

router.delete('/trips/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const deletedTrip = await prisma.trip.delete({
            where: { id: parseInt(id) },

            include: { bustickets: true, },
        }); res.json(deletedTrip);
    }
    catch (error) { res.status(500).json({ error: error.message }); }
});



module.exports = router;
