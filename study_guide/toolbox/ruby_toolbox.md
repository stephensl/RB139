# Lesson 3.1: Ruby Toolbox 

---

This lesson explores common tools in the Ruby Toolbox including: 
  - Rubygems
  - RVM and Rbenv
  - Bundler 
  - Rake 

We will learn about common tools, and how to use them to build a professional quality, ready for distribution, Ruby project. 

---
---
# Book: Core Ruby Tools 
---
---
## Gems 

Packages of code that you can download, install, and use in Ruby programs or from the command line. 

Common gems include: 
  - `rubocop`
  - `pry`
  - `sequel` : supplies set of classes and methods that simplify database access
  - `rails`  : web app framework 

### Gems, Ruby and Your Computer 
---

The Remote Library 
- When you find a gem to install, the `gem` command connects to the remote library, downloads the appropriate gem, and installs it. 
- If you specify additional remote libraries, `gem` also connects to those libraries to find the Gems you want. 

---

The Local Library 
- When `gem` installs a Gem, it places the files that comprise the Gem on your local file system in a location where Ruby and your system can find the files and commands it needs.
- This is the local library. 
- Precisely where `gem` creates the local library depends on several factors.
  - if Ruby needs root access 
  - a user maintainable ruby 
  - specific Ruby version
  - if use RVM 

---

Gem and Your File System 
- Run `gem env` (sample output below)
```ruby 
RubyGems Environment:
  - RUBYGEMS VERSION: 2.4.8
  - RUBY VERSION: 2.2.2 (2015-12-16 patchlevel 230) [x86_64-linux]
  - INSTALLATION DIRECTORY: /usr/local/rvm/gems/ruby-2.2.2
  - RUBY EXECUTABLE: /usr/local/rvm/rubies/ruby-2.2.2/bin/ruby
  - EXECUTABLE DIRECTORY: /usr/local/rvm/gems/ruby-2.2.2/bin
    ...
  - REMOTE SOURCES:
     - https://rubygems.org/
  - SHELL PATH:
     - /home/ubuntu/.nvm/versions/node/v4.5.0/bin
     - /usr/local/rvm/gems/ruby-2.2.2/bin
     - /usr/local/rvm/gems/ruby-2.2.2@global/bin
     ...
```
- RUBY EXECUTABLE

This is the location of the ruby command that you should use with the Gems managed by this gem command. This information is often useful when RUBY VERSION reveals a gem/ruby mismatch.

- NSTALLATION DIRECTORY

This directory is where gem installs Gems by default. Note that the location varies based on the Ruby version number (2.2.2 here). (Under rbenv, you may see two different versions in this name: the first is the major version, the second is the actual version. You can usually ignore the major version.)

Let's look at this structure visually. Note that the following shows the directory structure under RVM; the structure will be different but similar with rbenv or a system ruby. The below diagram shows a RVM-managed Ruby version 2.2.2, with the bundler, freewill, pry, and rubocop gems installed.
```ruby 
$ tree /usr/local/rvm      # the following is partial output
/usr/local/rvm
├── gems
│   └── ruby-2.2.2        # This is the INSTALLATION DIRECTORY for Gems
│       ├── bin
│       │   ├── bundle
│       │   └── rubocop
│       └── gems
│           ├── bundler-1.12.5
│           ├── freewill-1.0.0
│           │   └── lib
│           │       └── freewill.rb
│           ├── pry-0.10.4
│           └── rubocop-0.43.1
└── rubies
    └── ruby-2.2.2
        └── bin
            ├── gem
            ├── irb
            └── ruby
```
This structure shows Ruby 2.2.2 and some associated Gems installed under RVM. In particular, note the locations of the gems directory in this structure. All Gems for Ruby 2.2.2 are installed here. The files are in subdirectories named with the name and version number of the installed Gems. For instance, pry version 0.10.4 is in INSTALLATION DIRECTORY/gems/pry-0.10.4.

