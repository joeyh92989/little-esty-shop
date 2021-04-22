![Logo of the project](https://raw.githubusercontent.com/jehna/readme-best-practices/master/sample-logo.png)

# Little Esty Shop
> Additional information or tagline

This repo is an interactive online imitation e-commerce website that manages inventory and handles customer invoices.

## Installing / Getting started

In order to run this repo properly please use Ruby 2.5.3. Also, please be sure to do the following.
   - Fork this repo
   - Clone down your fork
   - In your terminal run the following on the command line

```shell
bundle
bundle update
rails db:create
bundle exec rspec
rails s
```

The code above installs all gems in the Gemfile and updates the Gemfile.lock. Also, it will create your database, run existing tests, and start your local server.

### Initial Configuration

Some projects require initial configuration (e.g. access tokens or keys, `npm i`).
This is the section where you would document those requirements.
* To use this app fully an API token is required to be installed and loaded, this token is not hardcoded into the application and masked. Therefore a distinct token will need to exist to make use of that functionality

## Developing

Here's a brief intro about what a developer must do in order to start developing
the project further:

```shell
git clone https://github.com/joeyh92989/little-esty-shop
cd little-esty-shop
atom . 
```

You will want to clone down the repository to your computer locally using git. Then cd into the repo. Last, open the repo in your test editor(atom is what's shown above).

### Building

If your project needs some additional steps for the developer to build the
project after some code changes, state them here:

```shell
./configure
make
make install
```

Here again you should state what actually happens when the code above gets
executed.

### Deploying / Publishing

In case there's some step you have to take that publishes this project to a
server, this is the right time to state it.

```shell
packagemanager deploy awesome-project -s server.com -u username -p password
```

And again you'd need to tell what the previous code actually does.

## Features

What's all the bells and whistles this project can perform?
* Have an interactive dashboard for your Merchant/Admin, to display details about the merchants,invoices,items, etc
* Seemless links and buttons to traverse the website and edit/update information
* If you get really randy, you can even see you top customers and items you sell AND all from one place.

