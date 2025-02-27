from flask import Flask, request, render_template_string
from selenium import webdriver
from selenium.webdriver.chrome.options import Options

app = Flask(__name__)

# Set up headless Chrome
chrome_options = Options()
chrome_options.add_argument("--headless")
chrome_options.add_argument("--disable-gpu")
chrome_options.add_argument("--no-sandbox")
chrome_options.add_argument("--disable-dev-shm-usage")

driver = webdriver.Chrome(options=chrome_options)

@app.route('/')
def home():
    return '<form action="/browse" method="get"><input name="url" type="text"><input type="submit" value="Go"></form>'

@app.route('/browse')
def browse():
    url = request.args.get('url')
    if not url.startswith("http"):
        url = "http://" + url # Ensure proper URL formatting
    
    driver.get(url)
    page_source = driver.page_source
    
    return render_template_string(page_source)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
