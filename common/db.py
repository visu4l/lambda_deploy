import pymysql

class DB(object):
    conn = None

    def __init__(self, db_info, cursor=pymysql.cursors.DictCursor):
        self._db_info = db_info
        self.cursor = cursor
        self.connect(db_info)
    
    def close(self):
        pass
    
    def connect(self, db_info):
        pass

    
    
        