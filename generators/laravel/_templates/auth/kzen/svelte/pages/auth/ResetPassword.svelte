<script>
  import { useForm } from '@inertiajs/inertia-svelte'
  import { route } from '@/utils'
  import AuthBox from '@/components/auth/AuthBox.svelte'
  import TextInput from '@/components/forms/TextInput.svelte'
  import Button from '@/components/Button.svelte'
  import Seo from '@/components/Seo.svelte'

  export let token
  export let email

  let title = 'Reset Password'
  let form = useForm({
    token: token,
    email: email,
    password: 'password',
    password_confirmation: 'password',
  })

  function handleSubmit() {
    $form.post(route('password.update'))
  }
</script>

<Seo {title} />

<AuthBox reversed="true">

  <svelte:fragment slot="form">
    <form class="w-full lg:px-4 lg:py-8" on:submit|preventDefault={handleSubmit}>
      <div class="my-2 text-center">
        <h3>{title}</h3>
      </div>

      <TextInput field="email" bind:value={$form.email} error={$form.errors.email} class="mt-6" label="Email:" type="email" autocapitalize="off" required />

      <TextInput field="password" bind:value={$form.password} error={$form.errors.password} class="mt-6" label="Password:" type="password" required />

      <TextInput field="password_confirmation" bind:value={$form.password_confirmation} class="mt-6" label="Password Confirmation:" type="password" required />

      <div class="pt-8 pb-6">
        <Button kind="primary" bind:loading={$form.processing} class="wide" size="sm">
          Reset Password
        </Button>
      </div>
    </form>
  </svelte:fragment>

</AuthBox>
