# Counters



## The Server

Run the mock server (included in this repo) by executing:

```
$ npm install
$ npm start
```

## API Endpoints and Examples

The following endpoints are expecting `Content-Type: application/json`:

- `GET` `/api/v1/counters`

   Response Body:
   ```
   [
   ]
   ```

- `POST` `/api/v1/counter`

   Request Body:
   ```
   {
      "title": "Coffee"
   }
   ```
   Response Body:
   ```
   [
      {
         "id": "foo",
         "title": "Coffee",
         "count": 0
      }
   ]
   ```

- `POST` `/api/v1/counter`

   Request Body:
   ```
   {
      "title": "Tea"
   }
   ```
   Response Body:
   ```
   [
     { 
        "id": "asdf",
        "title": "Coffee",
        "count": 0
     },
     {
        "id": "qwer",
        "title": "Tea",
        "count": 0
     }
   ]
   ```

- `POST` `/api/v1/counter/inc`

   Request Body:
   ```
   {
      "id": "asdf"
   }
   ```

   Response Body:
   ```
   [
      {
         "id": "asdf",
         "title": "Coffee",
         "count": 1
      },
      {
         "id": "qwer",
         "title": "Tea",
         "count": 0
      }
   ]
   ```

- `POST` `/api/v1/counter/dec`

   Request Body:
   ```
   {
      "id": "qwer"
   }
   ```
   Response Body:
   ```
   [
      {
         "id": "asdf",
         "title": "Coffee",
         "count": 1
      },
      {
         "id": "qwer",
         "title": "Tea",
         "count": -1
      }
   ]
   ```

- `DELETE` `/api/v1/counter`

   Request Body:
   ```
   {
      "id": "qwer"
   }
   ```
   Response Body:
   ```
   [
      {
        "id": "asdf",
        "title": "Coffee",
        "count": 1
      }
   ]
   ```

- `GET` `/api/v1/counters`

   Response Body:
   ```
   [
      {
         "id": "asdf",
         "title": "Coffee",
         "count": 1
      }
   ]
   ```

---
