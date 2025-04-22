# Paperless NGX services
#### Docker compose file [link](https://github.com/mrp-yt/Galaxy-Home-Lab/blob/main/Docker/Paperless-NGX/docker-compose.yml)
---
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

---

# Paperless-NGX Dashboard Menu options

🏠 Dashboard
Function: Displays a customizable overview with saved views and document statistics.

Features: Allows adding saved views for quick access to frequently used filters. ​
Paperless NGX Docs
+4
GitHub
+4
GitHub
+4

📄 Documents
Function: Main interface to view and manage all documents.

Features: Supports searching, filtering, sorting, and bulk editing.​

📥 Inbox
Function: Shows unprocessed documents awaiting classification.

Features: Allows manual processing and assignment of metadata.​

🏷️ Tags
Function: Manage labels to categorize documents.

Features: Create, edit, delete, and assign tags to documents.​

👤 Correspondents
Function: Manage entities (people or organizations) associated with documents.

Features: Helps in organizing documents by sender or related party.​

📂 Document Types
Function: Define and manage categories like invoices, receipts, etc.

Features: Facilitates automatic classification and filtering.​

📁 Storage Paths
Function: Manage physical storage locations for documents.

Features: Configure where documents are stored on disk.​

🧩 Workflows
Function: Automate actions based on document metadata.

Features: Set up rules to perform tasks like tagging or moving documents automatically.​

📧 Mail Accounts
Function: Configure email accounts for importing documents.

Features: Automatically fetch and process email attachments.​
freebsdfoundation.org

📜 Mail Rules
Function: Define rules for processing incoming emails.

Features: Set conditions to filter and handle emails appropriately.​

💾 Saved Views
Function: Create and manage custom filtered views of documents.

Features: Quick access to frequently used document filters.​

⚙️ Settings
Function: Configure system-wide settings.

Features: Adjust OCR settings, user preferences, and other configurations.​
paperless-ngx.readthedocs.io
+4
Paperless NGX Docs
+4
Paperless NGX Docs
+4

👥 Users
Function: Manage user accounts and permissions.

Features: Add, edit, or remove users and assign roles.​

🔍 Search Bar
Function: Perform quick searches across all documents.

Features: Supports advanced search queries using specific syntax.
