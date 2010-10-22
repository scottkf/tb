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