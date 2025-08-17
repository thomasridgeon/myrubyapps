#gem install sinatra
#gem install sinatra-reloader

#To test app in local host:
#Once my Gemfile and config.ru files are correct, and in my custombrokerapp directory
#cd into my custombrokerapp directory and run bundle install to download and set up all the required libraries from my Gemfile.
#Then run the command: bundle exec puma to open the app in localhost

#---REQUIREMENTS---------------------------------
require 'sinatra'
require 'dotenv/load'
require 'httparty' #required for solar calculator to make API calls
require 'json' #required to parse json responses from the API
require 'erector'
require 'pry-byebug'
require 'sinatra/reloader'
configure :development do
  register Sinatra::Reloader
end
#-----------------------------------------------

#---API Keys------------------------------------
OPENUV_API_KEY = ENV['OPENUV_API_KEY']
#-----------------------------------------------

#---RATES FOR PORT CHARGES----------------------
RATES = {
  'fas' => {
    '20ST' => 1221.98,
    '40ST' => 2443.96,
    '40HC' => 2661.32,
    '20RH' => 1328.93,
    '40RH' => 2657.85,
  },
  'security_fee' => {
    '20ST' => 155.10,
    '40ST' => 310.20,
    '40HC' => 310.20,
    '20RH' => 105.75,
    '40RH' => 211.50,
},
'hazard' => {
  '20ST' => 118.68,
  '40ST' => 259.09,
  '40HC' => 259.09,

},
'unstuffing' => {
  '20ST' => 528.75,
  '40ST' => 1075.50,
  '40HC' => 1075.50,

},
'plugs_daily_rate' => {
  '20RH' => 115.15,
  '40RH' => 230.30,
}
}
#In Ruby, => is a special operator most commonly used to define key-value pairs within a hash. It separates the key from its corresponding value.
#the curly braces {} are used to define a hash. A hash is a fundamental data structure in Ruby that stores data in key-value pairs. It's a perfect way to organize and look up information.
#
#----------------------------------------

#---HOMEPAGE-----------------------------
class HomePage < Erector::Widget 
  def content
    html do
      head do
        title { 'Welcome to my Website' }
        link rel: 'stylesheet', href: 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css'
      end
      body(class: 'bg-gray-100 p-8 font-sans antialiased') do
        div(class: 'container mx-auto bg-white rounded-xl shadow-lg p-6') do
          h1(class: 'text-4xl font-bold text-gray-800 mb-4') {'Welcome to my Website'}
          p(class: 'text-lg text-gray-600 mb-6') {'This is where I showcase the small web apps I have built while learning to program in Ruby'}
          u1(class: 'space-y-2') do
            #The ul method creates an unordered list <ul> tag. This is a list of items that don't have a specific order, and they are typically displayed with bullet points.
            li do
              #The li method creates a list item <li> tag. Each <li> tag represents a single item in a list. In your code, each link to a calculator is a separate list item.
              a(href: '/portcharges', class: 'text-blue-500 hover:text-blue-700 font-semibold text-lg transition duration-300') {'Go to the Port Charges Calculator'} 
              #The a method creates an anchor <a> tag. This tag is used to create a hyperlink, which is a clickable link that takes the user from one page to another.
            end
            li do 
              a(href: '/solardcalculator', class: 'text-blue-500 hover:text-blue-700 font-semibold text-lg transition duration-300') {'Go to the Solar D Calculator'}
            end
          end
        end
      end
    end
  end
end
#---------------------------------------------

#---ERECTOR WIDGET FOR SOLAR D CALCULATOR PAGE
class SolarDCalculatorPage > Erector::Widget 
  needs :uv_indux

  def content
    html do
      head do
        title { 'Solar D Calculator' }
        link rel: 'stylesheet', href: 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css' 
      end
      body(class: 'font-sans bg-slate-100 flex items-center justify-center min-h-screen p-5') do
        div(class: 'container bg-white p-10 rounded-xl shadow-2xl max-w-lg w-full text-center') do
          h1(class: 'text-3xl font-bold text-center text-slate-800 mb-8') {'Solar D Calculator'}
          p(class: 'text-lg font-semibold text-blue-700 mb-6') {'The current UV index at your location is'}
          p(class: 'text-5xl font-extrabold text-blue-800 mb-6') {uv_index}
          div(class: 'mt-8') do
            a(href: '/', class: 'w-full py-3 px-4 bg-blue-600 hover:bg-blue-700 text-white font-bold rounded-lg shadow-md transition-colors duration-300 inline-block') {'Return to Homepage'}
          end
        end
      end
    end
  end
