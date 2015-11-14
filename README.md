### HubotEx

Hubot inspired chat bot in Elixir.

### Readme driven development
#### Architecture

The whole `receive` - `match` - `respond` cycle can be looked at as a set of transformations from a question, received from the chat source to a response which is sent back to the chat source. Like hubot, we should support multiple chat adapters from shell to slack to custom. The bot must have the capability to authenticate the received message, pick the relevant match rules and execute the rules of the received message. 

We should have a API to represent and interact with the rules. These rules could be auto generated or user generated.

Make use of the supervision trees.

#### To Do

##### Robot
- [ ] A robot must support names. A matcher can be named and futher can be addressed using the name. This allows the exsistance of more than one robot running parallely.
- [ ] HTTP server using cowboy for the robot. Hubot starts a server for each robot. We should investigate if one server for multiple bots. Each server could have a default bot to which they send all requests to if no bot is sepcified in the request. 

##### Matcher
- [x] Currently the matcher responds with the consequence of the first matcher. Ideally, consequences of all matchs should run and their results should be collated and responsed. But a match can specify to stop the matching process and respond with the results collated until now.
- [ ] Matching must be parallelized ([#3](https://github.com/avinasha/hubotex/pull/3))

##### Adapter
- [ ] Write a basic adapter (shell?)
- [ ] Adapter for Slack

##### Rules
Each rule is a pair of `regex, consequence`. Each consequnce is a function which accepts the message and reacts to it.
- [ ] Rule can be specified as a Elixir module which has a function rule which returns one or more `regex,consequence` pairs.
- [ ] Rule can be written in other languages than Elixir. Start with Ruby (Execution using ports)
