---
layout   : page
title    : Mac OS X
permalink: installation/mac/
published: true
tags     :
---

> ##### **Remark** *:point_up:*{:.pull-left .m-r}
> ---
> This installation guide is meant for *&nbsp;*{:.fa .fa-apple}**Mac OS X *El Capitan***, but will most probably apply to other versions too.
{:.alert .alert-info}

Prerequisites
-------------

### Apple Developer Tools

These tools are required to build some CLI applications later on.

#### Xcode

Download and install:

[*&nbsp;*{:.fa .fa-apple}Xcode][xcode]{:.btn .btn-{{ site.colour }}}

Then, open Xcode and accept the **Xcode License Agreement**. 

#### Xcode Command Line Tools

Open **Terminal** and start the installation. Choose **Install**.

{% highlight bash %}
$ xcode-select --install
{% endhighlight %}

Installation
------------

### Clone repository

In your user folder, make a new subfolder `Code` and clone the `dotfiles` repository into it.

{% highlight bash %}
$ mkdir -p ~/Code
$ cd ~/Code
$ git clone https://github.com/olivierparent/dotfiles
{% endhighlight %}

> ##### **Tip** *:bulb:*{:.pull-left .m-r}
> ---
> Update the dotfiles regularly with `git pull`.
{:.alert .alert-info}

{% highlight bash %}
$ cd ~/Code/dotfiles/
$ git pull
{% endhighlight %}

### Set environment variables

Open (or create) the `.bash_profile` file.

{% highlight bash %}
$ nano ~/.bash_profile
{% endhighlight %}

Add these lines to the `.bash_profile` file:

{% highlight bash %}
source ~/Code/dotfiles/bash_profile/dotfiles-scripts
source ~/Code/dotfiles/bash_profile/proxy
{% endhighlight %}

Save with <kbd>&lt;ctrl&gt;</kbd>+<kbd>x</kbd>, and choose Yes (<kbd>y</kbd>) to write the file and then press <kbd>return</kbd> to accept the filename. 

Reload the BASH profile to make the changes active for this Terminal session.

{% highlight bash %}
$ source ~/.bash_profile
{% endhighlight %}

Now you should have access to the `proxy` command.

{% highlight bash %}
$ proxy
{% endhighlight %}


{% comment %}
<!-- ⚓ Abbreviations -->
{% endcomment %}
*[CLI]:                     Command-Line Interface

{% comment %}
<!-- ⚓ Hyperlinks -->
{% endcomment %}
[xcode]:                    https://developer.apple.com/xcode