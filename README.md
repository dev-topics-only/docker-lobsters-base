# The base Docker image of Lobsters

This docker image contains the runtime environment and gem dependencies for [Lobsters](https://github.com/lobsters/lobsters).

This image is built off of the official Ruby Docker image ([ruby:2.7-alpine](https://hub.docker.com/_/ruby/)).

## Usage

```dockerfile
FROM pipecraftnet/lobsters-base:latest

...
```

See [example](https://github.com/dev-topics-only/docker-lobsters/blob/main/Dockerfile).

## Related

- [lobsters/lobsters](https://github.com/lobsters/lobsters) - Lobsters Rails Project
- [utensils/docker-lobsters](https://github.com/utensils/docker-lobsters) - Lobsters in a minimal Docker container.
- [dev-topics-only/docker-lobsters](https://github.com/dev-topics-only/docker-lobsters) - Docker for DTO

## License

Copyright (c) 2022 [Pipecraft](https://www.pipecraft.net). Licensed under the [MIT License](https://github.com/dev-topics-only/docker-lobsters-base/blob/main/LICENSE).

## >\_

[![Pipecraft](https://img.shields.io/badge/site-pipecraft-brightgreen)](https://www.pipecraft.net)
[![DTO](https://img.shields.io/badge/site-DTO-brightgreen)](https://dto.pipecraft.net)
