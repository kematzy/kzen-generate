<script>
  import { inertia, useForm, page } from '@inertiajs/inertia-svelte'
  import { route } from '@/utils'
  import AuthBox from '@/components/auth/AuthBox.svelte'
  import TextInput from '@/components/forms/TextInput.svelte'
  import Button from '@/components/Button.svelte'
  import Seo from '@/components/Seo.svelte'

  export let enabled = {}
  export let status

  let title = 'Login'

  let form = useForm({
    email: 'joeblogs@email.com',
    password: 'password',
    remember: true,
  })

  function handleSubmit() {
    $form.post(route('login'))
  }
</script>

<Seo {title} />

<AuthBox reversed="true">

  <svelte:fragment slot="form">
    {#if status}
      <div class="mb-4 text-sm font-medium text-green-600">{status}</div>
    {/if}
    <form class="w-full lg:px-4 lg:py-8" on:submit|preventDefault={handleSubmit}>
      <div class="my-2 text-center">
        <h3>{title}</h3>
      </div>

      {#if $form.errors.email}
        <div id="error-status" class="px-8 py-2 text-sm font-medium text-center text-red-600">{$form.errors.email}</div>
      {/if}

      <TextInput field="email" bind:value={$form.email} class="mt-6" label="Email" type="email" autofocus autocapitalize="off" required />

      <TextInput field="password" bind:value={$form.password} class="mt-6" label="Password" type="password" required />

      <div id="input-remember" class="mt-8">
        <label class="flex items-center select-none" for="remember">
          <input id="remember" bind:checked={$form.remember} class="mr-3" type="checkbox" />
          <span class="text-sm">Remember Me?</span>
        </label>
      </div>

      <div class="mt-12 mb-6">
        <Button kind="primary" bind:loading={$form.processing} class="wide" size="sm">
          Login
        </Button>
      </div>

      <div class="auth-alt-page-links">
        {#if enabled.register}
          <a href="{ route('register') }" title="Please Register if you are not already registered" use:inertia>Register?</a>
        {/if}
        {#if enabled.resetPasswords}
          <a href="{ route('password.request') }" title="Forgotten your password? Request a reset" use:inertia>Forgot Your Password?</a>
        {/if}
      </div>
    </form>
  </svelte:fragment>

</AuthBox>
