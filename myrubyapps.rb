#---REQUIREMENTS---------------------------------
require 'sinatra'
require 'dotenv/load' # loads environment variables from a .env file
require 'httparty' # required for solar calculator to make API calls
require 'json' # required to parse json responses from the API
require 'erector'
require 'pry-byebug' # debugging tool
require 'sinatra/reloader'
configure :development do
  register Sinatra::Reloader
end
#-------------------------

#---API Keys------------------------------------
OPENUV_API_KEY = ENV['OPENUV_API_KEY']
#-----------------------------------------------

#---HOMEPAGE-----------------------------------

#---Home Page Widget----------------------------
class HomePage < Erector::Widget
  # defines a new class HomePage which inherits from the superclass Erector::Widget. :: signifies that the Widget class lives inside the Erector module.
  # So because of inheritance, the HomePage is an Erector::Widget, and therefore gets all the methods and functionality of Erector::Widget.

  def content
    rawtext '<!DOCTYPE html>'
    # By including <!DOCTYPE html>, you ensure the browser uses the latest and most consistent rendering rules for modern HTML.
    html do
      head do
        title 'Home Page'
        meta(charset: 'UTF-8')
        meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0')

        link(rel: 'preconnect', href: 'https://fonts.googleapis.com')
        link(rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: 'anonymous')
        title "Hey I'm Thomas!"
        link rel: 'stylesheet', href: 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css'
        link href: 'https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap', rel: 'stylesheet'

        # CSS code to add custom font
        style do
          rawtext <<-CSS
            html, body {
              font-family: 'Montserrat', sans-serif !important;
            }
          CSS
        end
      end # closes head do

      body(class: 'bg-white text-black') do
        #---Nav bar---
        nav(class: 'bg-black text-white w-full px-6 py-4 flex justify-between items-center fixed top-0 left-0 right-0 shadow-md') do
          # Left Side
          div do
            a(href: '/', class: 'text-lg hover:text-gray-300 transition-colors ml-20') do
              text 'Home'
            end
          end

          # Right Side
          div(class: 'space-x-6 mr-20') do
            a(href: '/about', class: 'text-lg hover:text-gray-300 transition-colors') { text 'About Me' }
            a(href: '/projects', class: 'text-lg hover:text-gray-300 transition-colors') { text 'Projects' }
          end
        end
        #----------------

        #---Main content-----

        div(class: 'max-w-2xl p-6 flex flex-col items-start ml-20') do
          h1(class: 'text-7xl font-bold mt-28 mb-10') do # h1 only needs a bottom margin to space itself from the paragraphs below.
            text 'Hey!'
          end
          p(class: 'text-5xl mb-8') do
            text 'My name is Thomas Ridgeon'
          end
          p(class: 'text-lg mb-4') do
            text 'This is my website I coded from scratch where you can read a bit about me and try out some of the webapps I created while learning to program.'
          end
        end
      end
    end
  end
end

#---Homepage Get Route---------------------------
get '/' do
  HomePage.new.to_html
end
#------------------------------------------------

#---ABOUT PAGE-----------------------------------
#---About Page Widget-----------
class AboutPage < Erector::Widget
  def content
    rawtext '<!DOCTYPE html>'
    html do
      head do
        title 'About Me - Thomas Ridgeon'
        meta(charset: 'UTF-8')
        meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0')

        link(rel: 'preconnect', href: 'https://fonts.googleapis.com')
        link(rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: 'anonymous')
        title "Hey I'm Thomas!"
        link rel: 'stylesheet', href: 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css'
        link href: 'https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap', rel: 'stylesheet'

        # CSS code to add custom font
        style do
          rawtext <<-CSS
            html, body {
              font-family: 'Montserrat', sans-serif !important;
            }
          CSS
        end
      end

      body(class: 'bg-white text-black') do
        #---Nav bar---
        nav(class: 'bg-black text-white w-full px-6 py-4 flex justify-between items-center fixed top-0 left-0 right-0 shadow-md') do
          # Left Side
          div do
            a(href: '/', class: 'text-lg hover:text-gray-300 transition-colors ml-20') do
              text 'Home'
            end
          end

          # Right Side
          div(class: 'space-x-6 mr-20') do
            a(href: '/about', class: 'text-lg hover:text-gray-300 transition-colors') { text 'About Me' }
            a(href: '/projects', class: 'text-lg hover:text-gray-300 transition-colors') { text 'Projects' }
          end
        end
        #----------------

        #---Main content-----

        div(class: 'max-w-5xl p-6 flex flex-col ml-20') do
          h1(class: 'text-5xl font-bold mt-28 mb-10') do
            text 'About Me'
          end

          div(class: 'flex items-start gap-10') do
            div(class: 'flex-1') do
              p(class: 'text-base mb-4') do
                text 'I am currently employed as a Customs Broker, however I am a technology enthusiast and long-time Linux user with a passion for open source software.'
              end
              p(class: 'text-base mb-4') do
                text 'Using Replit, I "vibe coded" two applications to improve efficiency and accuracy in my work: a container clearance tracking app with detailed analytics to identify process bottlenecks, and a customs broker toolkit that automates complex calculations for charges and customs valuations.'
              end
              p(class: 'text-base mb-4') do
                text "What started as \"vibe coding\" quickly evolved into a strong desire to understand how to build web applications myself, from the ground up. I dove into learning Ruby, using Chris Pine's 'Learn to Program' as my guide and relying on LLMs as my personal coding tutors. My first project was an application I'd previously built on Replit, which I recreated from scratch in Ruby. This experience was the foundation for building other web apps and, eventually, this entire website, all of which I've coded from scratch, primarily in Ruby."
              end
            end
            div(class: 'flex-shrink-0 self-center') do
              img(src: '/images/myphoto.jpg', alt: 'My Photo', class: 'w-64 h-64 rounded-full mx-auto mb-6')
            end
          end
        end
      end
    end
  end
