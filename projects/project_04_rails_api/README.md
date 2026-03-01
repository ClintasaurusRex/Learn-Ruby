# Project 04: Rails API

## Goal
Build a Rails API-only service with JSON endpoints, token authentication, request specs, and documented `curl` usage.

## Endpoint Table

| Method | Endpoint | Auth Required | Purpose |
|--------|----------|---------------|---------|
| POST | /signup | No | Create user |
| POST | /login | No | Return auth token |
| GET | /posts | Yes | List posts |
| POST | /posts | Yes | Create post |
| GET | /posts/:id | Yes | Show post |
| PATCH | /posts/:id | Yes | Update post |
| DELETE | /posts/:id | Yes | Delete post |

## Auth Flow Diagram (ASCII)

```text
Client -> POST /login (email/password)
         <- 200 { token }
Client -> GET /posts with Authorization: Bearer <token>
         <- 200 JSON response
```

## Architecture Diagram (ASCII)

```text
Client(curl/Postman)
   |
   v
Rails API Router -> Controllers -> Models -> DB
                     |
                     v
                Token Auth Guard
```

## Design Decisions (Plain Language)
- API-only Rails keeps response behavior consistent for frontend/mobile clients.
- Bearer tokens keep auth stateless at the request layer.
- JSON serialization is explicit so response shape is predictable.
- Request specs verify public API behavior from a user perspective.

## How this maps to real-world use
This mirrors backend services consumed by SPAs and mobile apps where clients authenticate once, then call JSON endpoints with a token.

## Step-by-step run instructions (Linux Mint)
1. Move into this project:
   ```bash
   cd projects/project_04_rails_api
   ```
2. Build the API app scaffold:
   ```bash
   bash src/build_api_app.sh
   ```
3. Prepare DB and run:
   ```bash
   cd src/rails_api_app
   bundle install
   bin/rails db:create db:migrate
   bin/rails server
   ```
4. Run request specs:
   ```bash
   bundle exec rspec spec/requests
   ```

## curl examples for all endpoints

```bash
# signup
curl -X POST http://localhost:3000/signup -H "Content-Type: application/json" -d '{"email":"a@example.com","password":"secret123"}'

# login
curl -X POST http://localhost:3000/login -H "Content-Type: application/json" -d '{"email":"a@example.com","password":"secret123"}'

# list posts (replace TOKEN)
curl http://localhost:3000/posts -H "Authorization: Bearer TOKEN"

# create post
curl -X POST http://localhost:3000/posts -H "Authorization: Bearer TOKEN" -H "Content-Type: application/json" -d '{"title":"Hello","body":"API post"}'

# show post
curl http://localhost:3000/posts/1 -H "Authorization: Bearer TOKEN"

# update post
curl -X PATCH http://localhost:3000/posts/1 -H "Authorization: Bearer TOKEN" -H "Content-Type: application/json" -d '{"title":"Updated"}'

# delete post
curl -X DELETE http://localhost:3000/posts/1 -H "Authorization: Bearer TOKEN"
```
