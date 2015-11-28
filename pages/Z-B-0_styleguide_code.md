---
layout   : page
title    : "Code"
permalink: styleguide/code/
published: true
tags     : styleguide
---

Code
----

### CSS

{% highlight css linenos %}
body {
    font-family: sans-serif;
}
{% endhighlight %}

### HTML

{% highlight html linenos %}
<!DOCTYPE html>
<html>
<head>
    <title>html</title>
    <link rel="stylesheet" href="main.css">
</head>
</html>
{% endhighlight %}

### Ini

{% highlight ini linenos %}
variables_order = "EGPCS"
{% endhighlight %}

### JSON

{% highlight json linenos %}
[
    { 'x': 'y' }
]
{% endhighlight %}

### JavaScript

{% highlight js linenos %}
function logger(message) {
    console.log(message);
}
{% endhighlight %}

### PHP

{% highlight php linenos %}
<?php

phpinfo();
{% endhighlight %}

### SASS

{% highlight scss linenos %}
html {
    body {
        .home {
            color: red;
        }
    }
}
{% endhighlight %}

### SQL

{% highlight sql linenos %}
-- Toon tabellen
SHOW TABLES;
{% endhighlight %}

### TypeScript

{% highlight ts linenos %}
class {
    
}
{% endhighlight %}

### Twig

{% highlight jinja linenos %}{% raw %}
{% extends "layout.html" %}
{% block body %}
  <ul>
  {% for user in users %}
    <li><a href="{{ user.url }}">{{ user.username }}</a></li>
  {% endfor %}
  </ul>
{% endblock %}
{% endraw %}{% endhighlight %}

### YAML

{% highlight yaml linenos %}
 - X
   - X
{% endhighlight %}

---

Command Line
------------

### Bash

{% highlight bash %}
$ ls
{% endhighlight %}

### Batch

{% highlight bat %}
C:\> dir
{% endhighlight %}

### PowerShell

{% highlight powershell %}
PS> ls
{% endhighlight %}

Browsers
--------

### Firefox

> ##### *&nbsp;*{:.fa .fa-firefox}Firefox
>
> Description
> **MenuItem1** → **MenuItem2** → **MenuItem3**
{:.card .card-block}

> ##### *&nbsp;*{:.fa .fa-firefox}Firefox Developer Edition
>
> Description
> **MenuItem1** → **MenuItem2** → **MenuItem3**
{:.card .card-block}

### Google Chrome

> ##### *&nbsp;*{:.fa .fa-chrome}Google Chrome
>
> Description
> **MenuItem1** → **MenuItem2** → **MenuItem3**
{:.card .card-block}

### Microsoft

> ##### *&nbsp;*{:.fa .fa-edge}Edge
>
> Description
> **MenuItem1** → **MenuItem2** → **MenuItem3**
{:.card .card-block}

> ##### *&nbsp;*{:.fa .fa-internet-explorer}Internet Explorer
>
> Description
> **MenuItem1** → **MenuItem2** → **MenuItem3**
{:.card .card-block}

### Opera

> ##### *&nbsp;*{:.fa .fa-opera}Opera
>
> Description
> **MenuItem1** → **MenuItem2** → **MenuItem3**
{:.card .card-block}

### Safari

> ##### *&nbsp;*{:.fa .fa-safari}Safari
>
> Description
> **MenuItem1** → **MenuItem2** → **MenuItem3**
{:.card .card-block}

Operating Systems
-----------------

### Android

> ##### *&nbsp;*{:.fa .fa-android}Android
>
> Description
> **MenuItem1** → **MenuItem2** → **MenuItem3**
{:.card .card-block}

### iOS
> ##### *&nbsp;*{:.fa .fa-apple}iOS
>
> Description
> **MenuItem1** → **MenuItem2** → **MenuItem3**
{:.card .card-block}

### Mac OS X
> ##### *&nbsp;*{:.fa .fa-apple}Mac OS X
>
> Description
> **MenuItem1** → **MenuItem2** → **MenuItem3**
{:.card .card-block}

### Windows
> ##### *&nbsp;*{:.fa .fa-windows}Windows
>
> Description
> **MenuItem1** → **MenuItem2** → **MenuItem3**
{:.card .card-block}

Files
-----

> ##### Folders & Files/Mappen & Bestanden *:open_file_folder:*{:.pull-left .m-r}
> ---
>```
> nmdad3.arteveldehogeschool.local/
> ├── app/
> ├── docs/
> │   ├── academische_poster.pdf
> │   ├── checklist.md
> │   ├── presentatie.pdf
> │   ├── productiedossier.pdf
> │   └── timesheet.xslx
> ├── www/
> └── README.md
>```
{:.card .card-block}