end

#---About Me Get Route---------------------------
get '/about' do
  AboutPage.new.to_html
end
#------------------------------------------------

#---PROJECTS PAGE-------------------------------
class ProjectsPage < Erector::Widget
  def content
    rawtext '<!DOCTYPE html>'
    html do
      head do
        title 'Projects - Thomas Ridgeon'
        meta(charset: 'UTF-8')
        meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0')

        link(rel: 'preconnect', href: 'https://fonts.googleapis.com')
        link(rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: 'anonymous')
        title "Hey I'm Thomas!"
        link rel: 'stylesheet', href: 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css'
        link href: 'https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap', rel: 'stylesheet'

        # CSS code to add custom font
        style do
          rawtext <<-CSS
            html, body {
              font-family: 'Montserrat', sans-serif !important;
            }
          CSS
        end
      end # closes head do

      body(class: 'bg-white text-black') do
        #---Nav bar---
        nav(class: 'bg-black text-white w-full px-6 py-4 flex justify-between items-center fixed top-0 left-0 right-0 shadow-md') do
          # Left Side
          div do
            a(href: '/', class: 'text-lg hover:text-gray-300 transition-colors ml-20') do
              text 'Home'
            end
          end

          # Right Side
          div(class: 'space-x-6 mr-20') do
            a(href: '/about', class: 'text-lg hover:text-gray-300 transition-colors') { text 'About Me' }
            a(href: '/projects', class: 'text-lg hover:text-gray-300 transition-colors') { text 'Projects' }
          end
        end
        #----------------

        #---Main content-----

        div(class: 'max-w-2xl p-6 flex flex-col items-start ml-20') do
          h1(class: 'text-5xl font-bold mt-28 mb-10') do
            text 'My Projects'
          end
          a(href: '/portcharges', class: 'text-xl font-bold hover:text-gray-300 transition-colours') do
            text 'Port Charges Calculator'
          end
          p(class: 'text-base mb-4') do
            text "This is the first web app I coded from scratch. It's one of the tools I had created with Replit for my Customs Broker Toolkit. It's a simple web app for customs brokers in Barbados to calculate Barbados Port Charges."
          end
          a(href: '/solardcalculator', class: 'text-xl font-bold hover:text-gray-300 transition-colours') do
            text 'Solar D Calculator'
          end
          p(class: 'text-base mb-4') do
            text 'This is a web app which tells you the current UV index of the sun in your region and calculates, based on your age and skin type, the amount of time you would have to be outside with at least 25% of your body exposed to synthesize an optimum daily amount of vitamin D (1,000 IU).'
          end
        end
      end
    end
  end
end

#---Projects Get Route---------
get '/projects' do
  ProjectsPage.new.to_html
end
#------------------------------------------------

#---PORT CHARGES CALCULATOR-------------------

#---Rates for Port Charges----------------------
RATES = {
  'fas' => {
    '20ST' => 1221.98,
    '40ST' => 2443.96,
    '40HC' => 2661.32,
    '20RH' => 1328.93,
    '40RH' => 2657.85
  },
  'security_fee' => {
    '20ST' => 155.10,
    '40ST' => 310.20,
    '40HC' => 310.20,
    '20RH' => 105.75,
    '40RH' => 211.50
  },
  'hazard' => {
    '20ST' => 118.68,
    '40ST' => 259.09,
    '40HC' => 259.09

  },
  'unstuffing' => {
    '20ST' => 528.75,
    '40ST' => 1075.50,
    '40HC' => 1075.50

  },
  'plugs_daily_rate' => {
    '20RH' => 115.15,
    '40RH' => 230.30
  }
}
# In Ruby, => is a special operator most commonly used to define key-value pairs within a hash. It separates the key from its corresponding value.
# the curly braces {} are used to define a hash. A hash is a fundamental data structure in Ruby that stores data in key-value pairs. It's a perfect way to organize and look up information.

