def constantized_model(model)
  model.gsub(' ', '_').camelize.constantize
end

Given /^an? "([^\"]*)" exists/ do |model|
  constantized_model(model).make
end

Given /^an? "([^\"]*)" "([^\"]*)" exists/ do |named, model|
  constantized_model(model).make(named.to_sym)
end

Given /^(\d+) "([^\"]*)" exist/ do |count, model|
  count.to_i.times do
    constantized_model(model).make
  end
end

Given /^(\d+) "([^\"]*)" "([^\"]*)"s exist/ do |count, named, model|
  count.to_i.times do
    constantized_model(model).make(named.to_sym)
  end
end

Given /^"([^\"]*)"s? defined with:/ do |model, table|
  model = constantized_model(model)
  table.hashes.each do |hash|
    model.make(hash)
  end
end

Given /^"([^\"]*)" "([^\"]*)"s? defined with:/ do |named, model, table|
  model = constantized_model(model)
  table.hashes.each do |hash|
    model.make(named.to_sym, hash)
  end
end