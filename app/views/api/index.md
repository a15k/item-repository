
## <a name="resource-formats">Formats accepted by the A15K item repository</a>

Stability: `prototype`

A format describes how an accessment‘s question and solution are encoded.

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **description** | *string* | A human readable description of a format | `"example"` |
| **id** | *uuid* | unique identifier of format | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **name** | *string* | The unique name of format | `"example"` |

### <a name="link-GET-formats-/formats">Formats accepted by the A15K item repository List</a>

List all formats.

```
GET /formats
```


#### Curl Example

```bash
$ curl -n /formats \
  -H "Authorization: <jwt-access-token>"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
[
  {
    "id": "01234567-89ab-cdef-0123-456789abcdef",
    "name": "example",
    "description": "example"
  }
]
```