#---Port Charges Calculator Widget-----
class PortChargesCalculatorPage < Erector::Widget
  def content
    html do
      head do
        meta(charset: 'UTF-8')
        meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0')
        # meta(charset: 'UTF-8'): This line generates the <meta charset="UTF-8"> tag. This is crucial for web browsers to correctly display characters from different languages.
        # meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0'): This generates a meta tag that is essential for making the page responsive and look good on mobile devices. It tells the browser to match the page's width to the device's screen width.
        title 'Port Charges Calculator'

        link rel: 'stylesheet', href: 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css'
        link(rel: 'preconnect', href: 'https://fonts.googleapis.com')
        link(rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: 'anonymous')
        link href: 'https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap', rel: 'stylesheet'

        # Custom font CSS
        style do
          rawtext <<-CSS
      html, body {
        font-family: 'Montserrat', sans-serif !important;
      }
          CSS
        end
      end

      body(class: 'font-sans bg-slate-100 flex items-center justify-center min-h-screen p-5') do
        div(class: 'container bg-white p-10 rounded-xl shadow-2xl max-w-lg w-full') do
          h1(class: 'text-3xl font-bold text-center text-slate-800 mb-8') do
            text 'Port Charges Calculator'
          end

          form(action: '/calculate', method: 'post') do
            # form(action: '/calculate', method: 'post') do: This line uses the Erector form method to create an HTML <form> tag
            # action: '/calculate': This attribute specifies the URL (/calculate) to which the form data will be sent when the user clicks the "Calculate Charges" button. This corresponds to the post '/calculate' route in the Sinatra app.
            # method: 'post': This specifies that the form data will be sent using the HTTP POST method, which is the standard way to submit data that creates or updates something on the server.

            div(class: 'mb-6') do
              label('Number of Containers:', for: 'num_containers',
                                             class: 'block text-sm font-medium text-gray-700 mb-2')
              input(type: 'number', id: 'num_containers', name: 'num_containers', min: '1', required: true,
                    class: 'w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500') do
              end
              div(class: 'mb-6') do
                label('Container Size/Type', for: 'container_type',
                                             class: 'block text-sm font-medium text-gray-700 mb-2')
                select(id: 'container_type', name: 'container_type', required: true,
                       class: 'w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500') do
                  option('Select a size...', value: '', disabled: true, selected: true)
                  # This is the first <option> in the dropdown. It acts as a placeholder or a prompt for the user. value: '': This option has an empty value.value: '': This option has an empty value. disabled: true: This makes the option unclickable. selected: true: This makes the option the default one shown when the page loads.
                  option('20ST', value: '20ST')
                  option('40ST', value: '40ST')
                  option('40HC', value: '40HC')
                  option('20RH', value: '20RH')
                  option('40RH', value: '40RH')
                end
              end

              div(class: 'mb-6') do
                label 'Include Charges:', class: 'block text-sm font-medium text-gray-700 mb-2'
                %w[fas security_fee hazard unstuffing plugs_daily_rate].each do |charge|
                  # This is a core Ruby loop that makes the code efficient. is an array of strings, where each string corresponds to a type of charge. .each do |charge| iterates over this array one item at a time. In each iteration, the current string (e.g., 'fas', then 'security_fee') is assigned to the variable charge. This means the code inside the loop will run once for each type of charge.

                  div(class: 'flex items-center mb-3') do
                    input(type: 'checkbox', id: charge, name: charge,
                          class: 'form-checkbox h-5 w-5 text-blue-600 rounded focus:ring-blue-500 border-gray-300')
                    label(charge.split('_').map(&:capitalize).join(' '), for: charge,
                                                                         class: 'ml-3 text-sm text-gray-700')
                    # charge.split('_').map(&:capitalize).join(' '): This is a piece of Ruby code that takes the string from the loop (e.g., 'security_fee') and formats it to be a user-friendly label ("Security Fee"). It splits the string at the underscore, capitalizes each word, and then joins them back together with a space.
                  end
                end
              end

              div(class: 'mb-6', id: 'plugs-days-group') do
                label('Number of Days for Plugs:', for: 'plugs_days',
                                                   class: 'block text-sm font-medium text-gray-700 mb-2')
                input(type: 'number', id: 'plugs_days', name: 'plugs_days', min: '0', value: '0',
                      class: 'w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500')
              end
              button(type: 'submit',
                     class: 'w-full py-3 px-4 bg-blue-600 hover:bg-blue-700 text-white font-bold rounded-lg shadow-md transition-colors duration-300') do
                # This line generates the <button> tag. type: 'submit': This is a crucial attribute that tells the browser this button is meant to submit the form data to the server.
                text 'Calculate Charges'
              end
            end

            if @result
              # This is a conditional statement. It checks if the @result instance variable has a value. In Sinatra, the @result variable is only assigned a value when the post '/calculate' route is called after the form is submitted. This if block ensures that the total charge is only displayed after the calculation has been performed and a result is available, and not when the page is first loaded.
              div(class: 'mt-8 p-6 bg-blue-50 rounded-lg') do
                h2(class: 'text-2xl font-bold text-center text-blue-800 mb-4') do
                  text 'Breakdown of Charges'
                end
                ul(class: 'mb-4') do
                  # ul(class: 'mb-4') do: This creates an unordered list (<ul>) to hold the individual charge items.
                  @result[:breakdown].each do |charge_name, amount|
                    # @result[:breakdown].each do |charge_name, amount|: This is a key line that iterates through the breakdown hash
                    # charge_name, amount|: in each loop, the key (e.g., 'FAS') is assigned to the variable charge_name and the value (the calculated amount, e.g., 1221.98) is assigned to the variable amount.
                    li(class: 'flex justify-between items-center py-2 border-b border-blue-200 last:border-b-0') do
                      # This creates a list item (<li>) for each charge. The Tailwind classes are used to format it
                      span(class: 'text-sm font-medium text-blue-700') do
                        # This creates a <span> to hold the charge name. The Tailwind classes style the text.
                        text charge_name
                      end
                      span(class: 'text-sm font-semibold text-blue-700') do
                        # This creates another <span> to hold the amount. The classes style it with a slightly heavier font weight
                        text 'BBD $%.2f' % amount
                        # "BBD $%.2f": is a Ruby format string. %.2f is the placeholder for a floating-point number, and the .2 specifies that it should be rounded to exactly two decimal places.
                        # % amount: This is the format operator. It tells Ruby to take the value of the amount variable and insert it into the placeholder in the string. The result is a clean, formatted string like "BBD $1221.98".
                      end
                    end
                  end
                end

                div(class: 'text-lg font-semibold text-center text-blue-700 mt-4') do
                  text 'Total Port Charges'
                  span(class: 'text-2xl font-extrabold') do
                    # This line creates an inline <span> element. Since it's an inline element, it appears on the same line as the text that precedes it ("Total Port Charges"). This <span> is used to apply a different style specifically to the number, making it stand out from the rest of the line. The Tailwind classes are applied
                    text ' BBD $%.2f' % @result[:total]
                  end
                end
              end
            end

            #---Return to Homepage and Return to Projects Buttons
            div(class: 'my-8 text-center') do
              a(href: '/projects',
                class: 'inline-block py-2 px-4 bg-blue-600 hover:bg-blue-700 text-white text-base font-bold rounded-lg shadow-md transition-colors duration-300') do
                text 'Return to Projects'
              end
            end

            div(class: 'my-8 text-center') do
              a(href: '/',
                class: 'inline-block py-2 px-4 bg-blue-600 hover:bg-blue-700 text-white text-base font-bold rounded-lg shadow-md transition-colors duration-300') do
                text 'Return to Homepage'
              end
            end
          end
        end
      end
    end
  end

  def initialize(result = nil)
    # def initialize(result = nil): This line defines the initialize method, which is the class constructor in Ruby. It accepts one parameter, result, and the = nil part makes this parameter optional. When a page object is created without a result (e.g., on the initial /portcharges page load), result is set to nil. When a new page object is created after a calculation, the total charge is passed as the result.
    super ({})
    # super: The super keyword calls the initialize method of the parent class, which is Erector::Widget. This is a crucial step that ensures the parent class is properly set up before the subclass code runs.
    # super({}). This passes an empty hash to the parent class
    @result = result
    # @result = result: This line assigns the value of the result parameter to an instance variable named @result. An instance variable is a variable that belongs to a specific instance of the class, making its value available to all other methods within that instance, such as the content method that renders the HTML.
    # The @ symbol in front of a variable name in Ruby signifies that it's an instance variable. Think of a class as a blueprint for a house and an instance of that class as a specific house built from that blueprint.
    # result (without the @): This is a local variable. It only exists inside the initialize method. Once the initialize method finishes its job, this variable disappears.
    # @result (with the @): This is an instance variable. It becomes a part of the specific PortChargesCalculatorPage object you've created. This variable will persist for the entire life of that object and can be accessed by any other method within that same object.
    # The initialize method is where the result from the calculation is first received. By assigning it to the instance variable @result, you are effectively saving that value to the "house" so that other "rooms" (methods) in the "house" can use it.
  end