Inside each Gem-specific directory, you will find additional subdirectories and files. For example, we show a bit of detail for the freewill 1.0.0 Gem in Figure 1. The lib subdirectory is the most important: this is where your Ruby finds the require files for the Gem. For instance, when you write require 'freewill' in a program, Ruby loads freewill.rb from this lib subdirectory. Note that the Gems are installed within a specific Ruby version; in this way, it's possible to install the same Gem for multiple Rubies because they are installed under the Ruby version-specific directory.

- USER INSTALLATION DIRECTORY

Depending on your installation of Ruby and the options you pass to gem, gem may install Gems somewhere in your home directory instead of a system-level directory. This is the location in your home directory that gem uses in such cases.

The structure of the USER INSTALLATION DIRECTORY is the same as the INSTALLATION DIRECTORY.

- EXECUTABLE INSTALLATION DIRECTORY

Some Gems provide commands that you can use directly from a terminal prompt; gem places those commands in this directory. In Figure 1, we show the bundler and rubocop executables for Ruby 2.2.2 in the bin subdirectory.

Note that you need to include this directory in your shell PATH variable so that the shell can find these commands. Your Ruby version manager (rbenv or RVM) usually handles this, but it's useful to know where to look if you have problems. (See also SHELL PATH below.)

- REMOTE SOURCES

This is the remote library used by this gem installation.

SHELL PATH

The value of your shell's PATH variable; this variable tells your shell which directories it should search to find executable program files. If you have problems with command not found messages or running the wrong versions of programs, this listing may provide valuable clues about where the system looks for your programs.

Note in particular that the list of directories includes /usr/local/rvm/rubies/ruby-2.2.2/bin. We can see from Figure 1 that this directory contains the ruby, irb, and gem commands (it contains other commands as well).

---
---
---

## Which file was required?

While Ruby, Gem, and the Ruby version managers, rbenv and RVM, do a good job of organizing things, you may sometimes run into strange problems that can only happen when you're using the wrong Gem in a program.

To determine the Gem version, you need to know the full path name of the file that your program loaded. The easiest way to do this is to insert some debugging code (or a call to binding.pry) in your program shortly after the point where you require the Gem:

`puts $LOADED_FEATURES.grep(/freewill\.rb/)`

` # => /usr/local/rvm/gems/ruby-2.2.2/gems/freewill-1.0.0/lib/freewill.rb` 

- That command searches for any entries in the $LOADED_FEATURES Array that include freewill.rb in the name, and prints all matching entries.

- The resulting name is the path of the file that your program required; by looking at that name, you can see that your program loaded the file from freewill-1.0.0. This tells you that your program loaded version 1.0.0 of the Gem, not version 1.1.1 as needed.

## Multiple Gem Versions

In the previous section, we described an issue where we loaded the wrong version of a Gem. One possible solution to the problem was to install the correct version of the Gem. However, this introduces another opportunity for version-related problems with Gems.

Suppose our system now looks like this:

```ruby 
$ tree /usr/local/rvm      # the following is partial output
/usr/local/rvm
└── gems
    └── ruby-2.2.2        # This is the INSTALLATION DIRECTORY for Gems
        ├── bin
        │   ├── bundle
        │   └── rubocop
        └── gems
            ├── bundler-1.12.5
            ├── freewill-1.0.0
            │   └── lib
            │       └── freewill.rb
            ├── freewill-1.1.1
            │   └── lib
            │       └── freewill.rb
            ├── pry-0.10.4
            └── rubocop-0.43.1
```
- We now have two versions of freewill installed. Let's say that version 1.1.1 is not fully compatible with the older 1.0.0 version. Suppose further that we have another Ruby program that requires the version 1.0.0 of freewill. What happens when this program tries to `require 'freewill'`?

- In this situation, Ruby loads the installed version of the Gem with the most recent version number, namely version 1.1.1. This means trouble for our hypothetical program that needs the older version. This can be addressed in several ways:

    - Provide an absolute path name to `require`.
    - Add an appropriate `-I` option to the Ruby invocation.
    - Modify `$LOAD_PATH` prior to requiring `somegem`.
    - Modify the `RUBYLIB` environment variable.

