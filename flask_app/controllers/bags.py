from flask_app import app
from flask import render_template,redirect,session,request, flash
from ..models import user, bag

@app.route("/addBag")
def new_bag():
    if 'user_id' not in session:
        return redirect('/')
    data = {
        "id":session['user_id']
    }
    return render_template('add_bag.html', user = user.User.get_by_id(data))

@app.route('/addBag/new', methods = ['POST'])
def create_bag():
    if 'user_id' not in session:
        return redirect('/logout')
    if not bag.Bag.validate_bag(request.form):
        return redirect('/addBag')
    data = {
        "name":request.form["name"],
        "driver":request.form["driver"],
        "woods":request.form["woods"],
        "hybrids":request.form["hybrids"],
        "irons":request.form["irons"],
        "wedges":request.form["wedges"],
        "putter":request.form["putter"],
        "user_id": session["user_id"]
    }
    bag.Bag.create_bag(data)
    return redirect('/dashboard')