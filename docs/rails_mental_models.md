# Rails Mental Models 🛤️

> How to think about Rails before you write a single line.

---

## Mental Model 1 — MVC: The Three-Room House

Rails is organized into three rooms. Each room has one job.

```
┌─────────────────────────────────────────────────────────────┐
│                    THE MVC HOUSE                            │
│                                                             │
│  ┌───────────┐    ┌───────────────┐    ┌────────────────┐   │
│  │           │    │               │    │                │   │
│  │   MODEL   │◄──►│  CONTROLLER  │◄──►│      VIEW      │   │
│  │           │    │               │    │                │   │
│  │ Database  │    │ Orchestrates  │    │ What the user  │   │
│  │ Business  │    │ Handles req.  │    │ actually sees  │   │
│  │ Logic     │    │ Calls model   │    │ HTML/JSON      │   │
│  │ Rules     │    │ Picks view    │    │ ERB templates  │   │
│  │           │    │               │    │                │   │
│  └───────────┘    └───────────────┘    └────────────────┘   │
│                                                             │
│  User interacts with View                                   │
│  View sends request to Controller                           │
│  Controller asks Model for data                             │
│  Model returns data to Controller                           │
│  Controller sends data to View                              │
│  View renders HTML to User                                  │
└─────────────────────────────────────────────────────────────┘
```

**Rule of thumb:**
- **Model** — anything to do with data, storage, or business logic
- **Controller** — thin orchestrator, no business logic
- **View** — display only, no logic beyond simple conditionals

---

## Mental Model 2 — The Request Lifecycle

Every web request follows the same path through Rails.

```
┌───────────────────────────────────────────────────────────────┐
│                   REQUEST LIFECYCLE                           │
│                                                               │
│  Browser                                                      │
│     │                                                         │
│     │  GET /articles/1                                        │
│     ▼                                                         │
│  Router (config/routes.rb)                                    │
│     │  "GET /articles/:id" → ArticlesController#show         │
│     ▼                                                         │
│  Middleware Stack                                             │
│     │  (logging, session, CSRF, etc.)                         │
│     ▼                                                         │
│  ArticlesController#show                                      │
│     │  before_action :authenticate_user!                      │
│     │  @article = Article.find(params[:id])                   │
│     ▼                                                         │
│  Article Model (ActiveRecord)                                 │
│     │  SELECT * FROM articles WHERE id = 1                    │
│     │  ← returns Article object                               │
│     ▼                                                         │
│  View (app/views/articles/show.html.erb)                      │
│     │  renders HTML with @article data                        │
│     ▼                                                         │
│  Response (200 OK + HTML body)                                │
│     │                                                         │
│     ▼                                                         │
│  Browser renders page                                         │
└───────────────────────────────────────────────────────────────┘
```

---

## Mental Model 3 — ActiveRecord as Translator

ActiveRecord translates between Ruby objects and database rows.

```
┌────────────────────────────────────────────────────────────┐
│              ACTIVERECORD AS TRANSLATOR                    │
│                                                            │
│  Ruby World              Translator          Database      │
│  ───────────             ──────────          ────────────  │
│  Article.new        ─►  INSERT INTO  ─►  articles table   │
│  Article.find(1)    ─►  SELECT WHERE ─►  row id=1         │
│  article.update     ─►  UPDATE SET   ─►  row updated      │
│  article.destroy    ─►  DELETE FROM  ─►  row deleted       │
│                                                            │
│  Ruby objects ◄──────────────────────────── SQL results    │
│                                                            │
│  You never write SQL (usually).                            │
│  ActiveRecord does it for you.                             │
└────────────────────────────────────────────────────────────┘
```

**Examples:**

```ruby
# Ruby code         →  SQL generated
Article.all          #  SELECT * FROM articles
Article.find(1)      #  SELECT * FROM articles WHERE id = 1
Article.where(published: true)  #  SELECT * FROM articles WHERE published = true
Article.create(title: "Hi")     #  INSERT INTO articles (title) VALUES ('Hi')
article.update(title: "Bye")    #  UPDATE articles SET title = 'Bye' WHERE id = ?
article.destroy                 #  DELETE FROM articles WHERE id = ?
```

---

## Mental Model 4 — Convention Over Configuration

Rails makes assumptions so you don't have to configure everything.

```
┌─────────────────────────────────────────────────────────────┐
│            CONVENTION OVER CONFIGURATION                    │
│                                                             │
│  Convention                    What it means               │
│  ──────────                    ─────────────               │
│  Class: Article                Table: articles             │
│  Class: UserProfile            Table: user_profiles        │
│  File: articles_controller.rb  Class: ArticlesController    │
│  File: show.html.erb           Action: #show               │
│  Folder: app/views/articles/   Views for ArticlesController │
│  File: articles.rb (model)     Model for articles table     │
│                                                             │
│  If you follow conventions: zero configuration needed.      │
│  If you break conventions: you must configure manually.     │
│                                                             │
│  Tip: Follow conventions while learning.                    │
│  Break them only when you understand them.                  │
└─────────────────────────────────────────────────────────────┘
```

**Checklist:**
- [ ] I understand that Rails is organized into Models, Controllers, and Views
- [ ] I can trace a request from the browser through the router, controller, model, and view
- [ ] I understand that ActiveRecord translates between Ruby and SQL
- [ ] I understand "convention over configuration" — named things get wired up automatically
- [ ] I know where to put code: logic in model, orchestration in controller, display in view

**Common mistakes:**
- Putting business logic in the controller (it belongs in the model or service object)
- Putting logic in the view (move it to a helper or the model)
- Breaking naming conventions and then wondering why things don't connect
- Not reading the Rails guides — they are excellent and beginner-friendly
