from flask import Flask
import sentry_sdk
import logging
import sys


app = Flask(__name__)

sentry_sdk.init(
    dsn=sys.argv[1],
    traces_sample_rate=1.0
)

@app.route("/<string:mode>")
def index(mode):
    if mode == "error": 
        logging.error("Error for sentry", extra=dict(rc=777))
    elif mode == "exception":
        logging.exception("Exception for sentry")
    
    try:
        zero = 1 / 0
    except ZeroDivisionError:
        logging.exception("ZeroDivisionError")
    
    return f"Mode is {mode}"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8888)