end

#---Port Charges Get Route------------

get '/portcharges' do
  # The keyword get is an HTTP method. It's the standard way for a web browser to request a resource from a web server. When you type a URL into a browser and press Enter, the browser sends a GET request.
  PortChargesCalculatorPage.new.to_html
  # This line creates a new instance of the PortChargesCalculatorPage class. This is the class you defined using Erector to build the HTML for your page.
  # .to_html: This method is called on the new PortChargesCalculatorPage object. It's an Erector method that takes all of the Ruby methods you defined in the content block (html, head, body, etc.) and converts them into a single string of valid HTML. This HTML string is what the web browser will receive and render as the homepage.
end

#---Port Charges Post Route-----------

post '/calculate' do
  # This section of code is a Sinatra route that handles the form submission and performs the initial part of the calculation. It's the logic that runs on the server after a user clicks the "Calculate Charges" button on the form.
  # The post '/calculate' route is for submitting data to the server. This happens when the user fills out the form and clicks the "Calculate Charges" button. The form packages up all the user's input and sends it to the URL specified in the form's action attribute.
  num_containers = params[:num_containers].to_i
  # num_containers = params[:num_containers].to_i: This line retrieves the value from the "Number of Containers" input field.
  # params: Sinatra automatically collects all the data submitted by a form and puts it into a hash named params.
  # params[:num_containers]: This accesses the value from the form field that had the name attribute of 'num_containers'.
  container_type = params[:container_type]
  # This line does the same for container type, as the line above it did for number of containers, except the value is already a string, so no conversion is needed.
  total_charge = 0.0
  # total_charge = 0.0: This line initializes a variable to store the final calculated total. It's set to 0.0 to ensure it's a floating-point number, which is necessary for precise monetary calculations.
  breakdown = {}
  # I want to add a breakdown of each charge also, so I need to create a hash {} for the breakdown, and now within each of the if conditions, I will save the calculated charge to this new breakdown hash.

  if params['fas'] == 'on'
    # if params[:fas] == 'on': This is a conditional statement that checks if the "FAS" checkbox was selected in the form. When a checkbox is checked, its value is sent as 'on'.
    rate = RATES['fas'][container_type]
    # rate = RATES['fas'][container_type]: If the checkbox was checked, this line looks up the specific charge rate. It first accesses the RATES hash with the key 'fas', and then it uses the container_type (e.g., '20ST') as the key to find the corresponding rate.
    charge_amount = num_containers * rate
    # charge_amount =: This is a variable assignment. It creates a new variable named charge_amount and gives it a value.
    total_charge += charge_amount if rate
    # total_charge: This is the variable that keeps a running total of all the charges.
    # +=: This is a shorthand operator. It means "add the value on the right to the variable on the left and reassign the result to the variable." So, total_charge += charge_amount is the same as writing total_charge = total_charge + charge_amount.
    breakdown['FAS'] = charge_amount if rate
    # breakdown: This is the new hash you created to store the breakdown of charges.
    # ['FAS'] =: This is the syntax for adding a new key-value pair to a hash. The key is 'FAS' (a string you chose to describe the charge), and the value is the calculated charge_amount.
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
end

