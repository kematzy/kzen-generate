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

There are two basic ways that this works:


### 1) A FRESH START

To create a new Laravel project, just use the following command:

```bash
$  kzen laravel project:new
```

This command will initially ask a number of configuration questions, and then, depending upon your answers, generate a new Laravel install with the required code features already setup and with each step saved in easily followed git commits.

<br>

### 2) IN AN EXISTING PROJECT / APP / SOLUTION

You can also use this to add features / functionality to existing projects like this:

```bash
# inside an existing Laravel project

$ kzen laravel inertiajs
```

Which will install and setup the Inertia JS suite and common settings



<br>
<br>

## AVAILABLE GENERATORS

The following generators are available for use:

<br>

### Laravel

[Full listing](/Docs/Generators/Laravel.md#top) of Generators specifically for Laravel related projects:


- #### Projects:

  - **`project:raw`**  -- generate a new project directory with a prefilled config .yml file that you can easily edit and then use to generate your project.

  - **`project:new`**  -- generate a new Laravel project with the correct setups. Depends upon:
    - `db`, `telescope`, `git`, `github`, `tailwind`, `mailtrap`


- #### Databases:

  - **`db`** -- add or reset your database support within a project. Depends upon:
    - `db:sqlite`, `db:pgsql`, `db:mysql`

  - **`db:sqlite`** -- adds or resets SQLite support to a project.

  - **`db:pgsql`** -- adds or resets PostgreSQL support to a project.

  - **`db:mysql`** -- adds or resets MySQL support to a project.


  - **`db:sessions`** -- adds database support for Sessions in a project.



- #### CSS related:

  - **`tailwind`** -- adds Tailwind CSS support

  - **`stylelint`** -- adds Stylelint support

- #### JS related:

  - **`inertiajs`** -- adds Inertia JS support with setups. Depends upon:
    - `inertiajs:svelte`, `inertiajs:vue`

  - **`stylelint`** -- adds Stylelint support


- #### Development related:

  - **`telescope`** -- adds Telescope support. Depends upon:
    - `telescope:toolbar`

  - **`telescope:toolbar`** -- adds Telescope Toolbar support. Depends upon:
    - `telescope`

  - **`ray`** -- adds Ray support.


<br>

### Svelte

[Full listing](/Docs/Generators/Svelte.md#top) of Generators specifically for Svelte related projects or parts. Examples:


<br>

### Nuxt JS

[Full listing](/Docs/Generators/NuxtJS.md#top) of Generators specifically for Nuxt JS related projects. Examples:


<br>

### Hasura

[Full listing](/Docs/Generators/Hasura.md#top) of Generators specifically for Hasura based projects. Examples:



<br>

### Vue JS

[Full listing](/Docs/Generators/VueJS.md#top) of Generators specifically for Vue JS related projects or parts. Examples:



<br>

### Shared

[Full listing](/Docs/Generators/Shared.md#top) of Generators that can be used for any chosen solution. Examples:



<br>

## DEVELOPMENT


