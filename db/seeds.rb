# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


rows = [
  [1, "myfangate_i", "129418400529051", "f122af8f63887e22d7be61baed878974"],
  [2, "myfangate_ii", "392324854138348", "b3eaceb89c164e87c894c73a892d755a"],
  [3, "myfangate_iii", "110838302390370", "a2c1d8449f4bd59e870fcb1d215e641c"],
  [4, "myfangate_iv", "117576815047349", "63ce5f0b0c61eb2f4b010a66840fee61"],
  [5, "myfangate_v", "409428712428593", "b408184bd430ae68f1336ead36c1e618"],
  [6, "myfangate_vi", "392167880820542", "0f091135835fe1d8daf34068341346ff"],
  [7, "myfangate_vii", "397521873623478", "f0c6a0feebd2e14e510eb40580f88db0"],
  [8, "myfangate_viii", "286350421461124", "b359c1624c5a951b767eb16d412f90ef"],
  [9, "myfangate_ix", "418814111484102", "2549cae240a1e7c995ead979f3413116"],
  [10, "myfangate_x", "366194106769768", "40d959de8f6e3dc3fd2428b6fff24020"],
  [11, "myfangate_xi", "405557989487570", "1aa62ff3168d91c3d269d89d79e2ab48"],
  [12, "myfangate_xii", "317028931713812", "37646a9140d0af0b470ef719b0459ed6"]
]

Fbapp.transaction do
  rows.each do |attrs|
    fbapp = Fbapp.find_or_create_by_id attrs[0]
    fbapp.update_attributes(
      :id         => attrs[0],
      :namespace  => attrs[1],
      :key        => attrs[2],
      :secret     => attrs[3]
    )
    fbapp.save!
  end
end