
require 'mail'
require 'csv'

puts "connexion gmail en cours"
####################-CONNEXION_GMAIL-#################
options = { :address              => "smtp.gmail.com",
  :port                 => 587,
  :user_name            => 'mail',
  :password             => 'password',
  :authentication       => 'plain',
  :enable_starttls_auto => true  }
puts "importation des contact"
###################LECTURE_CSV#########################
def lectur
  table=CSV.read('../db/liste.csv')

  return table

end
puts "envoie des emails"
####################Send_mail_to_list_CSV#############
lectur.each do |amail , name|


  Mail.defaults do
    delivery_method :smtp, options
  end

  Mail.deliver do
    to amail
    from 'rubysendmail@gmail.com'
    subject 'Test'
    body ' hello #{name}!'
  end

end






