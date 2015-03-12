require 'csv'

namespace :import do 
  task :variety => :environment do 
    Variety.delete_all
    file_path = "#{::Rails.root}/db/product_list.csv"
    csv_text = File.read(file_path)
    csv = CSV.parse(csv_text, :headers => true)
    varieties = []
    csv.each do |row|
      attributes = row.to_hash
      varieties << attributes["Variety"]
    end
    uniq_varieties = varieties.uniq 
    uniq_varieties.each do |variety|
      Variety.create(name: variety)
    end
    Variety.create(name: "NA")

  end

  task :grade => :environment do
    Grade.delete_all 
    file_path = "#{::Rails.root}/db/product_list.csv"
    csv_text = File.read(file_path)
    csv = CSV.parse(csv_text, :headers => true)
    grades = []
    csv.each do |row|
      attributes = row.to_hash
      grades << attributes["Grade"]
    end
    uniq_grades = grades.uniq 
    uniq_grades.each do |grade|
      Grade.create(name: grade)
    end
    Grade.create(name: "NA")
  end

  task :size => :environment do
    Size.delete_all 
    file_path = "#{::Rails.root}/db/product_list.csv"
    csv_text = File.read(file_path)
    csv = CSV.parse(csv_text, :headers => true)
    sizes = []
    csv.each do |row|
      attributes = row.to_hash
      sizes << attributes["Size"]
    end
    uniq_sizes = sizes.uniq 
    uniq_sizes.each do |size|
      Size.create(name: size)
    end
    Size.create(name: "NA")
  end

  task :commodity => :environment do
    Commodity.delete_all 
    file_path = "#{::Rails.root}/db/product_list.csv"
    csv_text = File.read(file_path)
    csv = CSV.parse(csv_text, :headers => true)
    commodities = []
    csv.each do |row|
      attributes = row.to_hash
      commodities << attributes["Commodity"]
    end
    uniq_commodities = commodities.uniq 
    uniq_commodities.each do |commodity|
      Commodity.create(name: commodity)
    end
    Commodity.create(name: "NA")
  end

  task :origin => :environment do 
    Origin.delete_all
    file_path = "#{::Rails.root}/db/product_list.csv"
    csv_text = File.read(file_path)
    csv = CSV.parse(csv_text, :headers => true)
    origins = []
    csv.each do |row|
      attributes = row.to_hash
      origins << attributes["Origin"]
    end
    uniq_origins = origins.uniq 
    uniq_origins.each do |origin|
      Origin.create(name: origin)
    end
    Origin.create(name: "NA")
  end

  task :item => :environment do 
    Item.delete_all
    file_path = "#{::Rails.root}/db/product_list.csv"
    csv_text = File.read(file_path)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      attributes = row.to_hash
      variety_na = Variety.where(name: "NA").first
      grade_na = Grade.where(name: "NA").first
      size_na = Size.where(name: "NA").first
      origin_na = Origin.where(name: "NA").first
      commodity_na = Commodity.where(name: "NA").first
      variety = Variety.where(name: attributes["Variety"]).first
      grade = Grade.where(name: attributes["Grade"]).first 
      size = Size.where(name: attributes["Size"]).first
      origin = Origin.where(name: attributes["Origin"]).first
      commodity = Commodity.where(name: attributes["Commodity"]).first

      variety = variety.blank? ? variety_na : variety 
      grade = grade.blank? ? grade_na : grade 
      size = size.blank? ? size_na : size 
      origin = origin.blank? ? origin_na : origin 
      commodity = commodity.blank? ? commodity_na : commodity 

      item_name = "#{variety.name} #{grade.name} #{size.name}" 
      item_name = item_name.gsub(" NA", "")
      Item.create(name: item_name, variety_id: variety.id, size_id: size.id, grade_id: grade.id, commodity_id: commodity.id, origin_id: origin.id)
    end
  end
end