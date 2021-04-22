require 'nokogiri'
require 'open-uri'
@principal_adress="https://www2.assemblee-nationale.fr"
doc = Nokogiri::HTML(URI.open('https://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))

#tableau de hash avec : prénom nom et email

def fusiontab(tab1, tab2)
    return Hash[tab1.zip(tab2)]
end