# Creating the Data Package:
# result_data =: This line creates a new variable named result_data.
# { ... }: The curly braces create a new hash, which is a collection of key-value pairs. This hash acts as a single package to hold all the information you want to pass to the page.
# total: total_charge: This creates the first key-value pair.total_charge is the variable holding the final calculated total. Its value is assigned to the total: key.
# breakdown: breakdown: This creates the second key-value pair.
# breakdown: This is the variable holding the hash you created that contains the details of each individual charge. This means your result_data hash holds another hash as one of its values.

# Passing the Data to the Page:
# PortChargesCalculatorPage.new(...): This creates a new instance of your PortChargesCalculatorPage class. When you call .new, it automatically runs the initialize method inside your class.
# (result_data): This is the argument you are passing to the initialize method. The entire hash you just created is passed as the result parameter to that method, which then assigns it to the @result instance variable.
#-----------------------------------------------

#---Solar D Calculator Widget------------------
class SolarDCalculatorPage < Erector::Widget
  needs :uv_index, :result_time
  # added variables that will hold the numerical values for the UV index from openuv, the current time, and the time calculated for optimal vitamin D

  def content
    html do
      head do
        title { 'Solar D Calculator' }
        meta(charset: 'UTF-8')
        meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0')

        link rel: 'stylesheet', href: 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css'
        link(rel: 'preconnect', href: 'https://fonts.googleapis.com')
        link(rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: 'anonymous')
        link href: 'https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap', rel: 'stylesheet'

        # Custom font CSS
        style do
          rawtext <<-CSS
      html, body {
        font-family: 'Montserrat', sans-serif !important;
      }
          CSS
        end
      end
      body(class: 'font-sans bg-slate-100 flex justify-center min-h-screen p-5') do
        div(class: 'container bg-white p-10 rounded-xl shadow-2xl max-w-lg w-full text-center') do
          h1(class: 'text-3xl font-bold text-center text-slate-800 mb-8') { text 'Solar D Calculator' }

          if @result_time.nil? # #if nil, this means we will display the form for the initial GET request

            if @uv_index.nil? || @uv_index <= 0
              p(class: 'text-lg text-red-600 mb-6') do
                text "The UV index is currently too low(#{@uv_index}) to synthesize vitamin D."
              end # end of UV too low message
            else
              p(class: 'text-lg font-semibold text-blue-700 mb-6') { 'The current UV index at your location is' }
              p(class: 'text-5xl font-extrabold text-blue-800 mb-6') { @uv_index }

              form(action: '/solardcalculator', method: 'post') do
                input(type: 'hidden', name: 'uv_index', value: @uv_index)
                # here we add a hiden input to pass on the UV index to the POST request

                div(class: 'mb-6') do
                  label('Age', for: 'age', class: 'block text-sm font-medium text-gray-700 mb-2')
                  input(type: 'number', id: 'age', name: 'age', required: true, min: '1',
                        class: 'w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500')
                end # end of age field

                div(class: 'mb-6') do
                  label('Fitzpatrick Skin Type', for: 'skin_type',
                                                 class: 'block text-base font-medium text-gray-700 mb-2')
                  select(id: 'skin_type', name: 'skin_type', required: true,
                         class: 'block w-full py-2 px-3 text-base font-medium text-gray-700 mb-2') do
                    # The classes are applied to the SELECT tag, as most browsers ignore them on OPTION tags.
                    option('Select your skin type:', value: '', disabled: true, selected: true)
                    option('Type I: Very Fair (always burns, does not tan)', value: '1')
                    option('Type II: Fair (burns easily, tans poorly)', value: '2')
                    option('Type III: Medium (sometimes burns, tans after initial burn)', value: '3')
                    option('Type IV: Olive (burns minimally, tans easily)', value: '4')
                    option('Type V: Brown (rarely burns, tans darkly easily)', value: '5')
                    option('Type VI: Very Dark (never burns, always tans darkly)', value: '6')
                  end
                end # end of skin type field

                p(class: 'text-base text-gray-700 mb-4') do
                  text "Based on your location and the current UV index, let's calculate the amount of time you need in the sun right now to get an optimal daily intake of vitamin D. This estimate assumes you're exposing your face, neck, arms, and legs (like in a T-shirt and shorts)."
                end # if I do not use {} directly with a string, and instead use do, then text, i need to close the text

                button(type: 'submit',
                       class: 'w-full py-3 px-4 bg-blue-600 hover:bg-blue-700 text-white font-bold rounded-lg shadow-md transition-colors duration-300') do
                  text 'Calculate Time Required in the Sun'
                end
              end
            end
          else # else we are on the POST request, so display the results
            p(class: 'text-lg font-semibold text-blue-700 mb-6') do
              text "To get 1,000 IU of Vitamin D, you'll need to be in the sun for:"
            end
            p(class: 'text-5xl font-extrabold text-blue-800 mb-6') do
              text "#{format('%.1f', @result_time).to_f} minutes"
            end
            # @d_time: This is an instance variable that holds the raw, calculated time in minutes from the post '/solarcalculator'
            # '%.1f' % @d_time: This is Ruby's string formatting operator. The %.1f is a format specifier that tells Ruby to take the number in @d_time and turn it into a string with exactly one decimal place.
            # .to_f: This is a method that converts the formatted string back into a floating-point number.
            # "#{...} minutes": This is a string interpolation. The #{} syntax takes the result of the inner expression (the formatted time) and inserts it directly into the string, resulting in a final output like "15.3 minutes".

            p(class: 'text-sm text-gray-500 mt-4') do
              text "Note: This is an estimate based on a UV index of #{@uv_index} and assumes at least 25% of your body is exposed. Remember to be cautious with sun exposure."
            end
          end # end of main if @result_time.nil?

          div(class: 'mt-8 p-6 bg-gray-100 rounded-lg text-left') do
            h3(class: 'text-xl font-bold text-gray-800 mb-2') { 'About the Calculation' }
            p(class: 'text-sm text-gray-700 mb-4') do
              text 'This model is based on research by Dr. Michael Holick, a leading expert on vitamin D. The app calculates the time needed to synthesize 1,000 IU, which is considered an optimal daily level by many health professionals.'
            end

            p(class: 'text-xs text-gray-500 mt-4') do
              text 'Primary research sources for this model include:'
              br
              text 'Holick, M. F. (2004). Vitamin D: A new look at the sunshine vitamin. Dermato-Endocrinology, 29(1), 209-218.'
              br
              text "Çakmak, T., Yıldız, R., Usta, G., & Yılmaz, A. E. (2021). Holick's Rule Implementation: Calculation of Produced Vitamin D from Sunlight Based on UV Index, Skin Type, and Area of Sunlight Exposure on the Body. International Journal of Energy Research, 45(13), 19576-19590."
            end
          end

          div(class: 'my-4 text-center') do
            a(href: '/sunbenefits', class: 'bg-white text-gray-700 text-base') do
              text 'Click here to learn more about the benefits of sun exposure'
            end
          end

          div(class: 'my-8 text-center') do
            a(href: '/projects',
              class: 'inline-block py-2 px-4 bg-blue-600 hover:bg-blue-700 text-white text-base font-bold rounded-lg shadow-md transition-colors duration-300') do
              text 'Return to Projects'
            end
          end

          div(class: 'my-8 text-center') do
            a(href: '/',
              class: 'inline-block py-2 px-4 bg-blue-600 hover:bg-blue-700 text-white text-base font-bold rounded-lg shadow-md transition-colors duration-300') do
              text 'Return to Homepage'
            end
          end
        end
      end
    end
  end
