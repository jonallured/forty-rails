import React, { useState } from "react"
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
  const [errorMessage, setErrorMessage] = useState("")

  const handleUpgradeError = (error): void => {
    // i should be sending this to Honeybadger!
    console.log(error)
    setErrorMessage(error.message)
  }

  const handleUpgradeResult = (result): void => {
    if (result.error) {
      // i should be sending this to Honeybadger!
      console.log(result.error)
      setErrorMessage(result.error)
    } else {
      window.location.assign("/thanks")
    }
  }

  const handleSourceError = (error): void => {
    // i should be sending this to Honeybadger!
    console.log(error)
    setErrorMessage(error)
  }

  const handleSourceResult = (result): void => {
    if (result.error) {
      // i should be sending this to Honeybadger!
      console.log(result.error)
      setErrorMessage(result.error.message)
    } else {
      fetcher
        .createUpgrade(result.source.id)
        .then(handleUpgradeResult)
        .catch(handleUpgradeError)
    }
  }

  const handleSubmit = (e): void => {
    e.preventDefault()
    setErrorMessage("")

    const element = elements.getElement(CardElement)
    const sourceData = { type: "card", owner: { email } }

    stripe
      .createSource(element, sourceData)
      .then(handleSourceResult)
      .catch(handleSourceError)
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

  const showError = errorMessage !== ""

  return (
    <form onSubmit={handleSubmit}>
      {showError && <p className="error">{errorMessage}</p>}
      <CardElement options={cardElementOptions} />
      <input disabled={!stripe} type="submit" value="Pay" />
    </form>
  )
}
