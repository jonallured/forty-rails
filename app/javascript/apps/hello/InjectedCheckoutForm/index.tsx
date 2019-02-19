import React from 'react'
import { injectStripe } from 'react-stripe-elements'

const CheckoutForm = props => {
  // this is the punchline - i want to see the stripe object show up here
  // JON: look at this tomorrow so you don't lose context!!
  console.log(props)
  return (
    <h1>OMG</h1>
  )
}

export const InjectedCheckoutForm = injectStripe(CheckoutForm)