end
#---------------------------------------------

#---Solar D Calculator Get Route-------------
get '/solardcalculator' do
  ip = request.ip
  location_response = HTTParty.get("http://ip-api.com/json/#{ip}")
  # Make an API call to ip-api to get the location data.
  # No API key is required.

  if location_response.success? && JSON.parse(location_response.body)['status'] == 'success'
    location_data = JSON.parse(location_response.body)
    lat = location_data['lat']
    lng = location_data['lon']
  # Parse the JSON response from ip-api to get the latitude and longitude.
  else
    # Fallback to hardcoded Barabdos coordinates if IP-API fails, which it does when testing in localhost because localhost resolves to 127.0.0.1, based on which IP-API cannot determine a geographic location.
    lat = 13.1939
    lng = -59.5432
  end

  #---Debugging------------------------------
  puts "Latitude: #{lat}"
  puts "Longitude: #{lng}"
  #------------------------------------------

  openuv_response = HTTParty.get(
    "https://api.openuv.io/api/v1/uv?lat=#{lat}&lng=#{lng}",
    headers: { 'x-access-token' => OPENUV_API_KEY }
  )

  #---More debugging---------------------------
  puts "OpenUV API Response Status: #{openuv_response.code}"
  puts "OpenUV API Response Body: #{openuv_response.body}"
  #-------------------

  if openuv_response.success?
    # Adds error handling. Check if the OpenUV API call was successful before trying to parse the body.
    openuv_data = JSON.parse(openuv_response.body)
    uv_index = openuv_data ['result']['uv']
    # Parse the JSON response from OpenUV to get the UV index.

    #---Even more debugging---------------
    puts '===OPENUV DEBUG INFO==='
    puts "Full response: #{openuv_data.inspect}"
    puts "UV index value: #{uv_index}"
    puts "UV index class: #{uv_index.class}"
    puts "UV index <= 0? #{uv_index <= 0}"
    puts "Current time: #{Time.now}"

    SolarDCalculatorPage.new(uv_index: uv_index, result_time: nil).to_html
    # Render the page using the Erector widget and pass the calculated UV index to it.
    # We pass nil to `result_time` on the GET request so the form is displayed.
  else
    'Error: Could not retrieve UV data from OpenUV API. Please check your API key or try again later'
  end
