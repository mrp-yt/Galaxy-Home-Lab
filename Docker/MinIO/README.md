### 📦 `minio`

- **Image**: `minio/minio`
    
- **Job**: Acts like a mini Amazon S3. It's a place to **store files in buckets**.
    
- **Why**: Good for self-hosted apps that need S3-style storage (e.g., backups, documents, images).
    
- **Ports**:
    
    - `9000`: API for apps to talk to (S3-compatible).
        
    - `9090`: Web Console to manage buckets/files via browser.
        
- **Environment**:
    
    - `MINIO_ROOT_USER`: Username to log in.
        
    - `MINIO_ROOT_PASSWORD`: Password.
        
- **Volume**: Saves files in `<PATH_TO_DATA>:/data` on your host.
    
- **Command**: Launches server and binds web UI to port `9090`.
    

---

### Accessing it:

- Web Console: `http://<your-server-ip>:9090`
    
- S3 API: Used by apps via `http://<your-server-ip>:9000`
    

🔗 Official Docs: https://min.io/docs/minio/linux/index.html
