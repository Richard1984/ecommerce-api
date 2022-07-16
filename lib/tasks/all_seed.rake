namespace :db do
    desc "all seed being executed"
    task :all_seed, [] => :environment do
      raise "Not allowed to run on production" if Rails.env.production?
  
      Rake::Task['db:seed'].execute
      Rake::Task['db:seed:review'].execute
      Rake::Task['db:seed:users_image'].execute
      Rake::Task['db:seed:products_image'].execute
    end
  end