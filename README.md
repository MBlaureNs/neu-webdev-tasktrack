# Notes
design decisions:

all users may list all other users as managers and managees:
since there is no "project lead" type role and since the app currently supports
only one project, it seems that this app will most likely be used by a team
using a loose and informal style of management. as a result, the user experience
barrier to assigning managers and managees has been intentionally made very low.

for similar reasons, users are allowed to have multiple managers as well as
multiple managees.

task reports are displayed on users' profile pages. since all task and user
info are globally visible anyway, there is no need to limit viewing managee
reports to only their respective managers.


# TaskTrack

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
