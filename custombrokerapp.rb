#gem install sinatra
#gem install sinatra-reloader
#test app in local host using command: bundle exec puma
require 'sinatra'
require 'erector'
require 'pry-byebug'
require 'sinatra/reloader'
configure :development do
  register Sinatra::Reloader
end
#
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
    #The key: 'value' syntax with the colon is used for passing named arguments to a method. You see this with the Erector gem: div(class: '...') here, class: is a named argument for the div method.
    h1(class:'text-3xl font-bold text-center text-slate-800 mb-8') do
      text 'Port Charges Calculator'
#Here I am applying Tailwind CSS styles to my erector HTML tags.

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
  div(class: 'mt-8 p-6 bg-blue-50 rounded-lg text-center') do
    div(class: 'text-lg font-semibold text-blue-700') do
      text 'Total Port Charges: BBD $'
      span(class: 'text-2xl font-extrabold')
      #span(class: 'text-2xl font-extrabold') do: This creates an HTML <span> tag, which is an inline element used to apply specific styling to a part of the text.
      #text-2xl: Sets a much larger font size of 1.5rem (24px), making the number stand out. font-extrabold: Makes the font extra-bold to draw attention.
      text "%.2f" % @result
      #This is the core Ruby code that formats and displays the final number.
      #"%.2f": This is a format specifier string. The % signifies the start of a format, .2 means "format to exactly two decimal places," and f indicates that the number is a floating-point number.
      #% @result: This is the format operator. It applies the format string "%.2f" to the value stored in the @result variable. So, if @result is 550.0, it will display as "550.00". This is essential for displaying monetary values correctly.
    end
  end
end
end
end
end
end
end
#The reason you see so many end keywords is that they are Ruby's way of closing a block of code. Think of it like a pair of bookends. Every time you open a block with a keyword like if or do, you need to close it with an end.
#The first end closes the if block that checks for a result.
#The second end closes the outer div method's do block.
#The third end closes the inner div method's do block.
#The fourth end closes the span method's do block.
#The last two end keywords close the content method and the PortChargesCalculatorPage class itself, which are part of the larger Canvas code.
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

  if params['fas'] == 'on'
    #if params[:fas] == 'on': This is a conditional statement that checks if the "FAS" checkbox was selected in the form. When a checkbox is checked, its value is sent as 'on'.
    rate = RATES['fas'][container_type]
    #rate = RATES['fas'][container_type]: If the checkbox was checked, this line looks up the specific charge rate. It first accesses the RATES hash with the key 'fas', and then it uses the container_type (e.g., '20ST') as the key to find the corresponding rate.
    total_charge += num_containers * rate if rate
    #This line performs the actual calculation for the FAS charge and adds it to the total_charge variable. The if rate check ensures that the calculation only happens if a valid rate was found in the RATES hash.
    #the += operator is a shorthand way to add a value to a variable and then reassign the result to that same variable. It's a combination of addition and assignment. The line total_charge += num_containers * rate is an efficient way of writing: total_charge = total_charge + (num_containers * rate)
  end

  if params['security_fee'] == 'on'
    rate = RATES['security_fee'][container_type]
    total_charge += num_containers * rate if rate
  end

  if params['hazard'] == 'on'
    rate = RATES['hazard'][container_type]
    total_charge += num_containers * rate if rate
  end

  if params['unstuffing'] == 'on'
    rate = RATES['unstuffing'][container_type]
    total_charge += num_containers * rate if rate
  end

  if params['plugs_daily_rate'] == 'on'
    days = params['plugs_days'].to_i
    if days > 0
      total_charge += num_containers * days * RATES['plugs_daily_rate'][container_type]
    end
  end

  PortChargesCalculatorPage.new(total_charge).to_html
  #PortChargesCalculatorPage.new(total_charge).to_html is the final step in the calculation process. It's what generates the new web page with the total charges displayed.
  #PortChargesCalculatorPage.new(total_charge): This part creates a new instance of the PortChargesCalculatorPage class. It passes the total_charge variable, which was calculated in the lines above, into the initialize method of the class. This saves the calculated total to the @result instance variable so that it can be accessed later.
  #.to_html: This method is then called on the newly created PortChargesCalculatorPage object. It is a key method provided by the Erector gem. Its job is to take all the Ruby code you defined in the content method and convert it into a single, complete HTML string.
end
