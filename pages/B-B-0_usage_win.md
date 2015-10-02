---
layout   : page
title    : Windows
permalink: usage/win/
published: true
tags     :
---

Proxy Server
------------

### When to use?

> ##### **Do use Proxy** Server Settings *:thumbsup:*{:.pull-left .m-r}
> ---
> *&nbsp;*{:.fa .fa-wifi}Artevelde HS **Veilig**  
> *&nbsp;*{:.fa .fa-sitemap}Artevelde HS **Ethernet**
{:.alert .alert-success}

> ##### **Do not use Proxy** Server Settings *:thumbsdown:*{:.pull-left .m-r}
> ---
> *&nbsp;*{:.fa .fa-wifi}Artevelde HS **Open**  
> *&nbsp;*{:.fa .fa-wifi} **Home** Wifi  
> *&nbsp;*{:.fa .fa-sitemap} **Home** Ethernet
{:.alert .alert-danger}

### Using a script

Enable the proxy server settings by running the script.

{% highlight powershell %}
$ proxy
{% endhighlight %}

Disable the proxy server settings by running the script again.

{% highlight powershell %}
$ proxy
{% endhighlight %}

### Manual settings

If the script above doesn't work properly or isn't installed, you'll have to do it manually.

> **Environment Variables…** → **System variables**
> 
> | Variable      | Value                              |
> |:--------------|:-----------------------------------|
> | `HTTP_PROXY`  | `http://proxy.arteveldehs.be:8080` |
> | `HTTPS_PROXY` | `http://proxy.arteveldehs.be:8080` |
> | `FTP_PROXY`   | `http://proxy.arteveldehs.be:8080` |
{:.table}

> ##### **Tip** *:bulb:*{:.pull-left .m-r}
> ---
> To disable the proxy server settings, just rename the variables.
{:.alert .alert-info}


{% comment %}
    ⚓ Abbreviations
{% endcomment %}

*[CLI]:                     Command-Line Interface

{% comment %}
    ⚓ Hyperlinks
{% endcomment %}

[xcode]:                    https://developer.apple.com/xcode