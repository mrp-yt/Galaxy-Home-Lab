# Paperless NGX services

### 🧠 `broker` (Redis)

- **Image**: `redis:7.4.2`
    
- **Job**: Handles internal message queues (background jobs like OCR or file processing).
    
- **Why**: Helps offload tasks from the webserver to run asynchronously.
    
- 🔗 [https://redis.io/](https://redis.io/)
    

---

### 🗃️ `db` (PostgreSQL)

- **Image**: `postgres:16`
    
- **Job**: Stores documents, tags, users, and other metadata.
    
- **Why**: Central database for everything Paperless tracks.
    
- 🔗 [https://www.postgresql.org/](https://www.postgresql.org/)
    

---

### 🌐 `webserver` (Paperless-ngx)

- **Image**: `paperless-ngx:latest`
    
- **Job**: Main app – user interface, handles uploads, search, settings.
    
- **Why**: It’s the front-end and logic hub.
    
- **Exposes port**: `8000` to access the web UI.
    
- 🔗 [https://github.com/paperless-ngx/paperless-ngx](https://github.com/paperless-ngx/paperless-ngx)
    

---

### 🔄 `gotenberg`

- **Image**: `gotenberg:8.17`
    
- **Job**: Converts Word/Office files to PDFs.
    
- **Why**: Paperless only works with PDFs.
    
- **Notes**: JavaScript disabled for security.
    
- 🔗 [https://gotenberg.dev/](https://gotenberg.dev/)
    

---

### 📄 `tika`

- **Image**: `paperless-ngx/tika`
    
- **Job**: Extracts text & metadata from documents.
    
- **Why**: Enables document search by reading file content.
    
- 🔗 [https://tika.apache.org/](https://tika.apache.org/)

---
### 🐞 `DEBUG: true` in `webserver`

- **Purpose**: Enables Django debug mode in Paperless-ngx.
    
- **What it does**:
    
    - Shows **detailed error pages** if something breaks.
        
    - Logs more info to the console (great for development/troubleshooting).
        
    - **Not safe for production** – don’t use it on public servers.
        

🔗 [https://paperless-ngx.readthedocs.io/en/latest/configuration.html#debug](https://paperless-ngx.readthedocs.io/en/latest/configuration.html#debug)
