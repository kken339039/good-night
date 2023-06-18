# Good Night

This app is a RESTful Apis for Sleep Tracker

## Introduction

This project provides a set of RESTful APIs for managing sleep records and social interactions among users. The APIs allow users to perform clock-in actions, follow and unfollow other users, and retrieve sleep records of their following users from 7 days ago.

## Features

The project offers the key features:

- Feature1: Check In: Users can perform a check in action to record their sleep duration.
- Feature2: Subscribe/Unsubscribe: Users can Subscribe or Unsubscribe other users.
- Feature3: Sleep Records: Users can fetch sleep records of their following users from 7 days ago, adn sorted by the duration of their sleep duration.

## Technical

- Ruby on Rails
- PostgreSQL
- Docker

## API Endpoints
The project exposes the following RESTful API endpoints:
- `POST /api/user_id/sleep_record/check_in` Perform a check in action to start record time.
- `POST /api/user_id/sleep_record/check_out` Perform a check out action to start record time.
- `GET /api/user_id/subscriptions` Fetch sleep records of subscribed users from 7 days ago, and sorted sleep duration.
- `POST /api/user_id/subscriptions/activate` Perform subscribe action to  other user.
- `POST /api/user_id/subscriptions/deactivate` Perform unsubscribe action to other user.

### Environment

- Ruby 2.7.6
- Rails 7.0.4
- PostgreSQL 13.5

### Installation

1. clone
```shell
  git clone https://github.com/kken339039/good-night.git
```

You can use docker command or command in Makefile
2. build image
```
  make build
```

3. run container
```
  make start
```

4. init database in local
```
  make db_create
  make db_migrate
```

You can run other command when you need
1. rollback
```
  make db_rollback
```

2. execute container and run rails console
```
 docker exec -it good_night_app bash
 rails console
```
