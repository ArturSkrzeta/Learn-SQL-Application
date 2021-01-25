const express = require('express');
const bodyParser = require("body-parser");
const mongoose = require('mongoose');
require('dotenv/config');

const port = 3080;
const app = express();
app.set('view engine', 'hbs')

app.use(bodyParser.json());
app.use('/questions', require('./routes/questions'))
app.use('/', require('./routes/index'))

// getting connected with MongoDB
// it works for every imported endpoint
mongoose.set('useUnifiedTopology', true)
mongoose.set('useNewUrlParser', true)
mongoose.connect(process.env.DB_CONNECTION, () => console.log('Connected to db.'))

app.listen(port, () => console.log(`Server listening on the port:${port}`));
