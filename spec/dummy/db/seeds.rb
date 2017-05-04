Dir.glob(File.join(Rails.root, 'db', 'seeds', '*.rb')).each do |file|
  require file
end

Seeds::PulitzerPostTypes.create