end
#---------------------------------------------------

#---Solar D Calculator Post Route--------------------
post '/solardcalculator' do
  # This is the POST route that handles the calculation

  puts "POST params: #{params.inspect}"
  # Confirm the POST is being hit and parameters are passed correctly. Watch the console while the form is submitted.

  uv_index = params['uv_index']&.to_f
  age = params['age']&.to_i
  skin_type = params['skin_type']&.to_i
  # Here we get the variables from the form submission
  # #params: Sinatra automatically collects all the data submitted by a form and puts it into a hash named params.
  # &.to_f and &.to_i: These are used to safely call a method on an object. The &. operator checks if the object is nil before trying to call the method. If the object is nil, it just returns nil instead of causing an error.

  # Check if any of the required parameters are missing (nil).
  # If so, handle the error gracefully instead of crashing.
  redirect '/solardcalculator' if uv_index.nil? || age.nil? || skin_type.nil?

  #----Skin type multipliers and age factors--------------------

  # widely cited scientific model, often referenced in publications by Dr. Michael Holick, a leading vitamin D researcher, provides a practical rule of thumb. This model assumes that under optimal conditions (clear skies, midday sun, summer, 25% of the body exposed):

  # 10-15 minutes of sun exposure** on the arms and legs at a UV index of **7** can produce approximately **1,000 IU** of vitamin D.

  # **Type I (Very Fair):** Requires slightly less time, roughly **80%** of the baseline.
  # **Type II (Fair):** The baseline for the calculation, at **100%**.
  # **Type III (Medium):** Requires about **20-30% more** time.
  # **Type IV (Olive):** Requires about **50-70% more** time.
  # **Type V (Brown):** Requires **2-3 times more** time.
  # **Type VI (Very Dark):** Requires **5-10 times more** time.

  # Scientific studies have shown that the skin's capacity to produce vitamin D decreases with age. By the time a person is 70-80 years old, their skin's ability to produce vitamin D from sunlight is about **two to three times less** than that of a young adult.
  # **Ages 1-30:** No reduction factor.
  # **Ages 30-60:** A progressive reduction, perhaps a linear decrease to a factor of 0.75 by age 60.
  # **Ages 60+:** A continued, more pronounced reduction, to a factor of 0.50 or less by age 70 or 80.

  # Fitzpatrick Skin Type Multipliers
  skin_multipliers = {
    1 => 0.8,
    2 => 1.0,
    3 => 1.25,
    4 => 1.6,
    5 => 2.5,
    6 => 7.5
  }

  # Age-Related Scaling
  age_factor = 1.0
  if age >= 60
    # For ages 60+, reduction to a factor of 0.5 or less.
    # We use a linear decrease from 0.75 at age 60 to 0.5 at age 80
    age_factor = if age > 80
                   0.5
                 else
                   0.75 - ((age - 60) * (0.25 / 20.0))
                 end
  elsif age > 30
    # For ages 30-60, a progressive reduction to 0.75 by age 60
    age_factor = 1.0 - ((age - 30) * (0.25 / 30.0))
  end

  if uv_index.nil? || uv_index <= 0
    required_sun_time = nil
    # "If there’s no UV index, or if it’s nighttime (UV = 0), don’t try to calculate — just set required_sun_time = nil."

  else

    # Calculate the required sun exposure time in minutes
    # Formula: Time (minutes) = (10 minutes) * Fitzpatrick Multiplier) * (Age Factor) * (7/ Current UV Index)
    required_sun_time = 10.0 * skin_multipliers[skin_type] * age_factor * (7.0 / uv_index)
  end

  # Render the page with the calculation result
  SolarDCalculatorPage.new(uv_index: uv_index, result_time: required_sun_time).to_html
