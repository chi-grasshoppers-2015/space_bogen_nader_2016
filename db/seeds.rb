# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Lab.create(name: "General Lab", location: "Matt Baker's Basement", allotted_time: 400)
Lab.create(name: "Meth Lab", location: "Connor's House", allotted_time: 300)
Lab.create(name: "Poop Lab", location: "Bogen's House", allotted_time: 150)
Lab.create(name: "Redundancy Lab of Redundancy", location: "Redundant st Street", allotted_time: 300)
