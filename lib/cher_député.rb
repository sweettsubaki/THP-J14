require 'nokogiri'
require 'open-uri'
$principal_adress="https://www2.assemblee-nationale.fr"
doc = Nokogiri::HTML(URI.open('https://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))

#tableau de hash avec : prénom nom et email

def fusiontab(tab1, tab2)
    return Hash[tab1.zip(tab2)]
end

def get_mail(array_final, array_link)
    array_link.each{|link|
    page = Nokogiri::HTML(URI.open($principal_adress+link))
    mail = page.xpath('//dd[4]//li[2]/a').text
    array_final << mail
    }
    return array_final
end

def deputes(pages)
    array_of_first_name = []
    array_of_name = []
    array_of_mail = []
    array_of_link = []
    
    links = pages.xpath('//*[@id="deputes-list"]//a')
    links.each {|link|
    
    array_of_link << link['href']
    }
    
    links.each{|link|
    array_of_name << link.text
    }
    
    for i in 0..array_of_name.length - 1
        if array_of_name[i][0..2] == "Mme"
            array_of_name[i][0..3] = array_of_name[i][0..3].delete("Mme ")
        elsif array_of_name[i][0..2] == "M. "
            array_of_name[i][0..2] = array_of_name[i][0..2].delete("M. ")
        elsif array_of_name[i][0..1] == "M "
            array_of_name[i][0..1] = array_of_name[i][0..1].delete("M ")
        end
    end
    
    array_of_name.delete("")
    array_of_name.each {|name| 
        array_of_first_name << name.split(" ")}
    
        #print array_of_name.length
    #le . compact enléve tout les élément nil
    
    array_of_link = array_of_link.compact
    array_of_mail = get_mail(array_of_mail,array_of_link)
    #print hash = Hash.new[[["first_name", array_of_first_name], ["last_name", array_of_name], ["email", array_of_mail]]]
    hash_name = fusiontab(array_of_name, array_of_mail)
    print hash_name
end
deputes(doc)