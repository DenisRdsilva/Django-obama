const express = require('express');
const app = express();

var cors = require('cors');

app.use(cors({
  origin: '*',
}));

app.listen(3000, () => {
  console.log('Servidor rodando na porta 3000');
});

const sqlite3 = require('sqlite3').verbose();

const db = new sqlite3.Database('./db.sqlite3', (err) => {
  if (err) {
    console.error(err.message);
    return;
  }
  console.log('Conectado ao banco de dados SQLite3');
});

app.get('/dados', (req, res) => {
  db.all('SELECT * FROM hello_post', (err, rows) => {
    if (err) {
      console.error(err.message);
      return;
    }
    res.json(rows);
  });
});

// app.get('/pagina', (req, res) => {
//     res.sendFile(__dirname + '/pagina.html');
//   });
