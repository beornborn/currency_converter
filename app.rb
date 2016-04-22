require 'rubygems'
require 'bundler/setup'

Bundler.require
Mongoid.load!(File.expand_path('mongodb.yml'), :development)
Dir["./lib/*.rb"].each {|file| load file }
