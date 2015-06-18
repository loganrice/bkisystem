require 'paratrooper'

namespace :deploy do
 desc 'Deploy app in staging environment'
 task :staging do
   deployment = Paratrooper::Deploy.new("bki-staging", tag: 'staging')

   deployment.deploy
 end

 desc 'Deploy app in production environment'
 task :production do
   deployment = Paratrooper::Deploy.new("bki", tag: "production")   
  
   deployment.deploy
 end
end
