from flask import Flask, render_template
import random
app = Flask(__name__)
images = [
	"https://img.buzzfeed.com/buzzfeed-static/static/2017-10/6/5/asset/buzzfeed-prod-fastlane-03/sub-buzz-26473-1507283273-1.png",
	"https://img.buzzfeed.com/buzzfeed-static/static/2017-10/6/5/asset/buzzfeed-prod-fastlane-01/sub-buzz-20444-1507281284-1.jpg",
	"https://img.buzzfeed.com/buzzfeed-static/static/2017-10/6/5/asset/buzzfeed-prod-fastlane-01/sub-buzz-21674-1507283573-7.jpg",
	"https://img.buzzfeed.com/buzzfeed-static/static/2017-10/6/5/asset/buzzfeed-prod-fastlane-01/sub-buzz-20596-1507281484-2.jpg"
]
@app.route('/')

def index():
	url= random.choice(images)
	return render_template('index.html', url=url)
	
if __name__ == "__main__":
	app.run(host="0.0.0.0")
