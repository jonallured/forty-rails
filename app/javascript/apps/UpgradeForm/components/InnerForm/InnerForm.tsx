import React from "react"
import { CardElement, useElements, useStripe } from "@stripe/react-stripe-js"
import { UpgradeFormFetcher } from "../../UpgradeFormFetcher"

export interface InnerFormProps {
  email: string
  fetcher: UpgradeFormFetcher
}

export const InnerForm: React.FC<InnerFormProps> = (props) => {
  const { email, fetcher } = props
  const stripe = useStripe()
  const elements = useElements()

  const handleSourceResult = (result): void => {
    if (result.error) {
      console.log(result.error)
    } else {
      fetcher.createUpgrade(result.source.id).then(() => {
        // this would probably be better - send them to a page thanking them
        // and then they can use the app from there.
        window.location.assign("/upgrade/thanks")
      })
    }
  }

  const handleSubmit = (e): void => {
    e.preventDefault()

    const element = elements.getElement(CardElement)
    const sourceData = { type: "card", owner: { email } }

    stripe.createSource(element, sourceData).then(handleSourceResult)
  }

  const cardStyles = {
    fontSize: "20px",
  }

  const cardElementOptions = {
    style: {
      base: cardStyles,
    },
    hideIcon: true,
  }

  return (
    <>
      <h1>upgrade</h1>
      <form onSubmit={handleSubmit}>
        <CardElement options={cardElementOptions} />
        <input disabled={!stripe} type="submit" value="Pay" />
      </form>
    </>
  )
}
