class Directory:
    
    def __init__(self, name, parent):
        self.name = name
        self.size = 0
        self.files = []
        self.parent_directory = parent
        self.subdirectories = []
        self.subnames = []