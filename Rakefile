
namespace :kzen do

  desc "Install the kzen generators for local use"
  task :install do
    # symlink executable to ~/bin directory
    ln_sf File.expand_path('bin/kzen.rb'), "#{ENV['HOME']}/bin/kzen", verbose: true
    chmod "+x", "#{ENV['HOME']}/bin/kzen", verbose: true
    # symlink the generators folder to ~/.kzen
    ln_sf File.expand_path('generators'), "#{ENV['HOME']}/.kzen", verbose: true
  end

  desc "Uninstall the kzen generators from the local system"
  task :uninstall do
    # ...
  end

  # task :restore do
  #   # ...
  # end
end
