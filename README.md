# Mini Seedrs is on Docker !

( :mag: For a complete commit history see [mini-seedrs](https://github.com/filippomassarelli/mini-seedrs) )

## Introduction

### Overview

Mini Seedrs allows you to easily invest in businesses you believe in. Build your application to connect to our investment platform through our:

- **Campaign API** - instant access to investment opportunities
- **Investment API** - instant investment initiation

Our products provide an unified interface between our investment platform and third party applications over a common [RESTful API](https://en.wikipedia.org/wiki/Representational_state_transfer).

Make sure to read the installation guide and API documentation below.

Thank you supporting the next generation of businesses !

### Contents

- [Get started](#get-started)
  - [Prerequisites](#prerequisites)
  - [Install and run](#install-and-run)
  - [Test](#test)
- [Campaign API](#campaign-api)

  - [Overview](#overview-1)
  - [Available data](#available-data)
  - [Request](#request)
    - [API endpoint](#api-endpoint)
    - [HTTP verbs](#http-verbs)
    - [Params](#params)
      - [Path parameters](#path-parameters)
      - [Query parameters](#query-parameters)
    - [Example request](#example-request)
  - [Response](#response)
    - [Success](#success)
    - [Error](#error)

- [Investment API](#investment-api)
  - [Overview](#overview-2)
  - [Investment conditions](#investment-conditions)
  - [Request](#request-1)
    - [API endpoint](#api-endpoint-1)
    - [HTTP verbs](#http-verbs-1)
    - [Params](#params-1)
    - [Example request](#example-request-1)
  - [Response](#response-1)
    - [Success](#success-1)
    - [Error](#error-1)
  - [Contribution](#contribution)

---

## Get started

### Prerequisites

Before you start, open your terminal and check whether you have ruby, rails and docker installed on your machine:
```
$ ruby -v
Rails 2.5.7

$ rails -v
Rails 6.1.1

$ docker -v
Docker version 20.10.2, build 2291f61
```

We will also be using [cURL](https://curl.se/) to make HTTP requests to our API from the terminal, so make sure you have it:

```
$ curl --version
curl 7.54.0
```

If you need to install any of these follow the relevant installation guides:

- [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
- [Rails](https://guides.rubyonrails.org/v5.0/getting_started.html) 
- [Docker](https://www.docker.com/get-started)
- [cURL](https://curl.se/download.html)


### Install and run

To get started with the app, clone the repo and `cd` into the directory:

```
git clone https://github.com/filippomassarelli/docker-mini-seedrs.git
cd docker-mini-seedrs
```

Then build the Docker image:

```
docker-compose build
```

And run the containers:

```
docker-compose up
```

And that's it, you are running Mini Seedrs with Docker !

To make sure, you can run `docker ps` to list all containers and their status. You should see both `docker-mini-seedrs` and `postgres` images with status `Up`.

You can now send requests to localhost, on Port 3000.


### Test

Our APIs have been developed following a behavior-driven development (BDD) approach using [RSpec](https://rspec.info/). 

Refer to [mini-seedrs](https://github.com/filippomassarelli/mini-seedrs) to see the expected output of running `rspec`. 

> :warning: For speed and efficiency [mini-seedrs](https://github.com/filippomassarelli/mini-seedrs) was developed with sqlite3 as database. When dockerizing the project, the decision to move to PostgreSQL was also made. A database authentication error now arises when running `rspec` which I am struggling to resolve. 

BDD had already served its purpose though and we will be able to test the correct behaviour with our requests. 

Nevertheless, suggestions on this issue are welcome - see how to contribute in the [Contribution](#contribution) section.

---

## Campaign API

### Overview

The Mini Seedrs Campaign API is a single interface to access current and past investment opportunities (campaigns) on the Mini Seedrs investment platform.

### Available data

The Campaign API allows you to access the following data for when listing all campaigns:

- `id` (integer): The unique id for the campaign
- `name` (string): The name of the business running the campaign
- `image` (string): The url path of the logo of the business
- `percentage_raised` (float): The percentage raised based on the investment target
- `target_amount` (float): The investment target of the campaign
- `sector` (string): The industry sector in which the business operates
- `country` (string): The country where the business is based
- `investment_multiple` (decimal): The investment multiple for the campaign to accepting new investment

For single campaigns additional data is provided:

- `investment_count` (integer): The number of valid investments made for that campaign
- `is_open` (boolean): A statement indicating whether the campaign is currently open for investment

### Request

#### API endpoint

The local server is set to run on Port 3000 by default, and the api is versioned. The current version is `v1` which results in the base URL for all requests:

```
http://localhost:3000/api/v1/campaigns
```

#### HTTP verbs

The Campaign API v1 supports only the `READ` functionality:

| Verb  | Description                        |
| ----- | ---------------------------------- |
| `GET` | Retrieve one or multiple resources |

#### Params

##### Path parameters

V1 of the Campaign API allows you to retrieve a specific campaign, and perform a few predetermined filtering and sorting actions using path parameters to be added to the base URL.

| Path                    | Description                                                    |
| ----------------------- | -------------------------------------------------------------- |
| `/{campaign_id}`        | Retrieve single campaign of specified id                       |
| `/open`                 | Retrieve only campaigns that are open for investment           |
| `/target_desc`          | Sort all campaigns by their target amount in descending order  |
| `/target_asc`           | Sort all campaigns by their target amount in ascending order   |
| `/open_and_target_desc` | Sort open campaigns by their target amount in descending order |
| `/open_and_target_asc`  | Sort open campaigns by their target amount in ascending order  |

##### Query parameters

For greater control, V1 also supports query paramenters to filter all campaigns above or below a specified target amount.

| Query                           | Description                                                |
| ------------------------------- | ---------------------------------------------------------- |
| `?target_above={target_amount}` | Retrieve campaigns with targets above the specified amount |
| `?target_below={target_amount}` | Retrieve campaigns with targets below the specified amount |

#### Example request

We can use cURL to request all campaigns:

```
curl http://localhost:3000/api/v1/campaigns
```

Or only the campaign with id of 5:

```
curl http://localhost:3000/api/v1/campaigns/5
```

If we want to filter out campaigns that are closed and sort the results in descending order according to their campaign's investment target:

```
curl http://localhost:3000/api/v1/campaigns/open_and_target_desc
```

And if we are only interested in campaigns that are looking for more than £500k:

```
curl http://localhost:3000/api/v1/campaigns?target_above=500000
```

### Response

#### Success

When requesting multiple campaigns, a successful response would be similar to:

```json
[
 {
  "id":1,
  "name":"Hirthe-Christiansen",
  "image":"https://pigment.github.io/fake-logos/logos/medium/color/2.png","percentage_raised":"215.65","target_amount":922139.12,"sector":"Transportation / Trucking / Railroad",
  "country":"Bhutan",
  "investment_multiple":"9.65"
 },
 ...,
 {
  "id":50,
  "name":"Macejkovic-Stokes",
  "image":"https://pigment.github.io/fake-logos/logos/medium/color/11.png",
  "percentage_raised":110.0,
  "target_amount":915381.62,
  "sector":"Executive Office",
  "country":"France",
  "investment_multiple":"9.32"
 }
]
```

Whereas for a single campaign you should expect:

```json
{
  "id": 5,
  "name": "Friesen, Mills and Wyman",
  "image": "https://pigment.github.io/fake-logos/logos/medium/color/7.png",
  "percentage_raised": "131.25",
  "investment_count": 2,
  "target_amount": 293319.09,
  "sector": "Performing Arts",
  "country": "Panama",
  "investment_multiple": "7.43",
  "is_open": true
}
```

#### Error

Bad request will raise errors. These are most commonly due to either a typo in the base url, or an invalid campaign id for individual resource requests.

In case of a typo you can expect:

```
"{status":404,"error":"Not Found","exception":"#\u003cActionController::RoutingError: No route matches ...
```

Wheras in case of an invalid campaign id:

```
{"status":404,"error":"Not Found","exception":"#\u003cActiveRecord::RecordNotFound: Couldn't find Campaign with 'id'= ...
```

---

## Investment API

### Overview

The Mini Seedrs Investment API brings the investment functionality to our platform. Using the API, you can execute investments to any campaign that is open for investment on our platform.

### Investment conditions

In order to successfully invest in a campaign through our Investment API, make sure to satify all of the following conditions:

- [x] Specify a valid campaign_id
- [x] Invest in GBP (British Pounds) only
- [x] Ensure the campaign is open for investment
- [x] Invest an amount that is a multiple of the campaign's investment multiple

If one or more of the above conditions is not respected, your investment will be rejected and an appropriate `ERROR` message returned (see section [3.4.2 Error](#error-1) for more information).

### Request

#### API endpoint

The Investment API follows the same versioned structure as the Campaigns API, resulting in the base URL:

```
http://localhost:3000/api/v1/investments
```

#### HTTP verbs

The Investment API v1 only supports the `CREATE` functionality:

| Verb   | Description                        |
| ------ | ---------------------------------- |
| `POST` | Make an investment into a campaign |

#### Params

The POST request needs a header of `Content-Type: application/json` and the following data passed in the body of the request:

| Field               | Required | Description                                                    |
| ------------------- | -------- | -------------------------------------------------------------- |
| `user_name`         | No       | The name of the investor is optional in this API version       |
| `investment_amount` | Yes      | The amount to be invested is required for a successful request |
| `currency`          | Yes      | The currency of investment needs to be specified               |
| `campaign_id`       | Yes      | To invest in a campaign, its id needs to be provided           |

#### Example request

```
curl --header "Content-Type: application/json" --request POST --data '{"user_name":"Filippo Massarelli", "investment_amount": 1000, "currency":"GBP", "campaign_id":5}' http://localhost:3000/api/v1/investments
```

### Response

#### Success

If your request is successful you will receive a `201` `Created` status code back as an HTTP response.

The new investment is saved in the database and returned in the response:

```
{
 "status":"SUCCESS 201",
 "message":"Valid investment: Thank you for supporting the wonderful!",
 "data":
  {
   "id":7,
   "user_name":"Filippo Massarelli",
   "investment_amount":"7430.0",
   "currency":"GBP",
   "created_at":"2021-01-22T13:22:23.341Z",
   "updated_at":"2021-01-22T13:22:23.341Z",
   "campaign_id":5
  }
}
```

> :pencil2: Note that all valid investments are saved and their investment amounts contribute to their campaign's percentage raised.

#### Error

If your investment is invalid you will receive one of the `4XX` `Client Error` codes below, explaining the reason why.

| HTTP Status Code             | Description                                                                                                                                                       |
| ---------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `403` `Forbidden`            | The investment amount did not respect the campaign's investment multiple. For reference, the investment multiple of the campaign is returned in the error message |
| `404` `Not Found`            | A campaign with the specified id does not exist                                                                                                                   |
| `406` `Not Acceptable`       | The investment was rejected, either because the investment was not in GBP or because the campaign was no longer open. This is specified in the error message      |
| `422` `Unprocessable Entity` | The server was unable to process the contained instructions for reasons other than the above. The error appearing in the server is passed in the response         |

---

## Contribution
Want to contribute? Great!

To fix a bug or enhance an existing code, follow these steps:

- Fork the repo
- Create a new branch (`git checkout -b improve-feature`)
- Make your changes
- Commit with a descriptive message (`git commit -m 'description'`)
- Push to the branch (`git push origin improve-feature`)
- Create a Pull Request

---

:point_up_2: [Back to the top](#mini-seedrs-is-on-docker-)

**License**
MIT © [Filippo Massarelli](https://github.com/filippomassarelli)
