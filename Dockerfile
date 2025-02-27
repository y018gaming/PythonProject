FROM python:3.9

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    unzip \
    xvfb \
    libxi6 \
    libgconf-2-4 \
    && rm -rf /var/lib/apt/lists/*

# Install Chromium instead of Google Chrome (works in codespaces)
RUN apt-get update && apt-get install -y chromium-driver chromium

# Install Chrome Driver
RUN CHROME_VERSION=$(google-chrome --version | awk '{print $3}' | cut -d '.' -f 1) \
    && wget -q "https://chromedriver.storage.googleapis.com/${CHROME_VERSION}.0/chromedriver_linux64.zip" \
    && unzip chromedriver_linux64.zip -d /usr/local/bin/ \
    && rm chromedriver_linux64.zip

# Set up working directory
WORKDIR /app
COPY . .

# Install Python dependencies
RUN pip install -r requirements.txt

# Run the proxy
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "proxy:app"]
