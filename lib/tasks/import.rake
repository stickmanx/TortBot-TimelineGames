require 'csv' # create file

desc "import csv of platforms into platforms table"
task :import_systems => :environment do

  csv_text = File.read(Rails.root.join('lib','platforms.csv'))
  
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
  	System.create!(row.to_hash)
  end

end


desc "import csv of games into game db"
task :import_games => :environment do

  csv_text = File.read(Rails.root.join('lib','games.csv'))
  
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    if System.where(name:row["system"]).any?
      platform_id = System.where(name:row["system"]).first.id
    else
      platform_id = ""
    end
  	Game.create!(name:row["name"], system_id:platform_id)
  end
  
end