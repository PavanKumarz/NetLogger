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

app.get('/download', (req, res) => {
  const size = 5 * 1024 * 1024;
  const buffer = Buffer.alloc(size, 'x');
  
  res.setHeader('Content-Type', 'application/octet-stream');
  res.setHeader('Content-Length', size);
  res.send(buffer);
});

app.post('/upload', (req, res) => {
  let received = 0;

  req.on('data', (chunk) => {
    received += chunk.length;
  });

  req.on('end', () => {
    res.json({ status: 'ok', bytesReceived: received });
  });
});