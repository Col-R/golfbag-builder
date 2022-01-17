from flask_app.config.mysqlconnection import connectToMySQL
import re	# the regex module
# create a regular expression object that we'll use later
EMAIL_REGEX = re.compile(r'^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]+$')
from flask import flash
from ..models import bag

class User ():
    db = "bag_builder"
    def __init__(self, data):
        self.id = data['id']
        self.first_name = data['first_name']
        self.last_name = data['last_name']
        self.email = data['email']
        self.password = data['password']
        self.created_at = data['created_at']
        self.updated_at = data['updated_at']
        self.bags = []
    


    @classmethod
    def create(cls,data):
        query = "INSERT INTO users(first_name,last_name,email,password) VALUES(%(first_name)s,%(last_name)s,%(email)s,%(password)s);"
        return connectToMySQL(cls.db).query_db(query,data)
    
    # @classmethod
    # def like(cls, data):
    #     query = "INSERT INTO likes (user_id, bag_id) VALUES (%(user_id)s, %(bag_id)s);"
    #     return connectToMySQL(cls.db).query_db(query, data)

    @classmethod
    def get_by_email(cls,data):
        query = "SELECT * FROM users WHERE email = %(email)s;"
        results = connectToMySQL(cls.db).query_db(query,data)
        if len(results) < 1:
            return False
        return cls(results[0]) 

    @classmethod
    def get_by_id(cls,data):
        query = "SELECT * FROM users WHERE id = %(id)s;"
        results = connectToMySQL(cls.db).query_db(query,data)
        return cls(results[0])

    @classmethod
    def get_changes(cls):
        query = "SELECT * FROM users LEFT JOIN bags ON users.id = bags.user_id ORDER BY bags.updated_at DESC;"
        bag_changes = connectToMySQL(cls.db).query_db(query)
        changes = []
        for change in bag_changes:
            user = cls(change)
            bag_data = {
                "id": change['bags.id'],
                'name': change['name'],
                'driver': change['driver'],
                'woods':change['woods'],
                'hybrids' :change['hybrids'],
                'irons': change['irons'],
                'wedges': change['wedges'],
                'putter': change['putter'],
                'content': change['content'],
                'user_id':change['user_id'],
                'created_at': change['bags.created_at'],
                'updated_at': change['bags.updated_at']
            }
            user.bags.append(bag.Bag(bag_data))
            changes.append(user)
            
        return changes;

    @classmethod
    def like(cls, data):
        query = "INSERT INTO likes (user_id, bag_id) VALUES (%(user_id)s, %(bag_id)s);"
        return connectToMySQL(cls.db).query_db(query,data)


    @staticmethod
    def validate_register(user):
        is_valid = True
        query = "SELECT * FROM users WHERE email = %(email)s;"
        results = connectToMySQL(User.db).query_db(query,user)
        if len(results) >= 1:
            flash("Email already taken.","register")
            is_valid=False
        if not EMAIL_REGEX.match(user['email']):
            flash("Invalid email","register")
            is_valid=False
        if len(user['first_name']) < 3:
            flash("First name must be at least 3 characters","register")
            is_valid= False
        if len(user['last_name']) < 3:
            flash("Last name must be at least 3 characters","register")
            is_valid= False
        if len(user['password']) < 8:
            flash("Password must be at least 8 characters","register")
            is_valid= False
        if user['password'] != user['confirm']:
            flash("Passwords don't match","register")
            is_valid= False
        return is_valid    