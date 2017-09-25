# Schedule Job in Chronos

This step allows you to schedule a job using a json file to a chronos instance. It requires `curl` to be installed on the container.

The following paramaters are available:

* chronos-url (string, required)
* json-file (string, required)
* http-credentials (string, optional)

Example usage

```
deploy:
  steps:
    - petrica/chronos-schedule-job:
        chronos-url: http://your-chronos-url.com
        json-file: my-app.json
        http-credentials: "USERNAME:PASSWORD"
```