end
#---------------------------------------------


#---ERECTOR WIDGET FOR PORT CHARGES CALCULATOR-----


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
        link rel: 'stylesheet', href: 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css'
        #This is the standard HTML way to link to the Tailwind CSS stylesheet. It tells the browser, "Go get the CSS file at this URL and apply its styles to this page."
      end
      #Tailwind CSS is a framework which provides a large set of pre-built classes that you can apply directly to your HTML elements to style them.
      #The relationship between Erector and Tailwind CSS is that one provides the structure and the other provides the styling. They work together by allowing you to build the HTML structure using Ruby methods (Erector) and then apply pre-built styling to those elements by passing Tailwind's utility classes as arguments to those methods. Essentially, Erector creates the tags, and Tailwind CSS provides the look and feel.

body(class: 'font-sans bg-slate-100 flex items-center justify-center min-h-screen p-5') do
  div(class: 'container bg-white p-10 rounded-xl shadow-2xl max-w-lg w-full') do
    #The key: 'value' syntax with the colon is used for passing named arguments to a method. You see this with the Erector gem: div(class: '...') here, class: is a named argument for the div method.
    h1(class:'text-3xl font-bold text-center text-slate-800 mb-8') do
      text 'Port Charges Calculator'
#Here I am applying Tailwind CSS styles to my erector HTML tags.
    end

#-----------------------------------------------------------------------------

#---PORT CHARGES CALCULATOR LOGIC---------


form(action: '/calculate', method: 'post') do 
  #form(action: '/calculate', method: 'post') do: This line uses the Erector form method to create an HTML <form> tag
  #action: '/calculate': This attribute specifies the URL (/calculate) to which the form data will be sent when the user clicks the "Calculate Charges" button. This corresponds to the post '/calculate' route in the Sinatra app.
  #method: 'post': This specifies that the form data will be sent using the HTTP POST method, which is the standard way to submit data that creates or updates something on the server.
  div(class: 'mb-6') do
    label('Number of Containers:', for: 'num_containers', class: 'block text-sm font-medium text-gray-700 mb-2')
    #This creates an HTML <label> tag with the text "Number of Containers:". for: 'num_containers': This attribute links the label to the input field with the matching id of num_containers. This is important for accessibility, as clicking the label will focus the input field.
    input(type: 'number', id: 'num_containers', name: 'num_containers', min: '1', required: true, class: 'w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500') do
    #This line generates the <input> tag. type: 'number': This makes it a number-only input field, which often brings up a numeric keypad on mobile devices. id: 'num_containers' and name: 'num_containers': The id is used to link to the label, and the name is the key used to access the input's value in the Sinatra params hash when the form is submitted.   
  end
  div(class: 'mb-6') do
    label('Container Size/Type', for: 'container_type', class: 'block text-sm font-medium text-gray-700 mb-2')
    #This creates the label for the dropdown menu, linking it to the container_type element.
    #select(id: 'container_type', name: 'container_type', required: true, class: 'w-full ...') do: This creates the <select> tag, which is the dropdown itself.
    select(id: 'container_type', name: 'container_type', required: true, class: 'w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500') do 
      option('Select a size...', value: '', disabled: true, selected: true)
      #This is the first <option> in the dropdown. It acts as a placeholder or a prompt for the user. value: '': This option has an empty value.value: '': This option has an empty value. disabled: true: This makes the option unclickable. selected: true: This makes the option the default one shown when the page loads.
      option('20ST', value: '20ST')
      option('40ST', value: '40ST')
      option('40HC', value: '40HC')
      option('20RH', value: '20RH')
      option('40RH', value: '40RH')
      #These lines create the remaining <option> tags, representing the different container sizes. When a user selects one of these, its value attribute ('20ST', '40ST', etc.) is sent to the server.
    end
  end
