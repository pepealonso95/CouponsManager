const Router = require('koa-router');
const ReportController = require('./report-controller');

const router = new Router();
const report = new ReportController();

router.get('/reports', (ctx, next) => report.fetch(ctx, next));

module.exports = router;