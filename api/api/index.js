const app = require('express')();
const PORT = 8989;

app.listen(
    PORT,
    () => console.log(`Hello World from http://localhost:${PORT}`)
)