div(class: 'mb-6') do
  label 'Include Charges:', class: 'block text-sm font-medium text-gray-700 mb-2'
  ['fas', 'security_fee', 'hazard', 'unstuffing', 'plugs_daily_rate'].each do |charge|
    #This is a core Ruby loop that makes the code efficient. is an array of strings, where each string corresponds to a type of charge. .each do |charge| iterates over this array one item at a time. In each iteration, the current string (e.g., 'fas', then 'security_fee') is assigned to the variable charge. This means the code inside the loop will run once for each type of charge. 
    div(class: 'flex items-center mb-3') do
      #div(class: 'flex items-center mb-3') do: Inside the loop, this line creates a <div> to wrap each individual checkbox and its label. The flex and items-center classes use Tailwind's flexbox to align the checkbox and its label horizontally, and the mb-3 class adds a bottom margin to space out the checkboxes vertically.
      input(type: 'checkbox', id: charge, name: charge, class: 'form-checkbox h-5 w-5 text-blue-600 rounded focus:ring-blue-500 border-gray-300')
      # This is the Erector method that generates the <input> tag for each checkbox. type: 'checkbox': Specifies that the input element is a checkbox.
      #id: charge and name: charge: The id and name attributes are set dynamically based on the current charge in the loop (e.g., for the first iteration, they would both be 'fas'). This ensures each checkbox has a unique identifier that the server can use to figure out which charges the user selected.
      label(charge.split('_').map(&:capitalize).join(' '), for: charge, class: 'ml-3 text-sm text-gray-700')
      #This generates the <label> tag for the checkbox.
      #charge.split('_').map(&:capitalize).join(' '): This is a piece of Ruby code that takes the string from the loop (e.g., 'security_fee') and formats it to be a user-friendly label ("Security Fee"). It splits the string at the underscore, capitalizes each word, and then joins them back together with a space.
      #for: charge: This attribute links the label to its corresponding input field using the charge variable.
    end
  end
end
div(class: 'mb-6', id: 'plugs-days-group') do
  label('Number of Days for Plugs:', for: 'plugs_days', class: 'block text-sm font-medium text-gray-700 mb-2')
  input(type: 'number', id: 'plugs_days', name: 'plugs_days', min: '0', value: '0', class: 'w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500')
  #min: '0': This sets the minimum acceptable value to zero, preventing negative numbers. value: '0': This sets the default value of the field to 0 when the page first loads.
end
button(type: 'submit', class: 'w-full py-3 px-4 bg-blue-600 hover:bg-blue-700 text-white font-bold rounded-lg shadow-md transition-colors duration-300') do
  #This line generates the <button> tag. type: 'submit': This is a crucial attribute that tells the browser this button is meant to submit the form data to the server.
  text 'Calculate Charges'
  end
end

if @result
  #This is a conditional statement. It checks if the @result instance variable has a value. In Sinatra, the @result variable is only assigned a value when the post '/calculate' route is called after the form is submitted. This if block ensures that the total charge is only displayed after the calculation has been performed and a result is available, and not when the page is first loaded.
  div(class: 'mt-8 p-6 bg-blue-50 rounded-lg') do
    h2(class: 'text-2xl font-bold text-center text-blue-800 mb-4') do
      text 'Breakdown of Charges'
    end
    ul(class: 'mb-4') do
      #ul(class: 'mb-4') do: This creates an unordered list (<ul>) to hold the individual charge items. The mb-4 adds a bottom margin.
      @result[:breakdown].each do |charge_name, amount|
        #@result[:breakdown].each do |charge_name, amount|: This is a key line that iterates through the breakdown hash 
        #charge_name, amount|: in each loop, the key (e.g., 'FAS') is assigned to the variable charge_name and the value (the calculated amount, e.g., 1221.98) is assigned to the variable amount.
        li(class: 'flex justify-between items-center py-2 border-b border-blue-200 last:border-b-0') do
          #This creates a list item (<li>) for each charge. The Tailwind classes are used to format it
          span(class: 'text-sm font-medium text-blue-700') do
            #This creates a <span> to hold the charge name. The Tailwind classes style the text.
            text charge_name
          end
          span(class: 'text-sm font-semibold text-blue-700') do
            #This creates another <span> to hold the amount. The classes style it with a slightly heavier font weight 
            text "BBD $%.2f" % amount
            #"BBD $%.2f": is a Ruby format string. %.2f is the placeholder for a floating-point number, and the .2 specifies that it should be rounded to exactly two decimal places.
            #% amount: This is the format operator. It tells Ruby to take the value of the amount variable and insert it into the placeholder in the string. The result is a clean, formatted string like "BBD $1221.98".
          end
        end
      end
    end
    div(class: 'text-lg font-semibold text-center text-blue-700 mt-4') do
      text 'Total Port Charges'
      #This is an Erector method that simply inserts the string "Total Port Charges" as plain text inside the <div>
      span(class: 'text-2xl font-extrabold') do
        #This line creates an inline <span> element. Since it's an inline element, it appears on the same line as the text that precedes it ("Total Port Charges"). This <span> is used to apply a different style specifically to the number, making it stand out from the rest of the line. The Tailwind classes are applied
        #A <span> is an inline HTML element that is used to apply styling or markup to a small portion of text within a larger block.
        text "BBD $%.2f" % @result[:total]
       end # Closes the span do block
              end # Closes the div do block
            end # Closes the div do block
          end # Closes the if do block
        end # Closes the div do block
      end # Closes the body do block
    end # Closes the html do block
  end # Closes the def content do block
