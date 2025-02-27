# Web Proxy for GitHub Codespaces

This is a **browser-in-browser proxy** that:
- Loads JavaScript-heavy sites.
- Supports full navigation (links work).
- Runs in **GitHub Codespaces**.
- Can be embedded in other sites.

## **Setup Instructions**
1. **Clone this repo in GitHub Codespaces**.
2. **Run the following command to build & start the proxy:**
   ```sh
   docker build -t proxy .
   docker run -p 5000:5000 proxy
