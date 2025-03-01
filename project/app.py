from flask import Flask, render_template, send_from_directory

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/portfolio')
def portfolio():
    return render_template('portfolio.html')

@app.route('/contact')
def contact():
    return render_template('contact.html')

@app.route('/download')
def download_resume():
    directory = 'static'  # Ensure the static folder contains the file
    filename = 'Esurendrababu.pdf'  # Replace with your actual resume file name
    return send_from_directory(directory, filename, as_attachment=True)
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)



