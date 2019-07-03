import MemoryCache
import bitarray

'''
O mais recentemente usado fica com 1
'''

class LRU(object):
    def __init__(self, block, label):
        self.block = block
        self.label = label

    def verificacoes(self, cache, label, block):
        # Verifica se está na cache
        if cache.label 