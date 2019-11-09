# VacationTracker

## Slack Command:

- /time_off: 

	+ from YYYY-MM-DD to YYYY-MM-DD, reason: text

	+ help

Example:

	+ /time_off from 2019-11-20 to 2019-11-21, reason: I got sick

	+ /time_off help

## Dashboard

- Users login/out by Google Oauth
- User role: employee, owner
- View remaining annual leave
- View leave history
- For owner: ?

## Development

Please follow these steps to setup the project:

- `mix deps.get`
- `mix ecto.create`
- `mix ecto.migrate`
- `mix phx.server`
- Create your own testing workspace, please checkout https://api.slack.com/authentication/basics for detail.
- To test slack integration, you can use [ngrok](https://ngrok.com/)
- Add a slash command `time_off` using the endpoint `/commands/time_off`
- Add these scopes in the `OAuth & Permissions` link (You can find it in your app's feature): `commands`, `users:read`, `users:read:email`
- Add `.env` file to manage env variables (Please refer to `.env.example` for the detail), then `source .env`
- Finally: `mix test`
