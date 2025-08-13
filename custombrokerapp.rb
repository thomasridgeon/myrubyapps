#gem install sinatra
#gem install sinatra-reloader
require 'sinatra'
require 'erector'
require 'sinatra/reloader'
configure :development do
  register Sinatra::Reloader
end
#
RATES = {
  'fas' => {
    '20ST' => 1221.98
    '40ST' => 2443.96
    '40HC' => 2661.32
    '20RH' => 1328.93
    '40RH' => 2657.85
  },
  'security_fee' => {
    '20ST' => 155.10
    '40ST' => 310.20
    '40HC' => 310.20
    '20RH' => 105.75
    '40RH' => 211.50
},
'hazard' => {
  '20ST' => 118.68
  '40ST' => 259.09
  '40HC' => 259.09

},
'unstuffing' => {
  '20ST' => 528.75
  '40ST' => 1075.50
  '40HC' => 1075.50

},
'plugs_daily_rate' => {
  '20RH' => 115.15
  '40RH' => 230.30
}
}
#In Ruby, => is a special operator most commonly used to define key-value pairs within a hash. It separates the key from its corresponding value.
#the curly braces {} are used to define a hash. A hash is a fundamental data structure in Ruby that stores data in key-value pairs. It's a perfect way to organize and look up information.
#
#With the Erector gem, instead of writing a big block of HTML, you define your page's structure and content using Ruby methods. This lets you stay in the Ruby world you're more comfortable with.

#Use an Erector class to define the HTML with Tailwind CSS classes
class PortChargesCalculatorPage < Erector::Widget
  #This line defines a new class named PortChargesCalculatorPage. By inheriting from Erector::Widget, this class gets all the special abilities it needs to generate HTML using Ruby methods. 
  def content
    #This is a special method required by Erector. Everything you want to appear on your web page must be written inside this content method
    html do
      head do 
        #html do: This is an Erector method that generates the opening <html> tag for your web page. All subsequent code within this block will be nested inside the html tag.
        #head do: This generates the <head> tag, which contains important metadata about the page that isn't displayed to the user.
        meta(charset: 'UTF-8')
        meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0')
        #meta(charset: 'UTF-8'): This line generates the <meta charset="UTF-8"> tag. This is crucial for web browsers to correctly display characters from different languages.
        #meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0'): This generates a meta tag that is essential for making the page responsive and look good on mobile devices. It tells the browser to match the page's width to the device's screen width.
        title 'Port Charges Calculator'
        script(src: 'https://cdn.tailwindcss.com')
        #This line generates a <script> tag. The src attribute tells the browser to download the Tailwind CSS library from a public URL. This is how all the styling utility classes (like bg-white, p-10, text-3xl) are made available for the rest of the page.
      end
      #Tailwind CSS is a framework which provides a large set of pre-built classes that you can apply directly to your HTML elements to style them.
      #The relationship between Erector and Tailwind CSS is that one provides the structure and the other provides the styling. They work together by allowing you to build the HTML structure using Ruby methods (Erector) and then apply pre-built styling to those elements by passing Tailwind's utility classes as arguments to those methods. Essentially, Erector creates the tags, and Tailwind CSS provides the look and feel.

body(class: 'font-sans bg-slate-100 flex items-center justify-center min-h-screen p-5') do
  div(class: 'container bg-white p-10 rounded-xl shadow-2xl max-w-lg w-full') do
    h1(class:'text-3xl font-bold text-center text-slate-800 mb-8') do
      text 'Port Charges Calculator'
#Here I am applying Tailwind CSS styles to my erector HTML tags.

form(action: '/calculate', method: 'post') do 
  #form(action: '/calculate', method: 'post') do: This line uses the Erector form method to create an HTML <form> tag
  #action: '/calculate': This attribute specifies the URL (/calculate) to which the form data will be sent when the user clicks the "Calculate Charges" button. This corresponds to the post '/calculate' route in the Sinatra app.
  #method: 'post': This specifies that the form data will be sent using the HTTP POST method, which is the standard way to submit data that creates or updates something on the server.
  div(class: 'mb-6') do
    label('Number of Containers:' for 'num_containers', class: 'block text-sm font-medium text-gray-700 mb-2')
    input(type: 'number', id: 'num_containers', name: 'num_containers', min: '1', required: true, class: 'w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500') do
  end
  div(class: 'mb-6') do
    label('Container Size/Type', for: 'container_type', class: 'block text-sm font-medium text-gray-700 mb-2')
    select(id: 'container_type', name: 'container_type', required: true, class: 'w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500') do 
      option('20ST', value: '20ST')
      option('40ST', value: '40ST')
      option('40HC', value: '40HC')
      option('20RH', value: '20RH')
      option('40RH', value: '40RH')
    end