# Installing LineAwesome font

# DOCS: https://icons8.com/line-awesome/howto

puts
logger.begin('shared:lineawesome')


@project_type = {
  :laravel => 'public/fonts/line-awesome',
  :nuxt => 'static/fonts/line-awesome',
}

# version
version = '1.3.0'

# the root URL
root_url = 'https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome'

# the full URL
remote_url = "#{root_url}/#{version}/css/line-awesome.min.css"
# the zip file
zip_file = "line-awesome-#{version}.zip"
# the url
zip_url = "#{root_url}/#{version}/#{zip_file}"

# remote_url = '<link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">'



# # ask for Project Type support
# project_type = prompt.select("Choose Project Type?", %w(laravel nuxt vue))

# # ask for Type of Installation
# install_type = prompt.select("Install which version?", %w(local remote), default: 'remote')

###
# if project_type == 'laravel'
#   # test for artisan file
#   if File.exists?('artisan')
#     # check what install type
#     if install_type == 'remote'

#     else
#       # local install
#       # create '/static/fonts/' directory if not found
#       FileUtils.mkdir_p('static/fonts') unless Dir.exists?('static/fonts')

#     end
#   else
#     say_status 'error', "No 'artisan' file found. Is this really a Laravel project?", :red
#     exit
#   end
# end

# # NUXT PROJECTS
# if project_type == 'nuxt'

#   if File.exists?('nuxt.config.js')
#     # check what install type
#     if install_type == 'remote'
#       # { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
#     else
#       # local install
#       # create '/static/fonts/' directory if not found
#       FileUtils.mkdir_p('static/fonts') unless Dir.exists?('static/fonts')

        # Gets the content at the given address and places it at the given relative destination.
        # get zip_url, "tmp/lineawesome"

#       unzip tmp/lineawesome/line-awesome-1.3.0
#       run("unzip tmp/lineawesome/#{zip_file}")

        # copy the font files
        # directory("tmp/lineawesome/#{version}/fonts", "static/fonts/lineawesome")

        # copy the minified css file
        # copy_file("tmp/lineawesome/#{version}/css/line-awesome.min.css", 'public/css/line-awesome.min.css')

        # replace the ../fonts/ with /fonts/lineawesome/
        # gsub_file('public/css/line-awesome.min.css', '../fonts/', '/fonts/lineawesome/')

        # then remove the downloaded files and temporary directory
        # remove_file("tmp/lineawesome")

#     end
#   else
#     say_status 'error', "No 'nuxt.config.js' file found. Is this really a NuxtJS project?", :red
#     exit
#   end

# end


# # VUE PROJECTS
# if project_type == 'vue'
#   say_status 'error', "Not yet implemented...", :red
# end

# git commit


logger.end('shared:lineawesome')
puts
