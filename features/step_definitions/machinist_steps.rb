def constantized_model(model)
  model.gsub(' ', '_').camelize.constantize
end

def convert_association_string_to_instance(name, assignment)
  attribute, value = assignment.split(':', 2)  
  return if value.blank?
  attributes = convert_human_hash_to_attribute_hash(attribute => value.strip)
  model = constantized_model(name.to_s)
  model.make(attributes)
end

def convert_human_hash_to_attribute_hash(human_hash)
  human_hash.inject({}) do |attribute_hash, (human_key, value)|
    key = human_key.downcase.gsub(' ', '_').to_sym
    if value =~ /\:/
      value = convert_association_string_to_instance(key, value)
    end
    attribute_hash.merge(key => value)
  end
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


Given /^the following (.*) exists?:$/ do |model, table|
  model = constantized_model(model.singularize)
  table.hashes.each do |hash|
    attributes = convert_human_hash_to_attribute_hash(hash)
    model.make(attributes)
  end
end


Given /^"([^\"]*)" "([^\"]*)"s? defined with:/ do |named, model, table|
  model = constantized_model(model)
  table.hashes.each do |hash|
    model.make(named.to_sym, hash)
  end
end