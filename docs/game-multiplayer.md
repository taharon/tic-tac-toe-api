# Multiplayer Game Actions

Before you start attempting multiplayer game actions, make sure to update the
URLs listed in the `config.js` file.

```js
const apiUrls = {
  development: 'https://tic-tac-toe-wdi-multiplayer.herokuapp.com/',
  production: 'https://tic-tac-toe-wdi-production.herokuapp.com'
}
```

All games action requests must include a valid HTTP header `Authorization:
Token token=<token>` or they will be rejected with a status of 401 Unauthorized.

All of the game actions, except for `watch`, follow the *RESTful* style.

Games are associated with users, `player_x` and `player_o`. Actions, other than
update, will only retrieve a game if the user associated with the
`Authorization` header is one of those two users. If this requirement is unmet,
the response will be 404 Not Found, except for the index action which will
return an empty games array.

*Summary:*

<table>
<tr>
  <th colspan="3">Request</th>
  <th colspan="2">Response</th>
</tr>
<tr>
  <th>Verb</th>
  <th>URI</th>
  <th>body</th>
  <th>Status</th>
  <th>body</th>
</tr>
<tr>
<td>PATCH</td>
<td>`/games/:id`</td>
<td><em>empty</em></td>
<td>200, OK</td>
<td><strong>game joined</strong></td>
</tr>
<tr>
  <td colspan="3"></td>
  <td>400 Bad Request</td>
  <td><strong>errors</strong></td>
</tr>
<tr>
  <td colspan="3"></td>
  <td>400 Bad Request</td>
  <td><em>empty</em></td>
</tr>
</table>

## update

### join a game as player 'o'

This `update` action expects an empty (e.g `''` or `'{}'` if JSON) *PATCH* to
 join an existing game.

If the request is successful, the response will have an HTTP Status of 200 OK,
 and the body will be JSON containing the game joined, e.g.:

```json
{
  "game": {
    "id": 1,
    "cells": ["","","","","","","","",""],
    "over":false,
    "player_x": {
      "id": 1,
      "email": "and@and.com"
      },
    "player_o": {
      "id": 3,
      "email":
      "dna@dna.com"
    }
  }
}
```

If the request is unsuccessful, the response will have an HTTP Status of 400 Bad
 Request, and the response body will be empty (game cannot be joined, player_o
 already set or user making request is player_x) or JSON describing the errors.

## watch

The `watch` action is handled differently than all the others. Because `watch`
implements a streaming source of data, we'll use a wrapper around the html5
object EventSource to handle the events sent.

You can find the wrapper [here](public/js/resource-watcher-0.1.0.js). The
wrapper is also available from the deployed app at the path `/js/resource-
watcher-0.1.0.js`.

The events that `watch` implements let you know when a game has been updated.
By using this interface you can write code that lets a player see another's move
almost as it happens. Updates to the game from one player's browser are sent to
the other's browser.

You create a watcher object using the resourceWatcher function. This function
takes two parameters, the watch url and a configuration object which must
contain the Authorization token, and may contain an optional timeout in
seconds, e.g.:

```js
let gameWatcher = resourceWatcher('<server>/games/:id/watch', {
      Authorization: 'Token token=<token>'[,
      timeout: <timeout>]
});
```

By default, watching a game times-out after 120 seconds.

You should add a handler for `change` and `error` events. The error events are
not the most informative. The change event may pass to your handler an object
with a root key of "timeout" or "heartbeat".

Otherwise, it will pass an object with a root key of "game".  Each key in this
object will contain an array of length 2.  The first element of such an array
will contain the value for that key before the update.  The last element will
contain the value after the update.  The code example that follows shows
handling the most important case, a change to the game board.

```js
gameWatcher.on('change', function (data) {
  console.log(data);
  if (data.game && data.game.cells) {
    const diff = changes => {
      let before = changes[0];
      let after = changes[1];
      for (let i = 0; i < after.length; i++) {
        if (before[i] !== after[i]) {
          return {
            index: i,
            value: after[i],
          };
        }
      }

      return { index: -1, value: '' };
    };

    let cell = diff(data.game.cells);
    $('#watch-index').val(cell.index);
    $('#watch-value').val(cell.value);
  } else if (data.timeout) { //not an error
    gameWatcher.close();
  }
});

gameWatcher.on('error', function (e) {
  console.error('an error has occurred with the stream', e);
});
```
