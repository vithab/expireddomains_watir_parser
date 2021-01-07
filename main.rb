require 'watir'
require 'webdrivers'

browser = Watir::Browser.new :firefox #, headless: true
browser.goto('https://www.expireddomains.net/login/')

browser.text_field(id: 'inputLogin').set 'your_login'
browser.text_field(id: 'inputPassword').set 'your_password'
sleep 3.12244556
browser.button(text: 'Login').click
sleep 5.378421
browser.goto('https://member.expireddomains.net/domains/expiredfi/')

def get_links_per_page(browser)
  links = (browser.links class: 'namelinks').map do |link|
    link.exists?
    File.write("file_name.txt", "#{link.text}\n", mode: 'a')
    link.text
  end
end

def next_page_click(browser)
  next_page_link = browser.link class: 'next'
  next_page_link.click if next_page_link.exists?
end

p get_links_per_page(browser)

next_page_click(browser)

10.times do
  browser.goto(browser.url)
  sleep 4.135842

  p get_links_per_page(browser)
  next_page_click(browser)
end
