const ReportRepository = require(`../repositories/report-repository`);

module.exports = class ReportService {
    constructor() {
        this.reportRepository = new ReportRepository();
    }
    async findById(id) {
        return await this.reportRepository.findById(id);
    }
}