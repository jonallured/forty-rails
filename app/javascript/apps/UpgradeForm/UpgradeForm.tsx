import React from "react"
import { loadStripe } from "@stripe/stripe-js"
import { Elements } from "@stripe/react-stripe-js"
import { InnerForm, InnerFormProps } from "./components/InnerForm"

export interface UpgradeFormProps extends InnerFormProps {
  stripePublicKey: string
}

export const UpgradeForm: React.FC<UpgradeFormProps> = (props) => {
  const stripePromise = loadStripe(props.stripePublicKey)

  return (
    <Elements stripe={stripePromise}>
      <InnerForm {...props} />
    </Elements>
  )
}
