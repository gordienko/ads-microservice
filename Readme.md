# ADS Microservice

## Create development database

createdb ads_microservice_development

## Run migration

rake db:migrate

## Run server
bundle exec puma

## Usage

### Create ad

```
curl --request POST \
--url 'http://localhost:3000/ads/v1?ad%5Btitle%5D=land%20cruiser%20prado%20for%20sale&ad%5Bdescription%5D=Selling%20brand%20new%20car!&ad%5Bcity%5D=%D0%9C%D0%B0%D0%B3%D0%B0%D0%B4%D0%B0%D0%BD&user_id=123'
```

### Get ads

```
curl --request GET --url http://localhost:3000/ads/v1
```

## Rspec

1. createdb ads_microservice_test
2. RACK_ENV=test rake db:migrate
3. rspec
