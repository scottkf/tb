# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# default roles
r = Role.new(:name => "SuperAdmin")
r.id = 1
r.save

r = Role.new(:name => "Editor")
r.id = 2
r.save

r = Role.new(:name => "Regular")
r.id = 3
r.save