const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());


app.get('/ping', (req, res) => {
  res.json({ status: 'ok', serverTime: Date.now() });
});

app.listen(3000, '0.0.0.0', () => {
  console.log('Server running on port 3000');
});