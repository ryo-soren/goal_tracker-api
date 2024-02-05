set :environment, "production"
set :output, "log/cron.log"

every 1.day, at: "12:00 am" do
    runner "Goal.check_and_update_unsuccessful" 
end