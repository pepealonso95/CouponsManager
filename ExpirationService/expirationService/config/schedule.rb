# config/schedule.yml
my_first_job:
  cron: "*/1 * * * *" #it will retrieve data every 1 minute
  class: "HardWorker"