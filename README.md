# Access Backend Exercise B
Build an Voting Server to determine an issue about Wuhan coronavirus

## Question
Assume that we have a voting server that is designed for determining whether Wuhan coronavirus is created by China. The user can vote agree or disagree at any time. Please implement two APIs one is for voting and one is for retrieving the current votes count.

## Quick Start

### Download the dependencies

```bash
> mix deps.get
```

### Run the server

|Info|Default Value|
|:-:|:-:|
|Address|localhost:8080|
|Config|./config/config.exs|

**Command:**

```bash
> mix run --no-halt
10:04:25.491 [info]  Starting application...
```

## API

### Vote Your Opinion

#### Request

```
POST /vote
```

|Request Header|Description|
|:-:|:-:|
|Content-Type| application/json |

**FYI:** [contentType: MIME](https://en.wikipedia.org/wiki/MIME)

```json
{
    "agree": <agree(boolean)>
}
```

Example:

```json
{
	"agree": true
}
```

#### Response

```json
{
    "message": "Vote Success!"
}
```

#### Error

```json
{"error": "Please Send your opinion!"}
{"error": "Expected Payload: { 'agree': [...] }
```

#### Try it now!

```bash
> curl -X POST -d '{"agree":true}' -H "Content-Type: application/json" http://localhost:8080/vote
```

### Get Vote Result


#### Request

```
Get /vote
```

#### Response

```json
{
    "agree": 0,
    "disagree": 0,
    "total": 0
}
```

#### Try it now!

```bash
> curl -X GET http://localhost:8080/vote
```

## Test
```bash
> mix test test/exercise/router_test.exs
```

## Config

**config/config.exs**

- Define port only

```
config :exercise, cowboy_port: 8080
```