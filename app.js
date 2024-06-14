var express = require('express');
var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var tripsRouter = require('./routes/trips');
var busticketRouter = require('./routes/busTicket');

var app = express();



app.use(express.json());


app.use('/', indexRouter);

app.use('/users', usersRouter);

app.use('/trips', tripsRouter);

app.use('/busticket', busticketRouter);


const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

module.exports = app;
