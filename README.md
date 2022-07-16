# ecommerce-api

## Setup
Install the dependencies:
``` bash
bundle install
rake db:migrate
rake db:all_seed
bin/rails s
```

Add the following to credentials:
- ```secret_key_base: <secret_key_base>```
- ```devise_jwt_secret_key: <your_jwt_secret_key>```
- ```stripe_secret_key: <your_stripe_api_key>``` ([GUIDE](https://stripe.com/docs/keys))
- ```stripe_webhook_secret: <your_stripe_webhook_secret>``` ([GUIDE](https://stripe.com/docs/webhooks/signatures))

```bash
EDITOR="nano" bin/rails credentials:edit # eventually replace nano with your favorite editor
```
## Local testing Stripe webhooks
Run the following command to test the webhooks and copy the signature to the stripe_webhook_secret:
```bash
    stripe listen --forward-to http://localhost:3000/payment/success/webhook
```