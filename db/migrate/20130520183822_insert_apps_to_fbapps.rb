class InsertAppsToFbapps < ActiveRecord::Migration

  def up
    rows = [
      ["myfangate_i", "129418400529051", "f122af8f63887e22d7be61baed878974"],
      ["myfangate_ii", "392324854138348", "b3eaceb89c164e87c894c73a892d755a"],
      ["myfangate_iii", "110838302390370", "a2c1d8449f4bd59e870fcb1d215e641c"],
      ["myfangate_iv", "117576815047349", "63ce5f0b0c61eb2f4b010a66840fee61"],
      ["myfangate_v", "409428712428593", "b408184bd430ae68f1336ead36c1e618"],
      ["myfangate_vi", "392167880820542", "0f091135835fe1d8daf34068341346ff"],
      ["myfangate_vii", "397521873623478", "f0c6a0feebd2e14e510eb40580f88db0"],
      ["myfangate_viii", "286350421461124", "b359c1624c5a951b767eb16d412f90ef"],
      ["myfangate_ix", "418814111484102", "2549cae240a1e7c995ead979f3413116"],
      ["myfangate_x", "366194106769768", "40d959de8f6e3dc3fd2428b6fff24020"],
      ["myfangate_xi", "405557989487570", "1aa62ff3168d91c3d269d89d79e2ab48"],
      ["myfangate_xii", "317028931713812", "37646a9140d0af0b470ef719b0459ed6"]
    ]

    Fbapp.transaction do
      rows.each do |val|
        if Fbapp.where(:namespace => val[0]).empty? then
          Fbapp.new(
            :namespace  => val[0],
            :key        => val[1],
            :secret     => val[2]
          ).save!
        end
      end
    end
  end

  def down
    Fbapp.delete_all
  end

end
