require 'rubygems'
require 'nokogiri'
require 'open-uri'
#maka lien anle ville

class Mail


  def get_town_hall
	#initialisation du tablea town_hall dans on va y trouver apres les noms du 
	departement_mairie_url = []
	nom_ville = []
    departement = ["https://www.annuaire-des-mairies.com/hautes-alpes.html","https://www.annuaire-des-mairies.com/alpes-maritimes.html","https://www.annuaire-des-mairies.com/aude.html"]
      departement.each do |url_departement|
        
        page = Nokogiri::HTML(open("#{url_departement}"))
        departement_mairie_url  << page.xpath('//a[@class="lientxt"]/@href')
         
          departement_mairie_url.each do |ville|
            
            page = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/#{ville}"))
        puts  emails = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
      

          end

       

  	  end
  end

  def town_hall_email(get_town_hall)
 
  end	
    
  def perfom
     
  end

end
class Data
  attr_accessor :tabhash
  @tabhash = Mail.new.getting_the_townhall
  def save_as_JSON
  File.open("db/scrapper.json","w") do |f|
    f.write(JSON.pretty_generate(@tabhash))
    end
  end
  def save_as_csv
    File.open("db/scrapper.csv", "w") {|f| f.write(@tabhash.inject([]) { |csv, row|  csv << CSV.generate_line(row) }.join(""))}
  end
end