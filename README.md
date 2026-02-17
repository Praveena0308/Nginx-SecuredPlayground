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