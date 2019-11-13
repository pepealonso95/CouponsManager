
const { Client } = require('pg');
const client = new Client({
    user: 'nicolasdamiani',
    host: 'localhost',
    database: 'CouponManager_development',
    password: 'Damiani123',
    port: 5432,
  });

module.exports = class ReportRepository {
    constructor() {
        client.connect();
    }
    async findById(id) {
        const users = await client.query('select * from users' );
        console.log(users.rows[0]);
        return users.rows[0]; 
    }
}