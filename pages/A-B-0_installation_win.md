---
layout   : page
title    : Windows
permalink: installation/win/
published: true
tags     :
---

> ##### **Remark** *:point_up:*{:.pull-left .m-r}
> ---
> This installation guide is meant for *&nbsp;*{:.fa .fa-windows}**Windows *8.1***, but will most probably apply to other versions too.
{:.alert .alert-info}

Prerequisites
-------------

### Git

Download and install:

[*&nbsp;*{:.fa .fa-git-square}Git][git]{:.btn .btn-{{ site.colour }}}

Use these settings:

 - `Use Git and optional Unix tools from the Windows Command Prompt`
 - `Checkout windows-style, commit Unix-style line endings`

Installation
------------

### Clone repository

In your user folder, make a new subfolder `Code` and clone the `dotfiles` repository into it.

{% highlight powershell %}
$ mkdir %USERPROFILE%\Code
$ cd %USERPROFILE%\Code
$ git clone https://github.com/olivierparent/dotfiles
{% endhighlight %}

### Set environment variables

**Environment Variables…** → **User variables**

| Variable | Value                                 |
|:---------|:--------------------------------------|
| `PATH`   | `%USERPROFILE%\Code\dotfiles\scripts` |
{:.table}


{% comment %}
<!-- ⚓ Hyperlinks -->
{% endcomment %}
[git]:                      http://git-scm.com