import flask
from flask import Flask, jsonify
app = Flask(__name__)
d={}
d['data']={}
@app.route("/", methods=['GET'])
def home():
    return "This is a simple key value service with the following three methods <br/>/get return the entire dictionary <br/>/get/key returns the value of the given key <br/>/post/key/value sets a value for the given key <br/>/delete deletes the given key from the dictionary"
@app.route("/get", methods=['GET'])
def get():
    return jsonify(d)

@app.route("/get/<key>", methods=['GET'])
def getvalue(key):
    return jsonify(d['data'].get(key, {}))

@app.route('/post/<key>/<value>', methods=['GET','POST'])
def set(key,value):
    d['data'][key] = value
    return "Value for the given key is succesfully set"

@app.route('/delete/<key>')
def delete(key):
    d['data'].pop(key,None)
    return "Key deleted"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80, debug=True)