# K'zen Generate

Personal code generators for [Laravel](https://laravel.com), [Svelte](https://svelte.dev), [NuxtJS](https://nuxtjs.org) and more.

Written in Ruby &amp; Thor, using Thor's patch functionality for greater flexibility.

<br>

## INSTALLATION

```bash
$  git clone https://github.com/kematzy/kzen-generate.git
```

Then run the following Rake command:

```bash
$ rake kzen:install
```

And you should be good to go.

The `kzen:install` command essentially does this:

```bash
# symlink executable to ~/bin directory
ln -s path/2/kzen-generate/bin/kzen.rb $HOME/bin/kzen
chmod +x $HOME/bin/kzen

# symlink the generators folder to ~/.kzen
ln -s path/2/kzen-generate/generators $HOME/.kzen
```

<br>
<br>


## USAGE


```bash
$  kzen laravel project:new
```


<br>
<br>

## GENERATORS

The following generators are available for use:

<br>

### Laravel

  - **project:new**  -- generate a new Laravel project with the correct setups




