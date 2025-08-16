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

Now create a directory for this repository and clone it. To do so, navigate to the directory in your terminal:

```bash
cd ~/your_parent_directory
```

Replacing "your_parent_directory" with whatever parent directory you have chose for the directory you want to clone this repository into.

Once your are in your chosen parent directory, run the following command:

```bash
git clone git@github.com:thomasridgeon/myrubyapps.git
```

You should now see the following files in your directory:
* Gemfile
* Gemfile.lock
* config.ru
* myrubyapps.rb
* README.md

Finally, in your terminal, navigate to your directory which you just cloned this repository into and run the following command:

```bash
bundle install
```

This will download and set up all the required libraries from the Gemfile.

Now you're ready to run the app in localhost. To do so, run the following command:
```bash
bundle exec puma
```

You can now open your browser and go to http://0.0.0.0:9292 

To navigate to the Port Charges Calculator, use the path http://0.0.0.0:9292/portcharges



