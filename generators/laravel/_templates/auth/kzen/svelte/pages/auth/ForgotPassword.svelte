<script>
  import { inertia, useForm } from '@inertiajs/inertia-svelte'
  import { route } from '@/utils'
  import AuthBox from '@/components/auth/AuthBox.svelte'
  import TextInput from '@/components/forms/TextInput.svelte'
  import Button from '@/components/Button.svelte'
  import Seo from '@/components/Seo.svelte'

  export let enabled = {}
  export let status

  let title = 'Forgot Your Password?'

  let form = useForm({
    email: 'joeblogs@email.com',
  })

  function handleSubmit() {
    $form.post(route('password.email'))
  }
</script>

<Seo {title} />

<AuthBox reversed="true">

  <svelte:fragment slot="form">
    {#if status}
      <div class="mb-4 text-sm font-medium text-success-400">{status}</div>
    {/if}
    <form class="w-full lg:px-4 lg:py-8" on:submit|preventDefault={handleSubmit}>
      <div class="my-2 text-left">
        <h3>{title}</h3>

        <p class="pb-8 text-sm">
          Forgot your password? No problem. Just let us know your email address and we will email you a
          password reset link that will allow you to choose a new one.
        </p>
      </div>

      <TextInput field="email" bind:value={$form.email} error={$form.errors.email} class="mt-6" label="Email" type="email" autofocus autocapitalize="off" required />

      <div class="pt-8 pb-6 mt-6">
        <Button kind="primary" bind:loading={$form.processing} class="wide" size="sm">
          Send Reset Email
        </Button>
      </div>

      <div class="auth-alt-page-links">
        {#if enabled.login}
          <a href="{ route('login') }" title="Login instead?" use:inertia>Login?</a>
        {/if}
        {#if enabled.register}
          <a href="{ route('register') }" title="Not Registered yet?" use:inertia>Register?</a>
        {/if}
      </div>
    </form>
  </svelte:fragment>

</AuthBox>
