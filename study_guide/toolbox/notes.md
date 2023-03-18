# Version managers

  - rbenv
  - RVM 


# Ruby installation 

  - Core library
  - Standard library
  - `irb` REPL (Read Evaluate Print Loop)
  - `rake` utility: automates Ruby development tasks
  - `gem` command: manages ruby gems
  - Documentation tools (`rdoc` and `ri`)


# Gems

  Packages of code that you can download, install, and in Ruby programs or from command line.

  Common gems:
    - `rubocop`
    - `pry`
    - `sequel`- provides classes and methods that simplify database access
    - `rails` - web app framework

  ## Gems and File System

    - Installed to local library 


  ## If need different version of gem

  - Provide an absolute path name to `require`.
  - Add an appropriate `-I` option to the Ruby invocation.
  - Modify $LOAD_PATH prior to requiring `somegem`.
  - Modify the `RUBYLIB` environment variable.


# Version Managers 

  Ruby version managers let you manage multiple versions of Ruby, the utilities (such as irb) associated with each version, and the RubyGems installed for each Ruby. 
  
  With version managers, you can install and uninstall ruby versions and gems, and run specific versions of ruby with specific programs and environments.

  - `RVM` 


  - `rbenv` 
    - Differs in way rubies are managed
      - Uses small scripts called *shims* 
    - Does not make dynamic changes to environment or system commands. 
      - Instead makes one small change to `PATH` 
        - Preferred to RVM due to fewer moving parts 


# Bundler 

**Dependency manager**
  - Allows configuration of which Ruby and which Gems the project needs. 

  - Bundler lets you describe exactly which Ruby and Gems you want to use with your Ruby apps. Specifically, it lets you install multiple versions of each Gem under a specific version of Ruby and then use the proper version in your app.

# Gemfile - The configuration or instruction file for Bundler

Bundler relies on a text file named `Gemfile` to tell it which version of Ruby and Gems it should use. 

  - Gemfile is a simple Ruby program that uses DSL to provide details about the Ruby and Gem versions. 

# Gemfile.lock

  - After creating a `Gemfile` the `bundle install` command scans it, and downloads/installs all dependencies listed, and produces a `Gemfile.lock` file. 

  - `Gemfile.lock` shows all dependencies for the program including the Gems listed in the `Gemfile` as well as the Gems they depend on, which may not be explicitly listed in teh `Gemfile`. 
    - RubyGems often rely on other gems, creating a large dependency tree.


# Using `Gemfile` 

```ruby 
source 'https://rubygems.org'

ruby '2.3.1'
gem 'sinatra'
gem 'erubis'
gem 'rack'
gem 'rake'
```

Then running `bundle install` creates `Gemfile.lock` 

```ruby 
GEM
  remote: https://RubyGems.org/
  specs:
    erubis (2.7.0)
    rack (1.6.4)
    rack-protection (1.5.3)
      rack
    rake (10.4.2)
    sinatra (1.4.7)     # lists dependencies below
      rack (~> 1.5)
      rack-protection (~> 1.4)
      tilt (>= 1.3, < 3)
    tilt (2.0.5)

PLATFORMS
  ruby

DEPENDENCIES
  erubis
  rack
  rake
  sinatra

RUBY VERSION
   ruby 2.3.1p112

BUNDLED WITH
   1.13.6
```

After `Gemfile.lock created, add to top of file:

`require 'bundler/setup` 


## `bundle exec` 

The bundle exec command ensures that executable programs installed by Gems don't interfere with your app's requirements. For instance, if your app needs a specific version of rake but the default version of rake differs, bundle exec ensures that you can still run the specific rake version compatible with your app.

When to use?

  - We use it to resolve dependency conflicts when issuing shell commands.

  Common error message: 

  `Gem::LoadError: You have already activated rake 11.3.0, but your Gemfile requires rake 10.4.2. Prepending bundle exec to your command may solve this.`

  `bundle exec rake` solves the problem.


# Other errors 

`in require: cannot load such file -- colorize (LoadError)`

  - This message means that bundler/setup can't find the named Gem (colorize here). However, you've confirmed that the Gem is installed, has the proper permissions, and you're using the proper version of Ruby and the gem command. The problem here is that the Gemfile.lock file doesn't list the colorize Gem; bundler/setup insists that your Gemfile.lock contains all needed Gems. To add this Gem to yours, add it to your Gemfile, then run bundle install again to generate a new Gemfile.lock file.


## Here are some more things to try if problems continue:

Remove your Gemfile.lock and run bundle install again. This creates a new Gemfile.lock file.

Remove the .bundle directory and its contents from your project directory and run bundle install again.

If you're using the binstubs feature, remove the directory used by binstubs and run bundle install --binstubs again. Don't do this if you aren't using binstubs.

Remove and reinstall Bundler

If gem list shows that either rubygems-bundler or open_gem are installed, uninstall them. These old Gems are incompatible with Bundler. Repeat the above items if you remove either Gem.

Issue this command in the command line from your app's top-level directory:

`$ rm Gemfile.lock ; DEBUG_RESOLVER=1 bundle install` 
  
  - This command removes the `Gemfile.lock` then runs `bundle install` while producing debug information. 


# Rake

- Automates common functions required to build, test, package, and install programs. 

- Utilizes `Rakefile` that lives in project directory and lists the tasks that `rake` can perform for your project, and how to do so. 

Example `Rakefile` 

```ruby 
desc 'Say hello'
task :hello do
  puts "Hello there. This is the `hello` task."
end

desc 'Say goodbye'
task :bye do
  puts 'Bye now!'
end

desc 'Do everything'
task :default => [:hello, :bye]
```

- `Rake` runs the default task if you do not provide a specific task name to `rake` invocation. 

## Two rake methods
  - `desc` : provides short description, displayed with `rake -T` 
  - `task` : associates a name with either a block of Ruby code, or a list of dependencies. 

```ruby 
$ bundle exec rake -T
rake bye      # Say goodbye
rake default  # Do everything
rake hello    # Say hello
```
  - This shows that there are three tasks defined by the `Rakefile`: `bye`, `default`, and `hello`. The output shows a short description of each task on the right: this information comes from the `desc` method calls in `Rakefile`

## `Rakefile` is a Ruby program

  - You can put any Ruby code you want in a `Rakefile` and run it as part of a task. 

## Running tasks

```ruby 
$ bundle exec rake bye
Bye now!

$ bundle exec rake hello
Hello there. This is the `hello` task.

$ bundle exec rake default
Hello there. This is the `hello` task.
Bye now!

$ bundle exec rake                     # we don't need to specify 'default'
Hello there. This is the `hello` task.
Bye now!
```

# Relationship Summary 

Top Level:
  - Ruby version manager 
    - Each installation of Ruby can have multiple Gems. 
      - Each Gem may have multiple versions. 

The Bundler program is itself a Gem that is used to manage the Gem dependencies of your projects. That is, it determines and controls the Ruby version and Gems that your project uses, and attempts to ensure that the proper items are installed and used when you run the program.

Finally, Rake is another Gem. It isn't tied to any one Ruby project, but is, instead, a tool that you use to perform repetitive development tasks, such as running tests, building databases, packaging and releasing the software, etc. The tasks that Rake performs are varied, and frequently change from one project to another; you use the Rakefile file to control which tasks your project needs.


