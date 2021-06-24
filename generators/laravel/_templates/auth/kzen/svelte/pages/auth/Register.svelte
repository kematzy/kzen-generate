<script>
  import { inertia, useForm } from '@inertiajs/inertia-svelte'
  import { route } from '@/utils'
  import AuthBox from '@/components/auth/AuthBox.svelte'
  import TextInput from '@/components/forms/TextInput.svelte'
  import Button from '@/components/Button.svelte'
  import Seo from '@/components/Seo.svelte'

  export let enabled = {}

  let title = 'Register'
  let form = useForm({
    name: '',
    email: '',
    password: 'password',
    password_confirmation: 'password',
    terms: false,
  })

  function handleSubmit() {
    $form.post(route('register'))
  }
</script>

<Seo {title} />

<AuthBox reversed="true">

  <svelte:fragment slot="form">
    <form class="w-full lg:px-4 lg:py-8" on:submit|preventDefault={handleSubmit}>
      <div class="my-2 text-center">
        <h3>{title}</h3>
      </div>

      <TextInput field="name" bind:value={$form.name} error={$form.errors.name} class="mt-6" label="Name" type="text" autofocus autocapitalize="off" required />

      <TextInput field="email" bind:value={$form.email} error={$form.errors.email} class="mt-6" label="Email" type="email" autocapitalize="off" required />

      <TextInput field="password" bind:value={$form.password} error={$form.errors.password} class="mt-6" label="Password" type="password" autocomplete="new-password" required />

      <TextInput field="password_confirmation" bind:value={$form.password_confirmation} error={$form.errors.password} class="mt-6" label="Password Confirmation" type="password" autocomplete="new-password" required />

      {#if enabled.terms}
        <div id="input-terms" class="mt-6">
          <label class="flex items-center mt-12 select-none" for="terms">
            <input id="terms" bind:checked={$form.terms} class="mr-3" type="checkbox" />
            <span class="text-sm">
              I agree to the
                <a target="_blank" href="{ route('terms.show') }" class="text-sm underline">Terms of Service</a>
                and
                <a target="_blank" href="{ route('policy.show') }" class="text-sm underline">Privacy Policy</a>
              </span>
          </label>
          {#if $form.errors.terms}
            <div class="form-error">{ $form.errors.terms }</div>
          {/if}
        </div>
      {/if}

      <div class="pt-8 pb-6">
        <Button kind="primary" bind:loading={$form.processing} class="wide" size="sm">
          Register
        </Button>
      </div>

      <div class="page-links">
        <a href="{ route('login') }" title="back to the Login page" use:inertia>Login?</a>
      </div>
    </form>
  </svelte:fragment>

</AuthBox>
