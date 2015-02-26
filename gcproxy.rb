require 'sinatra'
require 'nokogiri'
require 'open-uri'

SOURCE = "https://www.google.com/calendar/embed?title=Jiahao's%20Availability%20Calendar&mode=WEEK&height=600&wkst=1&bgcolor=%23ffffff&src=8ej1aq9br99poqf0fjpj18o9n8%40group.calendar.google.com&color=%23182C57&src=7eluv46f01aeqo3d5insodduvc%40group.calendar.google.com&color=%232F6309&src=61k7v6n52cpm68846rkgn90p5o%40group.calendar.google.com&color=%232F6309&src=isundaylee.mit%40gmail.com&color=%236B3304&src=d7a9id6s61gchjc2p7ukg4uekk%40group.calendar.google.com&color=%23711616&src=be6tf5tgb792vtnlek5jd9lfl8%40group.calendar.google.com&color=%238C500B&src=qhspc8vjts8ovb4lid4t9snrp8%40group.calendar.google.com&color=%23711616&ctz=America%2FNew_York"

CSS_FILES = [
  'http://fonts.googleapis.com/css?family=Roboto:400,100,300',
  'http://fonts.googleapis.com/css?family=Open+Sans:400,600,700',
  'http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400',
  '/styles.css'
]

JS_FILES = [
  'https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js',
  '/tweaks.js'
]

STATIC_FILES = [
  'styles.css',
  'tweaks.js'
]

get '/' do
  page = Nokogiri::HTML(open(SOURCE).read)

  CSS_FILES.each do |c|
    css_node = Nokogiri::XML::Node.new('link', page)
    css_node['rel'] = 'stylesheet'
    css_node['type'] = 'text/css'
    css_node['href'] = c

    page.at_css('head').last_element_child.after(css_node)
  end

  JS_FILES.each do |j|
    js_node = Nokogiri::XML::Node.new('script', page)
    js_node['src'] = j

    page.at_css('head').last_element_child.after(js_node)
  end

  page.to_s
end

STATIC_FILES.each do |f|
  get '/' + f do
    send_file f
  end
end
