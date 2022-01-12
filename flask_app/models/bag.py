from flask_app.config.mysqlconnection import connectToMySQL
from flask import flash

class Bag:
    db = "bag_builder"
    def __init__(self, data):
        self.id = data['id']
        self.name = data['name']
        self.driver = data['driver']
        self.woods = data['woods']
        self.hybrids = data['hybrid']
        self.irons = data['irons']
        self.wedges = data['wedges']
        self.putter = data['putter']
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