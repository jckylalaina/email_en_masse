require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
#maka lien anle ville

class Mail


  def get_town_hall
  #initialisation du tablea town_hall dans on va y trouver apres les noms du 
    town_name_url = []
    departement = ["https://www.annuaire-des-mairies.com/cantal.html","https://www.annuaire-des-mairies.com/indre-et-loire.html","https://www.annuaire-des-mairies.com/puy-de-dome.html"]
    
    departement.each do |url_departement|
      page = Nokogiri::HTML(open("#{url_departement}"))
      a = page.xpath('//a[@class="lientxt"]/@href')
      #prendre les url.txt
        a.each do |url|
          unless url.to_s == "./63/martres-sur-morge.html"
        town_name_url << url.text
        end
        end
       
    end     
    #return les valeur de l'url de chaque ville de val d oise
     
    return town_name_url

   
  end

  def town_email(get_town_hall)
     town_name_url  = get_town_hall
     #initialisation des tableau
     emails_1 = []
     emails_2 = []
     emails_3 = []
     town_name_1 = []
     town_name_2 = []
     town_name_3 = []
     h1 = {}
     h2 = {}
     h3 = {}
     tabhash = {} 
     
     #pour tout les url des ville on prend les emails avec les @
      town_name_url.each do |town|
        page = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/#{town}"))
           page.xpath('//tr[@class="txt-primary tr-last"]/td[2]').select do |email|
        #prendre les td incluant @(les emails)
        #email.text if email.text.include?("@")
                    if emails_1.count <= 135
    puts   emails_1 << email.text if email.text.include?("@")
                    elsif emails_1.count > 135 && emails_2 <= 139
                      puts emails_1.count
       emails_2 << email.text if email.text.include?("@")  
                    elsif emails_2.count > 135 && emails_3 <= 237
       emails_3 << email.text if email.text.include?("@") 
                    end                      
                      
          
           end

       end
      
     #prendre les noms des villes dans les liens de townhall
      i = 0
      town_name_url.each do |a|
      while i <= town_name_url.length  
        if i  <= 135
        town_name1 << a.delete!(".1206547893/.html")
      elsif i > 135 && i <= 274
        town_name_2 << a.delete!(".1206547893/.html")
      elsif i i > 247 && i <= 511
        town_name_3 <<  a.delete!(".1206547893/.html")
            
      end
    end
    i+=1
  end
      #convertir en hash
      h1.store("cantal",town_name_1.zip(emails_1))
      h2.store("indre-et-loire",town_name_2.zip(emails_2))
      h3.store("puy-de-donne",town_name_3.zip(emails_3))
      tabhash.store(h1,h2,h3)
  end 

    
    def perfom
     return town_hall   = town_email(get_town_hall)
    end

end
Mail.new.perfom