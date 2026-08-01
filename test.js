const { Client } = require('pg');
const client = new Client({
  connectionString: 'postgresql://postgres:postgres@localhost:5432/motorcycledb'
});
client.connect().then(async () => {
  const res = await client.query('SELECT * FROM "Payment" WHERE "BookingID" IN (\'BK51619998\', \'BK57049122\', \'BK86046454\')');
  console.log(res.rows);
  client.end();
});