end # Closes the class do block
  
  
def initialize(result = nil)
  #def initialize(result = nil): This line defines the initialize method, which is the class constructor in Ruby. It accepts one parameter, result, and the = nil part makes this parameter optional. When a page object is created without a result (e.g., on the initial /portcharges page load), result is set to nil. When a new page object is created after a calculation, the total charge is passed as the result.
  super ({})
  #super: The super keyword calls the initialize method of the parent class, which is Erector::Widget. This is a crucial step that ensures the parent class is properly set up before the subclass code runs.
  #super({}). This passes an empty hash to the parent class
  @result = result
  #@result = result: This line assigns the value of the result parameter to an instance variable named @result. An instance variable is a variable that belongs to a specific instance of the class, making its value available to all other methods within that instance, such as the content method that renders the HTML.
#The @ symbol in front of a variable name in Ruby signifies that it's an instance variable. Think of a class as a blueprint for a house and an instance of that class as a specific house built from that blueprint.
#result (without the @): This is a local variable. It only exists inside the initialize method. Once the initialize method finishes its job, this variable disappears.
#@result (with the @): This is an instance variable. It becomes a part of the specific PortChargesCalculatorPage object you've created. This variable will persist for the entire life of that object and can be accessed by any other method within that same object.
#The initialize method is where the result from the calculation is first received. By assigning it to the instance variable @result, you are effectively saving that value to the "house" so that other "rooms" (methods) in the "house" can use it.
  end
end 


#---MAIN SINATRA ROUTES----------------

#Port Charges Route

get '/portcharges' do
  #The code get '/' is a fundamental part of the Sinatra framework and represents the homepage of your web application. It's the first thing a user sees when they visit your site.
  #The keyword get is an HTTP method. It's the standard way for a web browser to request a resource from a web server. When you type a URL into a browser and press Enter, the browser sends a GET request.
  #'/portcharges' represents the path of your website. Rather than just get '/', which would represent the root path, this makes the port charges calculator only accessible at /portcharges, leaving the homepage available for other content.
#The get '/' route is for retrieving or displaying a page. It's what happens when you visit thomasridgeon.com/portcharges. The browser is simply asking the server for the HTML document. The server doesn't expect any data to be sent with this request, just the page itself.
#The post '/calculate' route is separate. It's good practice to keep the form submission separate, so the form will still send its data to the correct location for calculation, even if the /portcharges page has a different URL.
#The post '/calculate' route is for submitting data to the server. This happens when the user fills out the form and clicks the "Calculate Charges" button. The form packages up all the user's input and sends it to the URL specified in the form's action attribute.
  PortChargesCalculatorPage.new.to_html
  #This line creates a new instance of the PortChargesCalculatorPage class. This is the class you defined using Erector to build the HTML for your page.
  #.to_html: This method is called on the new PortChargesCalculatorPage object. It's an Erector method that takes all of the Ruby methods you defined in the content block (html, head, body, etc.) and converts them into a single string of valid HTML. This HTML string is what the web browser will receive and render as the homepage.
end

#Solar D Calculator route
get '/solardcalculator' do
  ip = request.ip
  response = HTTParty.get("http://ip-api.com/json/#{ip}")
  # Make an API call to ip-api to get the location data.
  # No API key is required.
  location_data = JSON.parse(response.body)
  lat = location_data['lat']
  lng = location_data['lon']
  # Parse the JSON response from ip-api to get the latitude and longitude.
  openuv_response = HTTParty.get(
    "https://api.openuv.io/api/v1/uv?lat=#{lat}&lng=#{lng}")
    headers: { x-access-token => OPENUV_API_KEY }
    # Now, use those coordinates to make an API call to OpenUV.
    openuv_data = JSON.parse(openuv_response.body)
    uv_index = openuv_data ['result']['uv']
    # Parse the JSON response from OpenUV to get the UV index.
  SolarDCalculatorPage.new.to_html
  # Render the page using the Erector widget and pass the calculated UV index to it.
end

#Homepage route
get '/' do
  HomePage.new.to_html
end
#----------------------------------

