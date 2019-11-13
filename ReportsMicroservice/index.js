const Koa = require('koa');
const router = require('./controllers/router');

const app = new Koa();
const port = 9091;
app.use(router.routes());
app.use(router.allowedMethods());
app.listen(port);

console.log(`reports server started at port: ${port}`);