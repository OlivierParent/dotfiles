---
layout   : page
title    : Mac OS X
permalink: usage/mac/
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

Enable the proxy server settings once per Terminal session.

{% highlight bash %}
$ proxy on
{% endhighlight %}

Disable with `off` or just close the Terminal window and open a new one.

{% highlight bash %}
$ proxy off
{% endhighlight %}

### Manually

If the script above doesn't work properly or isn't installed, you'll have to do it manually.

Set proxy server settings for this session:

{% highlight bash %}
$ PXY=http://proxy.arteveldehs.be:8080 && NOPXY=localhost,127.0.0.1,.local && export HTTP_PROXY=$PXY HTTPS_PROXY=$PXY FTP_PROXY=$PXY NO_PROXY=$NOPXY http_proxy=$PXY https_proxy=$PXY ftp_proxy=$PXY no_proxy=$NOPXY && unset PXY NOPXY
{% endhighlight %}

Unset proxy server settings for this session:

{% highlight bash %}
$ unset HTTP_PROXY HTTPS_PROXY FTP_PROXY NO_PROXY http_proxy https_proxy ftp_proxy no_proxy
{% endhighlight %}


{% comment %}
<!-- ⚓ Abbreviations -->
{% endcomment %}
*[CLI]:                     Command-Line Interface

{% comment %}
<!-- ⚓ Hyperlinks -->
{% endcomment %}
[xcode]:                    https://developer.apple.com/xcode