These fixes are all hacks though; they will quickly become unmanageable and an enormous mess and source of bugs. You definitely do not want to go down this road except in the extremely short-term. The right choice is to use Bundler, which we'll discuss later. 

---
---
---

## Ruby Version Manager 
---

### What are Ruby Version Managers?

- Ruby version managers let you install, manage, and use multiple versions of Ruby. 
- Software applications tend to standardize on a specific Ruby version in order to guarantee developers don't use unsupported language features. 
  - For example, you may be asked to help out with an existing project that has standardized on Ruby version 2.1, but your current local Ruby version is 2.3, which you need to work on your current projects. In that case, you will need the assistance of a Ruby version manager to help you manage and move between different Rubies as you switch between different projects.

### Which Ruby Version Manager should I use?
- There are two major versions, RVM and rbenv 

## RVM 
This example hows a typical installation of two different Ruby versions under RVM. This output assumes that rvm stores its files in /usr/local/rvm; depending on your system and installation, the directory may be elsewhere. For instance, a common location is ~/.rvm (~/ means your home directory).

```ruby 
$ tree /usr/local/rvm        # the following is partial output
/usr/local/rvm               # RVM path directory
├── gems
│   ├── ruby-2.2.2
│   │   ├── bin
│   │   │   ├── bundle
│   │   │   └── rubocop
│   │   └── gems
│   │       ├── bundler-1.12.5
│   │       ├── freewill-1.0.0
│   │       │   └── lib
│   │       │       └── freewill.rb
│   │       ├── pry-0.10.4
│   │       └── rubocop-0.43.1
│   └── ruby-2.3.1
│       ├── bin
│       │   ├── bundle
│       │   └── rubocop
│       └── gems
│           ├── bundler-1.12.5
│           ├── freewill-1.0.0
│           │   └── lib
│           │       └── freewill.rb
│           ├── pry-0.10.4
│           └── rubocop-0.45.0
└── rubies
    ├── ruby-2.2.2
    │   └── bin
    │       ├── gem
    │       ├── irb
    │       └── ruby
    └── ruby-2.3.1
        └── bin
            ├── gem
            ├── irb
            └── ruby
```

