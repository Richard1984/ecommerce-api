# ecommerce-api

## Setup
Install the dependencies:
``` bash
bundle install
rake db:migrate
```

Add the following to credentials:
- ```devise_jwt_secret_key: <your_jwt_secret_key>```
- ```facebook_app_id: <your_facebook_app_id>```
- ```facebook_secret_key: <your_facebook_secret_key>```

```bash
EDITOR="nano" bin/rails credentials:edit # eventually replace nano with your favorite editor
```
