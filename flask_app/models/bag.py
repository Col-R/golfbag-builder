from flask_app.config.mysqlconnection import connectToMySQL
from flask import flash

class Bag:
    db = "bag_builder"
    def __init__(self, data):
        self.id = data['id']
        self.name = data['name']
        self.driver = data['driver']
        self.woods = data['woods']
        self.hybrids = data['hybrids']
        self.irons = data['irons']
        self.wedges = data['wedges']
        self.putter = data['putter']
        self.user_id = data['user_id']
        self.created_at = data['created_at']
        self.updated_at = data['updated_at']

    @classmethod
    def get_all(cls):
        query = "SELECT * FROM bags;"
        bags_from_db = connectToMySQL(cls.db).query_db(query)
        bags = []
        for row in bags_from_db:
            bags.append(cls(row))
        return bags

    # ask for help on this
    @classmethod
    def get_all_by_creator(cls, data):
        query = "SELECT * FROM bags JOIN users ON bags.user_id = users.id WHERE bags.user_id = %(id)s;"
        bags_from_db = connectToMySQL(cls.db).query_db(query, data)
        bags_by_creator = []
        for bag in bags_from_db:
            bags_by_creator.append(cls(bag))
        return bags_by_creator
        print (bags_by_creator)
    
    @classmethod
    def create_bag(cls,data):
        query = "INSERT INTO bags (name, driver, woods, hybrids, irons, wedges, putter, user_id) VALUES (%(name)s,%(driver)s,%(woods)s,%(hybrids)s,%(irons)s,%(wedges)s,%(putter)s,%(user_id)s); "
        bag_id = connectToMySQL(cls.db).query_db(query, data)
        return bag_id
    
    @classmethod
    def get_by_id(cls, data):
        query = "SELECT * FROM bags WHERE id = %(id)s;"
        bag_by_id = connectToMySQL(cls.db).query_db(query, data)
        this_bag = cls(bag_by_id[0])
        return this_bag
    
    @staticmethod
    def validate_bag(bag):
        is_valid = True
        if len(bag['name']) < 3:
            is_valid = False
            flash("Name must be at least 3 characters")
        return is_valid