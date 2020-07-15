# dynv6-updater

## Purpose

This Docker Image is used to update all zones of a DYNv6 account with the current public IP. For example, if you are using several services behind a private router that are accessed via zones of Dynv6, this image resp. the included script helps to update all zones in one go. The script is executed every minute by time control. An update is performed if a new public IP address is detected.

## Installation

The image can be created with the following command:

```
docker build --pull -t dynv6/dynv6-updater .
```

After the image has been created, the container can be started with the following command. For the required environment variables, see boitte under `Configuration`.

```
docker run -e DYNV6_TOKEN="<token>" -e DYNV6_ZONES="<zones>" -d dynv6/dyn6-updater
```

## Configuration

To use this image, the following environment variables must be set:

```DYNV6_TOKEN=<token>```

Enter the token `<token>` for using the API here. You can find the token under `Account` -> `Keys` -> `HTTP Tokens` -> `Token`.

```DYNV6_ZONES=<zones>```

Enter the list of zones (`<zones>`) to be updated here. If several zones are to be updated, the list must be separated by commas. At least one fully qualified zone must be specified (Example: `myzone.dynv6.net` or `myzone1.dynv6.net,myzone2.dynv6.net`).

## License

Licensed under MIT. See [LICENSE](LICENSE).