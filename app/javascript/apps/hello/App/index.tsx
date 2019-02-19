import React from 'react'
import { Elements, StripeProvider } from 'react-stripe-elements'

import { InjectedCheckoutForm } from 'apps/hello/InjectedCheckoutForm'

export const App = props => {
  return (
    <StripeProvider apiKey={props.stripePublicKey}>
      <Elements>
        <InjectedCheckoutForm />
      </Elements>
    </StripeProvider>
  )
}
