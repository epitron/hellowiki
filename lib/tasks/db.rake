namespace :db do

  desc "Reimport everything"
  task remigrate: [:drop, :create, :migrate, :seed]

end