post '/calculate' do
#This section of code is a Sinatra route that handles the form submission and performs the initial part of the calculation. It's the logic that runs on the server after a user clicks the "Calculate Charges" button on the form.
#post '/calculate' do: This line defines the route. post: This specifies the HTTP method. This code block will only execute when a POST request is sent to the /calculate URL. This happens when the user submits the form.
  num_containers = params[:num_containers].to_i
  #num_containers = params[:num_containers].to_i: This line retrieves the value from the "Number of Containers" input field.
  #params: Sinatra automatically collects all the data submitted by a form and puts it into a hash named params.
  #params[:num_containers]: This accesses the value from the form field that had the name attribute of 'num_containers'.
  container_type = params[:container_type]
  #This line does the same for container type, as the line above it did for number of containers, except the value is already a string, so no conversion is needed.
  total_charge = 0.0
  #total_charge = 0.0: This line initializes a variable to store the final calculated total. It's set to 0.0 to ensure it's a floating-point number, which is necessary for precise monetary calculations.
  breakdown = {}
  #I want to add a breakdown of each charge also, so I need to create a hash {} for the breakdown, and now within each of the if conditions, I will save the calculated charge to this new breakdown hash.

  if params['fas'] == 'on'
    #if params[:fas] == 'on': This is a conditional statement that checks if the "FAS" checkbox was selected in the form. When a checkbox is checked, its value is sent as 'on'.
    rate = RATES['fas'][container_type]
    #rate = RATES['fas'][container_type]: If the checkbox was checked, this line looks up the specific charge rate. It first accesses the RATES hash with the key 'fas', and then it uses the container_type (e.g., '20ST') as the key to find the corresponding rate.
    charge_amount = num_containers * rate 
    #charge_amount =: This is a variable assignment. It creates a new variable named charge_amount and gives it a value.
    total_charge += charge_amount if rate 
    #total_charge: This is the variable that keeps a running total of all the charges.
    #+=: This is a shorthand operator. It means "add the value on the right to the variable on the left and reassign the result to the variable." So, total_charge += charge_amount is the same as writing total_charge = total_charge + charge_amount.
    breakdown['FAS'] = charge_amount if rate 
    #breakdown: This is the new hash you created to store the breakdown of charges.
    #['FAS'] =: This is the syntax for adding a new key-value pair to a hash. The key is 'FAS' (a string you chose to describe the charge), and the value is the calculated charge_amount.
  end

  if params['security_fee'] == 'on'
    rate = RATES['security_fee'][container_type]
    charge_amount = num_containers * rate
    total_charge += charge_amount if rate
    breakdown['Security Fee'] = charge_amount if rate
  end

  if params['hazard'] == 'on'
    rate = RATES['hazard'][container_type]
    charge_amount = num_containers * rate
    total_charge += charge_amount if rate
    breakdown['Hazard'] = charge_amount if rate
  end

  if params['unstuffing'] == 'on'
    rate = RATES['unstuffing'][container_type]
    charge_amount = num_containers * rate
    total_charge += charge_amount if rate
    breakdown['Unstuffing'] = charge_amount if rate 
  end

  if params['plugs_daily_rate'] == 'on'
    days = params['plugs_days'].to_i
    if days > 0
      rate = RATES['plugs_daily_rate'][container_type]
      charge_amount = num_containers * days * rate
      total_charge += charge_amount if rate
      breakdown['Plugs Daily Rate'] = charge_amount if rate
    end
  end

  result_data = {
    total: total_charge,
    breakdown: breakdown
  }
  PortChargesCalculatorPage.new(result_data).to_html
  #Creating the Data Package:
  #result_data =: This line creates a new variable named result_data.
  #{ ... }: The curly braces create a new hash, which is a collection of key-value pairs. This hash acts as a single package to hold all the information you want to pass to the page.
  #total: total_charge: This creates the first key-value pair.
  #total:: This is a symbol, which is a lightweight, immutable string in Ruby. It's used here as a permanent, fixed name for the key.
  #total_charge: This is the variable holding the final calculated total. Its value is assigned to the total: key.
  #breakdown: breakdown: This creates the second key-value pair.
  #breakdown:: This is another symbol used as the key.
  #breakdown: This is the variable holding the hash you created that contains the details of each individual charge. This means your result_data hash holds another hash as one of its values.
  
  #Passing the Data to the Page:
  #PortChargesCalculatorPage.new(...): This creates a new instance of your PortChargesCalculatorPage class. When you call .new, it automatically runs the initialize method inside your class.
  #(result_data): This is the argument you are passing to the initialize method. The entire hash you just created is passed as the result parameter to that method, which then assigns it to the @result instance variable.
  #.to_html: This is the final step. It's an Erector method that takes all the Ruby code you defined in your content method and generates a complete HTML string. This final HTML string is what the web browser will receive and display to the user.
end
