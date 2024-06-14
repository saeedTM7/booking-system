const express = require('express');
const router = express.Router();




const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

router.use(express.json());

router.get('/users', async (req, res) => {
  try {
    // Fetch all users from the database
    const users = await prisma.user.findMany();
    
    // Send the users as JSON response
    res.json(users);
  } catch (error) {
    // If there's an error, send 500 Internal Server Error response
    res.status(500).json({ error: error.message });
  }
});


// Handle POST request to create a new user
router.post('/users', async (req, res) => {
  const { name, email,phone_number,id_cart } = req.body;

  try {
    const newUser = await prisma.user.create({
      data: { name, email,phone_number,id_cart },
    });
    res.json(newUser);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.delete('/users/:id', async (req, res) => {
  const { id } = req.params;

  try {
    // Delete the user
    await prisma.user.delete({
      where: { id: Number(id) },
    });
    res.json({ message: 'User deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});


module.exports = router;




