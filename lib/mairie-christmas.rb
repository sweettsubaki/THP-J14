require 'nokogiri'
require 'open-uri'
require 'rubygems'

@principal_adress = "http://annuaire-des-mairies.com"

def scrapper
   return doc = Nokogiri::HTML(URI.open('http://annuaire-des-mairies.com/val-d-oise.html'))
end

def get_mail(array_final,array_link)
    puts "Recherches des villes en cours ..."
    array_link.each{|link|
    pages = Nokogiri::HTML(URI.open(@principal_adress+link))
    mail = pages.xpath('//section[2]//tr[4]/td[2]').text
    array_final << mail
    }
    return array_final
end

def fusiontab(tab1,tab2)
    return Hash[tab1.zip(tab2)]
end

def mairie(page)
    array_of_mail = []
    array_of_link = []
    array_of_name = []

    links = page.xpath('//tr//td//p[1]//a')
    
    links.each{|link|
        array_of_name << link.text
    }
    #j'enlève ce qui n'a rien a faire dedans
    array_of_name.delete("Plan du site")

    links.each{|link|
    array_of_link << link['href']
    }
    #j'enlève l'adresse qui n'a rien à faire là
    array_of_link.delete("plan-du-site.html")
    #J'enlève tous les . 
    for i in 0..array_of_link.length - 1
        array_of_link[i][0] = array_of_link[i][0].delete(".")
    end
    get_mail(array_of_mail,array_of_link)
    hash = fusiontab(array_of_name,array_of_mail)
    return hash
end
print mairie(scrapper)