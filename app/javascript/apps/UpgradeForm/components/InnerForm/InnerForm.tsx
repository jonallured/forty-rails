import React, { useState } from "react"
import { CardElement, useElements, useStripe } from "@stripe/react-stripe-js"
import { UpgradeFormFetcher } from "../../UpgradeFormFetcher"

export interface InnerFormProps {
  email: string
  fetcher: UpgradeFormFetcher
  honeybadger: { notify: (any) => void }
}

export const InnerForm: React.FC<InnerFormProps> = (props) => {
  const { email, honeybadger, fetcher } = props
  const stripe = useStripe()
  const elements = useElements()
  const [errorMessage, setErrorMessage] = useState("")

  const handleUpgradeResult = (result): void => {
    if (result.error) {
      setErrorMessage(result.error)
    } else {
      window.location.assign("/thanks")
    }
  }

  const handleUpgradeError = (error): void => {
    honeybadger.notify(error)
    setErrorMessage(error.message)
  }

  const handleSourceResult = (result): void => {
    if (result.error) {
      honeybadger.notify(result)
      setErrorMessage(result.error.message)
    } else {
      fetcher
        .createUpgrade(result.source.id)
        .then(handleUpgradeResult)
        .catch(handleUpgradeError)
    }
  }

  const handleSourceError = (error): void => {
    honeybadger.notify(error)
    setErrorMessage(error)
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
