[![General Assembly Logo](https://camo.githubusercontent.com/1a91b05b8f4d44b5bbfb83abac2b0996d8e26c92/687474703a2f2f692e696d6775722e636f6d2f6b6538555354712e706e67)](https://generalassemb.ly/education/web-development-immersive)

# A Tic-tac-toe data store API

An API to store tic-tac-toe game state and let two players compete across the
internet. It allows players to register as users of the API and play against
other registered users.

The API does not currently validate game states.

## API URL

```js
  development: 'https://tic-tac-toe-wdi.herokuapp.com/',
  production: 'https://tic-tac-toe-wdi-production.herokuapp.com'
```

## API End Points

| Verb   | URI Pattern            | Controller#Action |
|--------|------------------------|-------------------|
| POST   | `/sign-up`             | `users#signup`    |
| POST   | `/sign-in`             | `users#signin`    |
| DELETE | `/sign-out`            | `users#signout`   |
| PATCH  | `/change-password`     | `users#changepw`  |
| GET    | `/games`               | `games#index`     |
| POST   | `/games`               | `games#create`    |
| GET    | `/games/:id`           | `games#show`      |
| PATCH  | `/games/:id`           | `games#update`    |
| GET    | `/games/:id/watch`     | `games#watch`     |

All data returned from API actions is formatted as JSON.

## API Guides

- [User Documentation](docs/user.md)
- [Game Documentation](docs/game.md)
- [Multiplayer Game Documentation](docs/game-multiplayer.md)
  - If attempting multiplayer make sure to use the dedicated multiplayer API,
    the url is in the link above.

## Disclaimer

This API may be reset or altered at anytime.  The future of this API may not
align with the current state and therefore the state your client application
expects.  If you would like to maintain a version of this API in its current
state for your future use, please fork and clone the repository and launch it
on heroku.

## [License](LICENSE)

1. All content is licensed under a CC­BY­NC­SA 4.0 license.
1. All software code is licensed under GNU GPLv3. For commercial use or
    alternative licensing, please contact legal@ga.co.
