#!/usr/bin/env python
import time
from flask import Flask
from flask_cors import CORS
import os

# Reading variable from environment
SERVICE_CLOCK_PORT = os.environ.get('SERVICE_CLOCK_PORT',5001)


app = Flask(__name__)

# We disable CORS check
cors = CORS(app, resources={r"/*": {"origins": "*"}})


@app.route('/clock')
def get_unix_time():
    """Returns the current time in Unix format."""
    unix_time = int(time.time())
    return str(unix_time)

if __name__ == '__main__':
    app.run(host="0.0.0.0",port=SERVICE_CLOCK_PORT)
    