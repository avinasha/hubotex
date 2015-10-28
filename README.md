### HubotEx

Hubot inspired chat bot in Elixir.

### Readme driven development
#### Architecture

The whole `receive` - `match` - `respond` cycle can be looked at as a set of transformations from a question, received from the chat source to a response which is sent back to the chat source. Like hubot, we should support multiple chat adapters from shell to slack to custom. The bot must have the capability to authenticate the received message, pick the relevant match rules and execute the rules of the received message. 

We should have a API to represent and interact with the rules. These rules could be auto generated or user generated.

Make use of the supervision trees.

#### First cut

Create the backbone to convert `Request message` => `Response`.
