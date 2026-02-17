# Security Playground - Hardened Edition


The security playground is an HTTP web server to simulate security breaches. It allows you to read, write, and execute commands in a containerized environment.

**This hardened version adds multiple security layers while preserving the intentional vulnerabilities for educational purposes.**

## 🔒 Security Enhancements Added

This version includes the following security improvements:

| Control | Status | Purpose |
|---------|--------|---------|
| **Non-root user** | ✅ Implemented | Prevents container breakout |
| **HTTPS encryption** | ✅ Implemented | Encrypts all traffic |
| **Authentication** | ✅ Implemented | Requires login before access |
| **Nginx reverse proxy** | ✅ Implemented | Centralized security layer |

## 📋 Prerequisites

- Docker and Docker Compose v2+
- OpenSSL (for certificate generation)
- htpasswd (usually in `apache2-utils` or `httpd-tools`)

### Installation

```bash
# Clone the repository
git clone <https://github.com/Praveena0308/Security-playgorund.git>
cd security-playground

# Generate SSL certificate (for HTTPS)
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes -subj "/CN=localhost"

# Create password file
htpasswd -c .htpasswd admin
# Enter password when prompted

# Start the secured application
docker-compose up

```

Why: Prevents container breakout attacks. If the application is compromised, the attacker has limited privileges instead of full root access to the container.

2. HTTPS with SSL/TLS Encryption
Self-signed SSL certificate for encrypted communication

Automatic HTTP to HTTPS redirection

Why: Passwords and data are encrypted in transit, preventing sniffing attacks and man-in-the-middle interception.

3. Nginx Reverse Proxy with Authentication
Basic authentication prompt before accessing the application

Rate limiting to prevent brute force attacks

Security headers for browser protection

Why: Adds multiple security layers without modifying the original application code. The vulnerable app remains unchanged but is now protected by a secure gateway.

flowchart TD
    
```mermaid
flowchart TD
    A[💻 User Request:<br/>curl http://localhost:8080/etc/shadow] --> B{🌐 Nginx on Port 80};
    
    B -->|🔄 301 Redirect| C[🔒 Forced to HTTPS:<br/>curl https://localhost/etc/shadow];
    
    C --> D{🔐 Nginx on Port 443<br/>SSL Certificate Check};
    
    D -->|📜 Self-signed Cert| E[⚠️ curl Error:<br/>SSL certificate problem<br/>Self-signed certificate];
    
    E --> F[🔧 Developer Uses -k Flag:<br/>curl -k https://localhost/etc/shadow<br/>Bypass SSL for testing];
    
    F --> G{🛡️ Nginx Basic Auth};
    
    G -->|❌ Wrong Password| H[⛔ 401 Unauthorized<br/>Access Denied];
    G -->|✅ Valid Credentials| I[➡️ Request Forwarded to App];
    
    I --> J{👤 App Running as<br/>Non-Root User};
    
    J --> K[📁 Attempt to Read /etc/shadow];
    
    K --> L{⚖️ Permission Check<br/>File: -rw-r----- root shadow};
    
    L -->|❌ No Read Permission| M[🛑 403 Permission Denied<br/>✅ SECURITY WORKING!];
    
    L -->|⚠️ If Root User| N[💥 Original Vulnerability<br/>Password Hashes Exposed];
    
    style A fill:#e1f5fe,stroke:#01579b
    style B fill:#fff3e0,stroke:#e65100
    style C fill:#fff3e0,stroke:#e65100
    style D fill:#fff3e0,stroke:#e65100
    style E fill:#ffebee,stroke:#b71c1c
    style F fill:#fff3e0,stroke:#e65100
    style G fill:#fff3e0,stroke:#e65100
    style H fill:#ffebee,stroke:#b71c1c
    style I fill:#e8f5e8,stroke:#1b5e20
    style J fill:#e8f5e8,stroke:#1b5e20
    style K fill:#e8f5e8,stroke:#1b5e20
    style L fill:#e8f5e8,stroke:#1b5e20
    style M fill:#a5d6a7,stroke:#1b5e20,stroke-width:4px
    style N fill:#ffccbc,stroke:#bf360c,stroke-width:2px
    
    ```
    