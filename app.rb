require 'bundler'
Bundler.require
# Initialisation de l'API
service = Google::Apis::GmailV1::GmailService.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = authorize

# Création du contenu du message
msg = Mail.new #msg est une instance de la classe « Mail ». On va définir ses variables d’instance
msg.date = Time.now
msg.subject = 'ceci est un test'
msg.body = Text.new('coucou!', 'plain', 'charset' => 'us-ascii')
msg.from = {'coucou@gmail.com' => 'Coucou Man'}
msg.to   = {
    'josé@valdoise.fr' => nil,
}

# Création de la requête, insertion du contenu dans la propriété `raw`
#(https://developers.google.com/gmail/api/v1/reference/users/messages/send)
message = Google::Apis::GmailV1::Message.new(raw: msg.to_s)

service.send_user_message('me', message)
$:.unshift File.expand_path("./../lib", __FILE__)
require 'app/scrapper'
# call the scrapp_data and save_as_JSON
@tabs = Scrapper.new
def save_as_JSON
	File.open("db/scrapper.json","w") do |f|
		f.write(JSON.pretty_generate(@tabs.getting_the_townhall))
    end
end
# create of the save of the csv
def save_as_csv
	File.open("db/scrapper.csv", "w") {|f| f.write(@tabs.getting_the_townhall.inject([]) { |csv, row|  csv << CSV.generate_line(row) }.join(""))}
end