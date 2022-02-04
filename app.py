import os
from flask import Flask, render_template, request, redirect, session
from flask.helpers import url_for
import mysql.connector

connection = mysql.connector.connect(
    host="localhost",
    database='ecom',
    user="root",
    autocommit=True,
    password="Mysql@8022"
)

cursor = connection.cursor(buffered=True)
pidlist = []

app = Flask(__name__)
app.secret_key = "super_key"
imgFolder = os.path.join('static', 'images')
app.config['UPLOAD FOLDER'] = imgFolder


@app.route("/")
def hello():
    return render_template('index.html')


@app.route("/login", methods=['POST', 'GET'])
def login():
    msg = ''
    session["id"] = ""
    if request.method == 'POST' and 'user' in request.form and 'password' in request.form:
        User_name = request.form.get('user')
        Password = request.form.get('password')
        cursor.execute(
            f'select * from user_login where Cus_name="{User_name}" AND C_password="{Password}"')
        account = cursor.fetchone()
        if account:
            session['loggedin'] = 'TRUE'
            session['id'] = account[0]

            session['User_name'] = account[1]
            return redirect(url_for('hello'))
        else:
            msg = 'Incorrect User_name or Password'
    return render_template("login.html", msg=msg)


@app.route("/Dresses")
def Dresses():

    if session.get("id"):
        global pidlist
        img1 = os.path.join(app.config['UPLOAD FOLDER'], 'pid 1.jpg')
        imagelist = os.listdir('static/images/Dresses')
        imagelist = ['images/Dresses/' + image for image in imagelist]
        cursor.execute('select * from products where P_category="Dresses"')
        value = cursor.fetchall()

        pidlist = [row[0] for row in value]

        return render_template('dresses.html', data=value, name='Dresses', imagelist=imagelist, pidlist=pidlist)
    else:
        return redirect('/login')


@app.route("/Gadgets")
def Gadgets():
    if session.get("id"):
        global pidlist
        cur1 = connection.cursor()
        cur1.execute("select * from products where P_category='Gadgets'")
        value = cur1.fetchall()
        pidlist = [row[0] for row in value]
        return render_template('gadgets.html', data=value, name='Gadgets')
    else:
        return redirect('/login')


@app.route("/Crockery")
def Crockery():
    if session.get("id"):
        cur1 = connection.cursor()
        cur1.execute("select * from products where P_category='Crockery'")
        value = cur1.fetchall()
        return render_template('crockery.html', data=value, name='Crockery')
    else:
        return redirect('/login')


@app.route("/School_items")
def School_items():
    if session.get("id"):
        cur1 = connection.cursor()
        cur1.execute("select * from products where P_category='Kids'")
        value = cur1.fetchall()
        return render_template('school.html', data=value, name='School items')
    else:
        return redirect('/login')


@app.route("/Electronic_Gadgets")
def Electronic_Gadgets():
    if session.get("id"):
        cur1 = connection.cursor()
        cur1.execute("select * from products where P_category='Kids'")
        value = cur1.fetchall()
        return render_template('school.html', data=value, name='School items')
    else:
        return redirect('/login')


@app.route("/cart/<int:pid>")
def cart(pid):
    if session.get("id"):
        global pidlist
        cur3 = connection.cursor()
        cur3.execute(
            f"select * from cart where pid={pid} and id = {session.get('id')}")
        value1 = cur3.fetchall()
        if not value1:
            cursor.execute(
                f"select pid,P_name,P_price,img_url,Stock from products where pid={pid}")
            products = cursor.fetchall()
            cursor.execute(
                f"insert into cart(pid, P_name, total_price, img_url, stock, id) values ({products[0][0]}, '{products[0][1]}', {products[0][2]}, '{products[0][3]}', {products[0][4]}, {session.get('id')})")
        else:
            cur4 = connection.cursor()
            cur4.execute(
                f"update cart set quantity=quantity+1 where id={session['id']}")

        cur2 = connection.cursor()
        cur2.execute(f"select * from cart where id = {session['id']}")
        value = cur2.fetchall()

        pidlist = [row[0] for row in value]
        return render_template('cart.html', data=value, name=cart)
    else:
        return redirect('/login')


