# My Ruby Apps

This is a repository for the ruby apps I create while learning to program.

---

## Apps

**Port Charges Calculator**
This is a simple web app for customs brokers in Barbados to calculate Barbados Port Charges.

---

## How to run the code

If you want to try out the apps:

First, you will need to install ruby. You can do so by following [this guide](https://www.theodinproject.com/lessons/ruby-installing-ruby) by The Odin Project.

Next, you'll need to install sinatra and sinatra-reloader by running the following commands in your terminal:

```bash
gem install sinatra
```

```bash
gem install sinatra-reloader
```

Now create a parent directory for this repository to be cloned into. To do so, navigate to the parent directory in your terminal:

```bash
cd ~/your_parent_directory
```

Replacing "your_parent_directory" with whatever parent directory you have chose for this repository's directory.

Once you have navigated to your parent directory, run the following command:

```bash
git clone git@github.com:thomasridgeon/myrubyapps.git
```

You should now see this repository's directory within your parent directory, with the following files inside of it:
* Gemfile
* Gemfile.lock
* config.ru
* myrubyapps.rb
* README.md

Finally, in your terminal, navigate to the repository directory and run the following command:

```bash
bundle install
```

This will download and set up all the required libraries from the Gemfile.

Now you're ready to run the app in localhost. To do so, run the following command:

```bash
bundle exec puma
```

You can now open your browser and go to the link provided in your terminal, such as http://0.0.0.0:9292 

To navigate to the Port Charges Calculator, use the /portcharges path http://0.0.0.0:9292/portcharges



