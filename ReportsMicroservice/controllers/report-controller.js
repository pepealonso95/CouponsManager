const ReportService = require('../services/report-service');

module.exports = class ReportController {
    constructor() {
        this.reportService = new ReportService();
    }
    async list (ctx, next) {
        let limit = parseInt(ctx.query.limit) || 100;
        let offset = parseInt(ctx.query.offset) || 0;
        let list = await this.reportService.findAll(limit, offset);
        ctx.body = { offset: offset, limit: limit, size: list.length, data: list };
        await next();
    }
    async fetch (ctx, next) {
        let report = await this.reportService.findById(ctx.params.id);
        ctx.body = report;
        await next();
    }
}