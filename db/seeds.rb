
Dir["../#{__dir__}/models/*.rb"].each {|file| require file }

example_sample = {
  "name" => "example name seed"
}

Example.create!(notification_sample)
