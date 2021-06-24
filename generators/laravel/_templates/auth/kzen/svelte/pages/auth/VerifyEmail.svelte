<script>
  import { inertia, useForm } from '@inertiajs/inertia-svelte'
  import { route } from '@/utils'
  import AuthBox from '@/components/auth/AuthBox.svelte'
  // import TextInput from '@/components/forms/TextInput.svelte'
  import Button from '@/components/Button.svelte'
  import Seo from '@/components/Seo.svelte'

  export let status

  let title = 'Verify Your Email'

  let form = useForm({})

  function handleSubmit() {
    $form.post(route('verification.send'))
  }
</script>

<Seo {title} />

<AuthBox reversed="true">

  <svelte:fragment slot="form">
    {#if status === 'verification-link-sent'}
      <div class="mb-4 text-sm font-medium text-green-600">
        A new verification link has been sent to the email address you provided during registration.
      </div>
    {/if}

    <form class="auth-form" on:submit|preventDefault={handleSubmit}>
      <div class="mx-auto my-2 text-center">
        <h3>Verify Your Email</h3>
      </div>

      <div class="mb-4 text-sm text-gray-600">
        <p><strong>Thanks for signing up!</strong></p>
        <p>
          Before you can get any further, you need verify your email address by clicking on the link in an email from us to you.
        </p>
        <p>
          If you didn't receive the email, please click the <em>"Resend Verification Email"</em> button again, and we will gladly send you a new email confirmation.
        </p>
      </div>

      <div class="pt-8 pb-6">
        <Button kind="primary" bind:loading={$form.processing} class="wide" size="sm">
          Resend Verification Email
        </Button>
      </div>

      <div class="flex items-center justify-between pb-4 text-sm text-center text-gray-500">
        <a href="{ route('logout') }" class="btn" use:inertia="{{ method: 'post' }}">
          <span class="flex flex-row items-center justify-start">
            <span>Logout</span>
          </span>
        </a>
      </div>
    </form>
  </svelte:fragment>

</AuthBox>
