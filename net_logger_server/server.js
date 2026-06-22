const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');

const app = express();

app.use(cors());
app.use(express.json());

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: { rejectUnauthorized: false },
});

async function initDb() {
  await pool.query(`
    CREATE TABLE IF NOT EXISTS speed_tests (
      id SERIAL PRIMARY KEY,
      network_name TEXT,
      download_speed REAL,
      upload_speed REAL,
      ping INTEGER,
      tested_at TEXT,
      synced_at TIMESTAMP DEFAULT NOW()
    )
  `);
  console.log('Database table ready');
}

initDb().catch((err) => console.error('DB init error:', err));

app.get('/ping', (req, res) => {
  res.json({ status: 'ok', serverTime: Date.now() });
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

app.post('/sync', async (req, res) => {
  try {
    const { networkName, downloadSpeed, uploadSpeed, ping, testedAt } = req.body;

    await pool.query(
      `INSERT INTO speed_tests (network_name, download_speed, upload_speed, ping, tested_at)
       VALUES ($1, $2, $3, $4, $5)`,
      [networkName, downloadSpeed, uploadSpeed, ping, testedAt]
    );

    res.json({ status: 'ok' });
  } catch (err) {
    console.error('Sync error:', err);
    res.status(500).json({ status: 'error', message: err.message });
  }
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
});