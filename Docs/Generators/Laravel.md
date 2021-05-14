# Laravel Generators

<a id="top">

A full listing of all the Laravel related generators:



- #### Projects:

  - **`project:raw`**  -- generate a new project directory with a prefilled config .yml file that you can easily edit and then use to generate your project.

  - **`project:new`**  -- generate a new Laravel project with the correct setups. Depends upon:
    - `db`, `telescope`, `git`, `github`, `tailwind`, `mailtrap`

<br>

- #### Databases:

  - **`db`** -- add or reset your database support within a project. Depends upon:
    - `db:sqlite`, `db:pgsql`, `db:mysql`

    - **`db:sqlite`** -- adds or resets SQLite support to a project.

    - **`db:pgsql`** -- adds or resets PostgreSQL support to a project.

    - **`db:mysql`** -- adds or resets MySQL support to a project.

  - **`db:sessions`** -- adds database support for Sessions in a project.

<br>

- #### CSS related:

  - **`tailwind`** -- adds Tailwind CSS support

  - **`stylelint`** -- adds Stylelint support

<br>

- #### JS related:

  - **`js:inertia`** -- adds Inertia JS support with setups. Depends upon:
    - `js:inertia:svelte`, `js:inertia:vue`

  - **`js:inertia:svelte`** -- adds common Svelte based files

  - **`js:inertia:vue`** -- adds common Vue based files

<br>

- #### Authentication related:

  - **`auth:fortify`** -- adds Fortify support

  - **`auth:breeze`** -- adds Breeze support


  - **`auth:jetstream`** -- adds JetStream support with the following options:
    - `default` -- installs the default Inertia & Vue version;
    - `svelte` -- install an Inertia & Svelte based version instead;
    - `livewire` -- installs the default Livewire & Blade version;


<br>

- #### Development related:

  - **`telescope`** -- adds Telescope support. Includes:
    - `telescope:toolbar`

  - **`telescope:toolbar`** -- adds Telescope Toolbar support. Requires `telescope`.

  - **`ray`** -- adds Ray support.


<br>

