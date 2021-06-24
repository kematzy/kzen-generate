<script>
  import { inertia, useForm } from '@inertiajs/inertia-svelte'
  import { route } from '@/utils'
  import AuthBox from '@/components/auth/AuthBox.svelte'
  import TextInput from '@/components/forms/TextInput.svelte'
  import Button from '@/components/Button.svelte'
  import Seo from '@/components/Seo.svelte'

  let title = 'Confirm Your Password'

  let form = useForm({
    password: 'password',
  })

  function handleSubmit() {
    $form.post(route('password.confirm'))
  }
</script>

<Seo {title} />

<AuthBox reversed="true">

  <svelte:fragment slot="form">
    <form class="w-full lg:px-4 lg:py-8" on:submit|preventDefault={handleSubmit}>
      <div class="my-2 text-left">
        <h3>{title}</h3>
        <p class="pb-8 text-sm">
          This is a secure area of the application. Please confirm your password before continuing.
        </p>
      </div>

      <TextInput bind:value={$form.password}  error={$form.errors.email} class="mt-6" label="Password:" type="password" />

      <div class="pt-8 pb-6 mt-6">
        <Button kind="primary" bind:loading={$form.processing} class="wide" size="sm">
          Confirm
        </Button>
      </div>
    </form>
  </svelte:fragment>

</AuthBox>