@app.route("/delete_cart/<int:pid>")
def delete_cart(pid):
    if session.get("id"):
        cursor.execute(
            f"delete from cart where id={session['id']} and pid={pid}")
        cur2 = connection.cursor()
        cur2.execute(f"select * from cart where id={session['id']}")
        value = cur2.fetchall()
        return render_template('cart.html', data=value, name='delete_cart')
    else:
        return redirect('/login')


@app.route("/view_cart")
def view_cart():
    if session.get("id"):
        global pidlist
        cursor.execute(f"select * from cart where id = {session.get('id')}")
        value = cursor.fetchall()
        pidlist = [row[0] for row in value]
        return render_template('cart.html', data=value, name='view_cart')
    else:
        return redirect('/login')


@app.route("/Proceed/<int:pid>")
def Proceed(pid):
    if session.get("id"):
        cursor.execute(
            f"select * from cart where id={session.get('id')} and pid={pid}")
        value = cursor.fetchall()

        return render_template('buy.html', data=value, name='Booking confirmation')
    else:
        return redirect('/login')


@app.route("/signup", methods=['POST', 'GET'])
def signup():
    if request.method == 'POST':
        User_name = request.form.get('user')
        Email = request.form.get('mail')
        Phone = request.form.get('mob')
        password = request.form.get('password')
        cursor.execute("insert into user_login (Cus_name,C_Email,C_Phone,C_password)values(%s,%s,%s,%s)",
                       (User_name, Email, Phone, password))
        return render_template("sign.html", name="Sign Up")

    else:
        return render_template("sign.html", name="Sign Up")


@app.route("/logout")
def logout():
    session.pop('loggedin', None)
    session.pop('id', None)
    session.pop('User_name', None)
    return redirect(url_for('login'))


@app.route("/increment/<int:pid>")
def increment(pid):
    if session.get("id"):
        cursor.execute(
            f"update cart set quantity=quantity+1 where pid={pid} and id={session.get('id')}")

        cursor4 = connection.cursor()
        cursor4.execute(
            f"update cart set total_price=total_price+(select P_price from products where pid={pid}) where pid={pid} id={session.get('id')}")
        cur7 = connection.cursor()
        cur7.execute(f"select * from cart")
        value = cur7.fetchall()
        return render_template('cart.html', data=value)
    else:
        return redirect("/login")


@app.route("/decrement/<int:pid>")
def decrement(pid):
    if session.get("id"):
        cursor.execute(
            f"update cart set quantity=quantity-1 where pid={pid} and id={session.get('id')}")
        cursor4 = connection.cursor()
        cursor4.execute(
            f"update cart set total_price=total_price-(select P_price from products where pid={pid}) where pid={pid} id={session.get('id')}")
        cur8 = connection.cursor()
        cur8.execute(f"select * from cart")
        value = cur8.fetchall()
        return render_template('cart.html', data=value)
    else:
        return redirect("/login")


@app.route("/Customers/<int:pid>", methods=['POST', 'GET'])
def customers(pid):
    if session.get("id"):
        cursor.execute(
            f"select * from cart where pid={pid} and id={session.get('id')}")
        value = cursor.fetchall()
        if request.method == 'POST':
            User_name = request.form.get('user')
            Address = request.form.get('Address')
            Phone_Number = request.form.get('Phone')
            cursor.execute(
                f"insert into Buyer(Cid, C_name,C_Address,C_phone,pid) values ({session.get('id')} ,'{User_name}','{Address}','{Phone_Number}',{pid})")
            return redirect(f"/Confirm/{pid}")
        else:
            return render_template("sample.html", data=value)
    else:
        return redirect("/login")


@app.route("/Confirm/<int:pid>")
def confirm(pid):
    if session.get("id"):

        cursor.execute(
            f"select * from cart where id={session.get('id')} and pid ={pid}")
        value = cursor.fetchall()
        return render_template("confirm.html", data=value)
    else:
        return redirect("/login")


@app.route("/view_order/<int:pid>")
def order(pid):
    if session.get("id"):
        cursor.execute(
            f"select * from cart where id={session.get('id')} and pid = {pid}")
        value = cursor.fetchall()
        cursor2 = connection.cursor()
        cursor2.execute(f"select * from buyer where Cid='{session.get('id')}'")
        value1 = cursor2.fetchall()
        return render_template("order.html", data=value, data1=value1)
    return redirect("/login")


if __name__ == '__main__':
    app.run(debug=True)
