const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  res.send('Hello bot2do from my containerized Node.js App deployed by CI/CD pipeline!');
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});