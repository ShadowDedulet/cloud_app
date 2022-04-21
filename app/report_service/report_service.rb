require_relative 'src/loaders/data_loader'
require_relative 'src/reporter'
require_relative 'src/printer'

DataLoader.load_data('./data/prices.csv', './data/vms.csv', './data/volumes.csv')