end
#----------------------------------

#---SunBenefitsPage--------------
# Sun Benefits erector Widget

class SunBenefitsPage < Erector::Widget
  def content
    rawtext '<!DOCTYPE html>'

    html do
      head do
        link(rel: 'preconnect', href: 'https://fonts.googleapis.com')
        link(rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: 'anonymous')
        title "Hey I'm Thomas!"
        link rel: 'stylesheet', href: 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css'
        link href: 'https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap', rel: 'stylesheet'

        # CSS code to add custom font
        style do
          rawtext <<-CSS
            html, body {
              font-family: 'Montserrat', sans-serif !important;
            }
          CSS
        end
      end

      body(class: 'bg-white text-black') do
        #---Nav bar---
        nav(class: 'bg-black text-white w-full px-6 py-4 flex justify-between items-center fixed top-0 left-0 right-0 shadow-md') do
          # Left Side
          div do
            a(href: '/', class: 'text-lg hover:text-gray-300 transition-colors') do
              text 'Home'
            end
          end

          # Right Side
          div(class: 'space-x-6') do
            a(href: '/about', class: 'text-lg hover:text-gray-300 transition-colors') { text 'About Me' }
            a(href: '/projects', class: 'text-lg hover:text-gray-300 transition-colors') { text 'Projects' }
          end
        end
        #----------------

        #---Main content----

        div(class: 'max-w-2xl p-6 flex flex-col items-start ml-20') do
          h1(class: 'text-5xl font-bold mt-20 mb-10') do # h1 only needs a bottom margin to space itself from the paragraphs below.
            text 'The Benefits of Sun Exposure'
          end
          h2(class: 'text-2xl font-bold my-8') do
            text "Research indicates that vitamin D derived from sunlight exposure surpasses oral supplementation in efficacy due to distinct physiological mechanisms. Here's a clear, concise explanation:"
          end
          p(class: 'text-base mb-4') do
            text ''
          end
          p(class: 'text-base mb-4') do
            text ''
          end
        end
      end
    end
  end
end

#---SolarInfo Get Route--------
get '/sunbenefits' do
  SunBenefitsPage.new.to_html
end