How RVM works: 
- RVM core is a set of directories that stores all you Ruby versions, its associated tools ( such as `gem` and `irb`), and its Gems.
- Each directory is specific to a given Ruby version. 
- RVM defines a shell function (see your shell's documentation for information on functions) named rvm. Your shell uses this function in preference to executing the disk-based rvm command. There are complex reasons behind using shell functions, but the main reason is that a function can modify your environment, while a disk-based command cannot.
- When you run `rvm use VERSION` to change the Ruby version you want to use, you actually invoke the `rvm` function. It modifies your environment so that the various ruby commands invoke the correct version. For instance, `rvm use 2.2.2` modifies your `PATH` variable so that the ruby command uses the Ruby installed in the `ruby-2.2.2` directory. It makes other changes as well, but the `PATH` change is the most noticeable.

Problems:
- the most likely issue with RVM is that you get confused about which version of Ruby you are running, or you install or update Gems with the wrong gem command. When trying to diagnose an RVM problem, first make sure that you are using the correct Ruby version -- such problems are easier to see -- then check for Gem versioning issues.


## rbenv

- typical installation of two different Ruby versions under rbenv.
```ruby 
$ tree /usr/local/rbenv # the following is partial output
/usr/local/rbenv # rbenv root directory
├── shims
│   ├── bundle
│   ├── irb
│   ├── rubocop
│   └── ruby
└── versions
    ├── 2.2.2
    │   ├── bin
    │   │   ├── bundle
    │   │   ├── irb
    │   │   ├── rubocop
    │   │   └── ruby
    │   └── lib
    │       └── ruby
    │           └── gems
    │               └── 2.2.0
    │                   └── gems
    │                       ├── bundler-1.12.5
    │                       ├── freewill-1.0.0
    │                       │   └── lib
    │                       │       └── freewill.rb
    │                       ├── pry-0.10.4
    │                       └── rubocop-0.43.1
    └── 2.3.1
        ├── bin
        │   ├── bundle
        │   ├── irb
        │   ├── rubocop
        │   └── ruby
        └── lib
            └── ruby
                └── gems
                    └── 2.2.0
                        └── gems
                            ├── bundler-1.12.5
                            ├── freewill-1.0.0
                            │   └── lib
                            │       └── freewill.rb
                            ├── pry-0.10.4
                            └── rubocop-0.45.0
```
### How `rbenv` works 
- At rbenv's heart is a set of directories very similar to the directories at RVM's core. It stores and uses the rubies, associated tools, and Gems from these directories. There are subdirectories for each version of Ruby located in the versions directory. If you need Ruby 2.3.1, rbenv uses the files in the 2.3.1 directory; if you need Ruby 2.2.2 it gets the files from the 2.2.2 directory. Note that the Gem version numbers can differ: in this case, Ruby 2.2.2 uses Rubocop 0.43.1, while Ruby 2.3.1 uses Rubocop 0.45.0.
- rbenv uses a set of small scripts called shims.
- The scripts have the same names as the various ruby and Gem programs. They live in the shims sub-directory of the main rbenv installation directory. Valid rbenv installations include the shims directory in the PATH; rbenv places it before any other directories that contain ruby or any related programs; this ensures that the system searches the shims directory first. This way, when you run one of the ruby commands or Gems, the system executes the proper shim script. The shim script, in turn, executes rbenv exec PROGRAM; this command determines what version of Ruby it should use, and executes the appropriate program from the Ruby version-specific directories, e.g., /usr/local/rbenv/versions/2.3.1/bin.

That all sounds pretty complex, and it is. However, in practice, it's mostly invisible. If you want to run, say, rubocop from the Ruby 2.2.2 directory, you tell rbenv to use Ruby 2.2.2, then run the rubocop command. Magically, the system finds the rubocop shim, the shim runs rbenv exec rubocop, and that runs the Ruby 2.2.2 version of rubocop.

---
---

### Setting Local Rubies 
- To set default version 
  `rbenv global 2.3.1` 
- To set project/directory specific version 
  - cd (path to directory) 
  - `rbenv local 2.0.0` 

This creates a .ruby-version file in the specified directory; when you run any Ruby-based programs stored in this directory, rbenv checks the .ruby-version file, and uses that version of Ruby for the program. If there is no .ruby-version file, rbenv launches a search for an alternative .ruby-version file, and, if it still can't find one, it uses the global version of Ruby.
  - Note that this `.ruby-version` file is identical to the `.ruby-version` file used by RVM: same name, same content, same function, and the same search sequence.

### Where are my Rubies, Gems, and Apps now?
- Rbenv creates a directory at installation known as the rbenv root directory; it also installs all rbenv related files, including all the Rubies and Gems that it manages, in this directory. To determine the location of the rbenv root directory, run: `rbenv root` 

- there are two important subdirectories in the root directory: the shims directory, and the versions directory. The shims directory contains all the shims used by rbenv, while versions contains all the different Rubies. Inside the versions directory, you will find one directory for each Ruby version you have installed; inside each of these directories, you will find the specific version of Ruby, all its companion programs, and your Gems for that version.

### Problems
Compared to RVM, rbenv uses a conservative approach to perform its tasks: it doesn't rely on making dynamic changes to your environment or system commands. Instead, it makes a small, one-time change to your PATH, and leaves your system to run exactly as designed. 

Useful troubleshooting commands: 
  - `rbenv version` 
    - Displays the currently active version of Ruby, along with a short explanation of how rbenv determined the version. If you see the wrong version displayed and don't understand why, see the documentation. The section on "Choosing the Ruby Version" is particularly important.

  - `echo $PATH`
    - Confirm that your shims directory is in your PATH. Specifically, verify that it occurs early in your path. If, for example, /usr/bin occurs before /usr/local/rbenv/shims in your PATH, your system may load the system version of Ruby instead of one managed by rbenv.

  - `rbenv which COMMAND`
    - Displays the disk location of the command named by COMMAND (e.g., ruby, irb, rubocop)

  - `rbenv rehash`
    - Rebuilds the shims directory. If you can't execute some commands or rbenv doesn't appear to be running the correct commands, try this command.

  - `rbenv root`
    - Display the path of the rbenv root directory.

  - `rbenv shims`
    - Display a list of all current shims.

  - `gem env`
    - Display configuration information about your RubyGems system.

---
---
---

## Bundler 
Dealing with dependencies -- multiple versions of Ruby and multiple versions of Gems -- is a significant issue in Ruby. A project may need a Ruby version that differs from your default Ruby. Even if it requires the same version of Ruby, it may need a different version of a RubyGem.

- This problem is not unique to Ruby; dependency issues arise in all languages. The techniques used to deal with the dilemma differ with each language. In Ruby, most developers use a Ruby version manager such as RVM or rbenv to manage multiple Ruby versions. You can also use your version manager to manage Gem dependencies, but the favored approach is to use a ***dependency manager***.
  - The most widely used dependency manager in the Ruby community, by far, is the Bundler Gem.
  - This Gem lets you configure which Ruby and which Gems each of your projects need. 

### Gemfile and Gemfile.lock 
Bundler relies on a text file named Gemfile to tell it which version of Ruby and its Gems it should use. This file is a simple Ruby program that uses a Domain Specific Language (DSL) to provide details about the Ruby and Gem versions. It's the configuration or instruction file for Bundler.

### Were are my Rubies, Gems, and Apps now?
Bundler does not interfere with your Rubies nor their Gems. They remain where they were before you installed Bundler, and will continue to use the same setup in the future. This means that you can still use gem env, rvm info, and rbenv version and other informational commands to find information you may need.

### bundle exec
Any Gem command that requires other Gems may load a Gem that conflicts with your app's requirements. bundle exec is the easiest way to fix this issue.

### Problems 
```ruby 
Gem::LoadError: You have already activated ...
```
  - This error merely tells you that you need to use bundle exec to run the command.

```ruby 
in `require': cannot load such file -- colorize (LoadError)
```
  - This message means that bundler/setup can't find the named Gem (colorize here). However, you've confirmed that the Gem is installed, has the proper permissions, and you're using the proper version of Ruby and the gem command. The problem here is that the Gemfile.lock file doesn't list the colorize Gem; bundler/setup insists that your Gemfile.lock contains all needed Gems. To add this Gem to yours, add it to your Gemfile, then run bundle install again to generate a new Gemfile.lock file.

---
---

## Summary 
Bundler lets you describe exactly which Ruby and Gems you want to use with your Ruby apps. Specifically, it lets you install multiple versions of each Gem under a specific version of Ruby and then use the proper version in your app.

Bundler is a RubyGem, so you must install it like a normal Gem: gem install bundler.

To use Bundler, you provide a file named Gemfile that describes the Ruby and Gem versions you want for your app. You use a DSL described on the Bundler website to provide this information.

Bundler uses the Gemfile to generate a Gemfile.lock file via the bundle install command. Gemfile.lock describes the actual versions of each Gem that your app needs, including any Gems that the Gems listed in Gemfile depend on. The bundler/setup package tells your Ruby program to use Gemfile.lock to determine which Gem versions it should load.

The bundle exec command ensures that executable programs installed by Gems don't interfere with your app's requirements. For instance, if your app needs a specific version of rake but the default version of rake differs, bundle exec ensures that you can still run the specific rake version compatible with your app.

In the next chapter, we'll take a look at Rake, Ruby's answer to the long time Unix development tool, Make. Rake lets you automate a lot of tasks common to many Ruby development projects.

---
---
---

## Rake 
Rake is a Rubygem that automates many common functions required to build, test, package, and install programs; it is part of every modern Ruby installation, so you don't need to install it yourself.

Here are some common Rake tasks that you may encounter:

  - Set up required environment by creating directories and files
  - Set up and initialize databases
  - Run tests
  - Package your application and all of its files for distribution
  - Install the application
  - Perform common Git tasks
  - Rebuild certain files and directories (assets) based on changes to other files and directories

In short, you can write Rake tasks to automate anything you may want to do with your application during the development, testing, and release cycles.

---
## How to use: 

Rake uses a file named Rakefile that lives in your project directory; this file describes the tasks that Rake can perform for your project, and how to perform those tasks. For instance, here is a very simple Rakefile:

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
This Rakefile contains three tasks: two that simply display a single message, and one task that has the other tasks as prerequisites or dependencies. The first two tasks are named :hello and :bye, while the final task is the default task; Rake runs the default task if you do not provide a specific task name when you invoke Rake.

Each of the above tasks calls two Rake methods: desc and task. The desc method provides a short description that Rake displays when you run rake -T (see below), and the task method associates a name with either a block of Ruby code (lines 2-4 and 7-9) or a list of dependencies (line 12). Here, the :default task depends on the :hello and :bye tasks: when you run the :default task, Rake will run the :hello and :bye tasks first.

Let's see this in action. The first thing you should do with any Rakefile is find out what tasks it can run. You do this with the `rake -T` command:

```ruby 
$ bundle exec rake -T
rake bye      # Say goodbye
rake default  # Do everything
rake hello    # Say hello
```

One very important thing to notice is that Rakefile is actually a Ruby program. You can put any Ruby code you want in a Rakefile and run it as part of a task. Commands like desc and task are just method calls to parts of Rake; these method calls comprise a Domain Specific Language (DSL) for writing automated Rake tasks.

Once you know what Rake tasks you can run, you just have to run them:
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

---
---

## Why Rake needed?

One reason why you need Rake is that nearly every Ruby project you can find has a Rakefile, and the presence of that file means you need to use Rake if you want to work on that project. However, just because everybody does something doesn't mean you need to use it too. If you start a brand-new project, you can always say "I don't feel like using Rake, so I won't."

While you can always opt-out of using Rake in your projects, there is little point to doing so. Every project that aims to produce a finished project that either you or other people intend to use in the future has repetitive tasks the developer needs. For instance, to release a new version of an existing program, you may want to:

  - Run all tests associated with the program.
  - Increment the version number.
  - Create your release notes.
  - Make a complete backup of your local repo.

Each step is easy enough to do manually, but you want to make sure you execute them in the proper order (for instance, you want to set the new version number before you commit your changes). You also don't want to be at the mercy of arbitrary typos that may do the wrong thing. It's far better to have a way to perform these tasks automatically with just one command, which is where Rake becomes extremely useful.

Your Rakefile likely has each of these as a separate task, as well as a single overall task (call it release, for instance) that steps through the tasks one at a time. The release task would stop only when it completes all the tasks or one task fails.

## Relationships

One thing to keep in mind as you become more comfortable with the Ruby tools is how they relate to each other.

Your Ruby Version Manager is at the top level -- it controls multiple installations of Ruby and all the other tools.

Within each installation of Ruby, you can have multiple Gems -- even 1000s of Gems if you want. Each Gem becomes accessible to the Ruby version under which it is installed. If you want to run a Gem in multiple versions of Ruby, you need to install it in all of the versions you want to use it with.

Each Gem in a Ruby installation can itself have multiple versions. This frequently occurs naturally as you install updated Gems, but can also be a requirement; sometimes you just need a specific version of a Gem for one project, but want to use another version for your other projects.

Ruby projects are programs and libraries that make use of Ruby as the primary development language. Each Ruby project is typically designed to use a specific version (or versions) of Ruby, and may also use a variety of different Gems.

The Bundler program is itself a Gem that is used to manage the Gem dependencies of your projects. That is, it determines and controls the Ruby version and Gems that your project uses, and attempts to ensure that the proper items are installed and used when you run the program.

Finally, Rake is another Gem. It isn't tied to any one Ruby project, but is, instead, a tool that you use to perform repetitive development tasks, such as running tests, building databases, packaging and releasing the software, etc. The tasks that Rake performs are varied, and frequently change from one project to another; you use the Rakefile file to control which tasks your project needs.

---
---
---
---
