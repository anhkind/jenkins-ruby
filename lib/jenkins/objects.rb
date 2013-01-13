require 'jenkins/object'

class Jenkins
  class Job                 < Object; end
  class Job::Configuration  < Object; end
  class Job::Status         < Object; end
end

objects = Jenkins::Object.children.dup
objects.each do |object|
  underscored_name_array = object.name.split("::")[1..-1].map { |s| s.split(/(?<=\w)(?=[A-Z])/).map(&:downcase).join("_") }
  require "jenkins/objects/#{underscored_name_array.join("/")}"
end